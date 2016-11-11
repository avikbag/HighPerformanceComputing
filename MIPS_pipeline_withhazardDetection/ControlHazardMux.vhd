library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControlHazardMux is 
port (
	Hazard : in STD_LOGIC;
	ControlPath: in STD_LOGIC_VECTOR(31 downto 0);
	HazardOut : out STD_LOGIC_VECTOR(31 downto 0)
);
end ControlHazardMux;

architecture behavioral of ControlHazardMux is

begin

  HazardMux_process: process(ControlPath, Hazard)
    begin 
	if (Hazard = '1') then
		HazardOut <= X"FFFFFFFF";
	else
		HazardOut <= ControlPath;
end if;
end process;

end behavioral;
