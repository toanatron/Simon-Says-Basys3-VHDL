library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    generic(
        k: natural := 7;
        DD: natural := 100
    );
    port(
        rst: in std_logic;
        clk: in std_logic;
        input: in std_logic;
        output: out std_logic
    );
end debouncer;

architecture STRUCTURE of debouncer is
    signal previous_input: std_logic;
    signal from_xor: std_logic; 
    signal from_and: std_logic;
    signal to_count, count: std_logic;
    signal to_output, output_buf: std_logic;
    signal eq_DD: std_logic;
    signal counter: unsigned(k-1 downto 0);
begin

    input_output_reg: process(clk)
    begin
        if rising_edge(clk) then
            previous_input <= input;  
            output_buf <= to_output;
            if rst = '1' then
                count <= '0';
            elsif from_and = '1' then
                count <= '1';
            else
                count <= to_count;
            end if;
        end if;
    end process;
    
    from_xor <= input xor previous_input;
    from_and <= from_xor and (not count);
    
    to_output <= input when count = '0'
                    else output_buf;
    output <= output_buf;
    
    to_count <= '0' when eq_DD = '1'
                else count;
    
    counter_gen: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                counter <= (others => '0');
            elsif count = '1' then
                if eq_DD = '1' then
                    counter <= (others => '0');
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    eq_DD <= '1' when counter = DD
                else '0';
end STRUCTURE;
