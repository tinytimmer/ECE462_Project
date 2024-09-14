`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 04:37:22 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb( ); //, CurrPC, WriteVal);
reg Clk, Reset;
wire [31:0] CurrPC, WriteVal;
Toplevel_Datapath top(Clk, Reset, CurrPC, WriteVal);

    always begin
		Clk = 1'b0;
		#500;
		Clk = 1;
		#500;
    end
    
    initial begin
		Reset = 1;
		@(posedge Clk);
		#1000;
		Reset = 0;
	end

endmodule