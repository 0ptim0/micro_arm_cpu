.PHONY: all clean compile run

SRC+="top_module.sv"
SRC+="top_module_tb.sv"

all: compile run

clean:
	vdel -all

compile:
	vlib work
	vlog -sv $(SRC)

run:
	vsim -gui -suppress 10000 -quiet work.top_module_tb -do "top_module_tb.do" -do "run -all"\
