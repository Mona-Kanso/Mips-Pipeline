----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    if_stage - Structural;
-- Description:    Componente responsvel por integrar os mdulos do estgio Instruction Fetch (IF).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_stage is
    generic (
        n: integer := 4;
        m: integer := 8
    );
    Port (
        clock     : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        instr_out : out STD_LOGIC_VECTOR(m-1 downto 0); -- sada do reg_if_id para o prximo estgio (ID)
        pc_out    : out STD_LOGIC_VECTOR(n-1 downto 0) -- sada para depurao do cdigo
    );
end if_stage;

architecture Structural of if_stage is

    signal pc_atual  : STD_LOGIC_VECTOR(n-1 downto 0);
    signal pc_prox   : STD_LOGIC_VECTOR(n-1 downto 0);
    signal instrucao : STD_LOGIC_VECTOR(m-1 downto 0);

begin

	 -- Program Counter
    PC_inst : entity work.pc
        port map (
            clock  => clock,
            reset  => reset,
            pc_in  => pc_prox,
            pc_out => pc_atual
        );

	 -- Incrementador do Program Counter
    INC_inst : entity work.inc
        port map (
            inc_in  => pc_atual,
            inc_out => pc_prox
        );

    -- Memria de Instrues (ROM)
    ROM_inst : entity work.rom
        port map (
            rom_in  => pc_atual,
            rom_out => instrucao
        );

    -- Registrador IF/ID
    REG_IF_ID_inst : entity work.reg_if_id
        port map (
            clock  => clock,
            reset  => reset,
            if_in  => instrucao,
            id_out => instr_out -- Saida para ID
        );

    pc_out <= pc_atual; -- saida de depuracao

end Structural;
