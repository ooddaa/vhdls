-- Project #4: Debouncing switch input 
library ieee; 
use ieee.std_logic_1164.all; 

entity Debounce_Top is 
  port(
    i_Clk     : in  std_logic;
    i_Switch  : in  std_logic;
    o_LED     : out std_logic
      ); 
end entity Debounce_Top;

architecture rtl of Debounce_Top is
 signal w_Debounced: std_logic; 

begin
  debounce_inst: entity work.Debounce_Filter
    generic map(DEBOUNCE_LIMIT => 250000)
    port map (
      i_Clk       => i_Clk,
      i_Bouncy    => i_Switch,
      o_Debounced => w_Debounced
         );

  LED_Toggle_Inst: entity work.LED_Toggle
    port map (
      i_Clk       => i_Clk,
      i_Switch    => w_Debounced,
      o_LED       => o_LED
         );

end architecture rtl;
