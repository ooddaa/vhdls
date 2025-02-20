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
