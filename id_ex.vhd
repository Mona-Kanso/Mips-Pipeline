library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity id_ex is
    port(
        clock : in std_logic;
        reset : in std_logic;

        acumulador_in : in std_logic_vector(3 downto 0);
        registrador_in : in std_logic_vector(3 downto 0);
        imediato_in : in std_logic_vector(3 downto 0);
        reg_dest_in : in std_logic_vector(3 downto 0);

        reg_dst_in    : in std_logic;
        reg_write_in  : in std_logic;
        alu_src_in    : in std_logic;
        alu_op_in     : in std_logic_vector(1 downto 0);
        mem_write_in  : in std_logic;
        mem_read_in   : in std_logic;
        mem_to_reg_in : in std_logic;

        acumulador_out : out std_logic_vector(3 downto 0);
        registrador_out : out std_logic_vector(3 downto 0);
        imediato_out : out std_logic_vector(3 downto 0);
        reg_dest_out : out std_logic_vector(3 downto 0);

        reg_dst_out    : out std_logic;
        reg_write_out  : out std_logic;
        alu_src_out    : out std_logic;
        alu_op_out     : out std_logic_vector(1 downto 0);
        mem_write_out  : out std_logic;
        mem_read_out   : out std_logic;
        mem_to_reg_out : out std_logic
    );
end id_ex;

architecture Behavioral of id_ex is
begin
    process(clock, reset)
    begin
        if reset = '1' then
            acumulador_out <= (others => '0');
            registrador_out <= (others => '0');
            imediato_out <= (others => '0');
            reg_dest_out <= (others => '0');

            reg_dst_out <= '0';
            reg_write_out <= '0';
            alu_src_out <= '0';
            alu_op_out <= (others => '0');
            mem_write_out <= '0';
            mem_read_out <= '0';
            mem_to_reg_out <= '0';

        elsif rising_edge(clock) then
            acumulador_out <= acumulador_in;
            registrador_out <= registrador_in;
            imediato_out <= imediato_in;
            reg_dest_out <= reg_dest_in;

            reg_dst_out <= reg_dst_in;
            reg_write_out <= reg_write_in;
            alu_src_out <= alu_src_in;
            alu_op_out <= alu_op_in;
            mem_write_out <= mem_write_in;
            mem_read_out <= mem_read_in;
            mem_to_reg_out <= mem_to_reg_in;
        end if;
    end process;
end Behavioral;