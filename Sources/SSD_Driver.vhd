library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SSD_Driver is
generic(n:natural := 25);
Port (clk,rst,blink: in std_logic;
      hex: in std_logic_vector(23 downto 0);
      seg: out std_logic_vector(6 downto 0);
      dp: out std_logic;
      an: out std_logic_vector(3 downto 0)
      );
end SSD_Driver;

architecture Behavioral of SSD_Driver is
signal to_hex_decoder: std_logic_vector(5 downto 0);
signal from_counter: std_logic_vector(n-1 downto 0);
signal nand_blink_q,counter_to_blink: std_logic;
signal to_oc : std_logic_vector(3 downto 0);
signal seg_buf: std_logic_vector(6 downto 0);

begin
--------------------------------------------------
counter1: entity work.counter(Behavioral)
        generic map( n => n)
        port map(clk => clk, rst => rst, Q => from_counter);
-------------------------------------------------    


dp <=  not to_hex_decoder(5);
gen_seg: for i in 6 downto 0 generate
    seg(i) <= seg_buf(6-i);
end generate;
------------------------------------------------
with from_counter(17 downto 16) select
    to_hex_decoder <= hex(6-1 downto 0) when "00",
              hex(12-1 downto 6) when "01",
              hex(18-1 downto 12) when "10",
              hex(24-1 downto 18) when others;
              
with to_hex_decoder(4 downto 0) select
           --a b c d e f g
seg_buf <= "0000001" when "00000",--0
           "1001111" when "00001",--1
           "0010010" when "00010",--2
           "0000110" when "00011",--3
           "1001100" when "00100",--4
           "0100100" when "00101",--5
           "0100000" when "00110",--6
           "0001111" when "00111",--7
           "0000000" when "01000",--8
           "0000100" when "01001",--9
           "0001000" when "01010",--a
           "1100000" when "01011",--b
           "0110001" when "01100",--c
           "1000010" when "01101",--d
           "0110000" when "01110",--E
           "0111000" when "01111",--F
           --Special cases
           "0000100" when "11000",--g
           "1101010" when "11001",--n
           "0011000" when "11011",--P
           "1110001" when "11100",--L
           "0111111" when "11101",--UP
           "1110111" when "11110",--DOWN
           "1001111" when "10001",--RIGHT
           "1111001" when "11111",--LEFT
           "1111111" when "11010",--Blank
           "0111000" when others;
           
--------------------------------------------------
process(nand_blink_q,from_counter(17 downto 16))
begin
    if nand_blink_q = '1' then
        to_OC <= "0000";
        case from_counter(17 downto 16) is
            when "00" => to_OC(0) <= '1';
            when "01" => to_OC(1) <= '1';
            when "10" => to_OC(2) <= '1';
            when "11" => to_OC(3) <= '1';
            when others => to_OC <= "0000";
        end case;
     else
            to_OC <= "0000";
     end if;                    
end process;
counter_to_blink <= from_counter(24);
nand_blink_q <= blink NAND counter_to_blink;
an <= not to_OC;
end Behavioral;
