`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2022 02:55:41 PM
// Design Name: 
// Module Name: IF-ID_reg
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


module EX_MEM_Reg(Clk, WB_In, M_In, ADDResult_In, ALUResult_In, ALUZero_In, ReadData2_In, MuxReg_In, MuxReg_Out, WB_Out, M_Out, ALUZero_Out, ADDResult_Out, ALUResult_Out, ReadData2_Out, EXFlush);

	input [1:0] WB_In;
	input [4:0] M_In;
	input Clk, EXFlush;
	//input [4:0] Rt_In;
	input [31:0] ADDResult_In, ALUResult_In;
	input ALUZero_In;
	input [4:0] MuxReg_In;
	input [31:0] ReadData2_In;
	
	output reg [31:0] ReadData2_Out, ADDResult_Out, ALUResult_Out;
	output reg [1:0] WB_Out;
	output reg [4:0] M_Out;
	output reg [4:0] MuxReg_Out;
	output reg ALUZero_Out;
    
    initial begin
        ReadData2_Out <= 0;
        ADDResult_Out <= 0;
        ALUResult_Out <= 0;
        WB_Out <= 0;
        M_Out <= 0;
        MuxReg_Out <= 0;
        ALUZero_Out <= 0;
    end
    
	//write the rest of the stuff here
	always@(posedge Clk)
		begin
		    if (EXFlush) begin
		      ReadData2_Out <= 0;
        ADDResult_Out <= 0;
        ALUResult_Out <= 0;
        WB_Out <= 0;
        M_Out <= 0;
        MuxReg_Out <= 0;
        ALUZero_Out <= 0;
		    end
		    else begin
			//passing control signals
			WB_Out = WB_In;
			M_Out = M_In; // used for DMem control signals: MemWrite | MemRead;
							//also used in the Branch
			
			//passing value of PC4 through Adder, not sure if this is right 
			//ADDResult_In = PC4_Out;
			ADDResult_Out = ADDResult_In;
			
			//passing values from ALU, whether its zero or not
			ALUZero_Out = ALUZero_In; //used in Branch
			ALUResult_Out = ALUResult_In;
			
			//Passing Instruction (copying from ID/EXE stage)
			MuxReg_Out = MuxReg_In;
			ReadData2_Out = ReadData2_In;
			end
		end

endmodule