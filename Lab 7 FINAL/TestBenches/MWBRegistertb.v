`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 11:33:01 PM
// Design Name: 
// Module Name: MWBRegistertb
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


module MWBRegistertb();

reg Clk;
reg Mmemtoreg, Mregwrite, Mcntrljalr, Mcntrljald;
reg [31:0] MPCAddResult;
reg [31:0] MAluResult;
reg [31:0] ReadDataOut;
reg [4:0] MRegDst;

wire WBmemtoreg, WBregwrite, WBcntrljalr, WBcntrljald;
wire [31:0] WBPCAddResult;
wire [31:0] WBAluResult;
wire [31:0] WBReadData;
wire [4:0] WBRegDst;

MWBRegister a(Clk, Mmemtoreg, Mregwrite, Mcntrljalr, Mcntrljald, MPCAddResult, MAluResult, ReadDataOut, MRegDst, WBmemtoreg, WBregwrite, WBcntrljalr,
WBcntrljald, WBPCAddResult, WBAluResult, WBReadData, WBRegDst);

initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end
	
initial begin

#10

Mmemtoreg = 1;
Mregwrite = 1;
Mcntrljalr = 1;
Mcntrljald = 1;
MPCAddResult = 4095;
MAluResult  = 2047;
ReadDataOut = 1023;
MRegDst = 31;

end

endmodule
