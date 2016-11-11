library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity jumpAddressModule is
port (
    pc : in STD_LOGIC_VECTOR(31 downto 28);
    instruction : in STD_LOGIC_VECTOR(25 downto 0);
    jumpAddress : out STD_LOGIC_VECTOR(31 downto 0)
);
end jumpAddressModule;

architecture behavioral of jumpAddressModule is 
begin
jumpAddress <= pc & instruction & "00";
end;
