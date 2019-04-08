library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Input_Interface is
 Port (clk,rst: in std_logic;
       btnU,btnD,btnL,btnR,btnC: in std_logic;
       
       btnUp,btnDp,btnLp,btnRp: out std_logic;
       start: out std_logic);
end Input_Interface;

architecture Structural of Input_Interface is
signal to_red_1,to_red_2,to_red_3,to_red_4,to_red_5 : std_logic;
signal btnUr, btnDr, btnLr, btnRr,btnCr: std_logic;

begin
bounceUp: entity work.debouncer(STRUCTURE)
    port map(clk => clk, rst => rst, input => btnU, output => to_red_1);
redUp: entity work.red(Behavioral)
        port map(clk => clk, rst => rst, input => to_red_1, output => btnUr); 
          
bounceDown: entity work.debouncer(STRUCTURE)
    port map(clk => clk, rst => rst, input => btnD, output => to_red_2);    
redDown: entity work.red(Behavioral)
        port map(clk => clk, rst => rst, input => to_red_2, output => btnDr);   
          
bounceLeft: entity work.debouncer(STRUCTURE)
    port map(clk => clk, rst => rst, input => btnL, output => to_red_3);
redLeft: entity work.red(Behavioral)
        port map(clk => clk, rst => rst, input => to_red_3, output => btnLr); 
        
bounceRight: entity work.debouncer(STRUCTURE)
    port map(clk => clk, rst => rst, input => btnR, output => to_red_4);
redRight: entity work.red(Behavioral)
         port map(clk => clk, rst => rst, input => to_red_4, output => btnRr);   
           
bounceCenter: entity work.debouncer(STRUCTURE)
    port map(clk => clk, rst => rst, input => btnC, output => to_red_5);
redCenter: entity work.red(Behavioral)
    port map(clk => clk, rst => rst, input => to_red_5, output => btnCr);
    
btnUp <= btnUr;
btnDp <= btnDr;
btnLp <= btnLr;
btnRp <= btnRr;    
start <= btnCr;    
                                                                                       
end Structural;
