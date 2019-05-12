`timescale 1ns/1ns

module Stack #(parameter N = 100)(
  input clk, rst,
  input push, pop, tos,
  input [7:0] d_in,
  output reg [7:0] d_out);
  reg [7:0] mem [N-1:0];
  reg [9:0] head;
  integer i;
  always @(posedge clk, posedge rst) begin
    if(rst) begin
      for(i = 0; i < N; i = i + 1) mem[i] = 8'b0;
      head = 0;
    end
    else if(push) begin
      mem[head] = d_in;
      head = head + 1;
    end
    else if(pop) begin
      head = head - 1;
      d_out = mem[head];
    end
    else if(tos) d_out = mem[head - 1];
  end
endmodule

