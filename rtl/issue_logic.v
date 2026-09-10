module issue_logic (rdya,rdyb,rdys,rdyd,rdym,rdyld,rdysw,adr,adi,subr,mulr,divr,ld,sw,br,
vj,vk,qj,qk,op,a,tag,addr_in,addr_out,avj,avk,aqj,aqk,aa,aop,atag,bvj,bvk,bqj,bqk,bop,btag,ba,
ldop,ldvj,ldvk,ldqj,ldqk,lda,ldtag,swop,swvj,swvk,swqj,swqk,swtag,swa,mop,mvj,mvk,mqj,mqk,mtag,ma,
dop,dvj,dvk,dqj,dqk,dtag,da,sop,svj,svk,sqj,sqk,stag,sa);

input adr,adi,subr,mulr,divr,ld,sw,br,rdya,rdyb,rdys,rdyd,rdym,rdyld,rdysw;
input [31:0]vj,vk,addr_in,a;
input [5:0]op;
input [3:0]qj,qk,tag;
output reg [31:0] addr_out,avj,avk,aa,bvj,bvk,ba,ldvj,ldvk,lda,swvj,swvk,swa,mvj,mvk,ma,dvj,dvk,
da,svj,svk,sa;
output reg [5:0]aop,bop,ldop,swop,mop,dop,sop;
output reg [3:0]aqj,aqk,atag,bqj,bqk,btag,ldqj,ldqk,ldtag,swqk,swqj,swtag,mtag,mqj,mqk,dtag,dqj,
dqk,stag,sqj,sqk;
always@ (*)
begin
    if (adr | adi) begin
        if (rdya) begin
            atag = tag;
            aop = op;
            avj = vj;
            avk = vk;
            aqj = qj;
            aqk = qk;
            aa = a;
        end
    end
    else if (subr) begin
        if (rdys) begin
            stag = tag;
            sop = op;
            svj = vj;
            svk = vk;
            sqj = qj;
            sqk = qk;
            sa = a;
        end
    end
    else if (mulr) begin
        if (rdym) begin
            mtag = tag;
            mop = op;
            mvj = vj;
            mvk = vk;
            mqj = qj;
            mqk = qk;
            ma = a;
        end
    end
    else if (divr) begin
        if (rdyd) begin
            dtag = tag;
            dop = op;
            dvj = vj;
            dvk = vk;
            dqj = qj;
            dqk = qk;
            da = a;
        end
    end
    else if (br) begin
        if (rdyb) begin
            bop = op;
            btag = tag;
            bvj = vj;
            bvk = vk;
            bqj = qj;
            bqk = qk;
            ba = a;
            addr_out = addr_in;
        end
    end
    else if (ld) begin
        if (rdyld) begin
            ldtag = tag;
            ldop = op;
            ldvj = vj;
            ldvk = 32'bx;
            ldqj = qj;
            ldqk = 4'bx;
            lda = a;
        end
    end
    else if (sw) begin
        if (rdysw) begin
            swtag = tag;
            swop = op;
            swvj = vj;
            swvk = vk;
            swqj = qj;
            swqk = qk;
            swa = a;
        end
    end
end
endmodule