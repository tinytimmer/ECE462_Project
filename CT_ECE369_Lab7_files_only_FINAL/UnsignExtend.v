`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - UnsignExtension.v
// Description - Unsign extension module.
////////////////////////////////////////////////////////////////////////////////
module UnsignExtension(in, out);

    /* A 26-Bit input word */
    input [25:0] in;
    
    /* A 32-Bit output word */
    output [31:0] out;
    
    /* Fill in the implementation here ... */
    assign out [1:0] = 0;
    assign out[27:2] = in[25:0];
	assign out[31:28] = 0;
	
endmodule