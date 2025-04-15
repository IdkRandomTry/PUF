`timescale 1ns / 1ps

/**
 * Arbiter PUF (Physical Unclonable Function) Core
 * @param N       Number of challenge bits/stages (default: 8)
 * @param reset   Global reset signal (active high)
 * @param challenge[N-1:0] Configuration bits for delay path selection
 * @param out     PUF response output
 */
module puf #(parameter N = 8) (
    input  wire [N-1:0] challenge,   // Configuration bits
    input  wire         reset,  //indicates new challenge bit
    input wire          start_flag,
    output reg         out,       // Response output
    output wire         out_n,         // Response output
    output reg         in_reset
);
    // Intermediate delay path signals
    wire [N-1:0] m;  // Upper delay path
    wire [N-1:0] n;  // Lower delay path

    // Initial stimulus generation
    reg in = 0;  // Initial pulse input (constant high)
    assign out_n = ~out;

    // First MUXblock stage
    MUXblock block0 (
        .in_up    (in),          // Upper input
        .in_down  (in),          // Lower input
        .sel      (challenge[0]),// First challenge bit
        .out_up   (m[0]),        // Upper path output
        .out_down (n[0])         // Lower path output
    );

    // Generate MUXblock chain for N-1 stages
    generate
        genvar i;
        for (i = 0; i < N-1; i = i+1) begin : gen_blocks
            MUXblock block (
                .in_up    (m[i]),            // Upper path input
                .in_down  (n[i]),            // Lower path input
                .sel      (challenge[i+1]),  // Subsequent challenge bits
                .out_up   (m[i+1]),          // Upper path propagation
                .out_down (n[i+1])           // Lower path propagation
            );
        end
    endgenerate

    always @(posedge reset or posedge n[N-1] or posedge start_flag)
    begin
    if (reset)
    begin
        in <= 0;
        out <= 0;
        in_reset <= 1;
    end
    else
    begin
    if (start_flag)
        begin
            if(!in) in<= 1;
            if (n[N-1]) out<=m[N-1]; 
        end
    end
    end
endmodule
