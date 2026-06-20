library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sign_extended is
    generic (
        i: integer := 3; -- Novo tamanho do Imediato na instrução
        o: integer := 4  -- Tamanho do datapath da ULA
    );
    port (
        data_in:  in  std_logic_vector(i-1 downto 0);
        data_out: out std_logic_vector(o-1 downto 0)           
    );
end sign_extended;

architecture Behavioral of sign_extended is
begin
    process(data_in)
    begin
        -- O bit data_in(2) é o bit de sinal. Ele é concatenado à frente do número.
        data_out <= data_in(2) & data_in;
    end process;
end Behavioral;