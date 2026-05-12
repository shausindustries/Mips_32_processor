module bu(in1,in2,flag,cdb,imm,tag);
input [31:0]in1,in2,imm;
input [3:0]tag;
output reg [35:0]cdb;
output reg flag;

wire out;
assign out = in1 - in2;
always @(*) begin
    if (out == 32'b0) begin
        flag <= 1'b1;
    end
    else begin
        flag <= 0;
    end
end
endmodule