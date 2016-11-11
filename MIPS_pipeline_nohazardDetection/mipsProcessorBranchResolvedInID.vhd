library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity mipsProcessor is port
(
	ck: in STD_LOGIC
);
end mipsProcessor;

architecture structure of mipsProcessor is

	signal PC : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal PCIncremented : STD_LOGIC_VECTOR(31 downto 0);
	signal instruction : STD_LOGIC_VECTOR(31 downto 0);
	signal writeToReg : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUInput2 : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUCon : STD_LOGIC_VECTOR(3 downto 0);
	signal ALUOut : STD_LOGIC_VECTOR(31 downto 0);
	signal immediateALUMux : STD_LOGIC_VECTOR(31 downto 0);
	signal readDataMemoryOut : STD_LOGIC_VECTOR(31 downto 0);
	signal writeRegWire : STD_LOGIC_VECTOR(4 downto 0);
	signal branchAddressWire, jumpAddressWire : STD_LOGIC_VECTOR(31 downto 0);
	signal branchMuxOut : STD_LOGIC_VECTOR(31 downto 0);
	signal PCNew : STD_LOGIC_VECTOR(31 downto 0);

	signal andGate : STD_LOGIC;
	signal cmp : STD_LOGIC;
	
	signal IFIDinstructionIN : STD_LOGIC_VECTOR(31 downto 0);
	signal IFIDinstructionOUT : STD_LOGIC_VECTOR(31 downto 0);	
	signal IFIDPCIncrementedIN : STD_LOGIC_VECTOR(31 downto 0);
	signal IFIDPCIncrementedOUT : STD_LOGIC_VECTOR(31 downto 0);
	
	signal  IDEXJumpAddressIN: STD_LOGIC_VECTOR(31 downto 0);
	signal  IDEXJumpAddressOUT: STD_LOGIC_VECTOR(31 downto 0);
	signal  IDEXreadData1IN: STD_LOGIC_VECTOR(31 downto 0);
	signal  IDEXreadData2IN: STD_LOGIC_VECTOR(31 downto 0);
	signal  IDEXreadData1OUT: STD_LOGIC_VECTOR(31 downto 0);
	signal  IDEXreadData2OUT: STD_LOGIC_VECTOR(31 downto 0);
	signal	IDEXimmediateExtendedIN: STD_LOGIC_VECTOR(31 downto 0);
	signal	IDEXPCIncrementedIN: STD_LOGIC_VECTOR(31 downto 0);
	signal	IDEXregRead1IN: STD_LOGIC_VECTOR(4 downto 0);
	signal	IDEXregRead2IN:  STD_LOGIC_VECTOR(4 downto 0);
	signal	IDEXregWrite1IN:  STD_LOGIC_VECTOR(4 downto 0);
	signal	IDEXimmediateExtendedOUT: STD_LOGIC_VECTOR(31 downto 0);
	signal	IDEXPCIncrementedOUT: STD_LOGIC_VECTOR(31 downto 0);
	signal	IDEXregRead1OUT: STD_LOGIC_VECTOR(4 downto 0);
	signal	IDEXregRead2OUT: STD_LOGIC_VECTOR(4 downto 0);
	signal	IDEXregWrite1OUT: STD_LOGIC_VECTOR(4 downto 0);
	signal	IDEXRegDstIn: STD_LOGIC;
	signal	IDEXRegDstOut: STD_LOGIC;
	signal	IDEXJumpIn: STD_LOGIC;
	signal	IDEXJumpOut: STD_LOGIC;
	signal	IDEXBranchIn: STD_LOGIC;
	signal	IDEXBranchOut: STD_LOGIC;
	signal	IDEXMemReadIn: STD_LOGIC;
	signal	IDEXMemReadOut: STD_LOGIC;
	signal	IDEXMemtoRegIn: STD_LOGIC;
	signal	IDEXMemtoRegOut: STD_LOGIC;
	signal	IDEXMemWriteIn: STD_LOGIC;
	signal	IDEXMemWriteOut: STD_LOGIC;
	signal	IDEXALUSrcIn: STD_LOGIC;
	signal	IDEXALUSrcOut: STD_LOGIC;
	signal	IDEXRegWriteIn: STD_LOGIC;
	signal	IDEXRegWriteOut: STD_LOGIC;
	signal	IDEXALUOpIn: STD_LOGIC_VECTOR(1 downto 0);
	signal	IDEXALUOpOut: STD_LOGIC_VECTOR(1 downto 0);
	
	signal EXMEMJumpAddressIN: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMJumpAddressOUT: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMALUResultIn: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMALUResultOut: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMbranchAddressIn: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMbranchAddressOut: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMreadData2In: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMreadData2Out: STD_LOGIC_VECTOR(31 downto 0);
	signal EXMEMregWrite1IN: STD_LOGIC_VECTOR(4 downto 0);
	signal EXMEMregWrite1OUT: STD_LOGIC_VECTOR(4 downto 0);
	signal EXMEMJumpIn: STD_LOGIC;
	signal EXMEMJumpOut: STD_LOGIC;
	signal EXMEMBranchIn: STD_LOGIC;
	signal EXMEMBranchOut: STD_LOGIC;
	signal EXMEMMemReadIn: STD_LOGIC;
	signal EXMEMMemReadOut: STD_LOGIC;
	signal EXMEMMemtoRegIn: STD_LOGIC;
	signal EXMEMMemtoRegOut: STD_LOGIC;
	signal EXMEMMemWriteIn: STD_LOGIC;
	signal EXMEMMemWriteOut: STD_LOGIC;
	signal EXMEMRegWriteIn: STD_LOGIC;
	signal EXMEMRegWriteOut: STD_LOGIC;
	signal EXMEMzeroWireIn: STD_LOGIC;
	signal EXMEMzeroWireOut: STD_LOGIC;
	
	signal MEMWBALUresultIN: STD_LOGIC_VECTOR(31 downto 0);
	signal MEMWBALUresultOut: STD_LOGIC_VECTOR(31 downto 0);
	signal MEMWBReadDataIn: STD_LOGIC_VECTOR(31 downto 0);
	signal MEMWBReadDataOut: STD_LOGIC_VECTOR(31 downto 0);
	signal MEMWBregWrite1In: STD_LOGIC_VECTOR(4 downto 0);
	signal MEMWBregWrite1Out: STD_LOGIC_VECTOR(4 downto 0);
	signal MEMWBMemtoRegIn: STD_LOGIC;
	signal MEMWBMemtoRegOut: STD_LOGIC;
	signal MEMWBRegWriteIn: STD_LOGIC;
	signal MEMWBRegWriteOut: STD_LOGIC;
	
	
	
	component IFIDRegister
	port
	(
		ck: in STD_LOGIC;
		instructionIN: in STD_LOGIC_VECTOR(31 downto 0);
		PCIncrementedIN: in STD_LOGIC_VECTOR(31 downto 0);
		instructionOUT: out STD_LOGIC_VECTOR(31 downto 0);
		PCIncrementedOUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component IDEXRegister
	port
	(
		ck: in STD_LOGIC;
		jumpAddressIN: in STD_LOGIC_VECTOR(31 downto 0);
		jumpAddressOUT: out STD_LOGIC_VECTOR(31 downto 0);
		readData1IN: in STD_LOGIC_VECTOR(31 downto 0);
		readData2IN: in STD_LOGIC_VECTOR(31 downto 0);
		readData1OUT: out STD_LOGIC_VECTOR(31 downto 0);
		readData2OUT: out STD_LOGIC_VECTOR(31 downto 0);
		immediateExtendedIN: in STD_LOGIC_VECTOR(31 downto 0);
		PCIncrementedIN: in STD_LOGIC_VECTOR(31 downto 0);
		regRead1IN: in STD_LOGIC_VECTOR(4 downto 0);
		regRead2IN: in STD_LOGIC_VECTOR(4 downto 0);
		regWrite1IN: in STD_LOGIC_VECTOR(4 downto 0);
		immediateExtendedOUT: out STD_LOGIC_VECTOR(31 downto 0);
		PCIncrementedOUT: out STD_LOGIC_VECTOR(31 downto 0);
		regRead1OUT: out STD_LOGIC_VECTOR(4 downto 0);
		regRead2OUT: out STD_LOGIC_VECTOR(4 downto 0);
		regWrite1OUT: out STD_LOGIC_VECTOR(4 downto 0);
		RegDstIn: in STD_LOGIC;
		RegDstOut: out STD_LOGIC;
		JumpIn: in STD_LOGIC;
		JumpOut: out STD_LOGIC;
		MemReadIn: in STD_LOGIC;
		MemReadOut: out STD_LOGIC;
		MemtoRegIn: in STD_LOGIC;
		MemtoRegOut: out STD_LOGIC;
		MemWriteIn: in STD_LOGIC;
		MemWriteOut: out STD_LOGIC;
		ALUSrcIn: in STD_LOGIC;
		ALUSrcOut: out STD_LOGIC;
		RegWriteIn: in STD_LOGIC;
		RegWriteOut: out STD_LOGIC;
		ALUOpIn: in STD_LOGIC_VECTOR(1 downto 0);
		ALUOpOut: out STD_LOGIC_VECTOR(1 downto 0)
	);
	end component;
	
	component EXMEMRegister
	port
	(
		ck: in STD_LOGIC;
		jumpAddressIN: in STD_LOGIC_VECTOR(31 downto 0);
		jumpAddressOUT: out STD_LOGIC_VECTOR(31 downto 0);
		ALUResultIn: in STD_LOGIC_VECTOR(31 downto 0);
		ALUResultOut: out STD_LOGIC_VECTOR(31 downto 0);
		readData2In: in STD_LOGIC_VECTOR(31 downto 0);
		readData2Out: out STD_LOGIC_VECTOR(31 downto 0);
		regWrite1IN: in STD_LOGIC_VECTOR(4 downto 0);
		regWrite1OUT: out STD_LOGIC_VECTOR(4 downto 0);
		JumpIn: in STD_LOGIC;
		JumpOut: out STD_LOGIC;
		MemReadIn: in STD_LOGIC;
		MemReadOut: out STD_LOGIC;
		MemtoRegIn: in STD_LOGIC;
		MemtoRegOut: out STD_LOGIC;
		MemWriteIn: in STD_LOGIC;
		MemWriteOut: out STD_LOGIC;
		RegWriteIn: in STD_LOGIC;
		RegWriteOut: out STD_LOGIC;
		zeroWireIn: in STD_LOGIC;
		zeroWireOut: out STD_LOGIC
	);
	end component;
	
	component MEMWBRegister
	port
	(
		ck: in STD_LOGIC;
		ALUResultIn: in STD_LOGIC_VECTOR(31 downto 0);
		ALUResultOut: out STD_LOGIC_VECTOR(31 downto 0);
		readDataIn: in STD_LOGIC_VECTOR(31 downto 0);
		readDataOut: out STD_LOGIC_VECTOR(31 downto 0);
		regWrite1In: in STD_LOGIC_VECTOR(4 downto 0);
		regWrite1Out: out STD_LOGIC_VECTOR(4 downto 0);
		MemtoRegIn: in STD_LOGIC;
		MemtoRegOut: out STD_LOGIC;
		RegWriteIn: in STD_LOGIC;
		RegWriteOut: out STD_LOGIC
	);
	end component;
	
	component branchAdder
	port
	(
		extendedImmediate, programCounter : in STD_LOGIC_VECTOR(31 downto 0);
		branchAddress : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component JumpMux
	port (
		Jump : in STD_LOGIC;
		jumpAddress, path : in STD_LOGIC_VECTOR(31 downto 0);
		programCounter : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component registers
	port (
		read_reg_1, read_reg_2, write_reg: in STD_LOGIC_VECTOR(4 downto 0);
		write_data: in STD_LOGIC_VECTOR (31 downto 0);
		RegWrite, ck: in STD_LOGIC;
		read_data_1: out STD_LOGIC_VECTOR (31 downto 0);
		read_data_2: out STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;

	component WriteRegisterMux
	port (
		RegDst : in STD_LOGIC;
		rt, rd : in STD_LOGIC_VECTOR(4 downto 0);
		write_register : out STD_LOGIC_VECTOR(4 downto 0)
	);
	end component;

	component instructionMemory
	port (
    		address: in STD_LOGIC_VECTOR(31 downto 0);
    		instruction: out STD_LOGIC_VECTOR(31 downto 0)
  	);
	end component;

	component RegWriteMux
	port (
		MemtoReg : in STD_LOGIC;
		read_data, alu_out : in STD_LOGIC_VECTOR(31 downto 0);
		write_data : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component controlModule
  	port (
  		controlIn: in STD_LOGIC_VECTOR(31 downto 26);
  		RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out STD_LOGIC;
  		ALUOp: out STD_LOGIC_VECTOR(1 downto 0)
  	);
	end component;

	component jumpAddressModule
	port (
    	pc : in STD_LOGIC_VECTOR(31 downto 28);
    	instruction : in STD_LOGIC_VECTOR(25 downto 0);
    	jumpAddress : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component signExtender
	port (
	input : in STD_LOGIC_VECTOR(15 downto 0);
	output : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component BranchMux
	port (
	andGate : in STD_LOGIC;
	branch, programCounter : in STD_LOGIC_VECTOR(31 downto 0);
	path : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component ALU
  	port (
    	read_data_1: in STD_LOGIC_VECTOR (31 downto 0);
    	read_data_2: in STD_LOGIC_VECTOR (31 downto 0);
    	ALUControl: in STD_LOGIC_VECTOR (3 downto 0);
	shamt: in STD_LOGIC_VECTOR(4 downto 0);
    	zero: out STD_LOGIC;
    	ALUResult: out STD_LOGIC_VECTOR(31 downto 0)
  	);
	end component;

	component aluControl
	port (
	ALUOp: in std_logic_vector(1 downto 0);
	funct: in std_logic_vector(5 downto 0);
	aluControl: out std_logic_vector(3 downto 0)
	);
	end component;

	component PCAdder
	port(
		pcValueIn: in STD_LOGIC_VECTOR(31 downto 0);
		pcValueOut: out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;

	component dataMemory
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead,ck: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;

	component ALUMux
	port (
	ALUSrc : in STD_LOGIC;
	read_data_2, immediateExtended : in STD_LOGIC_VECTOR(31 downto 0);
	ALUInput : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component comparator is
	port (
	input1 : in STD_LOGIC_VECTOR(31 downto 0);
	input2 : in STD_LOGIC_VECTOR(31 downto 0);
	res    : out STD_LOGIC
	);
	end component;
begin

U1: instructionMemory port map(PC, IFIDinstructionIN);
U2: PCAdder port map(PC, IFIDPCIncrementedIN);

U16: IFIDRegister port map(ck, IFIDinstructionIN, IFIDPCIncrementedIN, IFIDinstructionOUT, IFIDPCIncrementedOUT);

U10: controlModule port map(	IFIDinstructionOUT(31 downto 26), 
				IDEXRegDstIN, 
				IDEXJumpIn, 
				IDEXBranchIn, 
				IDEXMemReadIN, 
				IDEXMemtoRegIN, 
				IDEXMemWriteIN, 
				IDEXALUSrcIN, 
				IDEXRegWriteIN, 
				IDEXALUOpIN);

U9: jumpAddressModule port map(IFIDPCIncrementedOUT(31 downto 28), IFIDInstructionOut(25 downto 0), IDEXJumpAddressIN);

U3: registers port map(IFIDinstructionOUT(25 downto 21), 
		IFIDinstructionOUT(20 downto 16), 
		MEMWBRegWrite1Out, 
		writeToReg,
		MEMWBRegWriteOut, 
		ck,
		IDEXreadData1IN,
		IDEXreadData2IN);

U12: signExtender port map(IFIDinstructionOUT(15 downto 0), IDEXimmediateExtendedIN);	

-- The implementation for resolving brach statement in ID stage
U13: branchAdder port map(IDEXimmediateExtendedIN, IFIDPCIncrementedOUT, EXMEMbranchAddressIn);
U23: comparator port map(IDEXreadData1IN, IDEXreadData2IN, cmp);
andGate <= cmp and IDEXBranchIn;
U14: BranchMux port map(andGate, EXMEMbranchAddressIn, IFIDPCIncrementedIn, branchMuxOut);
			
-- ID/EX register, moving from ID stage to EX stage
U17: IDEXRegister port map(ck, 	IDEXJumpAddressIN, 
				IDEXJumpAddressOut, 
				IDEXreadData1IN, 
				IDEXreadData2IN, 
				IDEXreadData1OUT, 
				IDEXreadData2OUT, 
				IDEXimmediateExtendedIN, 
				IFIDPCincrementedOUT, 
				IFIDinstructionOUT(25 downto 21), 
				IFIDinstructionOUT(20 downto 16), 
				IFIDinstructionOUT(15 downto 11), 
				IDEXimmediateExtendedOUT, 
				IDEXPCIncrementedOUT, 
				IDEXregRead1OUT, 
				IDEXregRead2OUT, 
				IDEXregWrite1OUT,  
				IDEXRegDstIn, 
				IDEXRegDstOut, 
				IDEXJumpIn, 
				IDEXJumpOut, 
				IDEXMemReadIn, 
				IDEXMemReadOut, 
				IDEXMemWriteIn, 
				IDEXMemWriteOut, 
				IDEXMemtoRegIn, 
				IDEXMemToRegOut, 
				IDEXALUSrcIn, 
				IDEXALUSrcOut, 
				IDEXRegWriteIn, 
				IDEXRegWriteOut, 
				IDEXALUOpIn, 
				IDEXALUOpOut);

U8: WriteRegisterMux port map(IDEXRegDstOUT, IDEXregRead2OUT, IDEXregWrite1OUT, EXMEMregWrite1IN);

U11: aluControl port map(IDEXALUOpOut, IDEXimmediateExtendedOUT(5 downto 0), aluCon);
U4: ALUMux port map(IDEXALUSrcOut, IDEXreadData2OUT, IDEXimmediateExtendedOUT, ALUInput2);
U5: ALU port map(IDEXreadData1OUT, ALUInput2, ALUCon, IDEXimmediateExtendedOUT(10 downto 6), EXMEMZeroWireIn, EXMEMALUresultIN);


U18: EXMEMRegister port map(ck, IDEXJumpAddressOut, 
				EXMEMJumpAddressOut, 
				EXMEMALUresultIN, 
				EXMEMALUResultOut, 
				IDEXreadData2Out, 
				EXMEMreadData2Out, 
				EXMEMregWrite1IN, 
				EXMEMregWrite1OUT, 
				IDEXJumpOut, 
				EXMEMJumpOut, 
				IDEXMemReadOut, 
				EXMEMMemReadOut, 
				IDEXMemtoRegOut, 
				EXMEMMemtoRegOut, 
				IDEXMemWriteOut, 
				EXMEMMemWriteOut, 
				IDEXRegWriteOut, 
				EXMEMRegWriteOut, 
				EXMEMzeroWireIn, 
				EXMEMzeroWireOut);

U6: dataMemory port map(EXMEMALUResultOut, EXMEMreadData2Out, EXMEMMemWriteOut, EXMEMMemReadOut, ck, MEMWBReadDataIN);
U15: JumpMux port map(EXMEMJumpOut, EXMEMJumpAddressOut, branchMuxOut, PCNew);

U19: MEMWBRegister port map(ck, EXMEMALUResultOut, 
				MEMWBALUResultOut, 
				MEMWBReadDataIN, 
				MEMWBReadDataOUT, 
				EXMEMregWrite1OUT, 
				MEMWBregWrite1Out, 
				EXMEMMemtoRegOUT, 
				MEMWBMemtoRegOut, 
				EXMEMRegWriteOut, 
				MEMWBRegWriteOut);


U7: RegWriteMux port map(MEMWBMemtoRegOut, MEMWBReadDataOUT, MEMWBALUResultOut, writeToReg);


clockProcess: process(ck)
begin
if ck = '0' and ck'event then
 PC <= PCNew;
end if;
end process;
end structure;