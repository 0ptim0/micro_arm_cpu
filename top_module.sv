`timescale 1ns/1ns

module top_module #(
    parameter INST_MEMORY_SIZE = 1024
) (
    input clk,
    input reset
);

  reg [31:0] pc;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      pc <= 32'h00000000;
    end else begin
      pc <= pc + 'd4;
    end
  end



endmodule
