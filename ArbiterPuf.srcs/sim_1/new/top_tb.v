`timescale 1ns / 1ps

module top_tb();

reg clk, reset, en;
reg [7:0] seed = 8'b01010100;
wire out;

initial begin
    clk = 0;
    forever
        #5 clk = ~clk;
end

top uut (.clk(clk), .reset(reset), .seed(seed), .out(out), .en(en));

initial begin
    reset = 0;#15
    en = 1;
    reset = 1;#15
    reset = 0;
end

endmodule