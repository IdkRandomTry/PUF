`timescale 1ns / 1ps

/**
 * Arbiter PUF (Physical Unclonable Function) Core
 * @param N       Number of challenge bits/stages (default: 8)
 * @param reset   Global reset signal (active high)
 * @param challenge[N-1:0] Configuration bits for delay path selection
 * @param out     PUF response output
 */
module puf #(parameter N = 8) (
    input  wire         reset,       // Global reset
    input  wire [N-1:0] challenge,   // Configuration bits
    input  wire         start_flag,  //indicates new challenge bit
    output reg         out         // Response output
);
    // Intermediate delay path signals
    wire [N-1:0] m;  // Upper delay path
    wire [N-1:0] n;  // Lower delay path

    // Initial stimulus generation
    reg in = 0;  // Initial pulse input (constant high)
    reg race_reset = 1;
    wire d_out;
    not(finish_flag,start_flag);

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

    // Arbiter latch (D-latch) to capture who wins
    Dlatch finish_line (
        .clk   (n[N-1]),  // Clock from lower path
        .d     (m[N-1]),  // Data from upper path
        .reset (race_reset),   // Global reset
        .q     (d_out)   // PUF response output
    );
    
    always @(posedge start_flag or posedge finish_flag or posedge reset)
    begin
        if (reset) begin
            race_reset <= 1;
            in <= 0;
            out <= 0;
        end
        else if (start_flag) begin
            race_reset <= 0;
            in <= 1;
        end
        else if (finish_flag) begin
            race_reset <= 1;
            in <= 0;
            out <= d_out;
        end
    end
    
endmodule