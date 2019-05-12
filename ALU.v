`timescale 1ns/1ns

module ALU(
  input [1:0] op,
  input [7:0] A, B,
  output reg [7:0] alu_out);
  
  always @(op, A, B) begin 
    case(op)
      0: alu_out = A+B;
      1: alu_out = A-B;
      2: alu_out = A&B;
      3: alu_out = ~A; 
    endcase
  end
endmodule


