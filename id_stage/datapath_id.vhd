----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    datapath_id - Structural;
-- Description:    Componente responsavel por integrar os modulos do estagio Instruction Decoder (ID).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_id is
    port (
        clock : in std_logic;
        reset : in std_logic;
		  
        -- Instrucao vinda do IF/ID
        instrucao_in : in std_logic_vector(11 downto 0);

        -- Entradas vindas do WB para escrita no banco de registradores
        wb_regWrite      : in std_logic;
        wb_writeRegister : in std_logic_vector(2 downto 0);
        wb_writeData     : in std_logic_vector(3 downto 0);

        -- Saidas do registrador ID/EX para o estagio EX
        acumulador_out  : out std_logic_vector(3 downto 0);
        registrador_out : out std_logic_vector(3 downto 0);
        imediato_out    : out std_logic_vector(3 downto 0);

        -- rt e rd
        rt_out : out std_logic_vector(2 downto 0);
        rd_out : out std_logic_vector(2 downto 0);

        -- Sinais de controle que saem do ID/EX
        reg_dst_out    : out std_logic;
        reg_write_out  : out std_logic;
        alu_src_out    : out std_logic;
        alu_ctrl_out   : out std_logic_vector(2 downto 0);
        mem_write_out  : out std_logic;
        mem_read_out   : out std_logic;
        mem_reg_out    : out std_logic
    );
end datapath_id;

architecture Structural of datapath_id is

    signal opcode : std_logic_vector(2 downto 0);
    signal rs     : std_logic_vector(2 downto 0);
    signal rt     : std_logic_vector(2 downto 0);
    signal rd     : std_logic_vector(2 downto 0);
    signal imm3   : std_logic_vector(2 downto 0);
    signal imm4   : std_logic_vector(3 downto 0);

    signal read_data1 : std_logic_vector(3 downto 0);
    signal read_data2 : std_logic_vector(3 downto 0);

    -- sinais internos da unidade de controle
    signal uc_reg_dst    : std_logic;
    signal uc_reg_write  : std_logic;
    signal uc_alu_src    : std_logic;
    signal uc_mem_write  : std_logic;
    signal uc_mem_read   : std_logic;
    signal uc_mem_reg    : std_logic;
    signal uc_alu_ctrl   : std_logic_vector(2 downto 0);

begin

    -- separacao da instrucao
    opcode <= instrucao_in(11 downto 9);
    rs     <= instrucao_in(8 downto 6);
    rt     <= instrucao_in(5 downto 3);
    rd     <= instrucao_in(2 downto 0);
    imm3   <= instrucao_in(2 downto 0);

    -- unidade de controle
    inst_control : entity work.unidade_controle
        port map (
            opcode     => opcode,
            reg_dst    => uc_reg_dst,
            alu_src    => uc_alu_src,
            mem_to_reg => uc_mem_reg,
            reg_write  => uc_reg_write,
            mem_read   => uc_mem_read,
            mem_write  => uc_mem_write,
            alu_ctrl   => uc_alu_ctrl
        );

    -- banco de registradores
    inst_registers : entity work.banco_registradores
        port map (
            clock          => clock,
            reset          => reset,
            read_register1 => rs,
            read_register2 => rt,
            write_register => wb_writeRegister,
            write_data     => wb_writeData,
            read_data1     => read_data1,
            read_data2     => read_data2,
            reg_write      => wb_regWrite
        );

    -- extensor de sinal
    inst_zero_extended : entity work.zero_extended
        port map (
            data_in  => imm3,
            data_out => imm4
        );

    -- registrador de pipeline ID/EX
    inst_id_ex : entity work.id_ex
        port map (
            clock => clock,
            reset => reset,

            acumulador_in  => read_data1, -- dado rs
            registrador_in => read_data2, -- dado rt
            imediato_in    => imm4,

            rt_in => rt,
            rd_in => rd,

            reg_dst_in    => uc_reg_dst,
            reg_write_in  => uc_reg_write,
            alu_src_in    => uc_alu_src,
            alu_ctrl_in   => uc_alu_ctrl,
            mem_write_in  => uc_mem_write,
            mem_read_in   => uc_mem_read,
            mem_to_reg_in => uc_mem_reg,

            acumulador_out  => acumulador_out,
            registrador_out => registrador_out,
            imediato_out    => imediato_out,

            rt_out => rt_out,
            rd_out => rd_out,

            reg_dst_out    => reg_dst_out,
            reg_write_out  => reg_write_out,
            alu_src_out    => alu_src_out,
            alu_ctrl_out   => alu_ctrl_out,
            mem_write_out  => mem_write_out,
            mem_read_out   => mem_read_out,
            mem_to_reg_out => mem_reg_out
        );

end Structural;