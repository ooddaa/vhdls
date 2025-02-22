library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity Debounce_Filter is
  generic (DEBOUNCE_LIMIT : integer := 20);
  port (
   i_Clk        : in  std_logic;
   i_Bouncy     : in  std_logic;
   o_Debounced  : out std_logic
  );
end entity Debounce_Filter;

architecture rtl of Debounce_Filter is
  -- signal r_Count  : integer := range from 0 to DEBOUNCE_LIMIT;
  signal r_Count  : integer range 0 to DEBOUNCE_LIMIT := 0;
  signal r_State  : std_logic := '0';
  -- signal r_State  : integer := 0;

begin
-- we make sure we wait some debounce limit time 
-- T (ns/ms/..) = FPGA rate (Mhz/s) / DEBOUNCE_LIMIT    
  process (i_Clk) is
  begin
    if rising_edge(i_Clk) then 
      if (r_State /= i_Bouncy and r_Count < DEBOUNCE_LIMIT-1) then 
        r_Count <= r_Count + 1;   
      elsif r_Count = DEBOUNCE_LIMIT-1 then 
        r_State <= i_Bouncy;
        r_Count <= 0; 
      else
        r_Count <= 0;
      end if;
    end if;
  end process;

  o_Debounced <= r_State; 
end architecture rtl;
