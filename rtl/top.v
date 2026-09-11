`timescale 1ns / 1ps

module top(of,clk,rst);
input clk,rst;
output of;

wire dr,wq,mulr,adr,subr,divr,ld,sw,beq,bne,j,br,adi,commit,rdya,emp,full,rdyl,rdylb,di,rdys,
rdysb,memw;
wire [3:0] tag_rob,qj,qk,aqj,aqk,atag,bqj,bqk,btag,ldqj,ldqk,ldtag,swqk,swqj,swtag,mtag,mqj,mqk,dtag,
dqj,dqk,stag,sqj,sqk,autag,lutag,lbtag,sbtag,sutag,qkrs,qksb,swtg;
wire [4:0] ds_reg,com_reg;
wire [5:0] aop,bop,ldop,swop,mop,dop,sop;
wire [31:0] bmo,smo,jmo,pc_op,instr,nia,ins,addr,vj,vk,imm,br_addr,avj,avk,aa,bvj,bvk,ba,ldvj,
ldvk,lda,swvj,swvk,swa,mvj,mvk,ma,dvj,dvk,da,svj,svk,sa,adopa,adopb,ldopa,ldopb,mem_addr_ld,
jlabel,swopa,swopb,mem_addr_sw,vkrs,vksb,lsab,lsdb;
wire [35:0] cdb;
wire [36:0] rob_out;
wire [63:0] in_pkg,mem_pkg;

assign ins = in_pkg[31:0];
assign addr = in_pkg[63:32];
assign br = beq | bne;

prog_counter pc (.pci(jmo),.pco(pc_op),.clk(clk),.stl(full & ~(emp)),.rst(rst));
pc_adder pa (.in(pc_op),.op(nia));
mux_32 branch_mux (.a(/*branch target buffer*/),.b(/*recovery path*/),
.sel(/*mispredict OR miss*/),.o(bmo));
mux_32 step_mux (.a(bmo),.b(nia),.sel(br),.o(smo));
mux_32 jump_mux (.a(smo),.b(jlabel),.sel(j),.o(jmo));

ins_mem im (.a(pc_op),.rd(instr));
intruction_queue iq (.in({pc_op,instr}),.out(in_pkg),.clk(clk),.rst(rst),.ready(),.empty());

reg_file rf (.a1(ins[25:21]),.a2(ins[20:16]),.a3(ds_reg),.rd1(vj),.rd2(vk),.wd3(rob_out[31:0]),
.wq3(tag_rob),.q1(qj),.q2(qk),.clk(clk),.we3(commit),.wqe((wq & (~(full)))),.rst(rst));
p_mux dest_reg (.a(ins[20:16]),.b(ins[15:11]),.sel(dr),.o(ds_reg));
p_mux cm_reg (.a(ds_reg),.b(rob_out[36:32]),.o(com_reg),.sel(commit));

sign_extend se1 (.in(ins[15:0]),.out(imm));

rob r (.dr(ds_reg),.rn(tag_rob),.rst(rst),.clk(clk),.out(rob_out),.cdb(cdb),.commit(commit),
.empty(emp),.full(full),.sw(sw),.w(memw),.tg(swtg));

controlunit cu (.op(ins[31:26]),.func(ins[5:0]),.dr(dr),.wq(wq),.mulr(mulr),.adr(adr),
.subr(subr),.bne(bne),.beq(beq),.divr(divr),.ld(ld),.sw(sw));

issue_logic il (rdya(rdya),rdyb(),rdys(rdys),rdyd(),rdym(),rdyld(rdyl),rdysw(),rdyj(),adr(adr),
adi(adi),subr(subr),mulr(mulr),divr(divr),ld(ld),sw(sw),br(br),vj(vj),vk(vk),qj(qj),qk(qk),
op(ins[31:26]),a(imm),tag(tag_rob),addr_in(addr),addr_out(br_addr),avj(avj),avk(avk),aqj(aqj),aqk(aqk),
aa(aa),aop(aop),atag(atag),bvj(bvj),bvk(bvk),bqj(bqj),bqk(bqk),bop(bop),btag(btag),ba(ba),ldop(ldop),
ldvj(ldvj),ldvk(ldvk),ldqj(ldqj),ldqk(ldqk),lda(lda),ldtag(ldtag),swop(swop),swvj(swvj),swvk(swvk),
swqj(swqj),swqk(swqk),swtag(swtag),swa(swa),mop(mop),mvj(mvj),mvk(mvk),mqj(mqj),mqk(mqk),mtag(mtag),
ma(ma),dop(dop),dvj(dvj),dvk(dvk),dqj(dqj),dqk(dqk),dtag(dtag),da(da),sop(sop),svj(svj),svk(svk),
sqj(sqj),sqk(sqk),stag(stag),sa(sa));

//Add
reservation_station r1 (.rn(atag),.op(aop),.q1(aqj),.q2(aqk),.rd1(avj),.rd2(avk),.a(aa),.opa(adopa),
.opb(adopb),.tag(autag),.cdb(cdb),.clk(clk),.ready(rdya));
int_add ia (.opa(adopa),.opb(adopb),.tag(autag),.cdb(cdb));

//Load
reservation_station r2 (.rn(ldtag),.op(ldop),.q1(ldqj),.q2(ldqk),.rd1(ldvj),.rd2(ldvk),.clk(clk),
.a(lda),.tag(lutag),.opa(ldopa),.opb(ldopb),.cdb(cdb),.ready(rdyl));
addr_unit_ld au1 (.a(ldopa),.b(ldopb),.mem_adr(mem_addr_ld),.tag_out(lbtag),.tag(lutag));
lb buffer1 (.clk(clk),.in(mem_addr_ld),.cdb(cdb),.swa(lsab),.tg(lbtag),.ready(rdylb),.data(lsdb),
.di(di));

//Store
reservation_station r3 (.rn(swtag),.op(swop),.q1(swqj),.q2(swqk),.rd1(swvj),.rd2(swvk),.clk(clk),
.a(swa),.tag(sutag),.opa(swopa),.opb(swopb),.cdb(cdb),.ready(rdys),.qko(qko),.vko(vko));
addr_unit_sw au2 (.a(swopa),.b(swopb),.tg(sutag),.tgo(sbtag),.qk(qkrs),.vk(vkrs),.qko(qksb),
.vko(vksb),.addr_out(mem_addr_sw));
sb buffer2 (clk(clk),a(mem_addr_sw),out(mem_pkg),tg(sbtag),qk(qksb),vk(vksb),swa(lsab),dta(lsdb),
di(di),ready(rdysb),cdb(cdb),tgc(swtg));


//Jump
jdecoder jd (.op(instr[31:26]),.j(j),.label(instr[25:0]),.jtg(jlabel3),.addr(nia[31:28]));


endmodule