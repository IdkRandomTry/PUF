`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 15:30:11
// Design Name: 
// Module Name: MUX-block
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


module MUXblock(
    input in_up,in_down,sel,
    output out_up,out_down
    );
    
MUX mux_up(in_up,in_down,sel,out_up);
MUX mux_down(in_down,in_up,sel,out_down);    
     
endmodule
