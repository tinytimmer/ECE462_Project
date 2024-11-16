`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 10:58:53 PM
// Design Name: 
// Module Name: IDEXRegistertb
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


module IDEXRegistertb();

reg Clk;
reg regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite, cntrljalr, cntrljald;
reg [4:0] ac;
reg [1:0] cntrljr;

reg [25:0] ID250Inst;
reg [31:0] IDPCAddResult;
reg [31:0] RD1Out;
reg [31:0] RD2Out;
reg [31:0] SignExOut;
reg [4:0] ID2016Inst;
reg [4:0] ID1511Inst;

wire EXregdst, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXalusrc, EXregwrite, EXcntrljalr, EXcntrljald;
wire [4:0] EXac;
wire [1:0] EXcntrljr;

wire [25:0] EX250Inst;
wire [31:0] EXPCAddResult;
wire [31:0] EXRD1;
wire [31:0] EXRD2;
wire [31:0] EXSignEx;
wire [4:0] EX2016Inst;
wire [4:0] EX1511Inst;

IDEXRegister a(Clk, regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite, cntrljalr, cntrljald, ac, cntrljr, ID250Inst, IDPCAddResult, RD1Out, RD2Out,
SignExOut, ID2016Inst, ID1511Inst, EXregdst, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXalusrc, EXregwrite, EXcntrljalr, EXcntrljald, EXac, EXcntrljr,
EX250Inst, EXPCAddResult, EXRD1, EXRD2, EXSignEx, EX2016Inst, EX1511Inst);

initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end
	
initial begin

#100
regdst =1; 
branch = 1; 
memread = 1; 
memtoreg = 1; 
memwrite = 1; 
alusrc = 1; 
regwrite = 1; 
cntrljalr = 1; 
cntrljald = 1;
ac = 7;
cntrljr = 3;
ID250Inst = 26'b11111111111111111111111111;
IDPCAddResult = 63;
RD1Out = 127;
RD2Out = 255;
SignExOut = 511;
ID2016Inst = 7;
ID1511Inst = 15;



end


endmodule
