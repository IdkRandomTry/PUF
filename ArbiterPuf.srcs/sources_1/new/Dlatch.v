`timescale 1ns / 1ps

module Dlatch(
    input d, clk, reset,
    output reg q
);
    always@( clk)
    begin 
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule