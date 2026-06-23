----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    mux - Behavioral;
-- Description:    MUX de 3 bits entre a e b;
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_3b is

	generic (
		n: integer := 3
	);
    port (

			a:	in	std_logic_vector(n-1 downto 0);
			b:	in std_logic_vector(n-1 downto 0);  	 
			enable:	in    std_logic;
           data_out: out  std_logic_vector(n-1 downto 0)			  
	);

		
end mux_3b;

architecture Behavioral of mux_3b is

begin
	process(a, b, enable)
		begin
			if enable = '0' then
				data_out <= a;
			else
				data_out <= b;
			end if;
	end process;

end Behavioral;

