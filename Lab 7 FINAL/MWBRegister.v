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


module MWBRegister(Clk, Mmemtoreg, Mregwrite, Mcntrljalr, Mcntrljald, MPCAddResult, MAluResult, ReadDataOut, MRegDst, WBmemtoreg, WBregwrite, WBcntrljalr,
WBcntrljald, WBPCAddResult, WBAluResult, WBReadData, WBRegDst);

input Clk;
input Mmemtoreg, Mregwrite, Mcntrljalr, Mcntrljald;
input [31:0] MPCAddResult;
input [31:0] MAluResult;
input [31:0] ReadDataOut;
input [4:0] MRegDst;

output reg WBmemtoreg, WBregwrite, WBcntrljalr, WBcntrljald;
output reg [31:0] WBPCAddResult;
output reg [31:0] WBAluResult;
output reg [31:0] WBReadData;
output reg [4:0] WBRegDst;

always @ (posedge Clk) begin 

WBmemtoreg = Mmemtoreg;
WBregwrite = Mregwrite;
WBcntrljalr = Mcntrljalr;
WBcntrljald = Mcntrljald;
WBPCAddResult = MPCAddResult;
WBAluResult = MAluResult;
WBReadData = ReadDataOut;
WBRegDst = MRegDst;

end


endmodule
