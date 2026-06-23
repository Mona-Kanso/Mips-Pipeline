library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoria_dados is
    port(
        clock      : in  std_logic;
        mem_read   : in  std_logic;
        mem_write  : in  std_logic;
        address    : in  std_logic_vector(3 downto 0);
        write_data : in  std_logic_vector(3 downto 0);
        read_data  : out std_logic_vector(3 downto 0)
    );
end memoria_dados;

architecture Behavioral of memoria_dados is

    type t_memoria is array (0 to 15) of std_logic_vector(3 downto 0);

    signal memoria : t_memoria := (
        others => (others => '0')
    );

begin

    process(clock)
    begin
        if rising_edge(clock) then
            if mem_write = '1' then
                memoria(to_integer(unsigned(address))) <= write_data;
            end if;
        end if;
    end process;

    read_data <= memoria(to_integer(unsigned(address))) when mem_read = '1'
                 else (others => '0');

end Behavioral;