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


module signextend26to32(in, out);
input [25:0] in;
output reg [31:0] out;

always @*
begin

if (in[25:25] == 1)
out = in + 32'b11111100000000000000000000000000;
else
out = in;
end
endmodule
