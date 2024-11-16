`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Toplevel Datapath
// 
//////////////////////////////////////////////////////////////////////////////////


module Toplevel_Datapath(Clk, Reset, CurrPC, WriteVal);
input Clk, Reset;
output [31:0] CurrPC, WriteVal;

//output [6:0] out7; //seg a, b, ... g
//output [3:0] en_out;
//output wire dp;

//wire clkOut;
//for hd
wire Stall;
//
wire [15:0] display_w;

wire [31:0] PCIn, PCOut, InstMemOut, PCAdderOut, JSrcIn, JRSrIn, TargetAddress; // IF Wires

wire [31:0] Instruction, ReadData1_ID, ReadData2_ID, SignExtendOut, PC4_ID, v0, v1; // ID Wires
wire [1:0] WB_ID;
wire [4:0] M_ID;
wire [5:0] EX_ID;
wire [2:0] Jsig;
wire IDFlush, EXFlush;

wire [31:0] ReadData1_EX, ReadData2_EX, ALUMux, ALUResult_EX, Immediate, PC4_EX, AdderOut_EX; // EX Wires
wire [4:0] Rd, Rt, WriteReg_EX;
wire [1:0] WB_EX;
wire [4:0] M_EX;
wire [5:0] EX_EX;
wire Zero_EX;
//for hd
wire MemRead_EX;
wire [31:0] Instruction_EX; //I think this needs to be specifc since this isnt using the full 32bits of an instruction, what do you think?
//

wire [31:0] ALUResult_MEM, ReadData2_MEM, BranchAddress, MemData_MEM; // MEM Wires
wire [4:0] WriteReg_MEM;
wire [1:0] WB_MEM;
wire [4:0] M_MEM;
wire Zero_MEM, MemSign, BranchTaken;

wire [31:0] ALUResult_WB, MemData_WB, WBMux; // WB Wires
wire [4:0] WriteReg_WB;
wire [1:0] WB_WB;


//Mux32Bit2To1 dis(display_w, PCOut, WBMux, clkOut);
//Mux32Bit2To1 dpm(dp, 0, 1, clkOut);
//ClkDiv clock(Clk, 1'b0, clkOut);
//One4DigitDisplay display(Clk, display_w, out7, en_out);
//assign clkOut = Clk;
assign CurrPC = PCOut;
assign WriteVal = WBMux;

//       INSTRUCTION FETCH PHASE
UnsignExtension ue(Instruction[25:0], TargetAddress);
Mux32Bit2To1 PCSrc(JSrcIn, PCAdderOut, BranchAddress, BranchTaken);
Mux32Bit2To1 JSrc(JRSrIn, JSrcIn, TargetAddress, Jsig[0]);
Mux32Bit2To1 JRSrc(PCIn, JRSrIn, ReadData1_ID, Jsig[1]);
ProgramCounter pc(PCIn, PCOut, Reset, Clk, Stall);
PCAdder a1(PCOut, PCAdderOut);
InstructionMemory im(PCOut, InstMemOut);

IF_ID_reg r1(PCAdderOut, InstMemOut, Clk, PC4_ID, Instruction, IDFlush, Stall, Jsig[0], Jsig[1]);

//for hd
HazardDetector hd(M_MEM[0], M_EX[0], Instruction[25:21],Instruction[20:16], WriteReg_EX, WriteReg_MEM, Stall, Reset, BranchTaken, IDFlush, EXFlush, WB_EX[1], WB_MEM[1]);
//have not tested this yet
//

//       INSTRUCTION DECODE PHASE
Controller c1(Instruction, EX_ID, M_ID, WB_ID, Jsig, Stall);
RegisterFile rf(Instruction[25:21], Instruction[20:16], WriteReg_WB, WBMux, WB_WB[1], Clk, ReadData1_ID, ReadData2_ID, PC4_ID, Jsig[2], v0, v1);
SignExtension se(Instruction[15:0], SignExtendOut);

ID_EX_reg r2(WB_ID, M_ID, EX_ID, PC4_ID, ReadData1_ID, ReadData2_ID, SignExtendOut, Instruction[15:11], Instruction[20:16], Clk, WB_EX, M_EX, EX_EX, PC4_EX, ReadData1_EX, ReadData2_EX, Immediate, Rd, Rt, EXFlush);

//       EXECUTION PHASE
SLAdder a2(PC4_EX, Immediate, AdderOut_EX);
ALU32Bit alu(EX_EX[5:2], ReadData1_EX, ALUMux, ALUResult_EX, Zero_EX);
Mux32Bit2To1 ALUSrc(ALUMux, ReadData2_EX, Immediate, EX_EX[0]);
Mux5Bit2To1 RegDist(WriteReg_EX, Rt, Rd, EX_EX[1]);

EX_MEM_Reg r3(Clk, WB_EX, M_EX, AdderOut_EX, ALUResult_EX, Zero_EX, ReadData2_EX, WriteReg_EX, WriteReg_MEM, WB_MEM, M_MEM, Zero_MEM, BranchAddress, ALUResult_MEM, ReadData2_MEM, EXFlush);

//       MEMORY ACCESS PHASE
BranchModule bt(M_MEM[2], Zero_MEM, BranchTaken);
MemorySign ms(ALUResult_MEM, M_MEM[4:3], MemSign);
DataMemory dm(ALUResult_MEM, ReadData2_MEM, Clk, M_MEM[1], M_MEM[0], MemData_MEM, M_MEM[4:3], MemSign);

MEM_WB_Reg r4(Clk, WB_MEM, WB_WB, MemData_MEM, MemData_WB, ALUResult_MEM, ALUResult_WB, WriteReg_MEM, WriteReg_WB);

//       WRITE BACK PHASE
Mux32Bit2To1 MemToReg(WBMux, MemData_WB, ALUResult_WB, WB_WB[0]);

endmodule