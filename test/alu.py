import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def alu(dut):
    """ALU tests"""

    # ADD
    dut.a.value = 19
    dut.b.value = 79
    dut.ctrl.value = 0
    await Timer(1, units="ns")
    assert dut.out.value.integer == 98

    dut.a.value = -50
    dut.b.value = 12
    dut.ctrl.value = 0
    await Timer(1, units="ns")
    assert dut.out.value.signed_integer == -38

    # SUB
    dut.a.value = -50
    dut.b.value = -12
    dut.ctrl.value = 1
    await Timer(1, units="ns")
    assert dut.out.value.signed_integer == -38

    dut.a.value = 10
    dut.b.value = 12
    dut.ctrl.value = 1
    await Timer(1, units="ns")
    assert dut.out.value.signed_integer == -2

    # AND
    dut.a.value = 0x0F0F0F0F
    dut.b.value = 0xAAAAAAAA
    dut.ctrl.value = 2
    await Timer(1, units="ns")
    assert dut.out.value.integer == 0x0A0A0A0A

    # ORR
    dut.a.value = 0x0F0F0F0F
    dut.b.value = 0xAAAAAAAA
    dut.ctrl.value = 3
    await Timer(1, units="ns")
    assert dut.out.value.integer == 0xAFAFAFAF
