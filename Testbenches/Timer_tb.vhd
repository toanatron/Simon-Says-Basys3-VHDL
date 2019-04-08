library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Timer_tb is
--  Port ( );
end Timer_tb;

architecture Behavioral of Timer_tb is
signal en_timer, ld_timer, clk, rst,init_timer: std_logic;
signal switch: std_logic_vector(1 downto 0);
signal timeout1, timeout2: std_logic;
constant clk_period: time := 1 ns;

begin
duv: entity work.Timer
    port map (en_timer => en_timer, ld_timer => ld_timer, clk => clk, rst => rst, init_timer => init_timer,
                switch => switch, timeout1 => timeout1, timeout2 => timeout2);
   
clockProcess: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk<= '1';
    wait for clk_period/2;
end process;
   
stim: process
begin
    en_timer <= '0';
    rst <= '0';
	init_timer <= '0';
    ld_timer <= '0';
	switch <= "00";
    wait for clk_period;
    rst <= '1';
    en_timer <= '1';
    ld_timer <= '1';
	init_timer <= '1';
    wait for clk_period;
    rst <= '0';
    ld_timer <= '0';
	init_timer <= '1';
    wait for clk_period;
	init_timer <= '0';
    wait;
end process;            

end Behavioral;
