module subh(opa,opb,out);
input [31:0]opa,opb;
output [31:0]out;

wire [7:0] v11,v12,v13,v14,v21,v22,v23,v24,o1,o2,o3,o4;

assign v11 = opa[7:0];
assign v12 = opa[15:8];
assign v13 = opa[23:16];
assign v14 = opa[31:24];
assign v21 = opb[7:0];
assign v22 = opb[15:8];
assign v23 = opb[23:16];
assign v24 = opb[31:24];

assign o1 = v11 - v21;
assign o2 = v12 - v22;
assign o3 = v13 - v23;
assign o4 = v14 - v24;

assign out = {o4,o3,o2,o1};
endmodule