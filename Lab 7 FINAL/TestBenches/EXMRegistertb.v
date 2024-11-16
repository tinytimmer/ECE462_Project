`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 11:20:15 PM
// Design Name: 
// Module Name: EXMRegistertb
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


module EXMRegistertb();

reg Clk;
reg EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXregwrite, EXcntrljalr, EXcntrljald;
reg [1:0] EXcntrljr;

reg [25:0] EX250Inst;
reg [31:0] EXRD1;
reg [31:0] EXPCAddResult;
reg [31:0] AddResultOut;
reg AluZeroOut;
reg [31:0] AluResultOut;
reg [31:0] EXRD2;
reg [4:0] RegDstOut;

wire Mbranch, Mmemread, Mmemtoreg, Mmemwrite, Mregwrite, Mcntrljalr, Mcntrljald;
wire [1:0] Mcntrljr;

wire [25:0] M250Inst;
wire [31:0] MRD1;
wire [31:0] MPCAddResult;
wire [31:0] MAddResult;
wire MAluZero;
wire [31:0] MAluResult;
wire [31:0] MRD2;
wire [4:0] MRegDst;

EXMRegister a(Clk, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXregwrite, EXcntrljalr, EXcntrljald, EXcntrljr, EX250Inst, EXRD1, EXPCAddResult, AddResultOut,
AluZeroOut, AluResultOut, EXRD2, RegDstOut, Mbranch, Mmemread, Mmemtoreg, Mmemwrite, Mregwrite, Mcntrljalr, Mcntrljald, Mcntrljr, M250Inst, MRD1, MPCAddResult,
MAddResult, MAluZero, MAluResult, MRD2, MRegDst);

initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end
	
initial begin

#100
EXbranch = 1; 
EXmemread = 1; 
EXmemtoreg = 1; 
EXmemwrite = 1; 
EXregwrite = 1; 
EXcntrljalr = 1; 
EXcntrljald = 1;
EXcntrljr = 3;
EX250Inst = 2047;
EXRD1 = 1023;
EXPCAddResult = 1024;
AddResultOut = 511;
AluZeroOut = 1;
AluResultOut = 512;
EXRD2 = 4095;
RegDstOut = 31;




end


endmodule
