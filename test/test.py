
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_priority_encoder(dut):

    pass_count = 0
    fail_count = 0

    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.ena.value = 1
    dut.clk.value = 0
    dut.rst_n.value = 1

    for i in range(256):

        dut.ui_in.value = i
        await Timer(1, unit="ns")

        expected_valid = 1 if i != 0 else 0
        expected_idx = 0

        for j in range(8):
            if (i >> j) & 1:
                expected_idx = j

        expected = (expected_valid << 3) | expected_idx

        actual = int(dut.uo_out.value)
        uio_actual = int(dut.uio_out.value)
        oe_actual = int(dut.uio_oe.value)

        if (actual == expected
                and uio_actual == 0
                and oe_actual == 0):
            pass_count += 1
        else:
            fail_count += 1
            dut._log.error(
                f"FAIL: input={i:08b}, "
                f"expected={expected:04b}, "
                f"actual={actual:08b}, "
                f"uio_out={uio_actual:08b}, "
                f"uio_oe={oe_actual:08b}"
            )

    dut._log.info(f"TOTAL: {pass_count + fail_count}")
    dut._log.info(f"PASS: {pass_count}")
    dut._log.info(f"FAIL: {fail_count}")

    assert fail_count == 0, "Priority encoder test failed"
