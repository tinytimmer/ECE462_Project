`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 07:59:29 PM
// Design Name: 
// Module Name: IFIDRgeistertb
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


module IFIDRgeistertb();

reg [31:0] PCAddResult;
reg [31:0] Instruction;
reg Clk;

wire [5:0] CntrlIn;
wire [4:0] Cntrl2016;
wire [5:0] Cntrl50;
wire [25:0] ID250Inst;
wire [31:0] IDPCAddResult;
wire [4:0] RR1In;
wire [4:0] RR2In;
wire [15:0] SignExIn;
wire [4:0] ID2016Inst;
wire [4:0] ID1511Inst;

IFIDRegister a(Clk, PCAddResult, Instruction, CntrlIn, Cntrl2016, Cntrl50, ID250Inst, 
IDPCAddResult, RR1In, RR2In, SignExIn, ID2016Inst, ID1511Inst);

initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end
	
initial begin

#100
PCAddResult = 0;
Instruction = 32'b01001100011100001111000001111100;
#100
PCAddResult = 31;
Instruction = 32'b10110011100011110000111110000011;

end



endmodule
