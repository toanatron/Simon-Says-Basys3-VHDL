
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
  Port (btnU: in std_logic;
        btnD: in std_logic;
        btnL: in std_logic;
        btnR: in std_logic;
        btnC: in std_logic;
        sw_prng: in std_logic_vector (7 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        sw_timer: in std_logic_vector(1 downto 0);
        init_prng,ld_prng,en_prng : in std_logic;
        ld_timer, en_timer, init_timer: in std_logic;
        ldi,eni: in std_logic;
        ld_lvl, en_lvl: in std_logic;
        sel_disp: in std_logic_vector(2 downto 0);
        blink: in std_logic;
        disp_patt: in std_logic;
        
        max_lvl : out std_logic;
        seq_complete : out std_logic; 
        timeout1, timeout2 : out std_logic;
        valid,match,start: out std_logic;
        seg: out std_logic_vector (6 downto 0);
        dp: out std_logic;
        an: out std_logic_vector (3 downto 0)
        );
end datapath;

architecture Behavioral of datapath is
signal btnUp,btnDp,btnLp,btnRp: std_logic;--input interface output
signal encoder_out: std_logic_vector(1 downto 0);--encoder output
signal LCout, LCout2 : std_logic_vector(3 downto 0); --Level Counter outputs
signal prngOut: std_logic_vector (1 downto 0); --PRNG output
signal to_decimalOut: std_logic_vector (11 downto 0); --to_decimal output
signal prng_muxOut: std_logic_vector(11 downto 0);--Mux output for UP DOWN LEFT RIGHT
signal disp_muxOut: std_logic_vector(11 downto 0);
signal stage_muxOut: std_logic_vector(23 downto 0);--Mux output for different stages


begin
input_int: entity work.Input_Interface(Structural)
     port map(btnU => btnU, btnD => btnD, btnL => btnL, btnR => btnR, btnC => btnC,clk => clk, start => start, rst => rst,
     btnUp => btnUp, btnDp => btnDp, btnLp => btnLp, btnRp => btnRp);
     
encoder_com: entity work.Encoder(Behavioral)
     port map(btnUp => btnUp, btnDp => btnDp, btnRp => btnRp, btnLp => btnLp, en_out => encoder_out,
     valid => valid);
     
PRNG_com: entity work.PRNG(Behavioral)
      port map(i_seed => sw_prng, clk => clk, init_prng => init_prng, ld_prng => ld_prng, en_prng => en_prng, 
      dout => prngOut);                            
       
player_level: entity work.Level_Counter(Behavioral)
      port map (ldi => ldi, eni => eni, clk => clk, rst => rst, cout=> LCout);
                                           
game_level: entity work.Level_Counter_Game(Behavioral)
     port map(ld_lvl => ld_lvl, en_lvl => en_lvl, clk => clk, rst => rst, cout => LCout2);
            
Timer_com: entity work.Timer(Behavioral)
     port map(en_timer => en_timer, ld_timer => ld_timer, clk => clk, rst => rst, init_timer => init_timer,
     switch => sw_timer, timeout1 => timeout1, timeout2 => timeout2);
                    
prng_mux1: entity work.prng_mux(Behavioral)
            port map(prng_in => prngOut, muxOut => prng_muxOut);
            
To_Decimal_com: entity work.To_Decimal(Behavioral)
            port map(Din => LCout2, Dout => to_decimalOut);
            
with disp_patt select
     disp_muxOut <= "011010011010" when '0',
                    prng_muxOut when others;
                    
stage_mux1: entity work.stage_mux(Behavioral)
     port map(To_decimal_in => to_decimalOut, disp_patt_in => disp_muxOut, sel => sel_disp, Dout => stage_muxOut);  
               
ssd_driver_com: entity work.SSD_Driver(Behavioral)
            port map(clk => clk, rst => rst, blink => blink, hex => stage_muxOut, seg => seg, an => an, dp => dp);

seq_complete <= '1' when unsigned(Lcout) = unsigned(Lcout2) else '0';
max_lvl <= '1' when unsigned(LCout )= 15 and unsigned(LCout2) = 15 else '0'; 
match <= '1' when unsigned(encoder_out) = unsigned(prngOut) else '0';

end Behavioral;
