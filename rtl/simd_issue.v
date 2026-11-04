module simd_issue (psh,psb,pah,pab,vj,vk,qj,qk,tag,patag,pavj,pavk,paqj,paqk,pstag,psvj,psvk,op
,paop,psqk,psqj,psop,rdypa,rdyps);
input psh,psb,pah,pab,rdypa,rdyps;
input [31:0]vj,vk;
input [5:0]op;
input [3:0]qj,qk,tag;
output [5:0]paop,psop;
output reg [31:0]pavj,pavk,psvj,psvk;
output reg [3:0]paqj,paqk,psqk,psqj,patag,pstag;

always@ (*)
begin
    if (pab | pah) begin
        if (rdypa == 1'b1) begin
            patag <= tag;
            pavj <= vj;
            pavk <= vk;
            paqj <= qj;
            paqk <= qk; 
        end
    end
    else if (psh | psb) begin
        if (rdyps == 1'b1) begin
            pstag <= tag;
            psvj <= vj;
            psvk <= vk;
            psqj <= qj;
            psqk <= qk; 
        end
    end
end
endmodule