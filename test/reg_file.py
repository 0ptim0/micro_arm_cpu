import cocotb
from cocotb.clock import Clock

@cocotb.test()
async def reg_file(dut):
    """Register file tests"""
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start(start_high=False))
