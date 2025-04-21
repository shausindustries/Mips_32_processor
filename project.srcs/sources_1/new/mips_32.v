`timescale 1ns / 1ps
module mips_32(of,clk);
input clk;
wire we3,we,sel1,sel2,sel3,j,branch,ofs,we3m,wem,sel1m,sel2m,sel3m,branchm;
wire [2:0]op,opm;
wire [31:0]pc,instr,rdreg1,rdreg2,sim,alres1,alres2,alres3,d_out,m1r,m2r,m3r,m4r,m5r,pro1,pro2,b301,b302;
wire [4:0]mr;
wire zf,selm,t1;
wire [1:0]fwd1,fwd2;
reg [31:0]ar1; reg [31:0]ar2; reg [31:0]br1; reg [31:0]br2; reg [31:0]br3; reg [31:0]br4; reg [31:0]cr1; reg [31:0]cr2;reg [31:0]cr3; reg [31:0]dr1; reg [31:0]dr2;

reg [4:0]cr4; reg [4:0]dr3; reg [4:0]br12; reg [4:0]br13; reg [4:0]br14;
reg [1:0]br5;
reg br6,br7,br8,br9,br10,br11,cr5,cr6,cr7,cr8,dr4,dr5;
output of;

assign pro2 = instr[25:0] << 2;

prog_counter pc1 (.pco(pc),.clk(clk),.pci(m4r));

alu_behaviour a2 (.a(pc),.b(8'h00000004),.op(3'b000),.o(alres2));

l_shift l1 (.in(br3),.out(pro1));

alu_behaviour a3 (.a(pro1),.b(br4),.op(3'b000),.o(alres3));

mux_32 m3 (.a(cr3),.b(alres2),.sel(selm),.o(m3r));

mux_32 m4 (.a(m3r),.b({alres2[31:28],pro2}),.sel(j),.o(m4r));

ins_mem im1 (.a(pc),.rd(instr));

p_mux p1 (.a(br12),.b(br13),.sel(br7),.o(mr));

reg_file rf1 (.a1(ar1[25:21]),.a2(ar1[20:16]),.a3(dr3),.rd1(rdreg1),.rd2(rdreg2),.wd3(m2r),.clk(~(clk)),.we3(dr4));

sign_extend se1 (.in(ar1[15:0]),.out(sim));

mux_32 m1 (.a(br2),.b(br3),.sel(br6),.o(m1r));

bit32x4 b1 (.a(m1r),.b(m2r),.c(cr1),.sel(fwd1),.o(b301));
bit32x4 b2 (.a(br1),.b(m2r),.c(cr1),.sel(fwd2),.o(b302));

alu_behaviour a1 (.a(b301),.b(b302),.op(br5),.o(alres1),.zf(zf),.of(t1));

assign  of = ofs & t1;

assign selm = ((~zf & cr8)|(zf & cr8));

data_mem dm1 (.clk(clk),.a(cr1),.wd(m5r),.rd(d_out),.we(cr7));

mux_32 m2 (.a(dr1),.b(dr2),.sel(dr5),.o(m2r));

control_unit c1 (.opcode(instr[31:26]),.funct(instr[5:0]),.we(we),.we3(we3),.sel1(sel1),.sel2(sel2),.sel3(sel3),.j(j),.alc(op),.bc(branch),.ofs(ofs));
omux o1(.a(we),.b(1'b0),.o(wem));
omux o2(.a(we3),.b(1'b0),.o(we3m));
omux o3(.a(sel1),.b(1'b0),.o(sel1m));
omux o4(.a(sel2),.b(1'b0),.o(sel2m));
omux o5(.a(sel3),.b(1'b0),.o(sel3m));
omux o6(.a(branch),.b(1'b0),.o(branchm));
tmux tm1(.a(op),.b(3'b000),.o(opm));
mux_32 m5 (.a(cr2),.b(m2r),.sel(),.o(m5r));

fwd_unit f1 (.br14(br14),.br12(br12),.fwd1(fwd1),.fwd2(fwd2),.cr5(cr5),.dr4(dr4),.dr3(dr3),.cr4(cr4));

always@ (posedge clk)
    begin
        ar1 <= instr;
        ar2 <= alres2;
        br1 <= rdreg1;
        br2 <= rdreg2;
        br3 <= sim;
        br4 <= ar2;
        br5 <= opm;
        br6 <= sel1m;
        br7 <= sel3m;
        br8 <= we3m;
        br9 <= sel2m;
        br10 <= wem;
        br11 <= branchm;
        br12 <= ar1[20:16];
        br13 <= ar1[15:11];
        br14 <= ar1[25:21];
        cr1 <= alres1;
        cr2 <= br2;
        cr3 <= alres3;
        cr4 <= mr;
        cr5 <= br8;
        cr6 <= br9;
        cr7 <= br10;
        cr8 <= br11;
        dr1 <= cr1;
        dr2 <= d_out;
        dr3 <= cr4;
        dr4 <= cr5;
        dr5 <= cr6;
    end
endmodule
