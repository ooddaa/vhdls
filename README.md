## compile 
`ghdl -a adder.vhd`

## run
`ghdl -r adder`

## test
same `analyze & run`: 
`ghdl -a adder_tb.vhd` 
`ghdl -r adder_tb`

## produce wavefile 
`ghdl -r adder --wave=adder.ghw`
or 
`ghdl -r adder --vcd=adder_wave.vcd`

## view wavefile 
`gtkwave adder.ghw`
or 
`gtkwave adder_wave.vcd`

[Quick Start Guide](https://ghdl.github.io/ghdl/quick_start/index.html)
# VHDL-2008
if using
```
use std.env.all;
```
we must add `--std=08` to our `-a, -r` commands:

```
ghdl -a --std=08 debounce_filter.vhd
ghdl -a --std=08 debounce_filter_tb.vhd
ghdl -e --std=08 debounce_filter_tb
ghdl -r --std=08 debounce_filter_tb --vcd=debounce.vcd
```

VHDL-2008 is a significant revision of the VHDL (VHSIC Hardware Description Language) standard that was released in 2008. It introduced several important improvements over the previous versions (like VHDL-93 and VHDL-2002).

Key features introduced in VHDL-2008 include:

1. Enhanced type system:
   - Fixed-point and floating-point packages
   - Better support for mixed-language simulation
   - Enhanced array types and operations

2. Improved design and verification capabilities:
   - Force/release statements for debugging
   - Enhanced generic types
   - Better package generics
   - The `std.env` package (which we used with `finish` in our testbench)

3. Simplified coding:
   - Direct entity instantiation (without needing component declarations)
   - Enhanced file I/O capabilities
   - Better support for PSL (Property Specification Language)
   - External names

4. Better tool support:
   - Standardized VHDL PSL integration
   - Enhanced synthesis packages
   - Improved error handling

For example, in VHDL-93 you would need to write:
```vhdl
-- VHDL-93 style
component Debounce_Filter is
  generic (DEBOUNCE_LIMIT : integer);
  port (...);
end component;

-- Then instantiate
UUT: Debounce_Filter 
  generic map (...)
  port map (...);
```

While in VHDL-2008 you can directly write:
```vhdl
-- VHDL-2008 style
UUT: entity work.Debounce_Filter
  generic map (...)
  port map (...);
```

The newer standard makes the code more concise and easier to maintain, which is why many modern designs prefer using VHDL-2008 when the tools support it.
