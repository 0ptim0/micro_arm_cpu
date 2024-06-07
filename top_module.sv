`timescale 1ns / 1ns
`include "inst.vh"
`default_nettype none

module top_module (
    input wire clk,
    input wire reset
);

  /************* Current Instruction *************/
  inst_t inst;

  /************* Control Unit *************/
  wire pc_ctrl;
  wire mem_to_reg;
  wire mem_we;
  wire [1:0] alu_ctrl;
  wire alu_src;
  wire [1:0] imm_src;
  wire reg_we;
  wire [1:0] reg_src = 2'b0;
  wire [3:0] alu_flags;

  control_unit u_control_unit (
      .cond      (inst.ctrl.cond),
      .op        (inst.ctrl.op),
      .funct     (inst.ctrl.funct),
      .rd        (inst.ctrl.rd),
      .alu_flags (alu_flags),
      .pc_ctrl   (pc_ctrl),
      .mem_to_reg(mem_to_reg),
      .mem_we    (mem_we),
      .alu_ctrl  (alu_ctrl),
      .alu_src   (alu_src),
      .imm_src   (imm_src),
      .reg_we    (reg_we),
      .reg_src   (reg_src)
  );

  /************* Data Memory Feedback Multiplexer *************/
  wire [31:0] alu_out;
  wire [31:0] data_mem_out;
  wire [31:0] data_mem_out_mux = mem_to_reg ? alu_out : data_mem_out;

  /************* Program Counter *************/
  wire [31:0] pc;

  pc u_pc (
      .clk  (clk),
      .reset(reset),
      .we   (pc_ctrl),
      .wd   (data_mem_out_mux),
      .rd   (pc)
  );

  /************* Instruction Memory *************/
  inst_mem u_mem_inst (
      .a (pc),
      .rd(inst)
  );

  /************* CPU Registers *************/
  wire [31:0] pc_reg_file = pc + 32'd8;
  wire [ 3:0] reg_file_a1_mux = reg_src[0] ? 4'd15 : inst.mem.rn;
  wire [ 3:0] reg_file_a2_mux = reg_src[1] ? inst.mem.rd : inst.data.src2.register.rm;
  wire [31:0] reg_file_rd1;
  wire [31:0] reg_file_rd2;

  reg_file u_reg_file (
      .clk  (clk),
      .reset(reset),
      .a1   (reg_file_a1_mux),
      .a2   (reg_file_a2_mux),
      .a3   (inst.data.rd),
      .wd3  (data_mem_out_mux),
      .we3  (reg_we),
      .rpc  (pc_reg_file),
      .rd1  (reg_file_rd1),
      .rd2  (reg_file_rd2)
  );

  /************* Extend Immediates *************/
  wire [31:0] ext_imm_out;
  wire [31:0] ext_imm_in  [2:0];
  assign ext_imm_in[0] = {{24{1'b0}}, inst.data.src2.immediate.imm8};
  assign ext_imm_in[1] = {{20{1'b0}}, inst.mem.src2.immediate.imm12};
  assign ext_imm_in[2] = {{6{inst.b.imm24[23]}}, inst.b.imm24, 2'b00};

  mux #(
      .SIZE    ('d32),
      .CHANNELS('d3)
  ) u_ext_imm (
      .in (ext_imm_in),
      .sel(imm_src),
      .out(ext_imm_out)
  );

  /************* ALU *************/
  wire [31:0] alu_src_a_mux = reg_file_rd1;
  wire [31:0] alu_src_b_mux = alu_src ? ext_imm_out : reg_file_rd2;

  alu u_alu (
      .a   (alu_src_a_mux),
      .b   (alu_src_b_mux),
      .ctrl(alu_ctrl),
      .out (alu_out),
      .flags(alu_flags)
  );

  /************* Data Memory *************/
  data_mem #(
      .SIZE(32)
  ) u_data_mem (
      .clk  (clk),
      .reset(reset),
      .we   (mem_we),
      .a    (alu_out),
      .wd   (reg_file_rd2),
      .rd   (data_mem_out)
  );

endmodule
