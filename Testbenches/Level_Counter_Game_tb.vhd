

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Level_Counter_Game_tb is
--  Port ( );
end Level_Counter_Game_tb;

architecture Behavioral of Level_Counter_Game_tb is
signal en_lvl,ld_lvl,clk,rst: std_logic;
signal cout: std_logic_vector(3 downto 0);
constant clk_period: time := 10 ns;
begin
duv: entity work.Level_Counter_Game(Behavioral)
    port map(en_lvl => en_lvl, ld_lvl => ld_lvl, clk => clk, rst => rst, cout => cout);

clockProcess: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk<= '1';
    wait for clk_period/2;
end process;
   
stim: process
begin
    en_lvl <= '0';
    rst <= '0';
    ld_lvl <= '0';
    wait for clk_period;
    rst <= '1';
    en_lvl <= '1';
    ld_lvl <= '1';
    wait for clk_period;
    rst <= '0';
    ld_lvl <= '0';
    wait for clk_period;
    wait;
end process;


end Behavioral;
