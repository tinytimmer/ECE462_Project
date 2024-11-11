`timescale 1ns/1ps

module TwoBitBranchPredictor_tb;


    reg [31:0] instruction;
    reg [31:0] pc;
    reg actual_outcome;
    
    wire prediction;

    TwoBitBranchPredictor uut (
        .instruction(instruction),
        .pc(pc),
        .actual_outcome(actual_outcome),
        .prediction(prediction)
    );

    integer i;
    reg [1:0] expected_state;
    reg [3:0] test_index;

    initial begin

        instruction = 32'b00010000000000000000000000000000; 
        pc = 0;

        $display("Time\tPC\tPrediction\tActual Outcome\tBHT State");
        $display("--------------------------------------------------------");
        
        for (i = 0; i < 16; i = i + 1) begin
            pc = i; 

            actual_outcome = 1; #10;
            $display("%0dns\t%0d\t%0d\t\t%0d\t\t%0b", $time, pc, prediction, actual_outcome, uut.BHT[pc[3:0]]);
            
            actual_outcome = 0; #10; 
            $display("%0dns\t%0d\t%0d\t\t%0d\t\t%0b", $time, pc, prediction, actual_outcome, uut.BHT[pc[3:0]]);
            
            actual_outcome = 1; #10; 
            $display("%0dns\t%0d\t%0d\t\t%0d\t\t%0b", $time, pc, prediction, actual_outcome, uut.BHT[pc[3:0]]);
            
            actual_outcome = 1; #10; 
            $display("%0dns\t%0d\t%0d\t\t%0d\t\t%0b", $time, pc, prediction, actual_outcome, uut.BHT[pc[3:0]]);
            
            #10;
        end

        $finish;
    end
endmodule
