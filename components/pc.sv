`timescale 1ns / 1ns

module pc (
    input clk,
    input reset,
    input we,
    input [31:0] wd,
    output reg [31:0] rd
);

  reg [31:0] pc_i;

  always_ff @(posedge clk) begin
    if (reset) begin
      rd <= 32'h00000000;
    end else begin
      if (we) rd <= wd;
      else rd <= rd + 'd4;
    end
  end

endmodule
