----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    unidade_controle - Behavioral;
-- Description:    Unidade de controle do processador.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidade_controle is
    port(
        opcode      : in  std_logic_vector(2 downto 0); -- Bits [11:9] da instruo
        reg_dst     : out std_logic;
        alu_src     : out std_logic;
        mem_to_reg  : out std_logic;
        reg_write   : out std_logic;
        mem_read    : out std_logic;
        mem_write   : out std_logic;
        alu_ctrl    : out std_logic_vector(2 downto 0) -- Vai DIRETO para a ULA
    );
end unidade_controle;

architecture Behavioral of unidade_controle is
begin
    process(opcode)
    begin
        -- Inicializao para evitar Latch
        reg_dst    <= '0';
        alu_src    <= '0';
        mem_to_reg <= '0';
        reg_write  <= '0';
        mem_read   <= '0';
        mem_write  <= '0';
        alu_ctrl   <= "000";

        case opcode is
            when "001" => -- ADD (Tipo R)
                reg_dst   <= '1';
                reg_write <= '1';
                alu_ctrl  <= "010"; -- Cdigo ADD da ULA
                
            when "010" => -- SUB (Tipo R)
                reg_dst   <= '1';
                reg_write <= '1';
                alu_ctrl  <= "110"; -- Cdigo SUB da ULA
                
            when "011" => -- AND (Tipo R - Reutilizando o slot do AND do Green Card)
                reg_dst   <= '1';
                reg_write <= '1';
                alu_ctrl  <= "011";
                
            when "100" => -- LOAD (Tipo I)
                alu_src    <= '1';
                mem_to_reg <= '1';
                reg_write  <= '1';
                mem_read   <= '1';
                alu_ctrl   <= "010"; -- Soma para o endereo
                
            when "101" => -- STORE (Tipo I)
                alu_src   <= '1';
                mem_write <= '1';
                alu_ctrl  <= "010"; -- Soma para o endereo
                
            when "110" => -- ADDI (Tipo I)
                alu_src   <= '1';
                reg_write <= '1';
                alu_ctrl  <= "010"; -- Cdigo ADD
                
            when others => -- NOP (000) ou cdigos no mapeados
                null;
        end case;
    end process;
end Behavioral; 