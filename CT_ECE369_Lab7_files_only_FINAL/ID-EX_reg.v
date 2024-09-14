`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Instruction ID to Execution Register
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EX_reg(WB_I, M_I, EX_I, PC4_I, ReadData1_I, ReadData2_I, Offset_I, Rd_I, Rt_I, Clk, WB_O, M_O, EX_O, PC4_O, ReadData1_O, ReadData2_O, Offset_O, Rd_O, Rt_O, EXFlush);
    input [31:0] PC4_I, ReadData1_I, ReadData2_I, Offset_I;
    input [4:0] Rd_I, Rt_I;
    input [1:0] WB_I;
    input [4:0] M_I;
    input [5:0] EX_I;
    input Clk, EXFlush;
    
    output reg [31:0] PC4_O, ReadData1_O, ReadData2_O, Offset_O;
    output reg [4:0] Rd_O, Rt_O;
    output reg [1:0] WB_O;
    output reg [4:0] M_O;
    output reg [5:0] EX_O;
    
    initial begin
        PC4_O <= 0;
        ReadData1_O <= 0;
        ReadData2_O <= 0;
        Offset_O <= 0;
        Rd_O <= 0;
        Rt_O <= 0;
        WB_O <= 0;
        M_O <= 0;
        EX_O <= 0;
    end
    
    always @(posedge Clk) begin
        if (EXFlush) begin
            PC4_O <= 0;
            ReadData1_O <= 0;
            ReadData2_O <= 0;
            Offset_O <= 0;
            Rd_O <= 0;
            Rt_O <= 0;
            WB_O <= 0;
            M_O <= 0;
            EX_O <= 0;
        end
        else begin
            WB_O = WB_I; // Passing control signals
            M_O = M_I;
            EX_O = EX_I;
            
            PC4_O = PC4_I; // Passing the program counter
            
            ReadData1_O = ReadData1_I; // Passing register data
            ReadData2_O = ReadData2_I;
            
            Offset_O = Offset_I; // Passing instructions
            Rd_O = Rd_I;
            Rt_O = Rt_I;
        end
    end

endmodule