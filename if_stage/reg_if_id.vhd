----------------------------------------------------------------------------------
-- Design Name: Registrador IF/ID
-- Module Name: reg_if_id - Behavioral
-- Project Name: pipe4
-- Description: Registrador de pipeline responsável por armazenar a
-- instrução obtida pelo estágio Instruction Fetch (IF) e encaminhá-la
-- para o estágio Instruction Decode (ID).
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_IF_ID is
	generic ( 
			n: integer := 8
			);
    Port (
        clock    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        if_in  : in  STD_LOGIC_VECTOR(n-1 downto 0);
        id_out : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end reg_IF_ID;

architecture Behavioral of reg_IF_ID is
    signal reg_if_id : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');
begin

    process(clock, reset)
    begin
		  -- Limpa o registrador quando há reset
        if reset = '1' then
            reg_if_id <= (others => '0');
				
        -- Armazena a instrução recebida
        elsif rising_edge(clock) then
            reg_if_id <= if_in;
				
        end if;
    end process;

    id_out <= reg_if_id;

end Behavioral;
