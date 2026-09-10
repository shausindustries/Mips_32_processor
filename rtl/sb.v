module sb(clk,a,out,tg,qk,vk,swa,dta,di,ready,cdb,s);
input clk,di,s;
input [3:0]tg,qk;
input [31:0]vk,a;
input [35:0]cdb;
output reg ready;
output reg [31:0]swa,dta;
output reg [63:0]out;

reg [3:0] tag [0:6];
reg [3:0] qki [0:6];
reg [31:0] data [0:6];
reg [31:0] address [0:6];
reg rdy [0:6];

integer i;

always@ (posedge clk)
begin
    for (i=0; i<7; i=i+1) begin
        tag[i] <= tg;
        address[i] <= a;

        if (qk[i] == 4'b0000) begin
            data[i] <= vk;
            rdy[i] <= 1'b1;
        end
        else if (qk[i] == cdb[35:32]) begin
            data[i] <= cdb[31:0];
            rdy[i] <= 1'b1;
        end
        else begin
            rdy[i] <= 1'b0;
        end
    end 

    for (i=0; i<7; i=i+1) begin
        if (rdy[i] != 1'b1) begin
            ready <= 1'b0;
        end
        else begin
            ready <= 1'b1;
            swa <= address[i];
            if (di == 1'b1) begin
                dta <= data[i];
            end
        end
    end
end
endmodule