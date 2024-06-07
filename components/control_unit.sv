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
  reg  cond_ex_i;

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
      case (funct[4:1])
        FUNCT_4_1_ADD: begin
          alu_ctrl_i = ALU_ADD_CODE;
          if (funct[0]) flag_w_i = FLAGW_1_0_UPDATE_NZCV;
          else flag_w_i = FLAGW_1_0_IDLE;
        end
        FUNCT_4_1_SUB: begin
          alu_ctrl_i = ALU_SUB_CODE;
          if (funct[0]) flag_w_i = FLAGW_1_0_UPDATE_NZCV;
          else flag_w_i = FLAGW_1_0_IDLE;
        end
        FUNCT_4_1_AND: begin
          alu_ctrl_i = ALU_AND_CODE;
          if (funct[0]) flag_w_i = FLAGW_1_0_UPDATE_NZ;
          else flag_w_i = FLAGW_1_0_IDLE;
        end
        FUNCT_4_1_ORR: begin
          alu_ctrl_i = ALU_ORR_CODE;
          if (funct[0]) flag_w_i = FLAGW_1_0_UPDATE_NZ;
          else flag_w_i = FLAGW_1_0_IDLE;
        end
      endcase
    end else begin
      alu_ctrl_i = ALU_ADD_CODE;
      flag_w_i   = FLAGW_1_0_IDLE;
    end
  end

  /********** Conditional Check **********/
  wire nero, zero, carry, overflow;
  assign {neg, zero, carry, overflow} = alu_flags;

  always_comb begin
    case (Cond)
      4'b0000: cond_ex_i = zero;
      4'b0001: cond_ex_i = ~zero;
      4'b0010: cond_ex_i = carry;
      4'b0011: cond_ex_i = ~carry;
      4'b0100: cond_ex_i = neg;
      4'b0101: cond_ex_i = ~neg;
      4'b0110: cond_ex_i = overflow;
      4'b0111: cond_ex_i = ~overflow;
      4'b1000: cond_ex_i = carry & ~zero;
      4'b1001: cond_ex_i = ~(carry & ~zero);
      4'b1010: cond_ex_i = ge;
      4'b1011: cond_ex_i = ~ge;
      4'b1100: cond_ex_i = ~zero & ge;
      4'b1101: cond_ex_i = ~(~zero & ge);
      4'b1110: cond_ex_i = 1'b1;
      default: cond_ex_i = 1'bx;
    endcase
  end

  assign pc_ctrl = cond_ex_i & pc_ctrl_i;
  assign reg_we = cond_ex_i & reg_we_i;
  assign mem_we = cond_ex_i & reg_we_i;


  assign mem_to_reg = mem_to_reg_i;
  assign alu_ctrl = alu_ctrl_i;
  assign alu_src = alu_src_i;
  assign imm_src = imm_src_i;
  assign reg_src = reg_src_i;

endmodule
