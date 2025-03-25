`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 16:31:12
// Design Name: 
// Module Name: top_tb
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


module top_tb();

reg clk, reset;
reg [7:0] seed = 8'b01010100;
wire out;

initial begin
    clk = 0;
    forever
        #5 clk = ~clk;
end


top uut (.clk(clk), .reset(reset), .seed(seed), .out(out));

endmodule
