`timescale 1ns / 1ns

module reg_file (
    input clk,
    input reset,
    input [3:0] a1,
    input [3:0] a2,
    input [3:0] a3,
    input [31:0] wd3,
    input we3,
    input [31:0] rpc,
    output [31:0] rd1,
    output [31:0] rd2
);

  localparam NUM_OF_REGS = 16;
  localparam PC_REG_ADDR = 15;

  reg [31:0] regs[NUM_OF_REGS-2:0];
  reg [31:0] rd1_i;
  reg [31:0] rd2_i;

  integer i;

  always_ff @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < NUM_OF_REGS; i = i + 1) begin
        regs[i] <= 32'd0;
      end
      rd1_i <= 32'd0;
      rd2_i <= 32'd0;
    end else begin
      if (we3) begin
        if (a1 < 32'd15) begin
          regs[a3] <= wd3;
        end else begin
          // TODO: handling writing to the PC reg
        end
      end else begin
        rd1_i <= a1 == 32'd15 ? rpc : regs[a1];
        rd2_i <= a2 == 32'd15 ? rpc : regs[a2];
      end
    end
  end

  assign rd1 = rd1_i;
  assign rd2 = rd2_i;

endmodule
