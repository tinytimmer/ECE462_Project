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


module BranchComparison(instruction31_26, instruction20_16, RD1Out, RD2Out, BranchTaken);


input [5:0] instruction31_26,instruction20_16;
input [31:0] RD1Out, RD2Out;
output reg BranchTaken;

always @* begin
BranchTaken = 0;

case (instruction31_26)

    1: begin
    if (instruction20_16 == 5'b00000) begin //bltz
        if (RD1Out[31:31] == 1)
        BranchTaken = 1;
        end
    else if (instruction20_16 == 5'b00001) begin //bgez
        if (RD1Out[31:31] == 0)
        BranchTaken = 1;
        end  
   end 
   
   4: begin             //beq
        if ( RD1Out == RD2Out)
        BranchTaken = 1;
        end
        
   5: begin             //bne
        if (RD1Out != RD2Out)
        BranchTaken = 1;   
        end
        
   6: begin                             //blez
        if ((RD1Out[31:31] == 1) || RD1Out == 0)
        BranchTaken = 1;
        end
        
        
    7: begin                            //bgtz
        if ((RD1Out[31:31] == 0) && (RD1Out > 0))
        BranchTaken = 1;
        end
    
endcase

end

endmodule
