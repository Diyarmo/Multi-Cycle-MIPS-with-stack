`timescale 1ns/1ns

module TB();
  reg clk, rst;
  wire ldpc, ldmem, ldalu, pcsrc, memsrc, alusrcA, alusrcB, stksrc, 
  memRead, memWrite, push, pop, tos;
  wire [1:0] alu_control;
  wire [2:0] opcode;
  wire [7:0] d_out;
  CU cu(clk, rst, ldpc, ldmem, ldalu, pcsrc, memsrc, alusrcA, alusrcB, stksrc, 
  memRead, memWrite, push, pop, tos, alu_control, opcode, d_out);
  
  DP dp(clk, rst, ldpc, ldmem, ldalu, pcsrc, memsrc, alusrcA, alusrcB, stksrc,
  memRead, memWrite, push, pop, tos, alu_control, opcode, d_out);
  always #10 clk = ~clk;
  initial begin
    clk = 0;
    rst = 1;
    #50 rst = 0;
    
  end

endmodule