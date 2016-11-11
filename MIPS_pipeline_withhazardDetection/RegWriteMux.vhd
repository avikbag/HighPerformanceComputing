library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegWriteMux is 
port (
	MemtoReg : in STD_LOGIC;
	read_data, alu_out : in STD_LOGIC_VECTOR(31 downto 0);
	write_data : out STD_LOGIC_VECTOR(31 downto 0)
);
end RegWriteMux;

architecture behavioral of RegWriteMux is

begin

  RegWriteMux_process: process(read_data, alu_out, MemtoReg)
    begin 
	if (MemtoReg = '1') then
		write_data <= read_data;
else
	write_data <= alu_out;
end if;
end process;

end behavioral;
