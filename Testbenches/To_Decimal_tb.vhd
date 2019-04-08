library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;
entity To_Decimal_tb is
--  Port ( );
end To_Decimal_tb;

architecture Behavioral of To_Decimal_tb is
signal Din: std_logic_vector (3 downto 0);
signal Dout: std_logic_vector (11 downto 0);
signal clk: std_logic;
constant clk_period: time:= 10ns;
begin
duv: entity work.To_Decimal
    port map (Din => Din, Dout => Dout);
process
    begin
     clk <= '0';
     wait for clk_period/2;
     clk <= '1';
     wait for clk_period/2;
    end process;
    
    stim: process
    begin
        Din <= x"0";
        wait for clk_period;
        Din <= x"1";
        wait for clk_period;
        Din <= x"2";
        wait for clk_period;
        Din <= x"3";
        wait for clk_period;
        Din <= x"4";
        wait for clk_period;
        Din <= x"5";
        wait for clk_period;
        Din <= x"6";
        wait for clk_period;
        Din <= x"7";
        wait for clk_period;
        Din <= x"8";
        wait for clk_period;
        Din <= x"9";
        wait for clk_period;
        Din <= x"A";
        wait for clk_period;
        Din <= x"B";
        wait for clk_period;
        Din <= x"C";
        wait for clk_period;
        Din <= x"D";
        wait for clk_period;
        Din <= x"E";
        wait for clk_period;
        Din <= x"F";
        wait for clk_period;
        wait;
    end process; 
 end behavioral;   
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_textio.all;

--library std;
--use std.textio.all;
--entity To_Decimal_tb is
----  Port ( );
--end To_Decimal_tb;

--architecture Behavioral of To_Decimal_tb is
--signal Din: std_logic_vector (3 downto 0);
--signal Dout: std_logic_vector (9 downto 0);

--type To_Decimal_rec is record
--       Din : std_logic_vector (3 downto 0);
--       Dout : std_logic_vector(9 downto 0);
--end record;

--type To_Decimal_rec_array is array(natural range<>) of To_Decimal_rec;
--constant TEST_DATA: To_Decimal_rec_array := (
--    --Din,Dout
--    (x"0","0111101111"),
--    (x"1","0000010001"),
--    (x"2", "0000010010"),
--    (x"3", "0000010011"),
--    (x"4", "0000010100"),
--    (x"5", "0000010101"),
--    (x"6", "0000010110"),
--    (x"7", "0000010111"),
--    (x"8", "0000011000"),
--    (x"9", "0000011001"),
--    (x"A", "0000110000"),
--    (x"B", "0000110001"),
--    (x"C", "0000110010"),
--    (x"D", "0000110011"),
--    (x"E", "0000110100"),
--    (x"F", "0000110101")
--);
--constant duv_delay: time := 5 ns;
--constant test_interval: time := 10 ns;
--signal test_vector_index: integer range 0 to TEST_DATA'length-1 := 0;

--begin
--duv: entity work.To_Decimal
--    port map (Din => Din, Dout => Dout);

--stimuli_and_checker: process
--variable debug_line: line;
--begin
--    for i in TEST_DATA'range loop
--        Din <= TEST_DATA(i).Din;
--        test_vector_index <= i;
        
--        write(debug_line, string'("Testing DUV with input Din: "));
--        write(debug_line, TEST_DATA(i).Din);
--        writeline(output, debug_line);
        
--        wait for DUV_DELAY;
        
--        if Dout /= TEST_DATA(test_vector_index).Dout then
--            write(debug_line, string'("Error --DUV.Dout = "));
--            write(debug_line, Dout);
--            write(debug_line, string'(" -- TEST_DATA.Dout = "));
--            write(debug_line, TEST_DATA(test_vector_index).Dout);
--            writeline(output, debug_line);
            
--            report "SIMULATION FAILED"
--            severity FAILURE;
--        end if;
--        wait for TEST_INTERVAL - DUV_DELAY;
--        if Dout'stable(TEST_INTERVAL - DUV_DELAY) = false then
--            write(debug_line, string'("DUV.Dout is NOT stable"));
--            writeline(output, debug_line);
            
--            report "SIMULATION FAILED"
--            severity FAILURE;
--        end if;
--    end loop;
    
--    report "End of testbench. All tests passed.";
--    wait;
--end process;      
--end Behavioral;
