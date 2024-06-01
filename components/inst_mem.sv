`timescale 1ns / 1ns

module inst_mem (
    input  [31:0] a,
    output [31:0] rd
);

  // Hardcoded program for testing
  localparam MEM_SIZE = 8;
  wire [31:0][MEM_SIZE-1:0] mem_i = {32'h0, 32'h0, 32'h0, 32'h0, 32'h0, 32'h0, 32'h0, 32'h0};

  assign rd = a < 32'd8 ? mem_i[a] : 32'd0;

endmodule
