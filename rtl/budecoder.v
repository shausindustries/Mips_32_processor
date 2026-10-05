module budecoder (op,branch);
input [5:0]op;
output reg branch;

always@ (op) begin
    if (op == 6'b000100 || op == 6'b000101) begin
        branch <= 1'b1;
    end
    else begin
        branch <= 1'b0;
    end
end
endmodule