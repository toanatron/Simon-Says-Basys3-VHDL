library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is
  Port (
        start: in std_logic;
        valid: in std_logic;
        match: in std_logic;
        timeout1: in std_logic;
        timeout2: in std_logic;
        max_lvl: in std_logic;
        clk: in std_logic;
        rst: in std_logic;
        seq_complete: in std_logic;
		
        init_prng: out std_logic;
        ld_prng: out std_logic;
        en_prng: out std_logic;
        init_timer: out std_logic;
		ld_timer: out std_logic;
		en_timer: out std_logic;
        disp_patt: out std_logic;
		sel_disp: out std_logic_vector(2 downto 0); --"000" begin "001" level + pattern "010" pass "011"fail "100" end
        ldi: out std_logic;
        eni: out std_logic;
        ld_lvl: out std_logic;
        en_lvl: out std_logic;
		blink: out std_logic
         );
end Controller;

architecture Behavioral of Controller is
    TYPE state IS (s0,s1,s2,s3,s4,s5,s6,s7,s8);
    signal current_state, next_state: state;

begin
    U_moore: process(clk, rst)
    begin
        if rst = '1' then
            current_state <= s0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    next_state_output: process(current_state, valid, match, timeout1, timeout2, max_lvl, start,seq_complete)
    begin
        next_state <= current_state;
        init_prng <= '0';
        ld_prng <= '0';
        en_prng <= '0';
        init_timer <= '0';
        ld_timer <= '0';
        en_timer <= '0';
        disp_patt <= '0';
        sel_disp <= "111"; --"000" begin "001" level + pattern "010" pass "011"fail "100" end
        ldi <= '0';
        eni <= '0';
        ld_lvl <= '0';
        en_lvl <= '0';
        blink <= '0';
		case current_state is
			when s0 =>
				blink <= '1';			--7 segment blinks
				sel_disp <= "000";		--display bEgn
				if start = '1' then
				    ld_prng <= '1';     --load prng
					init_timer <= '1';	--initiate timer
					ld_lvl <= '1';		--increment to level 1
					en_lvl <= '1';		--enable increment
					eni <= '1';			--enable i
					ldi <= '1';			--load i
					next_state <= s1;
				else	
					next_state <= s0;
				end if;	
			when s1 =>
				init_prng <= '1';
				en_prng <= '1';			--enable prng
				next_state <= s2;
			
			when s2 =>
			    en_prng <= '1';
				eni <= '1';				--enable eni
				ld_timer <= '1';		--load timer
				en_timer <= '1';		--enable timer
				next_state <= s3;
			
			when s3 =>
				sel_disp <= "010";		--display level and pattern
				disp_patt <= '1';		--display pattern select
				en_timer <= '1';
				if timeout1 = '1' then	
					if seq_complete = '1' then
						en_prng <= '1';
						init_prng <= '1';
						eni <= '1';
						ldi <= '1';
						en_timer <= '1';
						ld_timer <= '1';
						next_state <= s4;
					else
						en_prng <= '1';
						next_state <= s2;
					end if;
				else
					next_state <= s3;
				end if;
			
			when s4 =>
				en_prng <= '1';
				eni <= '1';
				next_state <= s5;
			
			when s5 =>
				sel_disp <= "010";
				disp_patt <= '0';
				if valid = '1' then
					if match = '1' then
						if seq_complete = '1' then
							next_state <= s6;
						else
							en_prng <= '1';
							next_state <= s4;
						end if;
					else 
						next_state <= s7;
					end if;
				else 
					next_state <= s5;
				end if;
			
			when s6 =>
				sel_disp <= "011";
				en_timer <= '1';
				if timeout2 = '1' then
					en_timer <= '1';
					ld_timer <= '1';
					if max_lvl = '1' then
						next_state <= s8;
					else
						en_lvl <= '1';
						eni <= '1';
						ldi <= '1';
						next_state <= s1;
					end if;
			   else
			     next_state <= s6;
			end if;	
					
			when s7 =>
			    sel_disp <= "100";
				en_timer <= '1';
				if timeout2 = '1' then
					next_state <= s8;
				else
					next_state <= s7;
				end if;
			
			when s8 =>
			    sel_disp <= "001";
			    blink <= '1';
				en_timer <= '1';
				if timeout2 = '1' then
					next_state <= s0;
				else
					next_state <= s8;
				end if;
		end case;
	end process;
end Behavioral;
