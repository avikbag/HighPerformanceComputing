library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BranchMux is 
port (
	andGate : in STD_LOGIC;
	branch, programCounter : in STD_LOGIC_VECTOR(31 downto 0);
	path : out STD_LOGIC_VECTOR(31 downto 0)
);
end BranchMux;

architecture behavioral of BranchMux is

begin

  BranchMux_process: process(branch, programCounter, andGate)
    begin 
	if (andGate = '1') then
		path <= branch;
	else
		path <= programCounter;
end if;
end process;

end behavioral;