`timescale 1ns / 1ns

module control_unit (
    input [3:0] cond,
    input [1:0] op,
    input [5:0] funct,
    input [3:0] rd,
    input [3:0] alu_flags,
    output pc_ctrl,
    output mem_to_reg,
    output mem_we,
    output [1:0] alu_ctrl,
    output alu_src,
    output [1:0] imm_src,
    output reg_we,
    output [1:0] reg_src
);

  wire reg_we_i;
  wire cond_ex_i;

  /**********  PC Logic **********/
  wire pc_ctrl_i = (op == OP_CODE_B) || (rd == REG_NUM_PC && reg_we_i);
  assign pc_ctrl = pc_ctrl_i & cond_ex_i;

  /********** Main Decoder **********/
  wire mem_to_reg_i = (op == OP_CODE_MEM) && (funct[0] == FUNCT_0_LDR);
  wire mem_we_i = (op == OP_CODE_MEM) && (funct[0] == FUNCT_0_STR);
  wire alu_src_i = (op == OP_CODE_DP) && (funct[5] != FUNCT_5_DP_REG);
  wire [1:0] imm_src_i = op;
  wire imm_reg_we_i = (op == OP_CODE_DP) || (op == OP_CODE_MEM && funct[0] == FUNCT_0_LDR);
  wire [1:0] reg_src_i = {(op == OP_CODE_MEM && funct[0] == FUNCT_0_STR), (op == OP_CODE_B)};
  wire alu_op_i = (op == OP_CODE_DP);

  /********** ALU Decoder **********/
  reg [1:0] alu_ctrl_i;
  reg [1:0] flag_w_i;
  always_comb begin
    if (alu_op_i) begin
      case(funct[4:1])
        FUNCT_4_1_ADD: begin
          alu_ctrl_i <= ALU_ADD_CODE;
          if (funct[0]) flag_w_i <= FLAGW_1_0_UPDATE_NZCV;
          else flag_w_i <= FLAGW_1_0_IDLE;
        end
        FUNCT_4_1_SUB: begin
          alu_ctrl_i <= ALU_SUB_CODE;
          if (funct[0]) flag_w_i <= FLAGW_1_0_UPDATE_NZCV;
          else flag_w_i <= FLAGW_1_0_IDLE;
        end
        FUNCT_4_1_AND: begin
          alu_ctrl_i <= ALU_AND_CODE;
          if (funct[0]) flag_w_i <= FLAGW_1_0_UPDATE_NZ;
          else flag_w_i <= FLAGW_1_0_IDLE;
        end
        FUNCT_4_1_ORR: begin
          alu_ctrl_i <= ALU_ORR_CODE;
          if (funct[0]) flag_w_i <= FLAGW_1_0_UPDATE_NZ;
          else flag_w_i <= FLAGW_1_0_IDLE;
        end
      endcase
    end else begin
      alu_ctrl_i <= ALU_ADD_CODE;
      flag_w_i <= FLAGW_1_0_IDLE;
    end
  end
  assign alu_ctrl_i[0] = 

  /********** Conditional Check **********/
  assign pc_ctrl = cond_ex_i & pc_ctrl_i;
  assign reg_we = cond_ex_i & reg_we_i;
  assign mem_we = cond_ex_i & reg_we_i;

  assign mem_to_reg = mem_to_reg_i;
  assign alu_ctrl = alu_ctrl_i;
  assign alu_src = alu_src_i;
  assign imm_src = imm_src_i;
  assign reg_src = reg_src_i;

endmodule
