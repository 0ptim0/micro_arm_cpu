`timescale 1ns / 1ns
`include "inst.vh"

module top_module_tb;

  reg clk;
  reg reset;
  reg [31:0] inst;
  wire [31:0] pc;

  top_module DUT (
      .clk(clk),
      .reset(reset),
      .inst(inst),
      .mem_pc(pc)
  );

  initial begin
    clk = 0;
    forever begin
      #5;
      clk = ~clk;
    end
  end

  initial begin
    inst = 32'h00000000;
    @(posedge clk);
    reset = 1;
    @(posedge clk);
    reset = 0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    // ADD R3, R0, #3
    inst = {4'b1110, OP_CODE_DP, FUNCT_5_DP_IMM, FUNCT_4_1_ADD, 1'b0, 4'd0, 4'd3, 4'd0, 8'd6};
    @(posedge clk);

    // ADD R4, R3, #8
    inst = {4'b1110, OP_CODE_DP, FUNCT_5_DP_IMM, FUNCT_4_1_ADD, 1'b0, 4'd3, 4'd4, 4'd0, 8'd8};
    @(posedge clk);

    // STR R3, [R4]
    inst = {4'b1110, OP_CODE_MEM, 5'b0, FUNCT_0_STR, 4'd4, 4'd3, 12'd0};
    @(posedge clk);

    // STR R4, [R3+1]
    inst = {4'b1110, OP_CODE_MEM, 5'b0, FUNCT_0_STR, 4'd3, 4'd4, 12'd1};
    @(posedge clk);

    // STR R4, [R3-1]
    inst = {4'b1110, OP_CODE_MEM, 5'b0, FUNCT_0_STR, 4'd3, 4'd4, -12'd1};
    @(posedge clk);

    // LDR R8, [R3+8]
    inst = {4'b1110, OP_CODE_MEM, 5'b0, FUNCT_0_LDR, 4'd3, 4'd8, 12'd8};
    @(posedge clk);

    // B +4<<2
    inst = {4'b1110, OP_CODE_B, 2'b0, 24'h4};
    @(posedge clk);

    // B -44>>2
    inst = {4'b1110, OP_CODE_B, 2'b0, -24'h12};
    @(posedge clk);

    inst = {32'd0};
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    $stop;
  end

endmodule
