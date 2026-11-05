module subh(opa,opb,cdb,tg);
input [3:0]tg;
input [31:0]opa,opb;
output [35:0]cdb;

wire [15:0]v11,v12,v21,v22,o1,o2;
wire [31:0]out;

assign v11 = opa[15:0];
assign v12 = opa[31:16];
assign v21 = opb[15:0];
assign v22 = opb[31:16];

assign o1 = v11 - v21;
assign o2 = v12 - v22;

assign out = {o2,o1};
assign cdb = {tg,out};

endmodule