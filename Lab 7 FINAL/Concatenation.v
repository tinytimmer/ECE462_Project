`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 09:37:00 PM
// Design Name: 
// Module Name: Concatenation
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


module Concatenation(PCAddResult, ShiftLeft2Result, ConcatenationResult);

input [31:0] PCAddResult;
input [31:0] ShiftLeft2Result;
output reg [31:0] ConcatenationResult;

always @* begin

ConcatenationResult = (PCAddResult[31:28] * 268435456) + ShiftLeft2Result[27:0];

end


endmodule
