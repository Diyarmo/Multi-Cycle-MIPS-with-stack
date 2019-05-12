`timescale 1ns/1ns

module REG #(parameter N = 8)(input [N-1:0] in, output reg [N-1:0] out, input clk, rst);
  reg [7:0] temp;
  always @(posedge clk, posedge rst) begin
  out <=(rst)?8'b0:in;
end
endmodule  

module REG2 #(parameter N = 8)(input [N-1:0] in, output reg [N-1:0] out, input clk, rst, ld);
  always @(posedge clk, posedge rst) begin
    if (rst) out <= 8'b0;
    else if(ld) out <= in;
    end
endmodule  



