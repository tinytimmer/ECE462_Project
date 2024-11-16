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

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2,
 V0, V1, S0, S1, lowestSAD, currentSAD);

	input RegWrite;
	input Clk;
	input [4:0] ReadRegister1;
	input [4:0] ReadRegister2;
	input [4:0] WriteRegister;
	input [31:0] WriteData;
	
	reg [31:0] registers [31:0];
	
	reg [31:0] ReadData1;
	reg [31:0] ReadData2;
	
	output [31:0] ReadData1;
	output [31:0] ReadData2;
	
	output reg [31:0] V0, V1, S0, S1, lowestSAD, currentSAD;
	
	always @* begin
	
	ReadData1 = registers[ReadRegister1];
	ReadData2 = registers[ReadRegister2];
	
	V0 = registers[2];
	V1 = registers[3];
	S0 = registers[16];
	S1 = registers[17];
	lowestSAD = registers[22];
	currentSAD = registers[12];
	
	end
	
	always @(negedge Clk) begin 
	
	if (RegWrite == 1) begin
	
	registers[WriteRegister] = WriteData;
	
	end
	
	end
	


endmodule
