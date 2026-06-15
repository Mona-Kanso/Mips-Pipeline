----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    inc - Behavioral;
-- Description:    Componente responsvel por incrementar o valor do Program Counter (PC).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inc is
    generic (
				n: integer := 4
				);
    Port ( inc_in : in  std_logic_vector(n-1 downto 0);
           inc_out : out std_logic_vector(n-1 downto 0)
			  );
end inc;

architecture Behavioral of inc is

begin

	inc_out <= std_logic_vector(unsigned(inc_in) + 1);

end Behavioral;
