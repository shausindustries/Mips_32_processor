`timescale 1ns / 1ps

module top(of,clk,rst);
input clk,rst;
output of;

wire [35:0]cdb;
wire [36:0]rob_out;
wire [31:0]pc,instr,alres2,iq,mr,rdreg1,rdreg2,rdq1,rdq2,ar1,ar2,ia1,ia2,addr,a_i,be_i,avko,
ar1o,ar2o,br1o,br2o,adr,bdr,bvko,ib1,ib2,btp,bta,buaddr;
wire [3:0]rob_tag,unit_tag,cdb_tag,aq1o,aq2o,bq1o,bq2o;
wire flush_if,br7,we,weq,br,taken,vd,zf,valid;

//Architecture
prog_counter pc1 (.pco(pc),.clk(clk),.pci(m4r),.stl(stall),.rst(rst));
pc_adder a2 (.in1(pc),.op(alres2));
mux_32 m3 (.a(alres2),.b(btp),.sel(taken),.o(m3r));
//mux_32 m4 (.a(m3r),.b(br4),.sel(mispredict),.o(m4r));


ins_mem im1 (.a(pc),.rd(instr));
intruction_queue im2 (.in(ar1),.out(iq),.clk(clk),.ready(),.empty(),.rst(rst));

issue_logic il1(.instr(iq),.clk(clk),.we3(we),.wq(weq),.sel(br7),.add_i(a_i),.br_i(be_i),
.br(br),.addr(addr),.ilt(vd),.fl(zf),.r1(rdreg1),.r2(rdreg2),.q1(rdq1),.q2(rdq2),
.a_r1o(ar1o),.a_r2o(ar2o),.a_q1o(aq1o),.a_q2o(aq2o),.b_r1o(br1o),.b_r2o(br2o),
.b_q1o(bq1o),.b_q2o(bq2o),.a_addr(adr),.b_addr(bdr));
xor x1 (valid,vd,taken);

sign_extend se1 (.in(be_i[0:15]),.out(addr));

p_mux p1 (.a(iq[20:16]),.b(iq[15:11]),.sel(br7),.o(mr));
reg_file rf1 (.a1(iq[25:21]),.a2(iq[20:16]),.a3(rob_out[36:32]),.rd1(rdreg1),
.rd2(rdreg2),.wd3(rob_out[31:0]),.wq3(rob_tag),.clk(clk),.we3(we),.rst(rst),
.q1(rdq1),.q2(rdq2),.wq(weq));
mux_32 m1 (.a(ar2o),.b(adr),.sel(~(br7)),.o(avko));
mux_32 m2 (.a(br2o),.b(bdr),.o(bvko),.sel(~(br7)));
rob r1 (.dr(mr),.val_u(cdb),.clk(clk),.altadr(),.rst(rst),.rn(rob_tag),
.s(),.ready(),.empty(),.out(rob_out),.commit());
data_mem dm1 (.clk(clk),.a(cr1),.wd(m2r),.rd(d_out),.we(cr7));
reservation_station rs1 (.op(a_i[31:26]),.rd1(ar1o),.rd2(avko),.clk(clk),.q1(aq1o),
.q2(aq2o),.cdb(cdb),.opa(ia1),.a(adr),opb(ia2),.rn(rob_tag),.tag(unit_tag));
int_add i1 (.opa(ia1),.opb(ia2),.tag(unit_tag),.cdb(cdb));
reservation_station rs2 (.op(be_i[31:26]),.clk(clk),.rd1(br1o),.rd2(bvko),.q1(bq1o),.q2(bq2o),
.a(bdr),.cdb(cdb),.rn(rob_tag),.tag(unit_tag),.opa(ib1),.opb(ib2),ad_dr(buaddr));
bu b1 (.opa(ib1),.opb(ib2),.tag(unit_tag),.cdb(cdb),.imm(buaddr),.pc_adder(alres2),.flag(zf));

//Stall Logic
stall_unit s1 (.rtn(br12),.rs(ar1[25:21]),.rt(ar1[20:16]),.nop(nop),.stall(stall),
.clk(clk),.memr(memrd));

//Dynamic Branch Prediction
bht b1 (.ind(pc[5:2]),.clk(clk),.val(vd),.br(br),.bta(addr),.taken(taken),.btp(btp),
.ver(pc[pc[31:6]]));

mux_32 m5 (.a(cdb[31:0]),.b(),.sel(),.o()); 
endmodule
