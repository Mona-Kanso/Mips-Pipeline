----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    sign_extended - Structural;
-- Description:    Extensor de bits para nmeros positivos;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sign_extended is

	 generic (
		i:   integer := 16;
      o:   integer := 4
	);
    port (

		data_in: in std_logic_vector(i-1 downto 0);
		data_out: out std_logic_vector(o-1 downto 0)	 		  
	);
		
end sign_extended;

architecture Behavioral of sign_extended is

begin
	process(data_in)
	begin
		data_out <= "0000000000000000" & data_in;
	end process;

end Behavioral;