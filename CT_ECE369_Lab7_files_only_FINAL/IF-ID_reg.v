`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Instruction Fetch to ID Register
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_ID_reg(PC4_I, Instruction_I, Clk, PC4_O, Instruction_O, IDFlush, Stall, JSrc, JRSrc);

    input [31:0] PC4_I, Instruction_I;
    input Clk, IDFlush, Stall, JSrc, JRSrc;
    
    output reg [31:0] PC4_O, Instruction_O;
    
    initial begin
        PC4_O <= 0;
        Instruction_O <= 0;
    end
    
    always @(posedge Clk) begin
        if(IDFlush || JSrc || JRSrc) begin
            PC4_O <= 0;
            Instruction_O <= 0;
        end
        else if (~Stall) begin
            PC4_O = PC4_I; // Passing program counter
            Instruction_O = Instruction_I; // Passing instructions
        end
    end

endmodule