----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    fpga_pipeline - Behavioral;
-- Description:    Componente que integra a placa FPGA com os arquivos do processador.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fpga_pipeline is
    port (
        clock : in std_logic;
        reset : in std_logic;
        segmento   : out std_logic_vector(7 downto 0);
        digito     : out std_logic_vector(3 downto 0);
        led   : out std_logic_vector(7 downto 0)
    );
end fpga_pipeline;

architecture Behavioral of fpga_pipeline is

    signal pc_data   : std_logic_vector(3 downto 0);
    signal wb_data   : std_logic_vector(3 downto 0);
    signal refresh   : unsigned(15 downto 0) := (others => '0');
    signal div_count : unsigned(25 downto 0) := (others => '0');
    signal cpu_clock : std_logic := '0';
    signal valor     : std_logic_vector(3 downto 0);

    function display(binario : std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
	     -- representa um valor binario em decimal no display
        case binario is
            when "0000" => return "11000000";
            when "0001" => return "11111001";
            when "0010" => return "10100100"; 
            when "0011" => return "10110000";
            when "0100" => return "10011001";
            when "0101" => return "10010010";
            when "0110" => return "10000010";
            when "0111" => return "11111000";
            when "1000" => return "10000000";
            when "1001" => return "10010000";
            when others => return "11111111";
        end case;
    end function;

    -- devolve o valor da dezena decimal do binario
    function dezena(x : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable n : integer;
    begin
        n := to_integer(unsigned(x));
        if n >= 10 then
            return "0001";
        else
            return "0000";
        end if;
    end function;

    -- devolve o valor da unidade decimal do binario
    function unidade(x : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable n : integer;
    begin
        n := to_integer(unsigned(x));
        if n >= 10 then
            n := n - 10;
        end if;
        return std_logic_vector(to_unsigned(n, 4));
    end function;

	 begin

    -- instancia o processador
    cpu : entity work.processador_pipeline
        port map (
            clock    => cpu_clock,
            reset    => reset,
            pc_out   => pc_data,
            data_out => wb_data
        );

    process(clock)
    begin
        if rising_edge(clock) then
		      -- contador pra atualizar o display em sequencia
            refresh <= refresh + 1;
            
				-- reset o estado do processador e do clock
            if reset = '1' then
                div_count <= (others => '0');
                cpu_clock <= '0';
					 
				-- "gera" um clock mais lento pro processador,
            elsif div_count = to_unsigned(49999999, div_count'length) then
                div_count <= (others => '0');
                cpu_clock <= not cpu_clock;
					 
            else
                div_count <= div_count + 1;
            end if;
        end if;
    end process;

    -- alterna a atualizao dos digitos do display
    process(refresh, pc_data, wb_data)
    begin
        valor  <= "0000";
        digito <= "1111";

        case refresh(15 downto 14) is
            when "00" =>
                valor  <= unidade(wb_data);
                digito <= "1110";
            when "01" =>
                valor  <= dezena(wb_data);
                digito <= "1101";
            when "10" =>
                valor  <= unidade(pc_data);
                digito <= "1011";
            when others =>
                valor  <= dezena(pc_data);
                digito <= "0111";
        end case;
    end process;

    segmento <= display(valor);
    led <= pc_data & wb_data;

end;