import cocotb
from cocotb.clock import Clock

@cocotb.test()
async def control_unit(dut):
    """Control unit tests"""
