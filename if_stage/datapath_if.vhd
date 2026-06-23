----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    datapath_if - Structural;
-- Description:    Componente responsavel por integrar os modulos do estagio Instruction Fetch (IF).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_if is
    generic (
        pc_b: integer := 4;
        inst_b: integer := 12
    );
    Port (
        clock     : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        instr_out : out STD_LOGIC_VECTOR(inst_b-1 downto 0); -- saida do reg_if_id para o proximo estagio (ID)
        pc_out    : out STD_LOGIC_VECTOR(pc_b-1 downto 0) -- saida para depuracao do codigo
    );
end datapath_if ;

architecture Structural of datapath_if is

    signal pc_atual  : STD_LOGIC_VECTOR(pc_b-1 downto 0);
    signal pc_prox   : STD_LOGIC_VECTOR(pc_b-1 downto 0);
    signal instrucao : STD_LOGIC_VECTOR(inst_b-1 downto 0);

begin

	 -- Program Counter
    inst_pc	 : entity work.pc
        port map (
            clock  => clock,
            reset  => reset,
            pc_in  => pc_prox,
            pc_out => pc_atual
        );

	 -- Incrementador do Program Counter
    inst_inc : entity work.inc
        port map (
            inc_in  => pc_atual,
            inc_out => pc_prox
        );

    -- Memoria de Instrucoes (ROM)
    inst_rom : entity work.rom
        port map (
            rom_in  => pc_atual,
            rom_out => instrucao
        );

    -- Registrador IF/ID
    inst_if_id : entity work.if_id
        port map (
            clock  => clock,
            reset  => reset,
            instrucao_in  => instrucao,
            instrucao_out => instr_out -- Saida para ID
        );

    pc_out <= pc_atual; -- saida de depuracao

end Structural;
