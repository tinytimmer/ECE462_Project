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

// - Work on figuring which operations to include
// - Assign values to them

//Fix And
module ALU32Bit(ALUControl, A, B, AR, Zero);

	input [4:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs

	output reg [31:0] AR;	// answer (ALUResult)
	output reg Zero;	    // Zero=1 if ALUResult == 0
    parameter And = 0, add = 1, sub = 2, mul = 3;
    parameter Or = 4, Nor = 5, Xor = 6, sll = 7;
    parameter srl = 8, slt = 9, bgez = 10, bgtz = 11, blez = 12, bltz = 13, bne= 14;
    parameter beq = 15, j = 16;
    /* Please fill in the implementation here... */
    always@*
    begin
    Zero = 0;
    case(ALUControl)
    0: AR = (A&B);
    add: AR = A + B;
    sub: begin
        AR <= A - B;
        if (A == B)
        Zero <= 1;
        end
    mul: AR = A*B;
    Or: AR = (A | B);
    Nor: AR = ~(A | B);
    Xor: AR = A ^ B;
    sll: AR = A << B;
    srl: AR = A >> B;
    slt: begin
        if (A < B)
        Zero = 1;
        AR = A < B;
        end
    bgez: begin
        if (A[31:31] == 0)
        Zero = 1;
        end
    bgtz: begin
        if ((A[31:31] == 0) && (A > 0))
        Zero = 1;
        end
    blez: begin
        if ((A[31:31] == 1) || A == 0)
        Zero = 1;
        end
    bltz: begin
        if (A[31:31] == 1)
        Zero = 1;
        end
    bne: begin
        if (A != B)
        Zero = 1;   
        end 
    beq: begin
        if ( A == B)
        Zero = 1;
        end
    j: Zero = 1;
    
    
    
    endcase
    
    end
    
endmodule

