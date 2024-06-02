import cocotb
from cocotb.clock import Clock

@cocotb.test()
async def data_mem(dut):
    """Data memory tests"""
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start(start_high=False))
