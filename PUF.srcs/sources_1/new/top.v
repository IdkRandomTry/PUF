`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 16:17:10
// Design Name: 
// Module Name: top
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


module top(
    input reset,clk,
    input [7:0] seed,
    output out);

reg [7:0] sel;

initial sel = seed;

puf uut (.sel(sel), .reset(reset), .out(out));

always @ (posedge clk)
begin
    sel = {sel[6:0],(sel[7]^sel[0])};
end

endmodule
