----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    mem_wb - Behavioral;
-- Description:    Registrador de pipeline entre os estagios MEM e WB.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem_wb is
    port(
        clock : in std_logic;
        reset : in std_logic;

        -- Dados vindos do estagio MEM
        dado_memoria_in : in std_logic_vector(3 downto 0);
        alu_result_in   : in std_logic_vector(3 downto 0);
        reg_dest_in     : in std_logic_vector(2 downto 0);

        -- Sinais de controle vindos do estagio MEM
        reg_write_in  : in std_logic;
        mem_to_reg_in : in std_logic;

        -- Dados enviados para o estagio WB
        dado_memoria_out : out std_logic_vector(3 downto 0);
        alu_result_out   : out std_logic_vector(3 downto 0);
        reg_dest_out     : out std_logic_vector(2 downto 0);

        -- Sinais de controle enviados para o estagio WB
        reg_write_out  : out std_logic;
        mem_to_reg_out : out std_logic
    );
end mem_wb;

architecture Behavioral of mem_wb is
begin

    process(clock, reset)
    begin
        if reset = '1' then
            dado_memoria_out <= (others => '0');
            alu_result_out   <= (others => '0');
            reg_dest_out     <= (others => '0');

            reg_write_out  <= '0';
            mem_to_reg_out <= '0';

        elsif rising_edge(clock) then
            dado_memoria_out <= dado_memoria_in;
            alu_result_out   <= alu_result_in;
            reg_dest_out     <= reg_dest_in;

            reg_write_out  <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
        end if;
    end process;

end Behavioral;