
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity IDEXRegister is 
	port (
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
		BranchIn: in STD_LOGIC;
		BranchOut: out STD_LOGIC;
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
end IDEXRegister;

architecture structure of IDEXRegister is
begin	
clockProcess: process(ck) begin
if ck = '0' and ck'event then
	jumpAddressOut <= jumpAddressIN;
	readData1OUT <= readData1IN;
	readData2OUT <= readData2IN;
	PCIncrementedOUT <= PCIncrementedIN;
	immediateExtendedOUT <= immediateExtendedIN;
	regRead1OUT <= regRead1IN;
	regRead2OUT <= regRead2IN;
	regWrite1OUT <= regWrite1IN;
	RegDstOut <= RegDstIn;
	JumpOut <= JumpIn;
	BranchOut <= BranchIn;
	MemReadOut <= MemReadIn;
	MemtoRegOut <= MemtoRegIn;
	MemWriteOut <= MemWriteIn;
	ALUSrcOut <= ALUSrcIn;
	RegWriteOut <= RegWriteIn;
	ALUOpOut <= ALUOpIn;
end if;
end process;
end structure;
