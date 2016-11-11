library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity branchAdder is
port
(
	extendedImmediate, programCounter : in STD_LOGIC_VECTOR(31 downto 0);
	branchAddress : out STD_LOGIC_VECTOR(31 downto 0)
);
end branchAdder;

architecture behavioral of branchAdder is
begin
	branchAddress <= STD_LOGIC_VECTOR(signed(extendedImmediate(29 downto 0) & "00") + signed(programCounter));
end behavioral;
