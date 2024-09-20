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


module IFIDRegister(Clk, Reset, IFIDWrite,PCAddResult, Instruction, CntrlIn, Cntrl2016, Cntrl50, ID250Inst, IDPCAddResult, RR1In, RR2In, SignExIn, ID2016Inst, ID1511Inst,ID106Inst,Flush);

input Clk,IFIDWrite,Reset,Flush;
input [31:0] PCAddResult; 
input [31:0] Instruction;
output reg [5:0] CntrlIn;
output reg [4:0] Cntrl2016;
output reg [5:0] Cntrl50;
output reg [25:0] ID250Inst;
output reg [31:0] IDPCAddResult;
output reg [4:0] RR1In;
output reg [4:0] RR2In;
output reg [15:0] SignExIn;
output reg [4:0] ID2016Inst;
output reg [4:0] ID1511Inst;
output reg [4:0] ID106Inst;

always @ (posedge Clk) begin
if (Reset == 1)
begin
CntrlIn <= 6'b111111;
Cntrl2016 <= 15;         //Redundant, ID2016Inst and RR2In set to same value 
Cntrl50 <= 15;
ID250Inst <= 15;
IDPCAddResult <= 0;
RR1In <= 0;
RR2In <= 0;
SignExIn <=0;
ID2016Inst <= 0;
ID1511Inst <=0;
ID106Inst <=0;
end

else if (Flush == 1)
begin

CntrlIn <= 0;
Cntrl2016 <= 0;         //Redundant, ID2016Inst and RR2In set to same value 
Cntrl50 <= 0;
ID250Inst <= 0;
IDPCAddResult <= 0;
RR1In <= 0;
RR2In <= 0;
SignExIn <=0;
ID2016Inst <= 0;
ID1511Inst <=0;
ID106Inst <=0;

end


else
begin
if (IFIDWrite == 1)
begin
CntrlIn <= Instruction[31:26];
Cntrl2016 <= Instruction[20:16];         //Redundant, ID2016Inst and RR2In set to same value 
Cntrl50 <= Instruction[5:0];
ID250Inst <= Instruction [25:0];
IDPCAddResult <= PCAddResult;
RR1In <= Instruction [25:21];
RR2In <= Instruction [20:16];
SignExIn <= Instruction [15:0];
ID2016Inst <= Instruction [20:16];
ID1511Inst <= Instruction [15:11];
ID106Inst <= Instruction [10:6];
end
end
end
endmodule
