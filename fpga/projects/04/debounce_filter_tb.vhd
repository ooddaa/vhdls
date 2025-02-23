library IEEE;
use IEEE.std_logic_1164.all;
use std.env.all;

entity Debounce_Filter_TB is
end entity Debounce_Filter_TB;

architecture test of Debounce_Filter_TB is
  signal r_Clk, r_Bouncy, r_Debounced : std_logic := '0';
begin
  r_Clk <= not r_Clk after 2 ns;

  UUT: entity work.Debounce_Filter
    generic map (DEBOUNCE_LIMIT => 4)
    port map (
    i_Clk       => r_Clk,
    i_Bouncy    => r_Bouncy,
    o_Debounced => r_Debounced);

  process is
  begin
    wait for 10 ns;
    r_Bouncy <= '1';
    assert r_Debounced = '0' severity failure; -- signal must be debounced for 4 clock cycles

    wait until rising_edge(r_Clk);
    r_Bouncy <= '0';                            -- mock a glitch
    assert r_Debounced = '0' severity failure;  -- we haven't waited long enough

    wait until rising_edge(r_Clk);
    r_Bouncy <= '1';
    assert r_Debounced = '0' severity failure;  -- still waiting 4 cycles for signal to stabilize

    wait for 17 ns;                             -- 4th clock cycle ended
    assert r_Debounced = '1' severity failure;  -- signal is debounced
    finish;
  end process;
end architecture test;
