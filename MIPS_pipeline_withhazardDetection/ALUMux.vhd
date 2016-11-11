library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALUMux is 
port (
	ALUSrc : in STD_LOGIC;
	read_data_2, immediateExtended : in STD_LOGIC_VECTOR(31 downto 0);
	ALUInput : out STD_LOGIC_VECTOR(31 downto 0)
);
end ALUMux;

architecture behavioral of ALUMux is

begin

  ALUMux_process: process(read_data_2, immediateExtended, ALUSrc)
    begin 
	if (ALUSrc = '1') then
		ALUInput <= immediateExtended;
	else
		ALUInput <= read_data_2;
end if;
end process;

end behavioral;



