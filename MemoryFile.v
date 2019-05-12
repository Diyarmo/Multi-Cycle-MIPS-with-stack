`timescale 1ns/1ns

module MemoryFile(
  input rst, memread, memwrite,
  input [4:0] address,
  input [7:0] writeData,
  output reg [7:0] readData);
  reg [7:0] mem [31:0];
  integer i; 
  always @(memread, memwrite, address) begin 
    if(memwrite) mem[address] <= writeData;
    if(memread) readData <= mem[address];
  end
  
  initial begin
  for (i= 0; i < 32; i = i + 1) mem[i] <= 8'b0;
  mem[0] <= 8'b10011001;
  mem[1] <= 8'b10011010;
  mem[2] <= 8'b00000000;
  mem[3] <= 8'b10011011;
  mem[4] <= 8'b00000000;
  mem[5] <= 8'b10011100;
  mem[6] <= 8'b00000000;
  mem[7] <= 8'b10011101;
  mem[8] <= 8'b00000000;
  
  mem[25] <= 57;
  mem[26] <= 79;
  mem[27] <= 14;
  mem[28] <= 11;
  mem[29] <= 32;
  end
  
endmodule
