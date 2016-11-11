library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ForwardingUnit is
  port (
    RS_IDEX: in STD_LOGIC_VECTOR (4 downto 0);
    RT_IDEX: in STD_LOGIC_VECTOR (4 downto 0);
    RD_EXMEM: in STD_LOGIC_VECTOR(4 downto 0);
    RD_MEMWB: in STD_LOGIC_VECTOR(4 downto 0);
    WB_EXMEM: in STD_LOGIC;
    WB_MEMWB: in STD_LOGIC;
    ForwardA: out STD_LOGIC_VECTOR(1 downto 0);
    ForwardB: out STD_LOGIC_VECTOR(1 downto 0)
  );
end ForwardingUnit;

architecture behavioral of ForwardingUnit is
  
begin
	forwarding: process(RS_IDEX, RT_IDEX, RD_EXMEM, RD_MEMWB, WB_EXMEM, WB_MEMWB)
  	begin
		
			if 	WB_EXMEM = '1' and not(RD_EXMEM ="00000") and RD_EXMEM = RS_IDEX then 	
				ForwardA <= "10";
			elsif 	WB_MEMWB = '1' and RD_MEMWB = RS_IDEX then 
				ForwardA <= "01";
			else
				ForwardA <= "00";
			end if;

			if 	WB_EXMEM = '1' and not(RD_EXMEM ="00000") and RD_EXMEM = RT_IDEX then
				ForwardB <= "10";
			elsif 	WB_MEMWB = '1' and RD_MEMWB = RT_IDEX then
				ForwardB <= "01";
			else
				ForwardB <= "00";
			end if;

	end process;
end behavioral;
