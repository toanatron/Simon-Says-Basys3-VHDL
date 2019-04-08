
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity To_Decimal is
 Port (Din: in std_logic_vector (3 downto 0);
       Dout: out std_logic_vector(11 downto 0)
       );
end To_Decimal;

architecture Behavioral of To_Decimal is

begin
with Din select
    Dout <= "000000100001" when "0001", --1
            "000000100010" when "0010", --2
            "000000100011" when "0011", --3
            "000000100100" when "0100", --4
            "000000100101" when "0101", --5 
            "000000100110" when "0110", --6
            "000000100111" when "0111", -- 7
            "000000101000" when "1000", --8
            "000000101001" when "1001", --9
            "000001100000" when "1010", --10
            "000001100001" when "1011", --11
            "000001100010" when "1100", --12
            "000001100011" when "1101", --13
            "000001100100" when "1110", --14
            "000001100101" when "1111", --15
            "000000000000" when others;
end Behavioral;
