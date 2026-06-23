----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    datapath_ex - Structural;
-- Description:    Componente responsavel por integrar os modulos do estagio Execute (EX).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_ex is
    port (
        clock : in std_logic;
        reset : in std_logic;

        -- Entradas vindas do registrador ID/EX
        acumulador_in  : in std_logic_vector(3 downto 0);
        registrador_in : in std_logic_vector(3 downto 0);
        imediato_in    : in std_logic_vector(3 downto 0);

        -- rt e rd vindos do ID/EX
        rt_in : in std_logic_vector(2 downto 0);
        rd_in : in std_logic_vector(2 downto 0);

        -- Sinais de controle vindos do ID/EX
        reg_dst_in    : in std_logic;
        reg_write_in  : in std_logic;
        alu_src_in    : in std_logic;
        alu_ctrl_in   : in std_logic_vector(2 downto 0);
        mem_write_in  : in std_logic;
        mem_read_in   : in std_logic;
        mem_to_reg_in : in std_logic;

        -- Saidas do registrador EX/MEM para o estagio MEM
        resultado_ula_out : out std_logic_vector(3 downto 0);
        dado_memoria_out  : out std_logic_vector(3 downto 0);
        reg_dest_out      : out std_logic_vector(2 downto 0);

        -- Sinais de controle que saem do EX/MEM
        reg_write_out  : out std_logic;
        mem_write_out  : out std_logic;
        mem_read_out   : out std_logic;
        mem_to_reg_out : out std_logic
    );
end datapath_ex;

architecture Structural of datapath_ex is

    signal entrada_b_ula  : std_logic_vector(3 downto 0);
    signal resultado_ula  : std_logic_vector(3 downto 0);
    signal zero_ula       : std_logic;
    signal reg_dest_3     : std_logic_vector(2 downto 0);
    signal reg_dest_in_4  : std_logic_vector(3 downto 0);
    signal reg_dest_out_4 : std_logic_vector(3 downto 0);

begin

    -- ajuste de largura para o registrador EX/MEM
    reg_dest_in_4 <= '0' & reg_dest_3;
    reg_dest_out <= reg_dest_out_4(2 downto 0);

    -- mux da ULA
    inst_mux_alusrc : entity work.mux_4b
        port map (
            a        => registrador_in,
            b        => imediato_in,
            enable   => alu_src_in,
            data_out => entrada_b_ula
        );

    -- ULA principal do estagio EX
    inst_ula : entity work.ULA_MIPS
        port map (
            a           => acumulador_in,
            b           => entrada_b_ula,
            alu_control => alu_ctrl_in,
            result      => resultado_ula,
            zero        => zero_ula
        );

    -- mux do registrador de destino
    inst_mux_regdst : entity work.mux_3b
        port map (
            a        => rt_in,
            b        => rd_in,
            enable   => reg_dst_in,
            data_out => reg_dest_3
        );

    -- registrador de pipeline EX/MEM
    inst_ex_mem : entity work.ex_mem
        port map (
            clock => clock,
            reset => reset,

            resultado_ula_in => resultado_ula,
            dado_memoria_in  => registrador_in,
            reg_dest_in      => reg_dest_in_4,

            reg_write_in  => reg_write_in,
            mem_write_in  => mem_write_in,
            mem_read_in   => mem_read_in,
            mem_to_reg_in => mem_to_reg_in,

            resultado_ula_out => resultado_ula_out,
            dado_memoria_out  => dado_memoria_out,
            reg_dest_out      => reg_dest_out_4,

            reg_write_out  => reg_write_out,
            mem_write_out  => mem_write_out,
            mem_read_out   => mem_read_out,
            mem_to_reg_out => mem_to_reg_out
        );

end Structural;