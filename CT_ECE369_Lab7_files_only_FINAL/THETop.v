`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Toplevel Hardware Implementation
// 
//////////////////////////////////////////////////////////////////////////////////


module THETop(Clk, Reset, out7, en_out, dp);
input Clk, Reset;
wire [31:0] NumberA, NumberB;
wire [15:0] display_w;

output [6:0] out7; //seg a, b, ... g
output [3:0] en_out;
output wire dp;

Mux32Bit2To1 dis(display_w, NumberB, NumberA, clkOut);
Mux32Bit2To1 dpm(dp, 0, 1, clkOut);

ClkDiv clock(Clk, 1'b0, clkOut);

One4DigitDisplay display(Clk, display_w, out7, en_out);

Toplevel_Datapath top(clkOut, Reset, NumberB, NumberA);


endmodule