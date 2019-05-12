`timescale 1ns/1ns

module CU(input clk, rst, 
output reg ldpc, ldmem, ldalu, pcsrc, memsrc, alusrcA, alusrcB, stksrc, 
memRead, memWrite, push, pop, tos, 
output reg [1:0] alu_control, 
input [2:0] opcode, 
input [7:0] d_out);

reg [3:0] ps,ns;
parameter IF = 0, ID = 1, S_POP1 = 2, S_POP2 = 3, ALU = 4,
A_PUSH = 5, M_READ = 6, M_PUSH = 7, M_POP = 8,
M_WRITE = 9, TOS = 10, Z_CHECK = 11, JUMP = 12;
parameter ADD = 0, SUB = 1, AND = 2, NOT = 3, PUSH = 4, POP = 5, JMP = 6, JZ = 7;
always @(opcode, d_out, ps) begin
  {ldpc, ldmem, ldalu, pcsrc, memsrc, alusrcA, alusrcB, stksrc, 
  memRead, memWrite, push, pop, tos, alu_control} = 15'b0;
  ns = IF;
  case(ps)
    
    IF: begin
      ns = ID;
      ldpc = 1;
      memsrc = 0;
      alusrcA = 0;
      alusrcB = 0;
      alu_control = ADD;
      pcsrc = 0;
      memRead = 1;
      ldmem = 1;
    end
    
    ID: begin
      
      ns = (opcode==NOT)?S_POP2:
             (opcode==ADD || opcode==SUB || opcode==AND)?S_POP1:
             (opcode==PUSH)?M_PUSH:
             (opcode==POP)?M_POP:
             (opcode==JMP)?JUMP:
             (opcode==JZ)?TOS:IF;
    end
    
    S_POP1: begin
      ns = S_POP2;
      pop = 1;
    end
    
    S_POP2: begin
      ns = ALU;
      pop = 1;
    end
    
    ALU: begin
      ns = A_PUSH;
      alusrcA = 1;
      alusrcB = 1;
      ldalu = 1;
      alu_control = opcode[1:0];
    end
    
    A_PUSH: begin
      ns = IF;
      push = 1;
      stksrc = 0;
    end
      
    M_PUSH: begin
      ns = IF;
      memsrc = 1;
      memRead = 1;
      push = 1;
      stksrc = 1;
    end
    
    M_POP: begin
      ns = M_WRITE;
      pop = 1;
    end
    
    M_WRITE: begin
      ns = IF;
      memWrite = 1;
      memsrc = 1;
    end
    
    TOS: begin
      ns = Z_CHECK;
      tos = 1;
    end
    
    Z_CHECK: ns = (d_out == 8'b0)?JUMP:IF;
    
    JUMP: begin
      pcsrc = 1;
      ldpc = 1;
    end
    endcase     
end
always @(posedge clk, posedge rst) begin
  if (rst) ns <= IF;
  else ps <= ns;
end

endmodule