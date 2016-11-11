library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
  port (
    read_data_1: in STD_LOGIC_VECTOR (31 downto 0);
    read_data_2: in STD_LOGIC_VECTOR (31 downto 0);
    shamt: in STD_LOGIC_VECTOR(4 downto 0);
    ALUControl: in STD_LOGIC_VECTOR (3 downto 0);
    zero: out STD_LOGIC;
    ALUResult: out STD_LOGIC_VECTOR(31 downto 0)
  );
end ALU;

architecture behavioral of ALU is
  
begin
  ALU_process: process(read_data_1, read_data_2, ALUControl)
  begin
    if ALUControl = "0010" then
	zero <= '0';
        ALUResult <= std_logic_vector(signed(read_data_2) + signed(read_data_1));
    elsif ALUControl = "0110" then
	if signed(read_data_1) - signed(read_data_2) = X"00000000" then
		zero <= '1';
	else
		zero <= '0';
	end if;
        ALUResult <= std_logic_vector(signed(read_data_1) - signed(read_data_2));
    elsif ALUControl = "0000" then
	zero <= '0';
        ALUResult <= std_logic_vector(signed(read_data_1) and signed(read_data_2));
    elsif ALUControl = "0001" then
	zero <= '0';
        ALUResult <= std_logic_vector(signed(read_data_1) or signed(read_data_2));
    elsif ALUControl = "0111" then
	zero <= '0';
        if signed(read_data_1) < signed(read_data_2) then
          ALUResult <= "00000000000000000000000000000001";
        else
          ALUResult <= "00000000000000000000000000000000";
        end if;
    elsif ALUControl = "0011" then
	ALUResult <= std_logic_vector(shift_left(signed(read_data_2),to_integer(unsigned(shamt))));
    elsif ALUControl = "0100" then
	if signed(read_data_1) - signed(read_data_2) /= X"00000000" then
		zero <= '1';
	else
		zero <= '0';
	end if;
    end if;
  end process;
end behavioral;