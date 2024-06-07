/******** OP Codes ********/
parameter OP_CODE_DP = 2'b00;
parameter OP_CODE_MEM = 2'b01;
parameter OP_CODE_B = 2'b10;

/******** Registers ********/
parameter REG_NUM_PC = 'd15;

/******** Funct ********/
parameter FUNCT_0_STR = 1'b0;
parameter FUNCT_0_LDR = 1'b1;
parameter FUNCT_4_1_ADD = 4'b0100;
parameter FUNCT_4_1_SUB = 4'b0010;
parameter FUNCT_4_1_AND = 4'b0000;
parameter FUNCT_4_1_ORR = 4'b1100;
parameter FUNCT_5_DP_REG = 1'b0;
parameter FUNCT_5_DP_IMM = 1'b1;

/******** Flag W ********/
parameter FLAGW_1_0_IDLE = 2'b00;
parameter FLAGW_1_0_UPDATE_CV = 2'b01;
parameter FLAGW_1_0_UPDATE_NZ = 2'b10;
parameter FLAGW_1_0_UPDATE_NZCV = 2'b11;

/******** ALU ********/
parameter ALU_ADD_CODE = 2'd0;
parameter ALU_SUB_CODE = 2'd1;
parameter ALU_AND_CODE = 2'd2;
parameter ALU_ORR_CODE = 2'd3;

/******** Condition Flag Positions ********/
parameter COND_N = 'd3;
parameter COND_Z = 'd2;
parameter COND_C = 'd1;
parameter COND_V = 'd0;

/******** Memory Instruction ********/
typedef struct packed {
  bit [3:0] cond;
  bit [1:0] op;
  bit [5:0] funct;
  bit [3:0] rn;
  bit [3:0] rd;
  union packed {
    struct packed {bit [11:0] imm12;} immediate;
    struct packed {
      bit [4:0] shamt5;
      bit [1:0] sh;
      bit [0:0] one;
      bit [3:0] rm;
    } register;
  } src2;
} mem_inst_t;

/******** Data Instruction ********/
typedef struct packed {
  bit [3:0] cond;
  bit [1:0] op;
  bit [5:0] funct;
  bit [3:0] rn;
  bit [3:0] rd;
  union packed {
    struct packed {
      bit [3:0] rot;
      bit [7:0] imm8;
    } immediate;
    struct packed {
      bit [4:0] shamt5;
      bit [1:0] sh;
      bit [0:0] zero;
      bit [3:0] rm;
    } register;
  } src2;
} data_inst_t;

/******** Branch Instruction ********/
typedef struct packed {
  bit [3:0]  cond;
  bit [1:0]  op;
  bit [1:0]  funct;
  bit [23:0] imm24;
} b_inst_t;

/******** Common Control Fields ********/
typedef struct packed {
  bit [3:0]  cond;
  bit [1:0]  op;
  bit [5:0]  funct;
  bit [3:0]  rn;
  bit [3:0]  rd;
  bit [11:0] not_used;
} ctrl_inst_t;

/******** General Instruction Struct ********/
typedef union packed {
  mem_inst_t mem;
  data_inst_t data;
  b_inst_t b;
  ctrl_inst_t ctrl;
} inst_t;
