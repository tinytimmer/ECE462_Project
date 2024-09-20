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


module HazardDetection(Clk,EX2016Inst, EX1511Inst, MRegDst, Rs, Rt, EXregdst, EXMemRead, MMemRead,
IFIDWrite, Hazard, PCWrite, EXregwrite,Mregwrite,EXregdstOut,cntrljr,EXcntrljr,Mcntrljr,branch,StallAgain);

input [4:0] EX2016Inst, EX1511Inst;
input [4:0] MRegDst;
input [4:0] Rs;
input [4:0] Rt;
input EXregdst, EXMemRead, MMemRead,EXregwrite,Mregwrite,branch,Clk;
input [1:0] cntrljr,EXcntrljr,Mcntrljr;


output reg [4:0] EXregdstOut;
output reg [1:0] StallAgain;
                                  
output reg IFIDWrite, Hazard, PCWrite;

initial begin
StallAgain = 0;
end

always @*
begin
IFIDWrite = 1; Hazard = 0; PCWrite = 1; EXregdstOut = 0;


if (EXregdst == 1)begin
EXregdstOut = EX1511Inst;
end

else begin
EXregdstOut = EX2016Inst;
end



    if (EXregwrite == 1) begin
    if (EXregdstOut == Rs || EXregdstOut == Rt) begin
    
        IFIDWrite = 0;
        Hazard = 1;
        PCWrite = 0;    
    end
    end
    
    if (Mregwrite == 1) begin                               //Fix
    if (MRegDst == Rs || MRegDst == Rt) begin
    
        IFIDWrite = 0;
        Hazard = 1;
        PCWrite = 0;
        
    end
    end

        
        
end

endmodule
