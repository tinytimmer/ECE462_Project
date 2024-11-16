`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Memory Sign
// 
//////////////////////////////////////////////////////////////////////////////////


module MemorySign(numIn, BHW, MemSign);
    input [31:0] numIn;
    input [1:0] BHW;
    output reg MemSign;
    
    initial begin
        MemSign <= 0;
    end
    
    always @ (numIn, BHW) begin
        case (BHW)
            0: MemSign <= numIn[7]; // Byte
            1: MemSign <= numIn[15]; // Half
            2: MemSign <= numIn[31]; // Word
            default: MemSign <= numIn[31];
        endcase
    end

endmodule
