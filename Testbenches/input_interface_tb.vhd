----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2019 10:24:15 PM
-- Design Name: 
-- Module Name: input_interface_tb - Behavioral
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

entity input_interface_tb is
--  Port ( );
end input_interface_tb;

architecture Behavioral of input_interface_tb is
signal buttons : std_logic_vector(4 downto 0);
signal start: std_logic;
signal rst, clk: std_logic;
signal btnUp,btnDp,btnLp,btnRp: std_logic;
constant clk_period: time:= 10 ns;
begin
uut: entity work.Input_Interface(Structural)
     port map(clk => clk, rst => rst, btnU => buttons(3), btnD => buttons(2), btnL => buttons(1), btnR => buttons(0),
                btnC => buttons(4), start => start, btnUp => btnUp, btnDp => btnDp, btnLp => btnLp, btnRp => btnRp);
clockProcess: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk<= '1';
    wait for clk_period/2;
end process;
stim: process
begin
    buttons <= "10000";
    rst <= '1';
    wait for clk_period;
    rst <= '0';
    wait for clk_period;
    wait;
end process;
end Behavioral;
