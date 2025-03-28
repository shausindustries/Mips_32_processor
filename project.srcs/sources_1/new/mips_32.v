`timescale 1ns / 1ps
module mips_32(of,clk);
input clk;
wire we3,we,sel1,sel2,sel3,j,branch,ofs;
wire [2:0]op;
wire [31:0]pc,instr,rdreg1,rdreg2,sim,alres1,alres2,alres3,d_out,m1r,m2r,m3r,m4r,m5r,pro1,pro2;
wire [4:0]mr;
wire zf,selm,t1;
reg [31:0]ar1; reg [31:0]ar2; reg [31:0]br1; reg [31:0]br2; reg [31:0]br3; reg [31:0]br4; reg [31:0]cr1; reg [31:0]cr2;reg [31:0]cr3; reg [31:0]dr1; reg [31:0]dr2;
output of;

assign pro2 = instr[25:0] << 2;

prog_counter pc1 (.pco(pc),.clk(clk),.pci(m4r));

alu_behaviour a2 (.a(pc),.b(8'h00000004),.op(3'b000),.o(alres2));

l_shift l1 (.in(br3),.out(pro1));

alu_behaviour a3 (.a(pro1),.b(br4),.op(3'b000),.o(alres3));

mux_32 m3 (.a(cr3),.b(alres2),.sel(selm),.o(m3r));

mux_32 m4 (.a(m3r),.b({alres2[31:28],pro2}),.sel(j),.o(m4r));

ins_mem im1 (.a(pc),.rd(instr));

p_mux p1 (.a(ar1[20:16]),.b(ar1[15:11]),.sel(sel3),.o(mr));

reg_file rf1 (.a1(ar1[25:21]),.a2(ar1[20:16]),.a3(mr),.rd1(rdreg1),.rd2(rdreg2),.wd3(m2r),.clk(~(clk)),.we3(we3));

sign_extend se1 (.in(ar1[15:0]),.out(sim));

mux_32 m1 (.a(br2),.b(br3),.sel(sel1),.o(m1r));

alu_behaviour a1 (.a(br1),.b(m1r),.op(op),.o(alres1),.zf(zf),.of(t1));

assign  of = ofs & t1;

assign selm = ((~zf & branch)|(zf & branch));

data_mem dm1 (.clk(clk),.a(cr1),.wd(cr2),.rd(d_out),.we(we));

mux_32 m2 (.a(alres1),.b(d_out),.sel(sel2),.o(m2r));

control_unit c1 (.opcode(instr[31:26]),.funct(instr[5:0]),.we(we),.we3(we3),.sel1(sel1),.sel2(sel2),.sel3(sel3),.j(j),.alc(op),.bc(branch),.ofs(ofs));

always@ (posedge clk)
    begin
        ar1 <= instr;
        ar2 <= alres2;
        br1 <= rdreg1;
        br2 <= rdreg2;
        br3 <= sim;
        br4 <= ar2;
        cr1 <= alres1;
        cr2 <= br2;
        cr3 <= alres3;
        dr1 <= cr1;
        dr2 <= d_out;
    end
endmodule
