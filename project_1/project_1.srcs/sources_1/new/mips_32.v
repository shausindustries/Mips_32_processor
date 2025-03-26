`timescale 1ns / 1ps
module mips_32(clk,we3,we,op,sel1,sel2,sel3,j,branch);
input clk,we3,we,sel1,sel2,sel3,j,branch;
input [2:0]op;
wire [31:0]pc,instr,rdreg1,rdreg2,sim,alres1,alres2,alres3,d_out,m1r,m2r,m3r,m4r,m5r,pro1,pro2;
wire [4:0]mr;
wire zf,selm;

assign pro2 = instr[25:0] << 2;

prog_counter pc1 (.pco(pc),.clk(clk),.pci(m4r));

alu_behaviour a2 (.a(pc),.b(8'h00000004),.op(3'b000),.o(alres2));

l_shift l1 (.in(sim),.out(pro1));

alu_behaviour a3 (.a(pro1),.b(alres2),.op(3'b000),.o(alres3));

mux_32 m3 (.a(alres3),.b(alres2),.sel(selm),.o(m3r));

mux_32 m4 (.a(m3r),.b({alres2[31:28],pro2}),.sel(j),.o(m4r));

ins_mem im1 (.a(pc),.rd(instr));

p_mux p1 (.a(instr[20:16]),.b(instr[15:11]),.sel(sel3),.o(mr));

reg_file rf1 (.a1(instr[25:21]),.a2(instr[20:16]),.a3(mr),.rd1(rdreg1),.rd2(rdreg2),.wd3(m2r),.clk(clk),.we3(we3));

sign_extend se1 (.in(instr[15:0]),.out(sim));

mux_32 m1 (.a(rdreg2),.b(sim),.sel(sel1),.o(m1r));

alu_behaviour a1 (.a(rdreg1),.b(m1r),.op(op),.o(alres1),.zf(zf));

assign selm = zf & branch;

data_mem dm1 (.clk(clk),.a(alres1),.wd(rdreg2),.rd(d_out),.we(we));

mux_32 m2 (.a(alres1),.b(d_out),.sel(sel2),.o(m2r));

endmodule
