`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2023 12:05:56 AM
// Design Name: 
// Module Name: ALU32Bittb
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


module ALU32Bittb();

reg [4:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
reg [31:0] A, B;	    // inputs

wire [31:0] AR;	// answer (ALUResult)
wire Zero;	


ALU32Bit a(ALUControl, A, B, AR, Zero);

initial begin

#100

ALUControl = 0;
A = 15;
B = 15;

#100

ALUControl = 0;
A = 65;
B = 33;

#100

ALUControl = 1;
A = 64;
B = 32;

#100

ALUControl = 2;
A = 64;
B = 32;

#100

ALUControl = 3;
A = 6;
B = 10;

#100

ALUControl = 4;
A = 1;
B = 0;

#100

ALUControl = 5;
A = 1;
B = 0;

#100

ALUControl = 6;
A = 1;
B = 1;

#100

ALUControl = 7;
A = 64;
B = 2;

#100

ALUControl = 8;
A = 64;
B = 1;

#100

ALUControl = 9;
A = 64;
B = 65;

#100

ALUControl = 10;
A = 0;
B = 65;

#100

ALUControl = 11;
A = 0;
B = 32;

#100

ALUControl = 12;
A = 0;
B = 32;

#100

ALUControl = 13;
A = 0;
B = 32;

#100

ALUControl = 14;
A = 64;
B = 65;

#100

ALUControl = 15;
A = 64;
B = 64;

#100

ALUControl = 16;
A = 64;
B = 32;



end


endmodule
