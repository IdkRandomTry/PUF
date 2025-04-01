`timescale 1ns / 1ps

module top #(parameter N = 8)(
    input reset, clk, en,
    input [N-1:0] seed,
    output out);

reg [N-1:0] challenge;
initial challenge = seed;

//CALLING PUF WITH CHALLENGE BIT
puf uut (.challenge(challenge), .reset(reset), .out(out));

//LFSR EQUIVALENT CODE TO UPDATE CHALLENGE BITS
always @ (posedge clk, posedge reset)
begin
    challenge = reset?seed:{challenge[N-2:0],(challenge[N-1]^challenge[0]^1'b1)};
end

endmodule