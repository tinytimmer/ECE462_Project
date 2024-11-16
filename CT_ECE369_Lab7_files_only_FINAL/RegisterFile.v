`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: FILL IN YOUR INFO HERE!
//Carmen Timmer
//	Files worked on:
//	ProgramCounter.v & tb
//	PCAdder.v
//	Mux32Bit2To1.v & tb
//	EX_MEM_RegPipeline.v 
//	MEM_WB_RegPipeline.v
//	SignExtension.v
//	SLAdder.v
//	ALU32Bit.v & tb
//	RegisterFile.v & tb
//	DataMemory_tb.v
//	
//Enoch Dew
//	File worked on:
//	Controller.v
//	TopLevel_Design.v
//	IF_ID_RegPipeline.v
//	ID_EX_RegPipeline.v
//	InstructionMemory.v
//
// Module - RegisterFile.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, PC4, JALsig, v0, v1);

	/* Please fill in the implementation here... */
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input [31:0] WriteData, PC4;
	input RegWrite, Clk, JALsig;
	
	output reg [31:0] ReadData1, ReadData2, v0, v1;
	reg [31:0] Registers [0:31]; // this means reg [31:0] Registers = new reg[32]
	
	initial begin
	   ReadData1 <= 0;
	   ReadData2 <= 0;
	   v0 <= 0;
	   v1 <= 0;
	   
		Registers[0] <= 32'h00000000;
		Registers[2] <= 32'h00000000;
		Registers[3] <= 32'h00000000;
		Registers[8] <= 32'h00000000;
		Registers[9] <= 32'h00000000;
		Registers[10] <= 32'h00000000;
		Registers[11] <= 32'h00000000;
		Registers[12] <= 32'h00000000;
		Registers[13] <= 32'h00000000;
		Registers[14] <= 32'h00000000;
		Registers[15] <= 32'h00000000;
		Registers[16] <= 32'h00000000;
		Registers[17] <= 32'h00000000;
		Registers[18] <= 32'h00000000;
		Registers[19] <= 32'h00000000;
		Registers[20] <= 32'h00000000;
		Registers[21] <= 32'h00000000;
		Registers[22] <= 32'h00000000;
		Registers[23] <= 32'h00000000;
		Registers[24] <= 32'h00000000;
		Registers[25] <= 32'h00000000;
		Registers[29] <= 32'd32000; // this value should point to the top of data memory, dont forget byte addressing
		Registers[31] <= 32'b0;
	end
	
	always @(negedge Clk)
	begin
	    if(JALsig) begin
	        Registers[31] <= PC4 + 4;
	    end
		if (RegWrite == 1)
		begin
			Registers[WriteRegister] <= WriteData;
			v0 <= Registers[2];
	        v1 <= Registers[3];
		end
	end
	
	always @(*)
	begin
		ReadData1 <= Registers[ReadRegister1];
		ReadData2 <= Registers[ReadRegister2];
	end



endmodule
