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
  
  // THIS ARE TWO DIFFERENT TEST SETS 

  // THIS ONE SUMS UP FIVE NUMBERS STARTING FORM MEMORY ADDRESS 25
  
  // mem[0] <= 8'b10011001;
  // mem[1] <= 8'b10011010;
  // mem[2] <= 8'b00000000;
  // mem[3] <= 8'b10011011;
  // mem[4] <= 8'b00000000;
  // mem[5] <= 8'b10011100;
  // mem[6] <= 8'b00000000;
  // mem[7] <= 8'b10011101;
  // mem[8] <= 8'b00000000;
  
  // mem[25] <= 57;
  // mem[26] <= 79;
  // mem[27] <= 14;
  // mem[28] <= 11;
  // mem[29] <= 32;

  // THIS ONE IS A SET OF DIFFERENT SYNTAXES

    mem[0] <= 8'b10011101; // push 8 in St
    mem[1] <= 8'b10011101; // push 8 in St
    mem[2] <= 8'b00000000; // add 8 + 8 and stoers 16 in St
    mem[3] <= 8'b11000111; // jump to instruction 7
    mem[7] <= 8'b11101100; // does not jumpz to 12 
    mem[8] <= 8'b10011110; // push 16 on St
    mem[9] <= 8'b00100000; // sub 16 - 16 and store 0 on St
    mem[10] <= 8'b11101111;  // jumpz 15
    mem[15] <= 8'b10011100;  // push 10101010 on St
    mem[16] <= 8'b10011011;  // push 01100110 on St
    mem[17] <= 8'b01000000;  // and 10101010 & 01100110 and store 01000100 on St
    mem[18] <= 8'b01100000;  // not 01000100 and store 10111011 on St
    mem[19] <= 8'b10111111;  // pop 10111011 from st and store it on mem[31]

    mem[27] <= 8'b01100110;
    mem[28] <= 8'b10101010;
    mem[29] <= 8'b00001000;
    mem[30] <= 8'b00010000;
  end
  
endmodule
