`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 10:49:09 PM
// Design Name: 
// Module Name: Addertb
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


module Addertb();

reg [31:0] in, in2;
wire [31:0] out;

Adder a(in, in2, out);

initial begin

#100
in = 10;
in2 = 15;

#100
in = -10;
in2 = 15;

#100
in = 20;
in2 = -15;

#100;

end

endmodule
