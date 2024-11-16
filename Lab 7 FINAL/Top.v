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


module top(Clk, Reset,PCResult, WriteData,ALUControl,RR1In, RR2In,BSignExIn,Instruction
,CntrlIn, Cntrl2016,Cntrl50,MAluResult,AluResult,EXRD1Out,ALUin2,Mmemtoreg,memtoreg,
WBregwrite,Mmemread,Mmemwrite,ReadDataOut,MRD2Out,WBmemtoreg,WBReadData,EXalusrc,EXRD2Out,Mlh,outJalData,
andout,PCWrite,Hazard,outCtrlJump,IFIDWrite,EXregdstOut,Mregwrite,EXregwrite,regwrite,RD1Out,StallAgain, WriteRegister,WBRegDst,
MRegDst,RegDstOut,EX2016Inst,ID2016Inst,SignExIn,EXSignExOut,SignExOut,branch,BranchTaken,BAddResult,cntrljr, V0, V1, S0, S1, lowestSAD, currentSAD);

input Clk, Reset;
wire ex,selCtrlJump, Zero,RegWrite,seljalr,shift;
wire [31:0] PCAddResult, out, inA, inB,outshiftleft2, ReadData1, ReadData2,
outjalr;
output wire [31:0] PCResult, WriteData,Instruction,outCtrlJump;
output wire [4:0] ALUControl;
wire regdst, memread, memwrite, cntrljalr, cntrljald;
output wire branch;
wire [4:0] ac;
output wire [4:0] WriteRegister;
output wire [1:0] cntrljr;
wire [1:0] alusrc;
wire [25:0] ID250Inst, ID250InstExtend;
output wire [4:0] RR1In, RR2In;
wire [31:0] IDPCAddResult;
wire [31:0] RD2Out;
wire [31:0] BSignExOut;
output wire [4:0] ID2016Inst;
wire [4:0] ID1511Inst;
output wire [15:0] BSignExIn,SignExIn;

wire EXregdst, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXcntrljalr, EXcntrljald;
wire [4:0] EXac;
wire [1:0] EXcntrljr;
wire [25:0] EX250Inst;
wire [31:0] EXPCAddResult,BShiftOut;
output wire [31:0] EXRD1Out,outJalData;
output wire [31:0] EXSignExOut,SignExOut;
output wire [4:0] EX2016Inst;
wire [4:0] EX1511Inst;


output wire [5:0]CntrlIn,Cntrl50;
output wire [4:0] Cntrl2016;
wire [31:0] AddResultOut;
wire AluZero;
output wire [31:0] AluResult,RD1Out;
output wire [4:0] RegDstOut;
output wire Mmemtoreg,memtoreg;
wire Mbranch, Mcntrljalr, Mcntrljald;
wire [1:0] Mcntrljr;
output wire [1:0] EXalusrc;
wire [25:0] M250Inst;
wire [31:0] MRD1Out,M250Instsignex,M250Instsignexshifted;
wire [31:0] MPCAddResult;
wire [31:0] MAddResult,PCIn;
wire MAluZero,EXlh,EXlb,EXsh, EXsb,lh,lb,sh,sb,Mlb,Msh,Msb;
output wire [31:0] MAluResult,ALUin2,ReadDataOut,MRD2Out,WBReadData,EXRD2Out;
wire [31:0] ShiftedOffset;
output wire [4:0] MRegDst;
wire WBcntrljalr, WBcntrljald,EXshift;
output wire WBregwrite,Mmemread,Mmemwrite,WBmemtoreg,Mlh,andout;
wire [31:0] WBPCAddResult;
wire [31:0] WBAluResult,ALUin1;
wire [31:0] MemToRegOut,ID106Instoext,EX106Inst;
output wire [31:0] BAddResult;
wire [4:0] ID106Inst;

wire [31:0] ID250ShiftOut, ConcatenationResult;

output wire PCWrite,Hazard,IFIDWrite,Mregwrite,EXregwrite,regwrite;
output wire [4:0] EXregdstOut, WBRegDst;
output wire [1:0] StallAgain;
wire Flush;
output wire BranchTaken;

output wire [31:0] V0, V1, S0, S1, lowestSAD, currentSAD;



PCAdder b(PCResult, PCAddResult);
Mux32Bit2To1 JD(outJalData, PCAddResult, BAddResult,branch);    //JalData


signextend26to32 ujse(ID250Inst, ID250InstExtend);
ShiftLeftby2 ujsl(ID250InstExtend, ID250ShiftOut);
Concatenation ujc(PCAddResult, ID250ShiftOut, ConcatenationResult);

SignExtension bse(SignExIn, BSignExOut);
ShiftLeftby2 bsl(BSignExOut, BShiftOut);
Adder badd(PCResult, BShiftOut, BAddResult);


Mux32Bit3To1 CJ(outCtrlJump,RD1Out, ConcatenationResult, outJalData, cntrljr);   //CtrlJump 

ProgramCounter asd(PCWrite, outCtrlJump, PCResult, Reset, Clk);

