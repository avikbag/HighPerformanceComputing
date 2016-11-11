library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity instructionMemory is
  port (
    address: in STD_LOGIC_VECTOR(31 downto 0);
    instruction: out STD_LOGIC_VECTOR(31 downto 0)
  );
end instructionMemory;

architecture behavioral of instructionMemory is
  
type ins_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

signal ins_mem: ins_array := (
    X"02954020", -- initialize ins memory
    X"02d74822", -- mem 1
    X"01098020",
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
    X"00000000",
    X"00000000",
    X"00000000",  
    X"00000000", -- mem 20
    X"00000000",
    X"00000000",
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

instruction <= ins_mem(conv_integer(address(6 downto 2)));

end behavioral;
