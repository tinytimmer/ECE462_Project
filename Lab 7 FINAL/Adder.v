`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
//Students: Rashed Altammar, Braden Curtis
//Percentage effort: 50% for both.

//5 Stage Pipeline with Branch/Jumps resolved in the Memory stage

// Create Date: 08/29/2023 09:11:03 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////


module Adder(in, in2, out);

input [31:0] in, in2;
output reg [31:0] out;

always @*
begin

if (in[31] == 1)begin
out = in2 - (~in + 1);
end

else if (in2[31] == 1) begin
out = in - (~in2 + 1);
end

else begin
out = in + in2;
end
end
endmodule
