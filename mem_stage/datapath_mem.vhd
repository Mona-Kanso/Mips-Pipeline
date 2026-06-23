----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    datapath_mem - Structural;
-- Description:    Componente responsavel por integrar os modulos do estagio Memory (MEM).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_mem is
    port (
        clock : in std_logic;
        reset : in std_logic;

        -- Dados vindos do registrador EX/MEM
        alu_result_in : in std_logic_vector(3 downto 0);
        write_data_in : in std_logic_vector(3 downto 0);
        reg_dest_in   : in std_logic_vector(2 downto 0);

        -- Sinais de controle vindos do EX/MEM
        mem_read_in   : in std_logic;
        mem_write_in  : in std_logic;
        reg_write_in  : in std_logic;
        mem_to_reg_in : in std_logic;

        -- Dados que saem para o estagio WB
        dado_memoria_out : out std_logic_vector(3 downto 0);
        alu_result_out   : out std_logic_vector(3 downto 0);
        reg_dest_out     : out std_logic_vector(2 downto 0);

        -- Sinais de controle que saem para o estagio WB
        reg_write_out  : out std_logic;
        mem_to_reg_out : out std_logic
    );
end datapath_mem;

architecture Structural of datapath_mem is

    signal dado_lido_memoria : std_logic_vector(3 downto 0);

begin


    inst_memoria_dados : entity work.memoria_dados
        port map (
            clock      => clock,
            mem_read   => mem_read_in,
            mem_write  => mem_write_in,
            address    => alu_result_in,
            write_data => write_data_in,
            read_data  => dado_lido_memoria
        );

 
    inst_mem_wb : entity work.mem_wb
        port map (
            clock => clock,
            reset => reset,

            dado_memoria_in => dado_lido_memoria,
            alu_result_in   => alu_result_in,
            reg_dest_in     => reg_dest_in,

            reg_write_in  => reg_write_in,
            mem_to_reg_in => mem_to_reg_in,

            dado_memoria_out => dado_memoria_out,
            alu_result_out   => alu_result_out,
            reg_dest_out     => reg_dest_out,

            reg_write_out  => reg_write_out,
            mem_to_reg_out => mem_to_reg_out
        );

end Structural;