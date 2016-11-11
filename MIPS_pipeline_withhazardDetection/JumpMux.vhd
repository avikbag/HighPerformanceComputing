library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity JumpMux is 
port (
	Jump : in STD_LOGIC;
	jumpAddress, path : in STD_LOGIC_VECTOR(31 downto 0);
	programCounter : out STD_LOGIC_VECTOR(31 downto 0)
);
end JumpMux;

architecture behavioral of JumpMux is

begin

  JumpMux_process: process(jumpAddress, path, Jump)
    begin 
	if (Jump = '1') then
		programCounter <= jumpAddress;
	else
		programCounter <= path;
end if;
end process;

end behavioral;

