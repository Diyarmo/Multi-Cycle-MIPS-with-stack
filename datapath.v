`timescale 1ns/1ns

module DP(input clk, rst, ldpc, ldmem, ldalu, pcsrc, memsrc, alusrcA, alusrcB, stksrc, memRead, memWrite, push, pop, tos, input [1:0] alu_control, output [2:0] opcode, output [7:0] d_out);
  
  wire [4:0] PC_in, PC_out;
  REG2 #(5) PC_reg (PC_in, PC_out, clk, rst, ldpc);
  
  wire [7:0] alu_in_A, alu_in_B, alu_out, alu_reg_out;
  ALU Alu(alu_control, alu_in_A, alu_in_B, alu_out);
  REG2 ALU_reg(alu_out,alu_reg_out, clk, rst, ldalu);
  
  wire [7:0] stack_in, stack_out, A_out;
  Stack stack(clk, rst, push, pop, tos, stack_in, stack_out);
  REG A(stack_out, A_out, clk, rst);
  
  wire [7:0] mem_data, mem_reg_out, ins_reg_out;
  wire [4:0] mem_in;
  MemoryFile MF(rst, memRead, memWrite, mem_in, stack_out, mem_data);
  REG2 mem_reg(mem_data, mem_reg_out, clk, rst, ldmem);

  assign d_out = stack_out;
  assign opcode = mem_reg_out[7:5];
  assign PC_in =(pcsrc==1)?mem_reg_out[4:0]:(pcsrc==0)?alu_out:8'bz;
  assign alu_in_A =(alusrcA==1)?stack_out:(alusrcA==0)?PC_out:8'bz;
  assign alu_in_B =(alusrcB==1)?A_out:(alusrcB==0)?8'b00000001:8'bz;
  assign stack_in =(stksrc==1)?mem_data:(stksrc==0)?alu_reg_out:8'bz;
  assign mem_in = (memsrc==1)?mem_reg_out[4:0]:(memsrc==0)?PC_out:8'bz;
endmodule  