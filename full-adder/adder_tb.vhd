entity adder_tb is 
end adder_tb;

architecture test_behavior of adder_tb is 
  component adder
    port (a,b,ci : in bit; s,co : out bit);
  end component;  

  for adder_0: adder use entity work.adder; 
    signal a,b,ci,s,co : bit;
  begin 
    adder_0: adder port map (a => a, b => b, ci => ci, s => s, co => co); 

    process 
      type pattern_type is record
        -- expected inputs 
        a,b,ci : bit; 
        -- expected outputs 
        s,co : bit; 
      end record; 

      type pattern_array is array (natural range <>) of pattern_type; 
      constant patterns : pattern_array :=  
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '1', '0'),
       ('0', '1', '0', '1', '0'),
       ('0', '1', '1', '0', '1'),
       ('1', '0', '0', '1', '0'),
       ('1', '0', '1', '0', '1'),
       ('1', '1', '0', '0', '1'),
       ('1', '1', '1', '1', '1'));
    begin
      -- checking each pattern 
      for i in patterns'range loop 
         -- set inputs 
        a <= patterns(i).a;
        b <= patterns(i).b;
        ci <= patterns(i).ci;

        -- allow propagation delay 
        wait for 2 ns; 

        -- check the outputs 
        assert s = patterns(i).s
          report "bad sum" severity error;
        assert co = patterns(i).co
          report "bad carry out" severity error;
      end loop;
      assert false 
        report "end of test" severity note;
      -- waiting forever to finish simulation
      wait;  
    end process;
end test_behavior;
