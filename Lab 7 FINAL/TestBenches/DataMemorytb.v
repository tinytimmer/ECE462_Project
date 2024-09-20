`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 08:29:34 PM
// Design Name: 
// Module Name: DataMemorytb
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


module DataMemorytb();

    reg [31:0] Address; 	// Input Address 
    reg [31:0] WriteData; // Data that needs to be written into the address 
    reg Clk, sh, sb, lh, lb;
    reg MemWrite; 		// Control signal for memory write 
    reg MemRead; 			// Control signal for memory read 
    
    wire [31:0] ReadData; // Contents of memory location at Address
    
    DataMemory a(Address, WriteData, Clk, MemWrite, MemRead, ReadData, sh, sb, lh, lb,mem0);
    
    initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end
    
    initial begin
    
    #200
    
    Address = 0;
    WriteData = 4294967295;
    MemWrite = 1;
    MemRead = 0;
    sh = 0;
    sb = 0;
    lh = 0;
    lb = 0;
    
    #200
    
    Address = 0;
    WriteData = 0;
    MemWrite = 0;
    MemRead = 1;
    sh = 0;
    sb = 0;
    lh = 0;
    lb = 1;
    
    #200;
    
    Address = 0;
    WriteData = 0;
    MemWrite = 0;
    MemRead = 1;
    sh = 0;
    sb = 0;
    lh = 1;
    lb = 0;
    
    #200
    
    Address = 2;
    WriteData = 0;
    MemWrite = 0;
    MemRead = 1;
    sh = 0;
    sb = 0;
    lh = 1;
    lb = 0;
    
    #200
    
    Address = 1;
    WriteData = 0;
    MemWrite = 0;
    MemRead = 1;
    sh = 0;
    sb = 0;
    lh = 0;
    lb = 1;
    
    #200
    
    Address = 2;
    WriteData = 0;
    MemWrite = 0;
    MemRead = 1;
    sh = 0;
    sb = 0;
    lh = 0;
    lb = 1;
    
    #200
    
    Address = 3;
    WriteData = 0;
    MemWrite = 0;
    MemRead = 1;
    sh = 0;
    sb = 0;
    lh = 0;
    lb = 1;
    
    

    end

endmodule
