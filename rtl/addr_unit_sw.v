module addr_unit_sw (a,b,tg,tgo,qk,vk,qko,vko,addr_out);
input [31:0]a,b,vk;
input [3:0]tg,qk;
output [3:0]tgo,qko;
output [31:0]addr_out,vko;

assign qko = qk;
assign vko = vk;
assign tgo = tg;
assign addr_out = a + b;

endmodule