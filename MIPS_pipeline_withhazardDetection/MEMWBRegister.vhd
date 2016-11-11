
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MEMWBRegister is 
	port (
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
end MEMWBRegister;

architecture structure of MEMWBRegister is
begin	
clockProcess: process(ck) begin
if ck = '0' and ck'event then
	ALUResultOut <= ALUResultIn;
	readDataOut <= readDataIn;
	regWrite1Out <= regWrite1In;
	MemtoRegOut <= MemtoRegIn;
	regWriteOut <= regWriteIn;
end if;
end process;
end structure;