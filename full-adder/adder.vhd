library ieee;
use ieee.std_logic_1164.all;

entity adder is 
   -- port (
   -- a  :   in std_logic;
   -- b  :   in std_logic;
   -- ci :   in std_logic;
   -- s  :   out std_logic;
   -- co :   out std_logic
   --      );
  port (a, b, ci: in bit; s, co: out bit);
end adder;

architecture behaviour of adder is 
begin 
  -- describe process
  s <= (a xor b) xor ci;
  co <= (a and b) or (a and ci) or (b and ci);
end behaviour;
