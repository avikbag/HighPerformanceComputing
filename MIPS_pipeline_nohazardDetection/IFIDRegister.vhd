
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity IFIDRegister is 
	port (
		ck: in STD_LOGIC;
		instructionIN: in STD_LOGIC_VECTOR(31 downto 0);
		PCIncrementedIN: in STD_LOGIC_VECTOR(31 downto 0);
		instructionOUT: out STD_LOGIC_VECTOR(31 downto 0);
		PCIncrementedOUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end IFIDRegister;

architecture structure of IFIDRegister is
begin	
clockProcess: process(ck) begin
if ck = '0' and ck'event then
	PCIncrementedOUT <= PCIncrementedIN;
	instructionOUT <= instructionIN;
end if;
end process;
end structure;