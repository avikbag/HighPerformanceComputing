library IEEE;

use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity aluControl is 
port
(
	ALUOp: in std_logic_vector(1 downto 0);
	funct: in std_logic_vector(5 downto 0);
	aluControl: out std_logic_vector(3 downto 0)
);
end aluControl;

architecture behavioral of aluControl is
begin

aluControlProcess: process(ALUOp, funct)
begin
	if ALUOp = "00" then
		aluControl <= "0010";
	elsif ALUOp = "01" then
		aluControl <= "0110";
	elsif ALUOp = "10" then
		if funct = "100000" then
			aluControl <= "0010";
		elsif funct = "100010" then
			aluControl <= "0110";
		elsif funct = "100100" then
			aluControl <= "0000";
		elsif funct = "100101" then
			aluControl <= "0001";
		elsif funct = "101010" then
			aluControl <= "0111";
		elsif funct = "000000" then
			aluControl <= "0011";
		else
			--associate aluControl to non-operation
			aluControl <= "1111"; 
		end if;
	elsif ALUOP = "11" then
		aluControl <= "0100";
	else
		--associate aluControl to non-operation
		aluControl <= "1111";
	end if;
end process;

end behavioral;