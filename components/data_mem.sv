`timescale 1ns / 1ns

module data_mem #(
    parameter SIZE = 32
) (
    input clk,
    input reset,
    input we,
    input [31:0] a,
    input [31:0] wd,
    output [31:0] rd
);

  reg [31:0] reg_mem_i[SIZE-1:0];
  integer i;

  always_ff @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < SIZE; i = i + 1) begin
        reg_mem_i[i] <= 32'd0;
      end
    end else begin
      if (a < SIZE) begin
        if (we) begin
          reg_mem_i[a] <= wd;
        end
      end
    end
  end

  assign rd = reg_mem_i[a];;

endmodule
