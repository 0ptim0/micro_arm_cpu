typedef struct packed {
  bit [3:0] cond;
  bit [1:0] op;
  bit [5:0] funct;
  bit [3:0] rn;
  bit [3:0] rd;
  bit [11:0] src2;
} data_inst_t;
