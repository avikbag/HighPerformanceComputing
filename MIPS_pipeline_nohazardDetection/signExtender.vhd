library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signExtender is
port (
	input : in STD_LOGIC_VECTOR(15 downto 0);
	output : out STD_LOGIC_VECTOR(31 downto 0)
);
end signExtender;

architecture behavioral of signExtender is
begin
	output <= std_logic_vector(resize(signed(input), output'length));
end architecture;