library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_level is
 Port (BTNU,BTND,BTNL,BTNR,BTNC: in std_logic;
       sw_prng: in std_logic_vector(7 downto 0);
       rst, clk: in std_logic;
       sw_timer: in std_logic_vector(1 downto 0);
       
       seg: out std_logic_vector(6 downto 0);
       an: out std_logic_vector(3 downto 0);
       dp: out std_logic
       );
end Top_level;

architecture Behavioral of Top_level is
signal init_prng,ld_prng,en_prng : std_logic;
signal ld_timer, en_timer, init_timer:std_logic;
signal ldi,eni: std_logic;
signal ld_lvl, en_lvl: std_logic;
signal sel_disp: std_logic_vector(2 downto 0);
signal blink: std_logic;
signal disp_patt: std_logic;
        
signal max_lvl : std_logic;
signal seq_complete : std_logic; 
signal timeout1, timeout2 : std_logic;
signal valid,match,start: std_logic;

begin
datap: entity work.datapath(Behavioral)
        port map(btnU => btnU, btnD => btnD, btnL => btnL, btnR => btnR, btnC => btnC, sw_prng => sw_prng,
                clk => clk, rst => rst, sw_timer => sw_timer, init_prng => init_prng, ld_prng => ld_prng,
                en_prng => en_prng, ld_timer => ld_timer, en_timer => en_timer, init_timer => init_timer,
                ldi => ldi, eni => eni, ld_lvl => ld_lvl, en_lvl => en_lvl, sel_disp => sel_disp, blink => blink,
                disp_patt => disp_patt, max_lvl => max_lvl, seq_complete => seq_complete, timeout1 => timeout1,
                timeout2 => timeout2, valid => valid, match => match, start => start, seg => seg, dp => dp, an => an);

cntl: entity work.Controller(Behavioral)
        port map(start => start, valid => valid, timeout1 => timeout1, timeout2 => timeout2, max_lvl => max_lvl,
                clk => clk, rst => rst, seq_complete => seq_complete, init_prng => init_prng, ld_prng => ld_prng,
                en_prng => en_prng, init_timer => init_timer, ld_timer => ld_timer, en_timer => en_timer, 
                disp_patt => disp_patt, sel_disp => sel_disp, ldi => ldi, eni => eni, ld_lvl => ld_lvl, en_lvl => en_lvl,
                blink => blink, match => match);
            

end Behavioral;
