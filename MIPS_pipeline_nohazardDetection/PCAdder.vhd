library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity PCAdder is
	port(
		pcValueIn: in STD_LOGIC_VECTOR(31 downto 0);
		pcValueOut: out STD_LOGIC_VECTOR(31 downto 0)
);
end PCAdder;

architecture behavioral of PCAdder is

begin
  pcValueOut <= std_logic_vector(signed(pcValueIn) + 4);
end behavioral;