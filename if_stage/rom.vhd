----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    rom - Behavioral
-- Description:    Memoria responsavel por armazenar as instrucoes do processador.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity rom is
	generic (
			pc_b: integer := 4;
			rom_b: integer := 12;
			add_b: integer := 16
			);
    Port ( rom_in : in  std_logic_vector(pc_b-1 downto 0);
           rom_out : out  std_logic_vector(rom_b-1 downto 0)
			 );
end rom;

architecture Behavioral of rom is

	type v_instruct is array (0 to add_b-1) of std_logic_vector(rom_b-1 downto 0);
	
	constant rom_content: v_instruct := (
	
			0  => "110000100100", -- 0: ADDI R0, R4, 4  
			1  => "110000101101", -- 1: ADDI R0, R5, 5 
			2  => "000000000000", -- 2: NOP
			3  => "000000000000", -- 3: NOP
			4  => "101111100000", -- 4: SW SP, R4, 0(SP)
			5  => "001100101001", -- 5: ADD R4, R5, R1
			6  => "010101100010", -- 6: SUB R5, R4, R2
			7  => "100111001000", -- 7: LW SP, R1, 0(SP)
			
			others => (others => '0')
    );
	 
begin
	process(rom_in)
		begin
			rom_out <= rom_content(to_integer(unsigned(rom_in)));
		end process;
end Behavioral;