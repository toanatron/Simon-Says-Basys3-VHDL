----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2019 01:22:32 PM
-- Design Name: 
-- Module Name: prng_mux_tb - Behavioral
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

entity prng_mux_tb is
--  Port ( );
end prng_mux_tb;

architecture Behavioral of prng_mux_tb is
signal prng_in: std_logic_vector(1 downto 0);
signal clk: std_logic;
constant clk_period: time:= 10ns;
signal muxOut: std_logic_vector(11 downto 0);
component prng_mux is
 Port (prng_in: in std_logic_vector(1 downto 0);
       muxOut: out std_logic_vector(11 downto 0)
       );
end component;
begin
uut: prng_mux port map(prng_in => prng_in, muxOut => muxOut);

process
begin
 clk <= '0';
 wait for clk_period/2;
 clk <= '1';
 wait for clk_period/2;
end process;

stim: process
begin
    prng_in <= "00";
    wait for clk_period;
    prng_in <= "01";
    wait for clk_period;
    prng_in <= "10";
    wait for clk_period;
    prng_in <= "11";
    wait for clk_period;
    wait;
end process;

end Behavioral;
