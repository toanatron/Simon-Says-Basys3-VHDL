
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Level_Counter_tb is
--  Port ( );
end Level_Counter_tb;

architecture Behavioral of Level_Counter_tb is
signal eni,ldi,clk,rst: std_logic;
signal cout: std_logic_vector(3 downto 0);
constant clk_period: time := 10 ns;
begin
duv: entity work.Level_Counter(Behavioral)
    port map(eni => eni, ldi => ldi, clk => clk, rst => rst, cout => cout);

clockProcess: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk<= '1';
    wait for clk_period/2;
end process;
   
stim: process
begin
    eni <= '0';
    rst <= '0';
    ldi <= '0';
    wait for clk_period;
    rst <= '1';
    eni <= '1';
    ldi <= '1';
    wait for clk_period;
    rst <= '0';
    ldi <= '0';
    wait for clk_period;
    wait;
end process;


end Behavioral;
