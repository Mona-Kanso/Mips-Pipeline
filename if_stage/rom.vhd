----------------------------------------------------------------------------------
-- Design Name: Memória ROM de Instruções
-- Module Name: rom - Behavioral
-- Project Name: pipe4
-- Description: Memória responsável por armazenar as instruções do processador.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity rom is
	generic (
			n: integer := 4;
			m: integer := 16;
			p: integer := 8
			);
    Port ( rom_in : in  std_logic_vector(n-1 downto 0);
           rom_out : out  std_logic_vector(p-1 downto 0)
			 );
end rom;

architecture Behavioral of rom is

	type v_instruct is array (0 to m-1) of std_logic_vector(p-1 downto 0);
	
	-- Memória ROM vazia
	constant rom_content: v_instruct := (
	
        0  => "00000000",
        1  => "00000000",
        2  => "00000000",
        3  => "00000000",
        4  => "00000000",
        5  => "00000000",
        6  => "00000000",
        7  => "00000000",
        8  => "00000000",
        9  => "00000000",
        10 => "00000000",
        11 => "00000000",
        12 => "00000000",
        13 => "00000000",
        14 => "00000000",
        15 => "00000000",

      others => (others => '0')
    );
	 
begin
	process(rom_in)
		begin
			rom_out <= rom_content(to_integer(unsigned(rom_in)));
		end process;
end Behavioral;
