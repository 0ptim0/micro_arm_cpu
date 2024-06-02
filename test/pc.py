import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def pc(dut):
    """Program counter tests"""
    clock = Clock(dut.clk, 2, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    dut.reset.value = 1
    await RisingEdge(dut.clk)

    dut.reset.value = 0
    await RisingEdge(dut.clk)
    assert dut.rd.value.integer == 0

    await RisingEdge(dut.clk)
    assert dut.rd.value.integer == 4

    dut.we.value = 1
    dut.wd.value = 10
    await RisingEdge(dut.clk)
    dut.we.value = 0
    assert dut.rd.value.integer == 8
    await RisingEdge(dut.clk)
    assert dut.rd.value.integer == 10
    await RisingEdge(dut.clk)
    assert dut.rd.value.integer == 14

    dut.reset.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    assert dut.rd.value.integer == 0
