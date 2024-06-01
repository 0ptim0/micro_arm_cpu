`timescale 1ns / 1ns

module alu (
    input [31:0] a,
    input [31:0] b,
    input [1:0] ctrl,
    output reg [31:0] out
);

  localparam ADD_CODE = 2'd0;
  localparam SUB_CODE = 2'd1;
  localparam AND_CODE = 2'd2;
  localparam ORR_CODE = 2'd3;

  always_comb begin
    case (ctrl)
      ADD_CODE: out = a + b;
      SUB_CODE: out = a - b;
      AND_CODE: out = a & b;
      ORR_CODE: out = a | b;
      default:  out = 32'd0;
    endcase
  end

endmodule
