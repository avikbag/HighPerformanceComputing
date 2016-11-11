library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ForwardingMux is
  port (
    IDEX: in STD_LOGIC_VECTOR (31 downto 0);
    EXMEM: in STD_LOGIC_VECTOR (31 downto 0);
    MEMWB: in STD_LOGIC_VECTOR (31 downto 0);
    Forward: in STD_LOGIC_VECTOR(1 downto 0);
    result: out STD_LOGIC_VECTOR(31 downto 0)
  );
end ForwardingMux;

architecture behavioral of ForwardingMux is
begin 
ForwardMux_process: process(Forward, IDEX, EXMEM, MEMWB)
begin
	if Forward = "00" then
		result <= IDEX;
	elsif (Forward = "10") then
		result <= EXMEM;
	elsif (Forward = "01") then
		result <= MEMWB;	
	else 
		result <= IDEX;
	end if;
end process;
end behavioral;
