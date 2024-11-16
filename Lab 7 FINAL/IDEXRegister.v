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


module IDEXRegister(Clk, Hazard ,regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite, cntrljalr, cntrljald, ac, cntrljr,shift, ID250Inst, IDPCAddResult, RD1Out, RD2Out,
SignExOut, ID2016Inst, ID1511Inst, EXregdst, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXalusrc, EXregwrite, EXcntrljalr, EXcntrljald, EXac, EXcntrljr,
EX250Inst, EXPCAddResult, EXRD1, EXRD2, EXSignEx, EX2016Inst, EX1511Inst,EXlh,EXlb,EXsh, EXsb,lh,lb,sh,sb,EX106Inst,EXshift,ID106Instoext);

input Clk, Hazard;
input regdst, branch, memread, memtoreg, memwrite, regwrite, cntrljalr, cntrljald,lh,lb,sh,sb,shift;
input [4:0] ac;
input [1:0] cntrljr,alusrc;

input [25:0] ID250Inst;
input [31:0] IDPCAddResult;
input [31:0] RD1Out;
input [31:0] RD2Out,ID106Instoext;
input [31:0] SignExOut;
input [4:0] ID2016Inst;
input [4:0] ID1511Inst;

output reg EXregdst, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXregwrite, EXcntrljalr, EXcntrljald,EXshift;
output reg [4:0] EXac;
output reg [1:0] EXcntrljr,EXalusrc;

output reg [25:0] EX250Inst;
output reg [31:0] EXPCAddResult,EX106Inst;
output reg [31:0] EXRD1;
output reg [31:0] EXRD2;
output reg [31:0] EXSignEx;
output reg [4:0] EX2016Inst;
output reg [4:0] EX1511Inst;
output reg EXlh,EXlb,EXsh, EXsb;

initial begin
EXcntrljr = 2;
end

always @ (posedge Clk)
 begin
 EXregdst = 0; EXbranch = 0;EXmemread = 0;EXmemtoreg = 0;EXmemwrite = 0;EXalusrc = 0;EXregwrite = 0;
EXcntrljalr = 0;EXcntrljald = 0;EXac = ac;EXcntrljr = 2;EX250Inst = 0;EXPCAddResult = 0;EXRD1 = 0;
EXRD2 = 0;EXSignEx = 0;EX2016Inst = 0;EX1511Inst = 0;EXlh = 0;EXlb = 0;EXsh =  0;EXsb = 0; EX106Inst = 0;EXshift = 0;
if (Hazard == 0)
begin
EXregdst = regdst;
EXbranch = branch;
EXmemread = memread;
EXmemtoreg = memtoreg;
EXmemwrite = memwrite;
EXalusrc = alusrc;
EXregwrite = regwrite;
EXcntrljalr = cntrljalr;
EXcntrljald = cntrljald;
EXac = ac;
EXcntrljr = cntrljr;
EX250Inst = ID250Inst;
EXPCAddResult = IDPCAddResult;
EXRD1 = RD1Out;
EXRD2 = RD2Out;
EXSignEx = SignExOut;
EX2016Inst = ID2016Inst;
EX1511Inst = ID1511Inst;
EXlh =    lh;
EXlb =    lb;
  EXsh =  sh;
  EXsb =   sb;
  EX106Inst = ID106Instoext;
  EXshift <= shift;
  end
  
end

endmodule
