----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    banco_registradores - Behavioral;
-- Description:    banco de registradores do processador;
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity banco_registradores is
	generic( 
        n: integer := 32;
        bits_enderecamento: integer := 5;
		  num_registradores	:	integer := 8
    );

	port(
		read_register1: in std_logic_vector(bits_enderecamento-1 downto 0);
        read_register2: in std_logic_vector(bits_enderecamento-1 downto 0);
        write_register: in std_logic_vector(bits_enderecamento-1 downto 0);
        write_data: in std_logic_vector(n-1 downto 0);
        read_data1: out std_logic_vector(n-1 downto 0);
        read_data2: out std_logic(n-1 downto 0);
        reg_write: in std_logic
	);
	
end banco_registradores;

architecture Behavioral of banco_registradores is

	type t_reg_array is array (0 to num_registradores-1) of std_logic_vector(n-1 downto 0);
    signal s_registradores: t_reg_array := (others => (others => '0'));
begin

    -- processo de escrita
    process(clock)
    begin
        if falling_edge(clock) then
            if reg_wirte = '1' then
                s_registradores(to_integer(unsigned(write_register(bits_enderecamento-1 downto 0)))) <= wirte_data;
            end if;
        end if;
    end process;

    -- saidas
    read_data1 <= s_registradores(to_integer(unsigned(read_register1(bits_enderecamento-1 downto 0))));
    read_data2 <= s_registradores(to_integer(unsigned(read_register2(bits_enderecamento-1 downto 0))));
	 
end Behavioral;

