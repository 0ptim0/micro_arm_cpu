`timescale 1ns / 1ns

module top_module_tb;

  reg clk;
  wire reset;

  top_module DUT (
    .clk(clk),
    .reset(reset)
  );

  initial begin
    clk = 0;
    forever begin
      #5;
      clk = ~clk;
    end
  end

  initial begin
    #1000;
    $stop;
  end

endmodule
