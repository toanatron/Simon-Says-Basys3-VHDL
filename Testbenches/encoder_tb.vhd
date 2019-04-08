----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2019 11:24:04 PM
-- Design Name: 
-- Module Name: encoder_tb - Behavioral
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

entity encoder_tb is
--  Port ( );
end encoder_tb;

architecture Behavioral of encoder_tb is
component encoder is
Port (btnUp, btnDp, btnRp, btnLp: in std_logic;
      en_out: out std_logic_vector(1 downto 0);
      valid: out std_logic
      );
end component;
signal buttons: std_logic_vector(3 downto 0);
signal valid: std_logic;
signal en_out : std_logic_vector (1 downto 0);
constant clk_period: time:= 10ns;
begin
uut: encoder port map (btnUp => buttons(3), btnDp => buttons(2), btnRp => buttons(1), btnLp => buttons(0), valid => valid, en_out => en_out);

stimu: process
    begin
    buttons <= "1000";
    wait for clk_period;
    buttons <= "0001";
    wait for clk_period;
    buttons <= "1111";
    wait for clk_period;
    buttons <= "0010";
    wait for clk_period;
    buttons <= "0100";
    wait for clk_period;
    buttons <= "1100";
    wait for clk_period;
    wait;
 end process;
end Behavioral;
