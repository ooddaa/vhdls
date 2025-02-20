library ieee;
use ieee.std_logic_1164.all;

entity leds_tb is
end leds_tb;

architecture behavior of leds_tb is
    -- Component Declaration
    component leds is
        port(
            i_switch_1: in std_logic;
            i_switch_2: in std_logic;
            i_switch_3: in std_logic;
            i_switch_4: in std_logic;
            o_led_1: out std_logic;
            o_led_2: out std_logic;
            o_led_3: out std_logic;
            o_led_4: out std_logic
        );
    end component;
    
    -- Signal Declaration
    signal switch_1: std_logic := '0';
    signal switch_2: std_logic := '0';
    signal switch_3: std_logic := '0';
    signal switch_4: std_logic := '0';
    signal led_1: std_logic;
    signal led_2: std_logic;
    signal led_3: std_logic;
    signal led_4: std_logic;

begin
    -- Unit Under Test (UUT)
    uut: leds port map (
        i_switch_1 => switch_1,
        i_switch_2 => switch_2,
        i_switch_3 => switch_3,
        i_switch_4 => switch_4,
        o_led_1 => led_1,
        o_led_2 => led_2,
        o_led_3 => led_3,
        o_led_4 => led_4
    );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: All switches OFF
        wait for 10 ns;
        assert (led_1 = '0' and led_2 = '0' and led_3 = '0' and led_4 = '0')
            report "Test Case 1 Failed: All LEDs should be OFF"
            severity error;

        -- Test Case 2: All switches ON
        switch_1 <= '1';
        switch_2 <= '1';
        switch_3 <= '1';
        switch_4 <= '1';
        wait for 10 ns;
        assert (led_1 = '1' and led_2 = '1' and led_3 = '1' and led_4 = '1')
            report "Test Case 2 Failed: All LEDs should be ON"
            severity error;

        -- Test Case 3: Alternating pattern
        switch_1 <= '1';
        switch_2 <= '0';
        switch_3 <= '1';
        switch_4 <= '0';
        wait for 10 ns;
        assert (led_1 = '1' and led_2 = '0' and led_3 = '1' and led_4 = '0')
            report "Test Case 3 Failed: LEDs should match alternating pattern"
            severity error;

        -- Test Case 4: Individual toggle
        switch_1 <= '0';
        wait for 10 ns;
        assert (led_1 = '0' and led_2 = '0' and led_3 = '1' and led_4 = '0')
            report "Test Case 4 Failed: LED 1 should toggle OFF"
            severity error;

        -- End simulation
        wait for 10 ns;
        report "Simulation completed successfully";
        wait;
    end process;

end behavior;
