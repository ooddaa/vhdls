library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.all;

entity Debounce_Filter_TB_2 is
-- Testbench doesn't have ports
end entity Debounce_Filter_TB_2;

architecture sim of Debounce_Filter_TB_2 is
  -- Test bench constants
  constant CLK_PERIOD : time := 10 ns;  -- 100MHz clock
  constant DEBOUNCE_LIMIT_TEST : integer := 5;  -- Smaller value for simulation
  
  -- Test bench signals
  signal tb_clk : std_logic := '0';
  signal tb_bouncy : std_logic := '0';
  signal tb_debounced : std_logic;
  signal tb_sim_done : boolean := false;

begin
  -- Instantiate the Unit Under Test (UUT)
  UUT: entity work.Debounce_Filter
    generic map (
      DEBOUNCE_LIMIT => DEBOUNCE_LIMIT_TEST
    )
    port map (
      i_Clk => tb_clk,
      i_Bouncy => tb_bouncy,
      o_Debounced => tb_debounced
    );

  -- Clock generation process
  p_clk: process
  begin
    while not tb_sim_done loop
      tb_clk <= '0';
      wait for CLK_PERIOD/2;
      tb_clk <= '1';
      wait for CLK_PERIOD/2;
    end loop;
    wait;
  end process p_clk;

  -- Stimulus process
  p_stim: process
  begin
    -- Initial state
    tb_bouncy <= '0';
    wait for CLK_PERIOD * 2;
    
    -- Test Case 1: Quick toggles (bouncing)
    report "Test Case 1: Quick toggles (bouncing)";
    tb_bouncy <= '1';
    wait for CLK_PERIOD * 2;
    tb_bouncy <= '0';
    wait for CLK_PERIOD * 1;
    tb_bouncy <= '1';
    wait for CLK_PERIOD * 1;
    tb_bouncy <= '0';
    wait for CLK_PERIOD * 2;
    
    -- Wait to see if output remains stable
    wait for CLK_PERIOD * (DEBOUNCE_LIMIT_TEST + 2);
    assert (tb_debounced = '0') severity failure;
    
    -- Test Case 2: Stable high input
    report "Test Case 2: Stable high input";
    tb_bouncy <= '1';
    wait for CLK_PERIOD * (DEBOUNCE_LIMIT_TEST + 5);
    assert (tb_debounced = '1') severity failure;
    
    -- Test Case 3: Stable low input
    report "Test Case 3: Stable low input";
    tb_bouncy <= '0';
    wait for CLK_PERIOD * (DEBOUNCE_LIMIT_TEST + 5);
    assert (tb_debounced = '0') severity failure;
    
    -- Test Case 4: Brief pulse shorter than debounce time
    report "Test Case 4: Brief pulse";
    tb_bouncy <= '1';
    wait for CLK_PERIOD * 2;
    tb_bouncy <= '0';
    wait for CLK_PERIOD * (DEBOUNCE_LIMIT_TEST + 2);
    assert (tb_debounced = '0') severity failure;

    -- Test Case 5: Debouncing from high to low
    report "Test Case 5: Brief high pulse";
    tb_bouncy <= '1';
    wait for CLK_PERIOD * (DEBOUNCE_LIMIT_TEST + 5);
    assert (tb_debounced = '1') severity failure;
    -- start bouncing
    tb_bouncy <= '0';
    wait for CLK_PERIOD;
    tb_bouncy <= '1';
    wait for CLK_PERIOD;
    tb_bouncy <= '0';
    wait for CLK_PERIOD * 4; -- not enough time for debouncing
    assert (tb_debounced = '1') severity failure;
    wait for CLK_PERIOD * 2;
    assert (tb_debounced = '0') severity failure;

    -- End simulation
    report "Simulation done!";
    tb_sim_done <= true;
    wait;
  end process p_stim;

  -- Monitor process to check outputs
  p_monitor: process
  begin
    wait for CLK_PERIOD;
    while not tb_sim_done loop
      if rising_edge(tb_clk) then
        report "Time: " & to_string(now) & 
               " Bouncy: " & std_logic'image(tb_bouncy) &
               " Debounced: " & std_logic'image(tb_debounced);
      end if;
      wait for CLK_PERIOD;
    end loop;
    wait;
  end process p_monitor;

end architecture sim;
