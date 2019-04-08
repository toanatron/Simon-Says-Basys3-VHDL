library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_level_tb is
--  Port ( );
end Top_level_tb;

architecture Behavioral of Top_level_tb is
signal buttons: std_logic_vector(4 downto 0);
signal sw_prng: std_logic_vector (7 downto 0);
signal rst, clk: std_logic;
signal sw_timer: std_logic_vector(1 downto 0);
signal seg: std_logic_vector(6 downto 0);
signal an: std_logic_vector (3 downto 0);
signal dp: std_logic;
constant clk_period: time:= 1ns;

component Top_level is
 Port (btnU,btnD,btnL,btnR,btnC: in std_logic;
       sw_prng: in std_logic_vector(7 downto 0);
       rst, clk: in std_logic;
       sw_timer: in std_logic_vector(1 downto 0);
       
       seg: out std_logic_vector(6 downto 0);
       an: out std_logic_vector(3 downto 0);
       dp: out std_logic
       );
end component;
begin

uut: Top_level port map(btnU => buttons(3), btnD => buttons(2), btnL => buttons(1), btnR => buttons(0), btnC => buttons(4),
                        sw_prng => sw_prng, clk => clk, rst => rst, sw_timer => sw_timer, seg => seg, an => an, dp => dp);
                        
process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim: process
begin
    sw_timer<= "00";
    sw_prng <= "01110001";
    for i in 0 to 5 loop
        buttons <= "00000";
        wait for 2ns;
        buttons <= "10000";
        wait for 2ns;
    wait for 20 ns;
    end loop;
    for i in 0 to 5 loop
        buttons <= "00000";
        wait for 2ns;
        buttons <= "01000";
        wait for 2ns;
    wait for 20ns;
    end loop;
end process;
    

end Behavioral;
