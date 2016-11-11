library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity registers is
	port (
		read_reg_1, read_reg_2, write_reg: in STD_LOGIC_VECTOR(4 downto 0);
		write_data: in STD_LOGIC_VECTOR (31 downto 0);
		RegWrite, ck: in STD_LOGIC;
		read_data_1: out STD_LOGIC_VECTOR (31 downto 0);
		read_data_2: out STD_LOGIC_VECTOR (31 downto 0)
	);
end registers;


architecture behavioral of registers is	  

type reg_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

signal regs: reg_array := (
 X"00000000", -- initialize data memory
    X"00000000", -- mem 1
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 10 
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000005",
    X"0000000A",
    X"00000001",
    X"00000000", -- mem 20	
    X"FFFFFFFD",
    X"00000004",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 30
    X"00000000");

begin

reg_process: process(read_reg_1, read_reg_2, write_data,ck)
begin
	if ck = '1' and ck'event then
		if read_reg_1 = write_reg then
			read_data_1 <= write_data;
		else
			read_data_1 <= regs(conv_integer(read_reg_1));
		end if;
		if read_reg_2 = write_reg then
			read_data_2 <= write_data;
		else
			read_data_2 <= regs(conv_integer(read_reg_2));
		end if;
	end if;
	if ck = '1' and ck'event then --was ck = '0'
	  	if (RegWrite = '1') then
		 	regs(conv_integer(write_reg)) <= write_data;
		end if;
	end if;
end process reg_process;

end behavioral;

