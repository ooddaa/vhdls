library ieee;
use ieee.std_logic_1164.all;

entity blink_tb is
end blink_tb;

architecture behavior of blink_tb is
    -- Component Declaration
    component blink is
        port(
            i_clk    : in  std_logic;
            i_switch : in  std_logic;
            o_led    : out std_logic
        );
    end component;
    
    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    
    -- Signals
    signal clk    : std_logic := '0';
    signal switch : std_logic := '0';
    signal led    : std_logic;
    
    -- Test completion signal
    signal sim_done : boolean := false;

begin
    -- Unit Under Test
    uut: blink port map (
        i_clk    => clk,
        i_switch => switch,
        o_led    => led
    );

    -- Clock generation process
    clk_gen: process
    begin
        while not sim_done loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state
        switch <= '0';
        wait for CLK_PERIOD * 2;
        
        -- Test Case 1: Single toggle
        -- Press switch
        switch <= '1';
        wait for CLK_PERIOD * 2;
        -- Release switch
        switch <= '0';
        wait for CLK_PERIOD * 2;
        -- LED should be '1'
        assert led = '1'
            report "Test Case 1 Failed: LED should be ON after first toggle"
            severity error;
            
        -- Test Case 2: Second toggle
        -- Press switch
        switch <= '1';
        wait for CLK_PERIOD * 2;
        -- Release switch
        switch <= '0';
        wait for CLK_PERIOD * 2;
        -- LED should be '0'
        assert led = '0'
            report "Test Case 2 Failed: LED should be OFF after second toggle"
            severity error;
            
        -- Test Case 3: Quick press (glitch test)
        switch <= '1';
        wait for CLK_PERIOD/2;  -- Quick press shorter than clock period
        switch <= '0';
        wait for CLK_PERIOD * 2;
        -- LED state should not change due to synchronous design
        assert led = '0'
            report "Test Case 3 Failed: LED should not toggle on glitch"
            severity error;
            
        -- Test Case 4: Multiple clock cycles high
        switch <= '1';
        wait for CLK_PERIOD * 5;  -- Hold switch high for multiple cycles
        switch <= '0';
        wait for CLK_PERIOD * 2;
        -- LED should toggle only once
        assert led = '1'
            report "Test Case 4 Failed: LED should toggle only once on release"
            severity error;

        -- End simulation
        report "Simulation completed successfully";
        sim_done <= true;
        wait;
    end process;

end behavior;
