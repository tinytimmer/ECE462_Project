`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2022 04:27:07 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(Address, Instruction);

    input [31:0] Address; //input address
    output reg [31:0] Instruction; // the instruction at memory location Address
    reg [31:0] mem[0:1024];
    
    initial begin
        $readmemh("C:\\Users\\carme\\OneDrive\\Documents\\School\\ECE369\\ECE369_Labs\\ECE369-Lab7-Final\\instruction_memory.mem",mem); //need to change the name and whats contained in the file, chnage to .mem
    end
     
    always @(Address)
    begin
        Instruction = mem[Address>>2];   
    end

endmodule