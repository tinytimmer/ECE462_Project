`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Datapath Controller
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(Instruction, EX, M, WB, Jsig, Stall);
    input [31:0] Instruction;
    input Stall;
    
    output reg [5:0] EX; // [0] = ALUSrc, [1] = RegDist, [5:2] = ALUOp
    output reg [4:0] M; // [0] = MemRead, [1] = MemWrite, [2] = Branch, [4:3] = BHW (0 = Byte, 1 = Half, 2 = Word)
    output reg [1:0] WB; // [0] = MemtoReg, [1] = RegWrite
    output reg [2:0] Jsig; // [0] = Jmux, [1] = RJmux, [2] = JALreg
    
    initial begin
        EX <= 0;
        M <= 0;
        WB <= 0;
        Jsig <=0;
    end
    
    always @(Instruction, Stall) begin
        
        //EX <= 0;
        //M <= 0;
        //WB <= 0;
        //Jsig <=0;
        
        if((Instruction == 0) || (Stall == 1)) begin // Nop
            EX <= 0;
            M <= 0;
            WB <= 0;
            Jsig <=0;
        end
        else if (Instruction[31:28] == 8) begin // Load Instructions
            EX[0] <= 1; // ALUSrc = 1
            EX[1] <= 0; // RegDist = 0
            EX [5:2] <= 1; // ALUOp = add
            M [0] <= 1; // MemRead = 1
            M [2:1] <= 0; // MemWrite and Branch = 0
            WB [0] <= 0; // MemtoReg = 0
            WB [1] <= 1; // RegWrite = 1
            Jsig <= 0; // Jump Signals = 0
            
            case (Instruction[27:26])
                0: M [4:3] = 0; // lb
                1: M [4:3] = 1; // lh
                3: M [4:3] = 2; // lw
                default: M [4:3] = 2;
            endcase
        end
        
        else if (Instruction[31:28] == 10) begin // Store Instructions
            EX[0] <= 1; // ALUSrc = 1
            EX [5:2] <= 1; // ALUOp = add
            M [0] <= 0; // MemRead = 0
            M [1] <= 1; // MemWrite = 1
            M [2] <= 0; // Branch = 0
            WB [1] <= 0; // RegWrite = 0
            Jsig <= 0; // Jump Signals = 0
            case (Instruction[27:26])
                0: M [4:3] = 0; // sb
                1: M [4:3] = 1; // sh
                3: M [4:3] = 2; // sw
                default: M [4:3] = 2;
            endcase
        end
        
        else begin // All Other Instructions
            case (Instruction[31:26])
                0: begin // R-Type Instructions
                    EX[0] <= 0; // ALUSrc = 0
                    EX[1] <= 1; // RegDist = 1
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                    case (Instruction[5:0])
                        0: EX [5:2] <= 8; // sll
                        2: EX [5:2] <= 9; // srl
                        8: begin  // jr
                            EX [5:2] <= 0; // ALUOp = Zero
                            WB [1] <= 0; // RegWrite = 0
                            Jsig [1] <= 1; // RJmux = 1
                        end
                        32: EX [5:2] <= 1; // add
                        34: EX [5:2] <= 2; // sub
                        36: EX [5:2] <= 4; // and
                        37: EX [5:2] <= 5; // or
                        38: EX [5:2] <= 7; // xor
                        39: EX [5:2] <= 6; // nor
                        42: EX [5:2] <= 10; // stl
                        default: EX [5:2] <= 0;
                    endcase
                end
                1 : begin // btlz & bgez 
                    EX[0] <= 0; // ALUSrc = 0
                    M [1:0] <= 0; // MemRead and MemWrite = 0
                    M [2] <= 1; // Branch = 1
                    WB [1] <= 0; // RegWrite = 0
                    Jsig <= 0; // Jump Signals = 0       
                    case (Instruction[20:16])
                        
                        0: begin // bltz
                            EX [5:2] <= 14; // ALUOp = bltz
                        end
                        1: begin // bgez
                            EX [5:2] <= 11; // ALUOp = bgez
                        end
                        default: begin
                            
                        end
                    endcase
                end
                2: begin // j
                    EX [5:2] <= 0; // ALUOp = Zero
                    M [2:0] <= 0; // MemRead, MemWrite = 0, and Branch = 0
                    WB [1] <= 0; // RegWrite = 0
                    Jsig [0] <= 1; // Jmux = 1
                    Jsig [2:1] <= 0; // JRmux = 0, JALreg = 0
                end
                3: begin // jal
                    M [2:0] <= 0; // MemRead, MemWrite = 0, and Branch = 0
                    WB [1] <= 0; // RegWrite = 0
                    Jsig [0] <= 1; // Jmux = 1
                    Jsig [1] <= 0; // JRmux = 0
                    Jsig [2] <= 1; // JALreg = 1
                end
                4: begin // beq
                    EX[0] <= 0; // ALUSrc = 0
                    EX [5:2] <= 2; // ALUOp = subtract
                    M [1:0] <= 0; // MemRead and MemWrite = 0
                    M [2] <= 1; // Branch = 1
                    WB [1] <= 0; // RegWrite = 0
                    Jsig <= 0; // Jump Signals = 0
                end
                5 : begin // bne
                    EX[0] <= 0; // ALUSrc = 0
                    EX [5:2] <= 15; // ALUOp = bne
                    M [1:0] <= 0; // MemRead and MemWrite = 0
                    M [2] <= 1; // Branch = 1
                    WB [1] <= 0; // RegWrite = 0
                    Jsig <= 0; // Jump Signals = 0 
                end
                6 : begin // blez
                    EX[0] <= 0; // ALUSrc = 0
                    EX [5:2] <= 13; // ALUOp = blez
                    M [1:0] <= 0; // MemRead and MemWrite = 0
                    M [2] <= 1; // Branch = 1
                    WB [1] <= 0; // RegWrite = 0
                    Jsig <= 0; // Jump Signals = 0
                end
                7 : begin // bgtz
                    EX[0] <= 0; // ALUSrc = 0
                    EX [5:2] <= 12; // ALUOp = bgtz
                    M [1:0] <= 0; // MemRead and MemWrite = 0
                    M [2] <= 1; // Branch = 1
                    WB [1] <= 0; // RegWrite = 0
                    Jsig <= 0; // Jump Signals = 0
                end
                8: begin // addi
                    EX[0] <= 1; // ALUSrc = 1
                    EX[1] <= 0; // RegDist = 0
                    EX [5:2] <= 1; // ALUOp = add
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                end
                10: begin // slti
                    EX[0] <= 1; // ALUSrc = 1
                    EX[1] <= 0; // RegDist = 0
                    EX [5:2] <= 10; // ALUOp = slt
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                end
                12: begin // andi
                    EX[0] <= 1; // ALUSrc = 1
                    EX[1] <= 0; // RegDist = 0
                    EX [5:2] <= 4; // ALUOp = and
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                end
                13: begin // ori
                    EX[0] <= 1; // ALUSrc = 1
                    EX[1] <= 0; // RegDist = 0
                    EX [5:2] <= 5; // ALUOp = or
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                end
                14: begin // xori
                    EX[0] <= 1; // ALUSrc = 1
                    EX[1] <= 0; // RegDist = 0
                    EX [5:2] <= 7; // ALUOp = xor
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                end
                28: begin // mul
                    EX[0] <= 0; // ALUSrc = 0
                    EX[1] <= 1; // RegDist = 1
                    EX [5:2] <= 3; // ALUOp = multiply
                    M [2:0] <= 0; // MemRead, MemWrite, and Branch = 0
                    WB [0] <= 1; // MemtoReg = 1
                    WB [1] <= 1; // RegWrite = 1
                    Jsig <= 0; // Jump Signals = 0
                end
                default: begin
                    EX <= 0;
                    M <= 0;
                    WB <= 0;
                    Jsig <=0;
                end
            endcase
        end
    end

endmodule