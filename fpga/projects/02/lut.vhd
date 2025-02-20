-- Project #2: Lighting an LED with Logic Gates
library ieee;
use ieee.std_logic_1164.all;

entity lut is
  port (
  i_switch_1: in std_logic;
  i_switch_2: in std_logic;
  o_led: out std_logic
       );
end lut;

architecture rtl of lut is
begin
  o_led <= i_switch_1 and i_switch_2;
end rtl;
