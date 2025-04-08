`timescale 1ns / 1ps

/**
 * PUF-LFSR Integration Module
 * @param N       Bit-width of challenge/seed (default: 8)
 * @param reset   Global reset (active high)
 * @param clk     System clock
 * @param en      Shift enable signal
 * @param seed    Initial seed value for LFSR
 * @param out     PUF response output
 */
module top #(parameter N = 8) (
    input  wire        reset,    // Global reset
    input  wire        clk,      // System clock
    input  wire        en,       // Shift enable
    input  wire [N-1:0] seed,    // Initial seed value
    output wire        out       // PUF response
);

    // LFSR state register with synchronous reset
    reg [N-1:0] challenge;
    reg en_puf;
    wire clk_n;
    assign clk_n = ~clk;
    
    // PUF core instantiation with named port connections
    puf #(.N(N)) puf_race (
        .challenge(challenge),  // Current challenge pattern
        .reset(reset),          // System reset
        .start_flag(en_puf),
        .out(out)               // PUF response
    );

    // LFSR update logic with custom polynomial: x^N + x + 1
    always @(posedge clk, posedge reset, posedge clk_n) begin
        if (reset) begin
            challenge <= seed;  // Asynchronous reset to initial seed
       
        end
        else begin
            if (clk) begin
                // Custom feedback polynomial: XOR MSB with LSB and invert
                challenge <= {challenge[N-2:0], (challenge[N-1] ^ challenge[0] ^ 1'b1)};
                if (en) en_puf <= 1;
            end
            else en_puf <= 0;
        end
    end

endmodule