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

module ProgramCounter(PCWrite,Address, PCResult, Reset, Clk);

	input [31:0] Address;
	input Reset, Clk,PCWrite;

	output reg [31:0] PCResult;
    
   
    /* Please fill in the implementation here... */
    always @(posedge Clk)
    begin
    if (Reset == 1)
    PCResult = 0;
    else if (PCWrite == 1)
    PCResult = Address; 
    else 
    PCResult = PCResult;    
    end
endmodule

