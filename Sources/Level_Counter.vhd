library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Level_Counter is
    Port (ldi: in std_logic;
          eni: in std_logic;
          clk: in std_logic;
          rst: in std_logic;
          cout: out std_logic_vector(3 downto 0)
           );
end Level_Counter;

architecture Behavioral of Level_Counter is
    signal count: unsigned(3 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count <= (others => '0');
            else
                if eni = '1' then
                    if ldi = '1' then
                        count <= (others => '0');
                    else
                        count <= count + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    cout <= std_logic_vector(count);

end Behavioral;
