module TwoBitBranchPredictor(
    input [31:0] instruction,       
    input [31:0] pc,                
    input actual_outcome,           
    output reg prediction           
);
    integer i;
    reg [1:0] BHT [15:0];
    initial begin
        
        for (i = 0; i < 16; i = i + 1) begin
            BHT[i] = 2'b10; 
        end
    end

    wire [3:0] index;
    assign index = pc[3:0];

    wire [5:0] opcode;
    assign opcode = instruction[31:26];

    always @(*) begin
        case (BHT[index])
            2'b11, 2'b10: prediction = 1;
            2'b01, 2'b00: prediction = 0; 
            default: prediction = 0;
        endcase
    end

    always @(posedge actual_outcome or negedge actual_outcome) begin
        case (BHT[index])
            2'b11: BHT[index] <= (actual_outcome) ? 2'b11 : 2'b10; 
            2'b10: BHT[index] <= (actual_outcome) ? 2'b11 : 2'b01; 
            2'b01: BHT[index] <= (actual_outcome) ? 2'b10 : 2'b00; 
            2'b00: BHT[index] <= (actual_outcome) ? 2'b01 : 2'b00;
        endcase
    end
endmodule