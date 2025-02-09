library ieee; 
use ieee.std_logic_1164.all;

entity clock is 
  port (CLK: out std_logic);
end clock; 

architecture behaviour of clock is 
  constant CLK_PERIOD : time := 20 ns; 
begin
  CLK_PROCESS: process 
    begin
      CLK <= '0';
      wait for CLK_PERIOD/2;
      CLK <= '1';
      wait for CLK_PERIOD/2;
  end process;  
end behaviour;  
