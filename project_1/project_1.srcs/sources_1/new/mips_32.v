`timescale 1ns / 1ps
module mips_32(clk,we3,we);
input clk,we3,we;
wire [31:0]pc,instr,rdmem,sim,alres,d_out;

prog_counter pc1 (.pco(pc),.pci(),.clk());
ins_mem im1 (.a(pc),.rd(instr));
reg_file rf1 (.a1(instr[25:21]),.rd1(rdmem),.a3(instr[20:16]),.wd3(d_out),.clk(clk),.we3(we3));
sign_extend se1 (.in(instr[15:0]),.out(sim));
alu_behaviour a1 (.a(rdmem),.b(sim),.op(3'b000),.o(alres));
data_mem dm1 (.clk(clk),.a(alres),.rd(d_out),.we(we));
endmodule
