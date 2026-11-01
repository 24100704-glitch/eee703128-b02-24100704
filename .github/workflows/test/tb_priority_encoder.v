`timescale 1ns/1ps
`default_nettype none

module tb_priority_encoder;

    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    reg        ena, clk, rst_n;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    integer i;
    integer j;
    integer pass_count;
    integer fail_count;
    reg [2:0] expected_idx;
    reg expected_valid;

    tt_um_eee703128_24100704 dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        ui_in = 0;
        uio_in = 0;
        ena = 1;
        clk = 0;
        rst_n = 1;

        pass_count = 0;
        fail_count = 0;

        for (i = 0; i < 256; i = i + 1) begin
            ui_in = i;
            #1;

            expected_valid = |ui_in;
            expected_idx = 0;

            for (j = 0; j < 8; j = j + 1) begin
                if (ui_in[j])
                    expected_idx = j;
            end

            if (uo_out[3:0] === {expected_valid, expected_idx}
                && uo_out[7:4] === 4'b0000
                && uio_out === 8'b00000000
                && uio_oe === 8'b00000000) begin
                pass_count = pass_count + 1;
            end
            else begin
                fail_count = fail_count + 1;
                $display("FAIL: input=%b output=%b",
                         ui_in, uo_out);
            end
        end

        $display("--------------------------------");
        $display("TOTAL: %0d", pass_count + fail_count);
        $display("PASS : %0d", pass_count);
        $display("FAIL : %0d", fail_count);
        $display("--------------------------------");

        if (fail_count == 0)
            $display("RESULT: PASS");
        else
            $display("RESULT: FAIL");

        $finish;
    end

endmodule

`default_nettype wire
