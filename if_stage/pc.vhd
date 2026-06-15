----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    pc - Behavioral;
-- Description:    Registrador responsvel por armazenar o endereo da
-- instruo atual e disponibiliz-lo para acesso  memria de instrues.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
	generic ( 
			n: integer := 4
			);
    Port ( pc_in : in std_logic_vector(n-1 downto 0); 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pc_out : out  std_logic_vector(n-1 downto 0)
			 );
end pc;

architecture Behavioral of pc is

	signal reg_pc : std_logic_vector(n-1 downto 0) := (others => '0');
	
begin
process(clock, reset)
	begin
		 if reset = '1' then
			  reg_pc <= (others => '0');

		 elsif rising_edge(clock) then
			  reg_pc <= pc_in;
		 end if;
	end process;
	pc_out <= reg_pc;
end Behavioral;