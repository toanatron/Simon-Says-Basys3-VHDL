
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prng_tb is
--  Port ( );
end prng_tb;

architecture Behavioral of prng_tb is
signal i_seed : std_logic_vector (7 downto 0);
signal clk,init_prng,ld_prng,en_prng : std_logic;
signal dout : std_logic_vector (1 downto 0);
constant time_period: time := 10 ns;

component PRNG is
 Port (i_seed: in std_logic_vector (7 downto 0);
       clk: in std_logic;
       init_prng: in std_logic;
       ld_prng: in std_logic;
       en_prng: in std_logic;
       dout: out std_logic_vector (1 downto 0)
       );
end component;

begin
uut: PRNG port map ( i_seed => i_seed, clk => clk, init_prng => init_prng, ld_prng => ld_prng, en_prng => en_prng, dout => dout);

stim: process
begin
    wait for time_period; --clk 0
    i_seed <= "10101011";
    en_prng <= '0';
    ld_prng <= '1';
    wait for time_period;
    en_prng<= '1';
    ld_prng <= '0';
    init_prng<= '1';
    wait for time_period;
    init_prng <= '0';
    wait;
 end process;
 clock: process
 begin
    clk <= '0';
    wait for time_period/2;
    clk <= '1';
    wait for time_period/2;
 end process;
end Behavioral;
