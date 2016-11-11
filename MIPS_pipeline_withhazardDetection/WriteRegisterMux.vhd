library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity WriteRegisterMux is 
port (
	RegDst : in STD_LOGIC;
	rt, rd : in STD_LOGIC_VECTOR(4 downto 0);
	write_register : out STD_LOGIC_VECTOR(4 downto 0)
);
end WriteRegisterMux;

architecture behavioral of WriteRegisterMux is

begin

  WriteRegisterMux_process: process(rt, rd, RegDst)
    begin 
	if (RegDst = '1') then
		write_register <= rd;
	else
		write_register <= rt;
end if;
end process;

end behavioral;


