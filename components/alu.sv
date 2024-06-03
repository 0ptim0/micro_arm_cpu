`timescale 1ns / 1ns

module alu (
    input [31:0] a,
    input [31:0] b,
    input [1:0] ctrl,
    output reg [31:0] out,
    output [3:0] flags
);

  always_comb begin
    case (ctrl)
      ALU_ADD_CODE: out = a + b;
      ALU_SUB_CODE: out = a - b;
      ALU_AND_CODE: out = a & b;
      ALU_ORR_CODE: out = a | b;
      default:  out = 32'd0;
    endcase
  end

  assign flags = 4'b0;

endmodule
