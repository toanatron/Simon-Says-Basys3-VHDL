library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Timer is
  Port (en_timer: in std_logic;
        ld_timer: in std_logic;
        clk: in std_logic;
        rst: in std_logic;
        init_timer: in std_logic;
        switch: in std_logic_vector(1 downto 0);
        timeout1: out std_logic;
        timeout2: out std_logic
         );
end Timer;

architecture Behavioral of Timer is
signal count: unsigned (27 downto 0);
signal time1, time2,time3,time4: std_logic := '0';
signal q: std_logic_vector(1 downto 0);
------------------------------------------------------
begin
process (clk,rst)
begin
    if rising_edge(clk) then
        if rst = '1' then
            count <= (others => '0');
        else
            if init_timer = '1' then
                q <= switch;
            end if;
            if en_timer = '1' then
                if ld_timer = '1' then
                    count <= (others => '0');
                else
                    count <= count + 1;
                end if;
            end if;
         end if;
    end if;
end process;

time1 <= '1' when count = 50000000 else '0';
time2 <= '1' when count = 100000000 else '0';
time3 <= '1' when count = 150000000 else '0';
time4 <= '1' when count = 200000000 else '0';

process(clk,q)    
begin
    if rising_edge(clk) then
            case q is
                when "00" => timeout1 <= time1;
                when "01" => timeout1 <= time2;
                when "10" => timeout1 <= time3;
                when others => timeout1 <= time4;
             end case;
     end if;
end process;
timeout2 <= time4;     
end Behavioral;
