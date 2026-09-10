module reservation_station(clk,op,rd1,rd2,q1,q2,cdb,a,opa,opb,rn,tag,ready,qko,vko);
input [5:0]op;
input [31:0]rd1,rd2;
input [3:0]q1,q2,rn;
input [31:0]a;
input [35:0]cdb;
input clk;
output reg ready;
output reg [3:0]qko;
output reg [31:0]vko;
output reg [31:0]opa,opb;
output reg [4:0]tag;

reg [3:0] num [0:8];
reg [5:0] opr [0:8];
reg [31:0] vj [0:8];
reg [31:0] vk [0:8];
reg [3:0] qj [0:8];
reg [3:0] qk [0:8];
reg [31:0] addr [0:8];
reg wtj [0:8];
reg wtk [0:8];

integer i;

always @(posedge clk) begin
    for (i = 0; i <= 2; i = i + 1) begin
        num[i] <= rn;
        opr[i] <= op;
        qj[i] <= q1;
        qk[i] <= q2;
        vj[i] <= rd1;
        vk[i] <= rd2;
        addr[i] <= a;

        if (qj[i] == cdb[35:32]) begin
            vj[i] <= cdb[31:0];
            wtj[i] <= 1'b0;
        end

        else if (qk[i] == cdb[35:32]) begin
            vk[i] <= cdb[31:0];
            wtk[i] <= 1'b0;
            end
        
        else if (qj[i] == 4'b0000) begin
            wtj[i] <= 1'b0;
        end

        else if (qk[i] == 4'b0000) begin
            wtk[i] <= 1'b0;
        end

        else begin
            wtk[i] <= 1'b1;
            wtj[i] <= 1'b1;
            end
        
        if (opr[i] == 6'b000000) begin
            if (wtj[i] == 1'b0 && wtk[i] == 1'b0) begin
                opa <= vj[i];
                opb <= vk[i];
                tag <= num[i];
                ready <= 1'b1;
            end
            else begin
                ready <= 1'b0;
            end
            end
        else if (opr[i] == 6'b101011 || opr[i] == 6'b000100 || opr[i] == 6'b000101) begin
            if (wtj[i] == 1'b0 && wtk[i] == 1'b0) begin
                opa <= vj[i];
                opb <= addr[i];
                tag <= num[i];
                qko <= 4'b0000;
                vko <= vk[i];
                ready <= 1'b1;
            end
            else if (wtj[i] == 1'b0 && wtk[i] == 1'b1) begin
                opa <= vj[i];
                opb <= addr[i];
                tag <= num[i];
                qko <= qk[i];
                ready <= 1'b1;
            end
            else begin
                ready <= 1'b0;
            end
        end
        else begin
            if (wtj[i] == 1'b0) begin
                opa <= vj[i];
                opb <= addr[i];
                tag <= num[i];
                ready <= 1'b1;
            end
            else begin
                ready <= 1'b0;
            end
        end
    end
    end
endmodule