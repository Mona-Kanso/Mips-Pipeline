----------------------------------------------------------------------------------
-- Project Name:   Mips-Pipeline; 
-- Module Name:    datapath_ex - Structural;
-- Description:    Top level do estágio de Execução (EX) do Pipeline com Branch Target;
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath_ex is
    generic (
        W       : integer := 4; -- Novo tamanho da palavra de dados (4 bits)
        RegBits : integer := 3  -- Novo tamanho do endereço do registrador (3 bits)
    );
    port (
        -- Entradas vindas do registrador ID/EX
        pc_plus_4   : in std_logic_vector(W-1 downto 0);   
        read_data_1 : in std_logic_vector(W-1 downto 0);
        read_data_2 : in std_logic_vector(W-1 downto 0);
        sign_ext    : in std_logic_vector(W-1 downto 0);   
        rt_addr     : in std_logic_vector(RegBits-1 downto 0); 
        rd_addr     : in std_logic_vector(RegBits-1 downto 0); 
        
        -- Sinais de Controle vindos do ID/EX (ATUALIZADO)
        alu_src     : in std_logic;
        reg_dst     : in std_logic;
        alu_ctrl    : in std_logic_vector(2 downto 0); -- Vem DIRETO da Unidade de Controle!
        
        -- Saídas indo para o registrador EX/MEM
        alu_result      : out std_logic_vector(W-1 downto 0);
        zero_flag       : out std_logic;
        write_reg_addr  : out std_logic_vector(RegBits-1 downto 0);
        branch_target   : out std_logic_vector(W-1 downto 0) 
    );
end datapath_ex;

architecture Structural of datapath_ex is

    signal s_alu_in_b     : std_logic_vector(W-1 downto 0);
    signal s_shifted_ext  : std_logic_vector(W-1 downto 0); 

begin

    -- Lógica do Branch
    s_shifted_ext <= sign_ext(W-3 downto 0) & "00";
    branch_target <= std_logic_vector(unsigned(pc_plus_4) + unsigned(s_shifted_ext));

    -- MUX ALUSrc
    inst_mux_alusrc: entity work.mux
        generic map ( n => W )
        port map (
            a        => read_data_2,  
            b        => sign_ext,     
            enable   => alu_src,
            data_out => s_alu_in_b
        );

    -- A ULA Principal (Agora ligada direto no alu_ctrl que vem de fora)
    inst_ula: entity work.ULA_MIPS
        generic map ( W => W )
        port map (
            a           => read_data_1,
            b           => s_alu_in_b,     
            alu_control => alu_ctrl,     -- CONEXÃO DIRETA AQUI
            result      => alu_result,
            zero        => zero_flag
        );

    -- MUX RegDst
    inst_mux_regdst: entity work.mux
        generic map ( n => RegBits )
        port map (
            a        => rt_addr,      
            b        => rd_addr,      
            enable   => reg_dst,
            data_out => write_reg_addr
        );

end Structural;