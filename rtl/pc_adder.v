module pc_adder (in1,op);
input [31:0]in1;
output [31:0]op;
assign op = in1 + 8'h00000004;
endmodule