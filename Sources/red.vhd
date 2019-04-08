library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity red is
    port(
        input : in std_logic;
        output: out std_logic;
        clk : in std_logic;
        rst: in std_logic
    );
end red;

architecture Behavioral of red is
    signal q: std_logic;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                q <= '0';
            else
                q <= input;
            end if;
        end if;
    end process;
    output <= input and (not q);
end Behavioral;
