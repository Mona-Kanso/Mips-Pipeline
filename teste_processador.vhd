----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    tb_processador_pipeline - Behavioral;
-- Description:    Testbench do processador_pipeline
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_pipeline_debug is
end tb_pipeline_debug;

architecture Behavioral of tb_pipeline_debug is

    constant CLOCK_TIME : time := 10 ns;

    signal clock : std_logic := '0';
    signal reset : std_logic := '0';

    -- if debug
    signal db_if_pc        : std_logic_vector(3 downto 0);
    signal db_if_instrucao : std_logic_vector(11 downto 0);

    -- id debug
    signal db_id_acumulador  : std_logic_vector(3 downto 0);
    signal db_id_registrador : std_logic_vector(3 downto 0);
    signal db_id_imediato    : std_logic_vector(3 downto 0);
    signal db_id_rt          : std_logic_vector(2 downto 0);
    signal db_id_rd          : std_logic_vector(2 downto 0);
    signal db_id_reg_dst    : std_logic;
    signal db_id_reg_write  : std_logic;
    signal db_id_alu_src    : std_logic;
    signal db_id_alu_ctrl   : std_logic_vector(2 downto 0);
    signal db_id_mem_write  : std_logic;
    signal db_id_mem_read   : std_logic;
    signal db_id_mem_to_reg : std_logic;

    -- ex debug
    signal db_ex_resultado_ula : std_logic_vector(3 downto 0);
    signal db_ex_dado_memoria  : std_logic_vector(3 downto 0);
    signal db_ex_reg_dest      : std_logic_vector(2 downto 0);

    signal db_ex_reg_write  : std_logic;
    signal db_ex_mem_write  : std_logic;
    signal db_ex_mem_read   : std_logic;
    signal db_ex_mem_to_reg : std_logic;

    -- mem debug
    signal db_mem_dado_memoria : std_logic_vector(3 downto 0);
    signal db_mem_alu_result   : std_logic_vector(3 downto 0);
    signal db_mem_reg_dest     : std_logic_vector(2 downto 0);

    signal db_mem_reg_write  : std_logic;
    signal db_mem_mem_to_reg : std_logic;

    -- wb debug
    signal db_wb_write_data : std_logic_vector(3 downto 0);
    signal db_wb_write_reg  : std_logic_vector(2 downto 0);
    signal db_wb_reg_write  : std_logic;

    -- tranforma um vetor de bits em string
    function rel_string(vector : std_logic_vector) return string is
        variable result : string(1 to vector'length);
        variable j      : integer := 1;
    begin
        for i in vector'range loop
            case vector(i) is
                when '0' =>
                    result(j) := '0';
                when '1' =>
                    result(j) := '1';
                when 'U' =>
                    result(j) := 'U'; -- No foi inicializado
                when 'X' =>
                    result(j) := 'X'; -- Conflito de valores
                when others =>
                    result(j) := '?'; -- Desconhecido
            end case;

            j := j + 1;
        end loop;

        return result;
    end function;

begin

    uut : entity work.pipeline_debug
        port map (
            clock => clock,
            reset => reset,
				-- if stage
            db_if_pc        => db_if_pc,
            db_if_instrucao => db_if_instrucao,
				-- id stage
            db_id_acumulador  => db_id_acumulador,
            db_id_registrador => db_id_registrador,
            db_id_imediato    => db_id_imediato,
            db_id_rt          => db_id_rt,
            db_id_rd          => db_id_rd,
            db_id_reg_dst    => db_id_reg_dst,
            db_id_reg_write  => db_id_reg_write,
            db_id_alu_src    => db_id_alu_src,
            db_id_alu_ctrl   => db_id_alu_ctrl,
            db_id_mem_write  => db_id_mem_write,
            db_id_mem_read   => db_id_mem_read,
            db_id_mem_to_reg => db_id_mem_to_reg,
				-- ex stage
            db_ex_resultado_ula => db_ex_resultado_ula,
            db_ex_dado_memoria  => db_ex_dado_memoria,
            db_ex_reg_dest      => db_ex_reg_dest,
            db_ex_reg_write  => db_ex_reg_write,
            db_ex_mem_write  => db_ex_mem_write,
            db_ex_mem_read   => db_ex_mem_read,
            db_ex_mem_to_reg => db_ex_mem_to_reg,
				-- mem stage
            db_mem_dado_memoria => db_mem_dado_memoria,
            db_mem_alu_result   => db_mem_alu_result,
            db_mem_reg_dest     => db_mem_reg_dest,
            db_mem_reg_write  => db_mem_reg_write,
            db_mem_mem_to_reg => db_mem_mem_to_reg,
				-- wb stage
            db_wb_write_data => db_wb_write_data,
            db_wb_write_reg  => db_wb_write_reg,
            db_wb_reg_write  => db_wb_reg_write
        );

    -- Simualacao do clock
    clock_process : process
    begin
        for i in 1 to 20 loop
            clock <= '0';
            wait for CLOCK_TIME / 2;

            clock <= '1';
            wait for CLOCK_TIME / 2;
        end loop;
		  assert false report "Fim da simulacao." severity failure;
    end process;

    -- Reset inicial
    reset_process : process
    begin
        reset <= '1';
        wait for 2 * CLOCK_TIME;

        reset <= '0';
        wait;
    end process;

    -- Relatorio do teste em texto
	 relatorio_process : process
			 variable ciclo : integer := 0;
	 begin
			   wait until rising_edge(clock);
			   wait for 1 ns;

			   ciclo := ciclo + 1;

            report "=================================================";
            report "Ciclo " & integer'image(ciclo) &
                   " | reset=" & std_logic'image(reset);

            report "IF  | pc=" & rel_string(db_if_pc) &
                   " | instr=" & rel_string(db_if_instrucao);

            report "ID  | acc=" & rel_string(db_id_acumulador) &
                   " | reg=" & rel_string(db_id_registrador) &
                   " | imm=" & rel_string(db_id_imediato) &
                   " | rt=" & rel_string(db_id_rt) &
                   " | rd=" & rel_string(db_id_rd);

            report "ID  | reg_dst=" & std_logic'image(db_id_reg_dst) &
                   " | reg_write=" & std_logic'image(db_id_reg_write) &
                   " | alu_src=" & std_logic'image(db_id_alu_src) &
                   " | alu_ctrl=" & rel_string(db_id_alu_ctrl) &
                   " | mem_write=" & std_logic'image(db_id_mem_write) &
                   " | mem_read=" & std_logic'image(db_id_mem_read) &
                   " | mem_to_reg=" & std_logic'image(db_id_mem_to_reg);

            report "EX  | alu_result=" & rel_string(db_ex_resultado_ula) &
                   " | dado_mem=" & rel_string(db_ex_dado_memoria) &
                   " | reg_dest=" & rel_string(db_ex_reg_dest);

            report "EX  | reg_write=" & std_logic'image(db_ex_reg_write) &
                   " | mem_write=" & std_logic'image(db_ex_mem_write) &
                   " | mem_read=" & std_logic'image(db_ex_mem_read) &
                   " | mem_to_reg=" & std_logic'image(db_ex_mem_to_reg);

            report "MEM | dado_mem=" & rel_string(db_mem_dado_memoria) &
                   " | alu_result=" & rel_string(db_mem_alu_result) &
                   " | reg_dest=" & rel_string(db_mem_reg_dest);

            report "MEM | reg_write=" & std_logic'image(db_mem_reg_write) &
                   " | mem_to_reg=" & std_logic'image(db_mem_mem_to_reg);

            report "WB  | write_data=" & rel_string(db_wb_write_data) &
                   " | write_reg=" & rel_string(db_wb_write_reg) &
                   " | reg_write=" & std_logic'image(db_wb_reg_write);

    end process;

end;