library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder is
Port (btnUp, btnDp, btnRp, btnLp: in std_logic;
      en_out: out std_logic_vector(1 downto 0);
      valid: out std_logic
      );
end encoder;

architecture Behavioral of encoder is
signal buttons: std_logic_vector (3 downto 0);
begin
buttons <= btnUp & btnDp & btnRp & btnLp;
en_out <=   "00" when btnUp = '1' else
            "01" when btnDp = '1' else
            "10" when btnLp = '1' else
            "11";
valid <= '0' when buttons ="0000" else '1';
    
end Behavioral;
