library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA_MIPS is
    generic (
        W : integer := 4 -- Largura de dados de 4 bits
    );
    port (
        a           : in  std_logic_vector(W-1 downto 0);
        b           : in  std_logic_vector(W-1 downto 0);
        alu_control : in  std_logic_vector(2 downto 0);
        result      : out std_logic_vector(W-1 downto 0);
        zero        : out std_logic
    );
end ULA_MIPS;

architecture Combinacional of ULA_MIPS is
    signal s_result : std_logic_vector(W-1 downto 0);
begin
    process(a, b, alu_control)
        variable v_a : unsigned(W-1 downto 0);
        variable v_b : unsigned(W-1 downto 0);
    begin
        v_a := unsigned(a);
        v_b := unsigned(b);
        
        case alu_control is
            when "000" => -- AND
                s_result <= std_logic_vector(v_a and v_b);
            when "001" => -- OR
                s_result <= std_logic_vector(v_a or v_b);
            when "010" => -- ADD
                s_result <= std_logic_vector(v_a + v_b);
            when "110" => -- SUB
                s_result <= std_logic_vector(v_a - v_b);
            when others => 
                s_result <= (others => '0');
        end case;
    end process;

    -- Atribuio contnua para a sada principal
    result <= s_result;

    -- Gerao da flag Zero
    zero <= '1' when s_result = "0000" else '0';

end Combinacional;