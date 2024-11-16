`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//  Branch Module
// 
//////////////////////////////////////////////////////////////////////////////////


module BranchModule(Branch, Zero, Out);
input Branch, Zero;
output reg Out;

initial begin
    Out <= 0;
end

always @(Branch, Zero) begin
    if ((Branch == 1) && (Zero == 1)) begin
        Out <= 1;
    end
    else begin
        Out <= 0;
    end
end

endmodule
