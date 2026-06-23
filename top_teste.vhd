library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pipeline_debug is
    port (
        clock : in std_logic;
        reset : in std_logic;

        -- DEBUG IF
        db_if_pc        : out std_logic_vector(3 downto 0);
        db_if_instrucao : out std_logic_vector(11 downto 0);

        -- DEBUG ID
        db_id_acumulador  : out std_logic_vector(3 downto 0);
        db_id_registrador : out std_logic_vector(3 downto 0);
        db_id_imediato    : out std_logic_vector(3 downto 0);
        db_id_rt          : out std_logic_vector(2 downto 0);
        db_id_rd          : out std_logic_vector(2 downto 0);

        db_id_reg_dst    : out std_logic;
        db_id_reg_write  : out std_logic;
        db_id_alu_src    : out std_logic;
        db_id_alu_ctrl   : out std_logic_vector(2 downto 0);
        db_id_mem_write  : out std_logic;
        db_id_mem_read   : out std_logic;
        db_id_mem_to_reg : out std_logic;

        -- DEBUG EX
        db_ex_resultado_ula : out std_logic_vector(3 downto 0);
        db_ex_dado_memoria  : out std_logic_vector(3 downto 0);
        db_ex_reg_dest      : out std_logic_vector(2 downto 0);

        db_ex_reg_write  : out std_logic;
        db_ex_mem_write  : out std_logic;
        db_ex_mem_read   : out std_logic;
        db_ex_mem_to_reg : out std_logic;

        -- DEBUG MEM
        db_mem_dado_memoria : out std_logic_vector(3 downto 0);
        db_mem_alu_result   : out std_logic_vector(3 downto 0);
        db_mem_reg_dest     : out std_logic_vector(2 downto 0);

        db_mem_reg_write  : out std_logic;
        db_mem_mem_to_reg : out std_logic;

        -- DEBUG WB
        db_wb_write_data : out std_logic_vector(3 downto 0);
        db_wb_write_reg  : out std_logic_vector(2 downto 0);
        db_wb_reg_write  : out std_logic
    );
end pipeline_debug;

architecture Structural of pipeline_debug is

    -- if -> id
    signal if_pc        : std_logic_vector(3 downto 0);
    signal if_instrucao : std_logic_vector(11 downto 0);

    -- id -> ex
    signal id_acumulador  : std_logic_vector(3 downto 0);
    signal id_registrador : std_logic_vector(3 downto 0);
    signal id_imediato    : std_logic_vector(3 downto 0);
    signal id_rt          : std_logic_vector(2 downto 0);
    signal id_rd          : std_logic_vector(2 downto 0);
    signal id_reg_dst    : std_logic;
    signal id_reg_write  : std_logic;
    signal id_alu_src    : std_logic;
    signal id_alu_ctrl   : std_logic_vector(2 downto 0);
    signal id_mem_write  : std_logic;
    signal id_mem_read   : std_logic;
    signal id_mem_to_reg : std_logic;

    -- ex -> mem
    signal ex_resultado_ula : std_logic_vector(3 downto 0);
    signal ex_dado_memoria  : std_logic_vector(3 downto 0);
    signal ex_reg_dest      : std_logic_vector(2 downto 0);
    signal ex_reg_write  : std_logic;
    signal ex_mem_write  : std_logic;
    signal ex_mem_read   : std_logic;
    signal ex_mem_to_reg : std_logic;

    -- mem -> wb
    signal mem_dado_memoria : std_logic_vector(3 downto 0);
    signal mem_alu_result   : std_logic_vector(3 downto 0);
    signal mem_reg_dest     : std_logic_vector(2 downto 0);
    signal mem_reg_write  : std_logic;
    signal mem_mem_to_reg : std_logic;

    -- wb
    signal wb_write_data : std_logic_vector(3 downto 0);
    signal wb_write_reg  : std_logic_vector(2 downto 0);
    signal wb_reg_write  : std_logic;

