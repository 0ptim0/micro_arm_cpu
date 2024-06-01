`timescale 1ns / 1ns
`include "inst.sv"

module top_module (
    input clk,
    input reset
);

  reg [31:0] pc;
  data_inst_t inst;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      pc <= 32'h00000000;
    end else begin
      pc <= pc + 'd4;
    end
  end

  inst_mem inst_mem_0 (
      .a (pc),
      .rd(inst)
  );

endmodule
