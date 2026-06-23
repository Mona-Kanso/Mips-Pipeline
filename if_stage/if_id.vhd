----------------------------------------------------------------------------------
-- Project Name:  Mips-Pipeline; 
-- Module Name:  if_id - Behavioral;
-- Description:  Registrador responsavel por armazenar a instrucao obtida pelo 
-- estagio IF e encaminha-la para o estagio ID.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_id is
    generic (
        inst_b: integer := 12
    );
    port (
        clock         : in  std_logic;
        reset         : in  std_logic;
        instrucao_in  : in  std_logic_vector(inst_b-1 downto 0);
        instrucao_out : out std_logic_vector(inst_b-1 downto 0)
    );
end if_id;

architecture Behavioral of if_id is
begin

    process(clock, reset)
    begin
        if reset = '1' then
            instrucao_out <= (others => '0');
        elsif rising_edge(clock) then
            instrucao_out <= instrucao_in;
        end if;
    end process;

end Behavioral;