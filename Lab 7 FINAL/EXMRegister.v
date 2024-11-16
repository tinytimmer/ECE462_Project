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


module EXMRegister(Clk, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXregwrite, EXcntrljalr, EXcntrljald, EXcntrljr, EX250Inst, EXRD1, EXPCAddResult, AddResultOut,
AluZeroOut, AluResultOut, EXRD2, RegDstOut, Mbranch, Mmemread, Mmemtoreg, Mmemwrite, Mregwrite, Mcntrljalr, Mcntrljald, Mcntrljr, M250Inst, MRD1, MPCAddResult,
MAddResult, MAluZero, MAluResult, MRD2, MRegDst,EXlh,EXlb,EXsh, EXsb,Mlh,Mlb,Msh,Msb);

input Clk;
input EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXregwrite, EXcntrljalr, EXcntrljald,EXlh,EXlb,EXsh, EXsb;
input [1:0] EXcntrljr;

input [25:0] EX250Inst;
input [31:0] EXRD1;
input [31:0] EXPCAddResult;
input [31:0] AddResultOut;
input AluZeroOut;
input [31:0] AluResultOut;
input [31:0] EXRD2;
input [4:0] RegDstOut;

output reg Mbranch, Mmemread, Mmemtoreg, Mmemwrite, Mregwrite, Mcntrljalr, Mcntrljald,Mlh,Mlb,Msh,Msb;
output reg [1:0] Mcntrljr;

output reg [25:0] M250Inst;
output reg [31:0] MRD1;
output reg [31:0] MPCAddResult;
output reg [31:0] MAddResult;
output reg MAluZero;
output reg [31:0] MAluResult;
output reg [31:0] MRD2;
output reg [4:0] MRegDst;

initial
begin
Mmemread = 0;
MAluZero = 0;
Mbranch = 0;
Mregwrite = 0;
Mcntrljr = 2;
end

always @ (posedge Clk) begin

Mbranch = EXbranch;
Mmemread = EXmemread;
Mmemtoreg = EXmemtoreg;
Mmemwrite = EXmemwrite;
Mregwrite = EXregwrite;
Mcntrljalr = EXcntrljalr;
Mcntrljald = EXcntrljald;
Mcntrljr = EXcntrljr;
M250Inst = EX250Inst;
MRD1 = EXRD1;
MPCAddResult = EXPCAddResult;
MAddResult = AddResultOut;
MAluZero = AluZeroOut;
MAluResult = AluResultOut;
MRD2 = EXRD2;
MRegDst = RegDstOut;
Mlh = EXlh;
Mlb = EXlb;
Msh = EXsh;
Msb = EXsb;
end

endmodule
