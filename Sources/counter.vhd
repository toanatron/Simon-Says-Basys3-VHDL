library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity counter is
generic(n: natural:= 25);
 Port (clk,rst: in std_logic;
       Q: out std_logic_vector(n-1 downto 0)
       );
end counter;

architecture Behavioral of counter is
signal count: unsigned(n-1 downto 0);
begin
process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            count <= (others => '0');
        else
            count <= count + 1;
        end if;
    end if;
end process;
Q <= std_logic_vector(count);
end Behavioral;
