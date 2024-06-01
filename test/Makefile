.PHONY: reg_file inst_mem

reg_file:
	$(MAKE) sim MODULE=reg_file TESTCASE=reg_file VERILOG_SOURCES=$(shell pwd)/../components/reg_file.sv
inst_mem:
	$(MAKE) sim MODULE=inst_mem TESTCASE=inst_mem VERILOG_SOURCES=$(shell pwd)/../components/inst_mem.sv

all: reg_file | inst_mem

include $(shell cocotb-config --makefiles)/Makefile.sim
