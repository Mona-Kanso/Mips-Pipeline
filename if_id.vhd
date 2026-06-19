library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_id is
    port(
        clock         : in  std_logic;
        reset         : in  std_logic;

        pc_in         : in  std_logic_vector(3 downto 0);
        instrucao_in  : in  std_logic_vector(7 downto 0);

        pc_out        : out std_logic_vector(3 downto 0);
        instrucao_out : out std_logic_vector(7 downto 0)
    );
end if_id;

architecture Behavioral of if_id is
begin
    process(clock, reset)
    begin
        if reset = '1' then
            pc_out        <= (others => '0');
            instrucao_out <= (others => '0');

        elsif rising_edge(clock) then
            pc_out        <= pc_in;
            instrucao_out <= instrucao_in;
        end if;
    end process;
end Behavioral;