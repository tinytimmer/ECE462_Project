`timescale 1ns / 1ps
module HazardDetector(MemRead_EXMEM, MemRead_IDEX, Rs_ID, Rt_ID, WriteReg_EX, WriteReg_MEM, Stall, Reset, BranchTaken, IDFlush, EXFlush, RegWrite_IDEX, RegWrite_EXMEM);
	input MemRead_EXMEM, MemRead_IDEX, RegWrite_IDEX, RegWrite_EXMEM, Reset, BranchTaken;
	input [4:0] Rs_ID, Rt_ID, WriteReg_EX, WriteReg_MEM;
	output reg Stall, IDFlush, EXFlush;
	
  // id_ex_instru[20:16]: ID/EX.Rt
  // if_id_instru[25:21]: IF/ID.Rs
  // if_id_instru[20:16]: IF/ID.Rt
	
	initial begin
	   Stall <= 0;
	   IDFlush <= 0;
	   EXFlush <= 0;
	end
	
	always @(BranchTaken) begin
	   if (BranchTaken == 1) begin
	       IDFlush <= 1;
	       EXFlush <= 1;
	   end
	   else begin
	       IDFlush <= 0;
	       EXFlush <= 0;
	   end
	end
	
	always @(*) begin
		if (Reset == 0) begin
			if ((RegWrite_IDEX == 1) && ((Rs_ID == WriteReg_EX) || (Rt_ID == WriteReg_EX))) begin // Register Read After Write (Execution Phase)
				Stall <= 1;
			end	
	        else if ((RegWrite_EXMEM == 1) && ((Rs_ID == WriteReg_MEM) || (Rt_ID == WriteReg_MEM))) begin // Register Read After Write (Memory Phase)
				Stall <= 1;
			end
			
			else if (MemRead_EXMEM == 1 && (Rs_ID == WriteReg_EX || Rt_ID == WriteReg_EX)) begin // hazard detected lw, look at signals in EX stage
				Stall <= 1;
			end
			
			else begin
		        Stall <= 0;
		    end
		end
		else begin
		  Stall <= 0;
		end
	end

endmodule