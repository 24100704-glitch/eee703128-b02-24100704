`default_nettype none

module tt_um_eee703128_24100704 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    reg [2:0] idx;
    wire valid;

    always @(*) begin
        if      (ui_in[7]) idx = 3'd7;
        else if (ui_in[6]) idx = 3'd6;
        else if (ui_in[5]) idx = 3'd5;
        else if (ui_in[4]) idx = 3'd4;
        else if (ui_in[3]) idx = 3'd3;
        else if (ui_in[2]) idx = 3'd2;
        else if (ui_in[1]) idx = 3'd1;
        else               idx = 3'd0;
    end

    assign valid   = |ui_in;
    assign uo_out  = {4'b0000, valid, idx};
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    wire unused;
    assign unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

`default_nettype wire
