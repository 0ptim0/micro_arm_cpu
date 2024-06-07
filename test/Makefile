.PHONY: reg_file inst_mem alu pc control_unit cpu

SRC_REG_FILE=$(PWD)/../components/reg_file.sv
SRC_INST_MEM=$(PWD)/../components/inst_mem.sv
SRC_ALU=$(PWD)/../components/alu.sv
SRC_DATA_MEM=$(PWD)/../components/data_mem.sv
SRC_PC=$(PWD)/../components/pc.sv
SRC_CONTROL_UNIT=$(PWD)/../components/control_unit.sv
SRC_CPU+=$(PWD)/../top_module.sv
INC_CPU=$(PWD)/../types

SRC_CORES=../ip_cores/basic/mux.sv

# Python tests
reg_file:
	$(MAKE) sim MODULE=reg_file TESTCASE=reg_file VERILOG_SOURCES=$(SRC_REG_FILE)
inst_mem:
	$(MAKE) sim MODULE=inst_mem TESTCASE=inst_mem VERILOG_SOURCES=$(SRC_INST_MEM)
alu:
	$(MAKE) sim MODULE=alu TESTCASE=alu VERILOG_SOURCES=$(SRC_ALU) VERILOG_INCLUDE_DIRS+=$(INC_CPU)
data_mem:
	$(MAKE) sim MODULE=data_mem TESTCASE=data_mem VERILOG_SOURCES=$(SRC_DATA_MEM)
pc:
	$(MAKE) sim MODULE=pc TESTCASE=pc VERILOG_SOURCES=$(SRC_PC)
control_unit:
	$(MAKE) sim MODULE=control_unit TESTCASE=control_unit VERILOG_SOURCES=$(SRC_CONTROL_UNIT) VERILOG_INCLUDE_DIRS+=$(INC_CPU)
cpu:
	$(MAKE) sim MODULE=top_module TESTCASE=top_module VERILOG_SOURCES=$(SRC_CPU) VERILOG_SOURCES+=$(SRC_REG_FILE) VERILOG_SOURCES+=$(SRC_INST_MEM) VERILOG_SOURCES+=$(SRC_ALU) VERILOG_SOURCES+=$(SRC_DATA_MEM) VERILOG_SOURCES+=$(SRC_PC) VERILOG_SOURCES+=$(SRC_CONTROL_UNIT) VERILOG_SOURCES+=$(SRC_CORES) VERILOG_INCLUDE_DIRS+=$(INC_CPU)

# Simulation
SRC_SIM+="top_module_tb.sv"
SRC_SIM+=$(SRC_REG_FILE)
SRC_SIM+=$(SRC_INST_MEM)
SRC_SIM+=$(SRC_ALU)
SRC_SIM+=$(SRC_DATA_MEM)
SRC_SIM+=$(SRC_PC)
SRC_SIM+=$(SRC_CONTROL_UNIT)
SRC_SIM+=$(SRC_CPU)
SRC_SIM+=$(SRC_CORES)

sim_clean:
	vdel -all

sim_compile:
	vlib work
	vlog -sv $(SRC_SIM) +incdir+$(INC_CPU)

modelsim: sim_compile
	vsim -default_radix hexadecimal -gui -suppress 10000 -quiet work.top_module_tb -do "top_module_tb.do" -do "run -all"\

# Common
all: reg_file | inst_mem | alu | pc | control_unit | cpu | modelsim

include $(shell cocotb-config --makefiles)/Makefile.sim
