`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
/// Company: 
// Engineer: 
// 
//Students: Rashed Altammar, Braden Curtis
//Percentage effort: 50% for both.

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

//********Fix sign extension********//


module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, sh, sb, lh, lb,mem0); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk, sh, sb, lh, lb;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    reg [31:0] memory[0:16383];
    output  reg [31:0] ReadData; // Contents of memory location at Address
    output [31:0] mem0;
    assign mem0 = memory[0];
    
//    integer i;
//    initial begin
//    for(i = 0; i < 255; i = i + 1)
//    begin
//    memory[i] = 0;
//    end
//    
    initial begin
    $readmemh("data_memory.mem", memory);
    end    

            
    always @(posedge Clk)
    begin
    if ( MemWrite == 1)
    begin
        if (sh == 1 && (Address[1:0] == 0 || Address[1:0] == 1))
        memory[Address[9:2]][15:0] =  WriteData[15:0];
                                            
       else if ( sh == 1 && (Address[1:0] == 2 || Address[1:0] == 3))
        memory[Address[9:2]][31:16] =  WriteData[15:0];
        
       else if ( sb == 1 && Address[1:0] == 0)
        memory[Address[9:2]][7:0] =  WriteData[7:0];
        
        else if ( sb == 1 && Address[1:0] == 1)
        memory[Address[9:2]][15:8] =  WriteData[7:0];
        
        else if ( sb == 1 && Address[1:0] == 2)
        memory[Address[9:2]][23:16] =  WriteData[7:0];
        
        else if ( sb == 1 && Address[1:0] == 3)
        memory[Address[9:2]][31:24] =  WriteData[7:0];
        
        else
        memory[Address[9:2]] = WriteData;
       
    end
    end
    
    
    always@*
    begin
    if (MemRead == 1)
    begin
    if (lh == 1 && (Address[1:0] == 0 || Address[1:0] == 1))
              begin
              
              if (memory[Address[20:2]][15:15] == 1)
             ReadData =  memory[Address[20:2]][15:0] + 32'b11111111111111110000000000000000;
             else
             ReadData =  memory[Address[20:2]][15:0];
             
             end
                                            
       else if ( lh == 1 && (Address[1:0] == 2 || Address[1:0] == 3))
             begin
        
             if (memory[Address[20:2]][31:31] == 1)
             ReadData = memory[Address[20:2]][31:16] + 32'b11111111111111110000000000000000;
             else
             ReadData = memory[Address[20:2]][31:16];
             
             end
        
       else if ( lb == 1 && Address[1:0] == 0)
       
                begin
                
                if (memory[Address[20:2]][7:7] == 1)
                ReadData = memory[Address[20:2]][7:0] + 32'b11111111111111111111111100000000;
                else if (memory[Address[20:2]][7:7] == 0)
                ReadData = memory[Address[20:2]][7:0];
                
                end
        
        else if ( lb == 1 && Address[1:0] == 1)
             begin
                if (memory[Address[20:2]][16:16] == 1)
                ReadData = memory[Address[20:2]][15:8] + 32'b11111111111111111111111100000000;
                else
                ReadData = memory[Address[20:2]][15:8];
                end
        
        else if ( lb == 1 && Address[1:0] == 2)
        
            begin
                 if (memory[Address[20:2]][23:23] == 1)
                ReadData = memory[Address[20:2]][23:16] + 32'b11111111111111111111111100000000;
                else
                ReadData = memory[Address[20:2]][23:16];
                end
        
        else if (lb == 1 && Address[1:0] == 3)
        
        begin
        ReadData = memory[Address[20:2]][31:24];
          if (memory[Address[20:2]][31:31] == 1)
                ReadData = memory[Address[20:2]][31:24] + 32'b11111111111111111111111100000000;
                else
                ReadData = memory[Address[20:2]][31:24];
                end
        
        else
        ReadData = memory[Address[20:2]];
    end
    
    if (MemRead == 0)
    ReadData = 0;
    end
endmodule
