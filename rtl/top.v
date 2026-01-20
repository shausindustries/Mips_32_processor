`timescale 1ns / 1ps

module top(of,clk);
input clk;
output of;

wire we3,we,sel1,sel2,sel3,j,branch,ofs,br6,br7,br8,br9,
br10,br11,cr5,cr6,cr7,cr8,dr4,dr5,memrd;
wire [2:0]op,br5;
wire [31:0]pc,instr,rdreg1,rdreg2,sim,alres1,alres2,alres3,d_out,m1r,m2r,m3r,
m4r,m5r,pro1,pro2,ar1,ar2,br1,br2,br3,br4,cr1,cr2,cr3,dr1,dr2;
wire [4:0]mr,br12,br13,br14,cr4,dr3,opra,oprb;
wire zf,selm,t1,stall,nop;
wire [1:0]sel1mf,sel2mf;

assign pro2 = instr[25:0] << 2;
assign  of = ofs & t1;
assign selm = ((~zf & cr8)|(zf & cr8));

//Architecture
prog_counter pc1 (.pco(pc),.clk(clk),.pci(m3r),.stl(stall));
alu_behaviour a2 (.a(pc),.b(8'h00000004),.op(3'b000),.o(alres2));
l_shift l1 (.in(br3),.out(pro1));
alu_behaviour a3 (.a(pro1),.b(br4),.op(3'b000),.o(alres3));
mux_32 m3 (.a(cr3),.b(alres2),.sel(selm),.o(m3r));

/*
for jump
mux_32 m4 (.a(m3r),.b({alres2[31:28],pro2}),.sel(j),.o(m4r));
*/

ins_mem im1 (.a(pc),.rd(instr));
p_mux p1 (.a(br12),.b(br13),.sel(br7),.o(mr));
reg_file rf1 (.a1(ar1[25:21]),.a2(ar1[20:16]),.a3(dr3),.rd1(rdreg1),
.rd2(rdreg2),.wd3(m2r),.clk(~(clk)),.we3(dr4));
sign_extend se1 (.in(ar1[15:0]),.out(sim));
mux_32 m1 (.a(br2),.b(br3),.sel(br6),.o(m1r));
alu_behaviour a1 (.a(opra),.b(oprb),.op(br5),.o(alres1),.zf(zf),.of(t1));
data_mem dm1 (.clk(clk),.a(cr1),.wd(m2r),.rd(d_out),.we(cr7));
mux_32 m2 (.a(dr1),.b(dr2),.sel(dr5),.o(m2r));

//Control Logic
control_unit c1 (.opcode(ar1[31:26]),.funct(ar1[5:0]),.we(we),.we3(we3),
.sel1(sel1),.sel2(sel2),.sel3(sel3),.j(j),.alc(op),.bc(branch),.ofs(ofs),.mrd(memrd));

//Pipeline Registers
if_id i1 (.ar1(instr),.ar2(alres2),.clk(clk),.ao1(ar1),.ao2(ar2),.nop(nop),.stall(stall));

id_ex i2 (.br1(rdreg1),.br2(rdreg2),.br3(sim),.br4(ar2),.br5(op),.br6(sel1),.br7(sel3),
.br8(we3),.br9(sel2),.br10(we),.br11(branch),.br12(ar1[20:16]),.br13(ar1[15:11]),
.br14(ar1[25:21]),.nop(nop),.clk(clk),.bo1(br1),.bo2(br2),.bo3(br3),.bo4(br4),.bo5(br5),
.bo6(br6),.bo7(br7),.bo8(br8),.bo9(br9),.bo10(br10),.bo11(br11),.bo12(br12),.bo13(br13));

ex_mem i3 (.cr1(alres1),.cr2(br2),.cr3(alres3),.cr4(mr),.cr5(br8),.cr6(br9),.cr7(br10),
.cr8(br11),.clk(clk),.co1(cr1),.co2(cr2),.co3(cr3),.co4(cr4),.co5(cr5),.co6(cr6),.co7(cr7),
.co8(cr8));

mem_wb i4 (.dr1(cr1),.dr2(d_out),.dr3(mr),.dr4(cr5),.dr5(cr6),.clk(clk),.do1(dr1),.do2(dr2),
.do3(dr3),.do4(dr4),.do5(dr5));

//Stall Logic
stall_unit s1 (.rtn(br12),.rs(ar1[25:21]),.rt(ar1[20:16]),.nop(nop),.stall(stall),
.clk(clk),.memr(memrd));

//Fwd logic
fwd_unit f1 (.rd1(cr4),.rd2(dr3),.regw(dr4),.clk(clk),.rs(br14),.rt(br12),.sel1mf(sel1mf),
.sel2mf(sel2mf));
operandmux o1 (.a(br1),.b(m2r),.c(cr1),.sel(sel1mf),.o(opra));
operandmux o2 (.a(br2),.b(cr1),.c(m2r),.sel(sel2mf),.o(oprb));

endmodule
