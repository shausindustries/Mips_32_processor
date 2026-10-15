module pc_adder (in,op);
input [31:0]in;
output [31:0]op;
assign op = in + 8'h00000004;
endmodule