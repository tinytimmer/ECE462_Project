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


module toptop(Clk, Reset,out7, en_out);
input Clk, Reset;
output [6:0] out7;
output [7:0] en_out;
wire ClkOut;
wire [31:0] PCResult, WriteData;
wire [31:0] V0, V1;
top t(ClkOut, Reset,PCResult, WriteData,ALUControl,RR1In, RR2In,BSignExIn,Instruction
,CntrlIn, Cntrl2016,Cntrl50,MAluResult,AluResult,EXRD1Out,ALUin2,Mmemtoreg,memtoreg,
WBregwrite,Mmemread,Mmemwrite,ReadDataOut,MRD2Out,WBmemtoreg,WBReadData,EXalusrc,EXRD2Out,Mlh,outJalData,
andout,PCWrite,Hazard,outCtrlJump,IFIDWrite,EXregdstOut,Mregwrite,EXregwrite,regwrite,RD1Out,StallAgain, WriteRegister,WBRegDst,
MRegDst,RegDstOut,EX2016Inst,ID2016Inst,SignExIn,EXSignExOut,SignExOut,branch,BranchTaken,BAddResult,cntrljr, V0, V1, S0, S1, lowestSAD, currentSAD);


ClkDiv c(Clk, 0, ClkOut);

Two4DigitDisplay td(Clk, V0[15:0],V1[15:0], out7, en_out);
endmodule
