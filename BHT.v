module BHT(bht,clk,index,isitbranch,update,itisbranch, prediction, Address, Target, branch,instruction,targetpc,indexdec,indexout);
input [3:0] index; //[2:0]PC. Carried by pipeline to next stage
input [3:0] indexdec; //Index from decode
input branch, isitbranch,clk; //Real result (branch)
input [31:0] Address; //PC
input [5:0] instruction;
reg [31:0] BHT [7:0];
//reg states [7:0];
reg predictions [7:0];
reg [31:0] Targets [7:0];
//reg [3:0] tempindex;
input [31:0] Target; //Target PC
output reg prediction;
output reg [31:0] targetpc;
output reg [3:0] indexout;
output reg itisbranch; //carried by pipeline
output reg update;
output [31:0] bht;
assign bht = BHT[index];
integer i;
initial
begin
for ( i = 0; i < 8; i = i + 1)
begin
BHT [i ] <= 0;
// states [i] <=0;
 predictions [i] <=0;
Targets [i] <= 0;
 end
 end

always @(posedge clk)
begin
if (instruction == 4 || instruction == 5 || instruction == 6 || instruction == 7)
begin
itisbranch <= 1;
if (BHT[index] != Address)
begin
BHT[index] <= Address;
Targets[index] <= Target;
predictions[index] <= 0;
end
if ( isitbranch == 1)
begin
if (branch != predictions[indexdec])
begin
if (predictions[indexdec] == 1)
predictions[indexdec] <= predictions[indexdec] - 1;
else
predictions[indexdec] <= predictions[indexdec] + 1;
end
end
end
else
itisbranch <= 0;
end

always @*
begin
if (instruction == 4 || instruction == 5 || instruction == 6 || instruction == 7)
begin 

if (BHT[index] == Address)      //Fix: New insturctions shouldn't inherit predictions of previous
begin                                     // instructions with the same index
prediction <= predictions[index];
targetpc <= Targets[index];
indexout <= index;
update <= 0;
end
else
begin
update <= 1;
end
end



end
endmodule