InstructionMemory fadsa(PCResult, Instruction);

IFIDRegister asIFIDRegister(Clk,Reset, IFIDWrite ,PCAddResult, Instruction, CntrlIn, Cntrl2016, Cntrl50, ID250Inst, IDPCAddResult, RR1In, RR2In, SignExIn, ID2016Inst, ID1511Inst,ID106Inst,Flush);

BranchComparison idbc(CntrlIn, Cntrl2016, RD1Out, RD2Out, BranchTaken);

Controller c(Hazard,CntrlIn,Cntrl2016,Cntrl50, regdst, branch, memread, memtoreg, ALUControl,memwrite,alusrc,regwrite, cntrljr, cntrljalr, cntrljald,lh,lb,sh, sb,shift,BranchTaken,Flush);


//RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
RegisterFile r(RR1In, RR2In, WriteRegister, WriteData, WBregwrite, Clk, RD1Out, RD2Out, V0, V1, S0, S1, lowestSAD, currentSAD);
//***********Start Here***********//
/*
HazardDetection(EX2016Inst, EX1511Inst, MRegDst, Rs, Rt, EXregdst, EXMemRead, MMemRead,
IFIDWrite, Hazard, PCWrite, EXregwrite,Mregwrite,EXregdstOut,cntrljr,branch,StallAgain);
*/
HazardDetection haza(Clk,EX2016Inst, EX1511Inst, MRegDst, RR1In, RR2In, EXregdst, EXmemread, Mmemread,
IFIDWrite, Hazard, PCWrite,EXregwrite, Mregwrite,EXregdstOut,cntrljr,EXcntrljr,Mcntrljr,branch,StallAgain);

SignExtension ww(SignExIn, SignExOut);
SignExtension wssw(ID106Inst, ID106Instoext);


IDEXRegister dssdsd(Clk, Hazard,regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite, cntrljalr, cntrljald, ALUControl, cntrljr,shift, ID250Inst, IDPCAddResult, RD1Out, RD2Out,
SignExOut, ID2016Inst, ID1511Inst, EXregdst, EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXalusrc, EXregwrite, EXcntrljalr, EXcntrljald, EXac, EXcntrljr,
EX250Inst, EXPCAddResult, EXRD1Out, EXRD2Out, EXSignExOut, EX2016Inst, EX1511Inst,EXlh,EXlb,EXsh, EXsb,lh,lb,sh,sb,EX106Inst,EXshift,ID106Instoext);

//ShiftLeftby2 asss(EXSignExOut, ShiftedOffset);
//Adder a(EXPCAddResult, ShiftedOffset, AddResultOut);

Mux32Bit3To1  jinjnin(ALUin2, EXRD2Out, EXSignExOut,EX106Inst, EXalusrc);     //Changed to 3x1 for shifting
Mux32Bit2To1 asdasdda(  ALUin1, EXRD1Out, EXRD2Out, EXshift);         //NEW for sll and srl
ALU32Bit xsds(EXac, ALUin1, ALUin2, AluResult, AluZero);
Mux32Bit2To1 ssdf(RegDstOut, EX2016Inst, EX1511Inst, EXregdst);   



EXMRegister ssss(Clk,EXbranch, EXmemread, EXmemtoreg, EXmemwrite, EXregwrite, EXcntrljalr, EXcntrljald, EXcntrljr, EX250Inst, EXRD1Out, EXPCAddResult, AddResultOut,
AluZero, AluResult, EXRD2Out, RegDstOut, Mbranch, Mmemread, Mmemtoreg, Mmemwrite, Mregwrite, Mcntrljalr, Mcntrljald, Mcntrljr, M250Inst, MRD1Out, MPCAddResult,
MAddResult, MAluZero, MAluResult, MRD2Out, MRegDst,EXlh,EXlb,EXsh, EXsb,Mlh,Mlb,Msh,Msb);


//signextend26to32 wwwd(M250Inst, M250Instsignex);
//ShiftLeftby2 asdasd(M250Instsignex, M250Instsignexshifted);
//andgate AG(Mbranch, MAluZero, andout);
            //DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, sh, sb, lh, lb,mem0); 
DataMemory d(MAluResult, MRD2Out, Clk, Mmemwrite, Mmemread, ReadDataOut, Msh, Msb, Mlh, Mlb);

MWBRegister asdfesd(Clk, Mmemtoreg, Mregwrite, Mcntrljalr, Mcntrljald, MPCAddResult, MAluResult, ReadDataOut, MRegDst, WBmemtoreg, WBregwrite, WBcntrljalr,
WBcntrljald, WBPCAddResult, WBAluResult, WBReadData, WBRegDst);

Mux32Bit2To1 RXX(MemToRegOut, WBReadData, WBAluResult, WBmemtoreg);    //Memtoreg
Mux32Bit2To1 AS(WriteData, MemToRegOut, WBPCAddResult, WBcntrljald);    //jald
Mux32Bit2To1 MR(WriteRegister, WBRegDst, 31, WBcntrljalr);    //jalr


endmodule
