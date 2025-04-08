`timescale 1ns / 1ps

module Dlatch(
    input d, clk, reset,
    output reg q
);
    always@(posedge clk, posedge reset)
    begin 
        if (reset)
        begin
            q <= 1'b0;
        end
        else
        begin
            q <= d;
        end
    end
endmodule