----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    datapath_wb - Structural;
-- Description:    Componente responsavel por integrar os modulos do estagio Write Back (WB).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_wb is
    port (
        -- Dados vindos do registrador MEM/WB
        dado_memoria_in : in std_logic_vector(3 downto 0);
        alu_result_in   : in std_logic_vector(3 downto 0);
        reg_dest_in     : in std_logic_vector(2 downto 0);

        -- Sinais de controle vindos do MEM/WB
        reg_write_in  : in std_logic;
        mem_to_reg_in : in std_logic;

        -- Saidas para o banco de registradores
        write_data_out : out std_logic_vector(3 downto 0);
        write_reg_out  : out std_logic_vector(2 downto 0);
        reg_write_out  : out std_logic
    );
end datapath_wb;

architecture Structural of datapath_wb is
begin

    inst_memReg : entity work.mux_4b
        generic map (
            n => 4
        )
        port map (
            a        => alu_result_in,
            b        => dado_memoria_in,
            enable   => mem_to_reg_in,
            data_out => write_data_out
        );
		  
    write_reg_out <= reg_dest_in;
    reg_write_out <= reg_write_in;

end Structural;