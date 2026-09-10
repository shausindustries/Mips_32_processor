module jdecoder (op,j,addr,jtg,label);
input [5:0]op;
input [25:0]label;
input [3:0]addr;
output reg j;
output reg jtg;

always@ (op) begin
if (op == 6'b000010) begin
    j <= 1'b1;
    jtg = {addr,label<<2};
end
else begin
    j <= 1'b0;
end
end
endmodule