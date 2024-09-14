`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input signed [31:0] A;	    // inputs
    input signed [31:0] B;

	output reg signed [31:0] ALUResult;	// answer, should this be a reg?
	output reg Zero;	    // Zero=1 if ALUResult == 0, should this be a reg too?

	//would it be beneficial to make a chart that lists out the different opcodes for these instructions?
	//     this may take more time than we got though so probably not
	//Need to find a way to adjust the ALUControl bit size since we cant stick to 4bits for this many instructions

    /* Please fill in the implementation here... */
//	integer temp, i, x;
//	reg [31:0] y;
//	reg sign;
	
	always @(ALUControl, A, B)
	begin
		case(ALUControl) //used to decide which instruction is being used and its operations
			//ARITHMETIC TYPE, some LOGIC and BRANCH TYPES may use the same operations
			0: ALUResult <= 0;
			1: ALUResult <= A + B; //ADD, i think ADDI, LW, and SW can use this operation
									// LW: base address + offset amount
									// SW: base address + offset amount
									// ADDI: [rt] + immediate (I think it cand be treated similarly to offset amount is
			2: ALUResult <= A - B; //SUB
			3: ALUResult <= A * B; //MUL
			//LOGICAL TYPE
			4: ALUResult <= A & B; //AND, ANDI can use this too (I think)
									//ANDI: [rs] & immediate
			5: ALUResult <= A | B; //OR, OR can use this too (I think)
									// ORI, [rs] | immediate
			6: ALUResult <= ~(A | B); //NOR
			7: ALUResult <= A ^ B; //XOR, XORI can use this too (i think)
									//XORI: [rs]^(immediate)
			8: ALUResult <= B<<2; //SLL
			9: ALUResult <= B>>2; //SRL
			10: begin //SLT, SLTI can use this too (I think)
						//SLTI 
					if(A[31] != B[31]) begin
						if(A[31] > B[31]) begin
							ALUResult <= 1;
						end 
						else begin
							ALUResult <= 0;
						end
					end
					else begin
						if (A < B) begin
							ALUResult <= 1;
						end
						else begin
							ALUResult <= 0;
						end
					end
				end
			11: begin // bgez
			        if (A >= 0) begin
						ALUResult <= 0;
					end
					else begin
						ALUResult <= 1;
					end
			end
			12: begin // bgtz
			    if (A > 0) begin
					ALUResult <= 0;
				end
				else begin
					ALUResult <= 1;
				end
			end
			13: begin // blez
			    if (A <= 0) begin
					ALUResult <= 0;
				end
				else begin
					ALUResult <= 1;
				end
			end
			14: begin // bltz
			    if (A < 0) begin
					ALUResult <= 0;
				end
				else begin
					ALUResult <= 1;
				end
			end
			15: begin // bne
			    if (A != B) begin
					ALUResult <= 0;
				end
				else begin
					ALUResult <= 1;
				end
			end
			default: ALUResult <= 0; //default to 0, though this shouldnt happen better safe than sorry I suppose
		endcase
    end
    
    always @(ALUResult) begin
        if (ALUResult == 0) begin //When the Zero flag is triggered
			Zero <= 1;
		end 
		else begin
			Zero <= 0;
		end
    end

endmodule