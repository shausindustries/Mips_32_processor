module reservation_station(clk,op,rd1,rd2,q1,q2,cdb,a,opa,opb,rn, tag);
input [5:0]op;
input [31:0]rd1,rd2;
input [3:0]q1,q2,rn;
input [31:0]a;
input [35:0]cdb;
input clk;
output reg [31:0]opa,opb;
output reg [3:0]tag;

reg [3:0] num [0:2];
reg [5:0] opr [0:2];
reg [31:0] vj [0:2];
reg [31:0] vk [0:2];
reg [3:0] qj [0:2];
reg [3:0] qk [0:2];
reg [31:0] addr [0:2];
reg busy [0:2];
reg wtj [0:2];
reg wtk [0:2];

integer i;

always @(posedge clk) begin
    for (i = 0; i <= 2; i = i + 1) begin
        num[i] <= rn;
        opr[i] <= op;
        if (q1 < 4'b1001 && q1 != 4'b0000) begin
            qj[i] <= q1;
            if (qj[i] == cdb[35:32]) begin
                vj[i] <= cdb[31:0];
                wtj[i] <= 1'b0;
                busy[i] <= 1'b1;
            end
            else begin
                wtj[i] <= 1'b1;
                busy[i] <= 1'b1;
            end
        end

        else if (q1 < 4'b1001 && q1 != 4'b0000) begin
            qk[i] <= q2;
            if (qk[i] == cdb[35:32]) begin
                vk[i] <= cdb[31:0];
                wtk[i] <= 1'b0;
                busy[i] <= 1'b1;
            end
            else begin
                wtk[i] <= 1'b1;
                busy[i] <= 1'b1;
            end
        end

        else begin
            vj[i] <= rd1;
            vk[i] <= rd2;
            qj[i] <= 4'b0000;
            qk[i] <= 4'b0000;
            wtj[i] <= 1'b0;
            wtk[i] <= 1'b0;
            if (wtj[i] == 1'b0 && wtk[i] == 1'b0) begin
                opa <= vj[i];
                opb <= vk[i];
                tag <= num[i];
                busy[i] <= 1'b0;
            end
            else begin
                busy[i] <= 1'b1;
        end
    end
    end
end
endmodule