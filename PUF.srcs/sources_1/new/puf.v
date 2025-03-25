`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 15:08:05
// Design Name: 
// Module Name: puf
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module puf #(parameter N = 8) (
  input reset,[N-1:0]sel,
  output out
);
  wire [N-1:0] m;
  wire [N-1:0] n;

  reg in = 1;
  MUXblock block0 (in,in,sel[0],m[0],n[0]);

  generate
    genvar i;
    for (i = 0; i < N - 1; i = i + 1) 
    begin: MUXblock
      MUXblock block(
        m[i],
        n[i],
        sel[i+1],
        m[i+1],
        n[i+1]
      );
    end
  endgenerate
  
  Dlatch uut (
  .clk(n[N-1]),
  .d(m[N-1]),
  .reset(reset),
  .q(out)
  );

endmodule  
