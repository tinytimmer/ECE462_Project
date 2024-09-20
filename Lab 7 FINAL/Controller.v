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


module Controller(Hazard,instruction31_26,instruction20_16,instruction5_0, regdst, branch, memread, memtoreg, ac,memwrite,
alusrc,regwrite, cntrljr, cntrljalr, cntrljald,lh,lb,sh, sb, shift, BranchTaken,Flush);
input [5:0] instruction31_26,instruction20_16,instruction5_0;
output reg regdst, branch, memread, memtoreg,memwrite,regwrite, cntrljalr, cntrljald, lh, lb, sh, sb, shift;
output reg [4:0] ac; //ALUcontrol
output reg [1:0] cntrljr,alusrc,Flush;
input Hazard, BranchTaken;


initial
begin
cntrljr=2;
end

always @(instruction31_26)
begin
if (Hazard == 0)
begin
regdst=0; branch=0; memread=0; memtoreg=0; ac=0;memwrite=0;alusrc=0;regwrite=0; cntrljr=2; cntrljalr=0; cntrljald=0;
lh = 0; lb = 0; sh = 0; sb =0; shift = 0; Flush = 0;
case(instruction31_26)

    0: begin
       
       if (instruction5_0 == 6'b100000) //add
       begin
       ac = 1;
       regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b100100) //and
       begin
       ac = 0;
       regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b001000)   //jr      
       begin
       cntrljr = 0;
       regwrite = 0;
       regdst = 1;
       memtoreg = 1;
       Flush = 1;
       end
       else if (instruction5_0 == 6'b100111)    //nor
       begin
       ac = 5;
       regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b100101)  //or
       begin
       ac = 4;regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b000000) begin //sll 
       if (instruction20_16 == 0)
       begin
       end
       else
       begin     
       ac = 7;
       alusrc = 2;
       regdst = 1;
       shift = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       end
       else if (instruction5_0 == 6'b101010)    //slt
       begin
       ac = 9;
       regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b000010) begin    //srl       
       ac = 8;
       alusrc = 2;
       regdst = 1;
       shift = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b100010)    //sub
       begin
       ac = 2;
       regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       else if (instruction5_0 == 6'b100110)    //xor
       begin
       ac = 6;
       regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
       end
       
     1: begin
        if (BranchTaken == 1) begin
        branch = 1;
        Flush = 1;
        end
        end
       
     2: begin 
        ac = 16;                                  //j
        cntrljr = 1;
        Flush = 1;
        end
        
     3: begin                               //jal
        ac = 16;                             
        cntrljalr = 1;
        cntrljald = 1;
        cntrljr = 1;
        regwrite = 1;
        Flush = 1;
        end
        
     4: begin                                  //beq
        if (BranchTaken == 1) begin
        branch = 1;
        Flush = 1;
        end
        end
        
     5:begin                                    //bne
        if (BranchTaken == 1) begin
        branch = 1;
        Flush = 1;
        end
        end
        
     6:begin                                   //blez
        if (BranchTaken == 1) begin
        branch = 1;
        Flush = 1;
        end
        end
     
     7:begin                                  //bgtz
       if (BranchTaken == 1) begin
        branch = 1;
        Flush = 1;
        end
       end
       
     8:begin        //addi
       ac = 1;
       alusrc = 1;
       regwrite = 1;
       memtoreg = 1;
       end

    10:begin         //slti
       ac = 9;
       alusrc = 1;
       regwrite = 1;
       memtoreg = 1;
       end
       
   12:begin         //andi
      ac = 0;
      alusrc = 1;
      regwrite = 1;
      memtoreg = 1;
      end
      
   13:begin         //ori 
      ac = 4;
      alusrc = 1;
      regwrite = 1;
      memtoreg = 1;
      end
      
   14:begin         //xori
      ac = 6;
      alusrc = 1;
      regwrite = 1;
      memtoreg = 1;
      end 
      
      //I AM NOT SURE IF LOAD AND STORE FUNCTIONS SHOULD USE THE "ADD" ac OR SOME OTHER ALUOP
      28: begin             //mul
      ac = 3;
      regdst = 1;
       memtoreg = 1;
       regwrite = 1;
       end
   
   32:begin     //lb
      alusrc = 1;
      memread = 1;
      regwrite = 1;
      ac = 1;
      lb = 1;
      end
   
   33:begin     //lh
      alusrc = 1;
      memread = 1;
      regwrite = 1;
      ac = 1;
      lh = 1;
      end
      
   35:begin     //lw
      alusrc = 1;
      memread = 1;
      regwrite = 1;
      ac = 1;
      end
   
   40:begin     //sb
      alusrc = 1;
      memwrite = 1;
      ac = 1;
      sb = 1;
      end
      
   41:begin     //sh
      alusrc = 1;
      memwrite = 1;
      ac = 1;
      sh = 1;
      end
   
   43:begin     //sw
      alusrc = 1;
      memwrite = 1;
      ac = 1;
      end
      
 
endcase
end

else if (Hazard == 1)
begin
regdst=0; branch=0; memread=0; memtoreg=0; ac=0;memwrite=0;alusrc=0;regwrite=0; cntrljr=2; cntrljalr=0; cntrljald=0;
lh = 0; lb = 0; sh = 0; sb =0; shift = 0; Flush = 0;
end

end
endmodule
