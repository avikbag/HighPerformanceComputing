library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity HazardDetection is
	port(
		IDEXMemRead: in STD_LOGIC;
		IDEX_RT: in STD_LOGIC_VECTOR(4 downto 0);
		IFID_RT: in STD_LOGIC_VECTOR(4 downto 0);
		IFID_RS: in STD_LOGIC_VECTOR(4 downto 0);
		pcValueIn: in STD_LOGIC_VECTOR(31 downto 0);
		HazardControl: out STD_LOGIC;
		pcValueOut: out STD_LOGIC_VECTOR(31 downto 0)
	);
end HazardDetection;

architecture behavioral of HazardDetection is
begin

check: process(IDEXMemRead, IDEX_RT, IFID_RT, IFID_RS, pcValueIn)
begin
	if (IDEXMemRead = '1' and ((IDEX_RT = IFID_RS) or (IDEX_RT = IFID_RT))) then
		HazardControl <= '1';
		pcValueOut <= std_logic_vector(signed(pcValueIn) - 4);
	else
		HazardControl <= '0';
		pcValueOut <= pcValueIn;
	end if;
end process;
end behavioral;