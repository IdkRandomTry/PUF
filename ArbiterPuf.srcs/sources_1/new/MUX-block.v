`timescale 1ns / 1ps

module MUXblock(
    input in_up,in_down,sel,
    output out_up,out_down
    );
    
MUX mux_up(in_up,in_down,sel,out_up);
MUX mux_down(in_down,in_up,sel,out_down);    
     
endmodule