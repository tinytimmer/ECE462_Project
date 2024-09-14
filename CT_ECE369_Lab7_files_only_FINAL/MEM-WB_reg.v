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


module MEM_WB_Reg(Clk, WB_In, WB_Out, DMem_In, DMem_Out, ALUResult_In, ALUResult_Out, MuxReg_In, MuxReg_Out);

	input Clk;
	input [1:0] WB_In;
	input [31:0] DMem_In, ALUResult_In;
	input [4:0] MuxReg_In;
	
	output reg [1:0] WB_Out;
	output reg [4:0] MuxReg_Out;
	output reg [31:0] DMem_Out, ALUResult_Out;
	
	initial begin
	   WB_Out <= 0;
	   MuxReg_Out <= 0;
	   DMem_Out <= 0;
	   ALUResult_Out <= 0;
	end
	
	//write the rest of the stuff here
	always@(posedge Clk)
		begin	
        WB_Out = WB_In; //willbe used a the control signal for MemReg Mux
        DMem_Out = DMem_In;
        ALUResult_Out = ALUResult_In;
        MuxReg_Out = MuxReg_In;
     end	

endmodule