module lb(clk,in,cdb,swa,tg,ready,memdata,di,sbdata,addr);
input clk;
input [3:0]tg;
input [31:0]in,swa,memdata,sbdata;
output reg ready,di;
output reg [31:0]addr;
output reg [35:0]cdb;

reg [3:0] tag [0:6];
reg [31:0] load_buffer [0:6];
reg rdsig [0:6];

integer i;

always@ (posedge clk)
begin
    for (i=0; i<7; i=i+1) begin
        tag[i] <= tg;
        load_buffer[i] <= in;
        rdsig[i] <= 1'b1;
    end

    for (i=0; i<7; i=i+1) begin
        if (rdsig[i] != 1'b1) begin
            ready <= 1'b0;
        end
        else
            ready <= 1'b1;
    end
end

always@ (swa) begin

    for (i=0; i<7; i=i+1) begin
        if (load_buffer[i] == swa) begin
            di = 1'b1;
            cdb = {tag[i],sbdata};
        end
        else begin
            di = 1'b0;
            addr = load_buffer[i];
            cdb = {tag[i],memdata};
        end
    end
end
endmodule