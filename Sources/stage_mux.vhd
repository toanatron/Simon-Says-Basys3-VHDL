library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stage_mux is
    Port (To_decimal_in : in std_logic_vector (11 downto 0);
          disp_patt_in: in std_logic_vector (11 downto 0);
          sel : in std_logic_vector (2 downto 0);
          Dout: out std_logic_vector (23 downto 0) 
          );
end stage_mux;

architecture Behavioral of stage_mux is

begin
with sel select
    Dout <= "001011"&"001110"&"011000"&"011001" when "000", --bEgn 011000 (g) 011001 (n)
            "001110"&"011001"&"001101"&"011010" when "001", --End 011010 is blank
             To_decimal_in & disp_patt_in when "010",  --Level
            "011011"&"001010"&"000101"&"000101" when "011", --PASS 011011 (p) 001010(A)
            "001111"&"001010"&"000001"&"011100" when "100", --FAIL 011101 L
            "011010"&"011010"&"011010"&"011010" when others;
end Behavioral;
