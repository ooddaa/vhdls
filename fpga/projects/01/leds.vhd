-- Project #1: Wiring Switches to LEDs

library ieee;
use ieee.std_logic_1164.all;

entity leds is
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
end leds;

architecture behaviour of leds is
begin
  o_led_1 <= i_switch_1;
  o_led_2 <= i_switch_2;
  o_led_3 <= i_switch_3;
  o_led_4 <= i_switch_4;
end behaviour;
