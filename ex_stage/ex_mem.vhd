library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex_mem is
    port(
        clock : in std_logic;
        reset : in std_logic;

        resultado_ula_in : in std_logic_vector(3 downto 0);
        dado_memoria_in  : in std_logic_vector(3 downto 0);
        reg_dest_in      : in std_logic_vector(3 downto 0);

        reg_write_in  : in std_logic;
        mem_write_in  : in std_logic;
        mem_read_in   : in std_logic;
        mem_to_reg_in : in std_logic;

        resultado_ula_out : out std_logic_vector(3 downto 0);
        dado_memoria_out  : out std_logic_vector(3 downto 0);
        reg_dest_out      : out std_logic_vector(3 downto 0);

        reg_write_out  : out std_logic;
        mem_write_out  : out std_logic;
        mem_read_out   : out std_logic;
        mem_to_reg_out : out std_logic
    );
end ex_mem;

architecture Behavioral of ex_mem is
begin
    process(clock, reset)
    begin
        if reset = '1' then
            resultado_ula_out <= (others => '0');
            dado_memoria_out <= (others => '0');
            reg_dest_out <= (others => '0');

            reg_write_out <= '0';
            mem_write_out <= '0';
            mem_read_out <= '0';
            mem_to_reg_out <= '0';

        elsif rising_edge(clock) then
            resultado_ula_out <= resultado_ula_in;
            dado_memoria_out <= dado_memoria_in;
            reg_dest_out <= reg_dest_in;

            reg_write_out <= reg_write_in;
            mem_write_out <= mem_write_in;
            mem_read_out <= mem_read_in;
            mem_to_reg_out <= mem_to_reg_in;
        end if;
    end process;
end Behavioral;