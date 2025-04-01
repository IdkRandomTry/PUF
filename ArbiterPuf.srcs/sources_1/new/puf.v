`timescale 1ns / 1ps

module puf #(parameter N = 8) (
  input reset,[N-1:0]challenge,
  output out
);
  wire [N-1:0] m; 
  wire [N-1:0] n;

  reg in = 1;
  MUXblock block0 (in,in,challenge[0],m[0],n[0]);

  generate
    genvar i;
    for (i = 0; i < N - 1; i = i + 1) 
    begin: MUXblock
      MUXblock block(
        m[i],               //in_up
        n[i],               //in_down
        challenge[i+1],     //select
        m[i+1],             //out_up
        n[i+1]              //out_down
      );
    end
  endgenerate
  
  Dlatch uut (
  .clk(n[N-1]),
  .d(m[N-1]),
  .reset(reset),
  .q(out)
  );

endmodule  