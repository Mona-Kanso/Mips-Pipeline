----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    zero_extended - Structural;
-- Description:    Extensor de bits para numeros positivos;
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zero_extended is
    generic (
        imm_b: integer := 3; -- Tamanho do Imediato na instrucao
        data_b: integer := 4  -- Tamanho do datapath da ULA
    );
    port (
        data_in:  in  std_logic_vector(imm_b-1 downto 0);
        data_out: out std_logic_vector(data_b-1 downto 0)           
    );
end zero_extended;

architecture Behavioral of zero_extended is
begin
    process(data_in)
    begin
        data_out <= "0" & data_in;
    end process;
end Behavioral;