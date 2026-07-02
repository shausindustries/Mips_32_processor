module bu(in1,in2,flag,cdb,imm,tag, pc_addr);
input [31:0]in1,in2,imm,pc_addr;
input [3:0]tag;
output [35:0]cdb;
output reg flag;

wire out,eximm,addr;

assign out = in1 - in2;
assign addr = pc_addr + (imm << 2);
assign cdb = {tag, addr};

always @(*) begin
    if (out == 8'h00000000) begin
        flag <= 1'b1;
    end
    else begin
        flag <= 1'b0;
    end
end
endmodule