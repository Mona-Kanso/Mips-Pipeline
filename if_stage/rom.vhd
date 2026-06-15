----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    rom - Behavioral
-- Description:    Memoria responsavel por armazenar as instrues do processador.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity rom is
	generic (
			n: integer := 4;
			m: integer := 16
			);
    Port ( rom_in : in  std_logic_vector(n-1 downto 0);
           rom_out : out  std_logic_vector(m-1 downto 0)
			 );
end rom;

architecture Behavioral of rom is

	type v_instruct is array (0 to m-1) of std_logic_vector(m-1 downto 0);
	
	-- Memria ROM vazia
	constant rom_content: v_instruct := (
	
        0  => "0000000000000000",
        1  => "0000000000000000",
        2  => "0000000000000000",
        3  => "0000000000000000",
        4  => "0000000000000000",
        5  => "0000000000000000",
        6  => "0000000000000000",
        7  => "0000000000000000",
        8  => "0000000000000000",
        9  => "0000000000000000",
        10 => "0000000000000000",
        11 => "0000000000000000",
        12 => "0000000000000000",
        13 => "0000000000000000",
        14 => "0000000000000000",
        15 => "0000000000000000",

      others => (others => '0')
    );
	 
begin
	process(rom_in)
		begin
			rom_out <= rom_content(to_integer(unsigned(rom_in)));
		end process;
end Behavioral;