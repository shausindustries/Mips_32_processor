`timescale 1ns / 1ps
module mips_32(clk,we3,we,op,sel);
input clk,we3,we,sel;
input [2:0]op;
wire [31:0]pc,instr,rdreg1,rdreg2,sim,alres,d_out,m1r,m2r,m3r,m4r,m5r;

prog_counter pc1 (.pco(pc),.clk());
ins_mem im1 (.a(pc),.rd(instr));
p_mux p1 (.a(instr[20:16]),.b(instr[15:11]),.sel(sel),.o(m3r));
reg_file rf1 (.a1(instr[25:21]),.a2(instr[20:16]),.a3(m3r),.rd1(rdreg1),.rd2(rdreg2),.wd3(m2r),.clk(clk),.we3(we3));
sign_extend se1 (.in(instr[15:0]),.out(sim));
mux_32 m1 (.a(rdreg2),.b(sim),.sel(sel),.o(m1r));
alu_behaviour a1 (.a(rdreg1),.b(m1r),.op(op),.o(alres));
data_mem dm1 (.clk(clk),.a(alres),.wd(rdreg2),.rd(d_out),.we(we));
mux_32 m2 (.a(alres),.b(d_out),.sel(sel),.o(m2r));
endmodule
