`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/// Company: 
// Engineer: 
// 
//Students: Rashed Altammar, Braden Curtis
//Percentage effort: 50% for both.

//Final

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
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module toptb();

reg Clk, Reset;
wire [31:0] PCResult, WriteData,Instruction,MAluResult,AluResult,EXRD1Out,ALUin2,ReadDataOut,MRD2Out,
WBReadData,EXRD2Out,outJalData,EXSignExOut,SignExOut,BAddResult;
wire [4:0] ALUControl, WriteRegister,WBRegDst,RegDstOut,EX2016Inst,ID2016Inst;
wire [4:0] RR1In, RR2In;
wire [15:0] SignExIn,BSignExIn;
wire [5:0]CntrlIn,Cntrl50;
wire [4:0] Cntrl2016;
wire branch,BranchTaken,Mmemtoreg,memtoreg,WBregwrite,Mmemread,Mmemwrite,WBmemtoreg,Mlh,andout;
wire [1:0] EXalusrc,cntrljr;

wire [31:0] V0, V1, S0, S1, lowestSAD, currentSAD;


top a(Clk, Reset,PCResult, WriteData,ALUControl,RR1In, RR2In,BSignExIn,Instruction
,CntrlIn, Cntrl2016,Cntrl50,MAluResult,AluResult,EXRD1Out,ALUin2,Mmemtoreg,memtoreg,
WBregwrite,Mmemread,Mmemwrite,ReadDataOut,MRD2Out,WBmemtoreg,WBReadData,EXalusrc,EXRD2Out,Mlh,outJalData,
andout,PCWrite,Hazard,outCtrlJump,IFIDWrite,EXregdstOut,Mregwrite,EXregwrite,regwrite,RD1Out,StallAgain, WriteRegister,WBRegDst,
MRegDst,RegDstOut,EX2016Inst,ID2016Inst,SignExIn,EXSignExOut,SignExOut,branch,BranchTaken,BAddResult,cntrljr,
 V0, V1, S0, S1, lowestSAD, currentSAD);

initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

initial begin
Reset = 1;
@(posedge Clk);
#30;
Reset = 0;
end

endmodule
