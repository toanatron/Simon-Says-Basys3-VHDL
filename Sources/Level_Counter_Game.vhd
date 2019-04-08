library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity Level_Counter_Game is
 Port (ld_lvl: in std_logic;
       en_lvl: in std_logic;
       clk: in std_logic;
       rst: in std_logic;
       cout: out std_logic_vector(3 downto 0)
       );
end Level_Counter_Game;

architecture Behavioral of Level_Counter_Game is
signal count: unsigned (3 downto 0);
begin
process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            count <= "0001";
        else   
            if en_lvl = '1' then
                 if ld_lvl = '1' then
                    count <= "0001";
                 else
                    count <= count + 1;
                 end if;
             end if;
         end if;
     end if;
end process;
cout <= std_logic_vector (count);
end Behavioral;
