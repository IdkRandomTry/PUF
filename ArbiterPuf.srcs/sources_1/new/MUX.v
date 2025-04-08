`timescale 1ns / 1ps

module MUX (
    input in_0, in_1, sel,
    output out
    );
    assign out = sel ? in_1 : in_0;
endmodule