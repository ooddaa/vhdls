-- Project #3: Blinking an LED
library ieee;
use ieee.std_logic_1164.all;

entity LED_Toggle is
  port(
    i_clk     : in  std_logic;
    i_switch  : in  std_logic;
    o_led     : out std_logic
      );
end LED_Toggle;

architecture rtl of LED_Toggle is
  signal r_switch : std_logic := '0';
  signal r_led    : std_logic := '0';

begin
  process (i_clk) is
  begin
    if rising_edge(i_clk) then
      r_switch <= i_switch;
      if r_switch = '1' and i_switch = '0' then
        r_led <= not r_led;
      end if;
    end if;
  end process;

  o_led <= r_led;
end architecture rtl;

