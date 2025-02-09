-- Hello World progamme 

use std.textio.all;

entity hello is 
end hello;

architecture behaviour of hello is 
begin 
  process 
    variable l : line;
  begin 
    write (l, String'("Hello oda"));
    writeline (output, l);
    wait;
  end process;

end behaviour;