begin

    -- IF Stage
    inst_if : entity work.datapath_if
        port map (
            clock     => clock,
            reset     => reset,
            instr_out => if_instrucao,
            pc_out    => if_pc
        );

    -- ID Stage
    inst_id : entity work.datapath_id
        port map (
            clock => clock,
            reset => reset,
            instrucao_in => if_instrucao,

            wb_regWrite      => wb_reg_write,
            wb_writeRegister => wb_write_reg,
            wb_writeData     => wb_write_data,

            acumulador_out  => id_acumulador,
            registrador_out => id_registrador,
            imediato_out    => id_imediato,

            rt_out => id_rt,
            rd_out => id_rd,

            reg_dst_out    => id_reg_dst,
            reg_write_out  => id_reg_write,
            alu_src_out    => id_alu_src,
            alu_ctrl_out   => id_alu_ctrl,
            mem_write_out  => id_mem_write,
            mem_read_out   => id_mem_read,
            mem_reg_out    => id_mem_to_reg
        );

    -- EX Stage
    inst_ex : entity work.datapath_ex
        port map (
            clock => clock,
            reset => reset,

            acumulador_in  => id_acumulador,
            registrador_in => id_registrador,
            imediato_in    => id_imediato,

            rt_in => id_rt,
            rd_in => id_rd,

            reg_dst_in    => id_reg_dst,
            reg_write_in  => id_reg_write,
            alu_src_in    => id_alu_src,
            alu_ctrl_in   => id_alu_ctrl,
            mem_write_in  => id_mem_write,
            mem_read_in   => id_mem_read,
            mem_to_reg_in => id_mem_to_reg,

            resultado_ula_out => ex_resultado_ula,
            dado_memoria_out  => ex_dado_memoria,
            reg_dest_out      => ex_reg_dest,

            reg_write_out  => ex_reg_write,
            mem_write_out  => ex_mem_write,
            mem_read_out   => ex_mem_read,
            mem_to_reg_out => ex_mem_to_reg
        );

    -- MEM Stage
    inst_mem : entity work.datapath_mem
        port map (
            clock => clock,
            reset => reset,

            alu_result_in => ex_resultado_ula,
            write_data_in => ex_dado_memoria,
            reg_dest_in   => ex_reg_dest,

            mem_read_in   => ex_mem_read,
            mem_write_in  => ex_mem_write,
            reg_write_in  => ex_reg_write,
            mem_to_reg_in => ex_mem_to_reg,

            dado_memoria_out => mem_dado_memoria,
            alu_result_out   => mem_alu_result,
            reg_dest_out     => mem_reg_dest,

            reg_write_out  => mem_reg_write,
            mem_to_reg_out => mem_mem_to_reg
        );

    -- WB Stage
    inst_wb : entity work.datapath_wb
        port map (
            dado_memoria_in => mem_dado_memoria,
            alu_result_in   => mem_alu_result,
            reg_dest_in     => mem_reg_dest,

            reg_write_in  => mem_reg_write,
            mem_to_reg_in => mem_mem_to_reg,

            write_data_out => wb_write_data,
            write_reg_out  => wb_write_reg,
            reg_write_out  => wb_reg_write
        );

    -- Saidas de debug IF
    db_if_pc        <= if_pc;
    db_if_instrucao <= if_instrucao;

    -- Saidas de debug ID
    db_id_acumulador  <= id_acumulador;
    db_id_registrador <= id_registrador;
    db_id_imediato    <= id_imediato;
    db_id_rt          <= id_rt;
    db_id_rd          <= id_rd;

    db_id_reg_dst    <= id_reg_dst;
    db_id_reg_write  <= id_reg_write;
    db_id_alu_src    <= id_alu_src;
    db_id_alu_ctrl   <= id_alu_ctrl;
    db_id_mem_write  <= id_mem_write;
    db_id_mem_read   <= id_mem_read;
    db_id_mem_to_reg <= id_mem_to_reg;

    -- Sadas de debug EX
    db_ex_resultado_ula <= ex_resultado_ula;
    db_ex_dado_memoria  <= ex_dado_memoria;
    db_ex_reg_dest      <= ex_reg_dest;

    db_ex_reg_write  <= ex_reg_write;
    db_ex_mem_write  <= ex_mem_write;
    db_ex_mem_read   <= ex_mem_read;
    db_ex_mem_to_reg <= ex_mem_to_reg;

    -- Sadas de debug MEM
    db_mem_dado_memoria <= mem_dado_memoria;
    db_mem_alu_result   <= mem_alu_result;
    db_mem_reg_dest     <= mem_reg_dest;

    db_mem_reg_write  <= mem_reg_write;
    db_mem_mem_to_reg <= mem_mem_to_reg;

    -- Sadas de debug WB
    db_wb_write_data <= wb_write_data;
    db_wb_write_reg  <= wb_write_reg;
    db_wb_reg_write  <= wb_reg_write;

end Structural;