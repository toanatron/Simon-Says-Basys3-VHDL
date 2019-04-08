library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity prng_mux is
 Port (prng_in: in std_logic_vector(1 downto 0);
       muxOut: out std_logic_vector(11 downto 0)
       );
end prng_mux;

architecture Behavioral of prng_mux is

begin
with prng_in select
    muxOut <= "011101" & "011101" when "00",-- "011101" UP
              "011110" & "011110" when "01", --"011110" DOWN
              "011111" & "011010" when "10", -- "011111"LEFT
              "011010" & "010001" when others; -- "010001" RIGHT
              
end Behavioral;
