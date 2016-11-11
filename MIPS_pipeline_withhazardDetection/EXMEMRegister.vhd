
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity EXMEMRegister is 
	port (
		ck: in STD_LOGIC;
		jumpAddressIN : in STD_LOGIC_VECTOR(31 downto 0);
		jumpAddressOUT: out STD_LOGIC_VECTOR(31 downto 0);
		ALUResultIn : in STD_LOGIC_VECTOR(31 downto 0);
		ALUResultOut: out STD_LOGIC_VECTOR(31 downto 0);
		branchAddressIn : in STD_LOGIC_VECTOR(31 downto 0);
		branchAddressOut : out STD_LOGIC_VECTOR(31 downto 0);
		readData2In: in STD_LOGIC_VECTOR(31 downto 0);
		readData2Out: out STD_LOGIC_VECTOR(31 downto 0);
		regWrite1IN: in STD_LOGIC_VECTOR(4 downto 0);
		regWrite1OUT: out STD_LOGIC_VECTOR(4 downto 0);
		JumpIn: in STD_LOGIC;
		JumpOut: out STD_LOGIC;
		BranchIn: in STD_LOGIC;
		BranchOut: out STD_LOGIC;
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
end EXMEMRegister;

architecture structure of EXMEMRegister is
begin	
clockProcess: process(ck) begin
if ck = '0' and ck'event then
	jumpAddressOUT <= jumpAddressIn;
	branchAddressOut <= branchAddressIn;
	ALUResultOut <= ALUResultIn;
	readData2Out <= readData2In;
	regWrite1OUT <= regWrite1IN;
	JumpOut <= JumpIn;
	BranchOut <= BranchIn;
	MemReadOut <= MemReadIn;
	MemtoRegOut <= MemtoRegIn;
	MemWriteOut <= MemWriteIn;
	RegWriteOut <= RegWriteIn;
	zeroWireOut <= zeroWireIn;
end if;
end process;
end structure;