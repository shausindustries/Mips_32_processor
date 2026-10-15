module int_add(opa,opb,tag,cdb);
input [31:0] opa, opb;
input [3:0] tag;
output [35:0]cdb;

wire out;

assign out = opa + opb;
assign cdb = {tag, out};

endmodule