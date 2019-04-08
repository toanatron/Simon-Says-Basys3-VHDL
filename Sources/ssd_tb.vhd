----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2019 11:51:51 AM
-- Design Name: 
-- Module Name: ssd_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd_tb is
--  Port ( );
end ssd_tb;

architecture Behavioral of ssd_tb is
signal clk,rst,blink : std_logic;
signal hex: std_logic_vector(23 downto 0);
signal seg: std_logic_vector(6 downto 0);
signal dp: std_logic;
signal an: std_logic_vector(3 downto 0);
constant clk_period: time := 1ns;

component SSD_Driver is
generic(n:natural);
Port (clk,rst,blink: in std_logic;
      hex: in std_logic_vector(23 downto 0);
      seg: out std_logic_vector(6 downto 0);
      dp: out std_logic;
      an: out std_logic_vector(3 downto 0)
      );
end component;
begin
uut: ssd_driver
     generic map(n => 25)
     port map(clk => clk, rst => rst, hex => hex, seg => seg, dp => dp, an => an, blink => blink);
 
 process
 begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim: process
begin
    blink <= '0';
    hex <= "000000"&"100001"&"011101" & "011101";
    wait for clk_period;
    hex <= "001011"&"001110"&"011000"&"011001";
    wait for clk_period;
    wait;
end process;

end Behavioral;
