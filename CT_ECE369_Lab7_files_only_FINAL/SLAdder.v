`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2022 07:49:28 PM
// Design Name: 
// Module Name: SLAdder
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
// 
//////////////////////////////////////////////////////////////////////////////////


module SLAdder(inA, inSLB, out);
    input [31:0] inA, inSLB;
    output reg [31:0] out;
	
	integer b;
	
	always @(inA, inSLB) begin
		b = inSLB<<2;
		out = inA + b;
    end
endmodule
