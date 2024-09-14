`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux5Bit2To1.v
// Description - Performs signal multiplexing between 2 5-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;
    
    initial begin
        out <= 0;
    end
    
    always @ (inA or inB or sel)
        begin
            if (sel)
                begin
                    out = inB;
                end
            else
                begin
                    out = inA;
                end
                
        end

endmodule
