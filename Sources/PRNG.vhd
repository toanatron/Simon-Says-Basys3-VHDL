library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PRNG is
 Port (i_seed: in std_logic_vector (7 downto 0);
       clk: in std_logic;
       init_prng: in std_logic;
       ld_prng: in std_logic;
       en_prng: in std_logic;
       dout: out std_logic_vector (1 downto 0)
       );
end PRNG;

architecture Behavioral of PRNG is
    signal Qload,Q : std_logic_vector (7 downto 0);
    signal Qfb: std_logic;
    signal dout1,dout2: std_logic;

begin
    loading:process(clk)
    begin
        if rising_edge(clk) then
            if ld_prng = '1' then
                Qload <= i_seed;
            end if;
            if en_prng = '1' then
                if init_prng = '1' then
                    Q <= Qload;
                else
                    Q <= Qfb & Q (7 downto 1);               
                end if;
            end if;
        end if;
    end process;
   
    process(Q)
    begin
       Qfb <= Q(4) xor Q(3) xor Q(2) xor Q(0);
    end process;
    dout <= Q(1) & Q(0);
    
end Behavioral;
