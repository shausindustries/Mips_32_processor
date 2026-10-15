module dm_cache (rd,wd,addr_in,addr_out,w,clk,m);
input w,clk;
input [31:0] wd,addr_in,addr_out;
output reg [31:0]rd;
output reg m;

reg val [0:1023];
reg [21:0] tag1 [0:1023];
reg [21:0] tag2 [0:1023];
reg [31:0] data1 [0:1023];
reg [31:0] data2 [0:1023];
reg dirty1 [0:1023];
reg dirty2 [0:1-23];

integer ind;

always @(posedge clk) begin
    if (w == 1'b0) begin
        for (ind = 0; ind < 1024; ind = ind + 1) begin
            if (val[ind] == 1'b1) begin
                if (tag1[ind] == addr_out[21:0]) begin
                    rd <= data1[ind];
                    m <= 1'b0;
                end
                else if (tag2[ind] == addr_out[21:0]) begin
                    rd <= data2[ind];
                    m <= 1'b0;
                end
                else 
                    m <= 1'b1;
            end
        end
    end
    else begin
        for (ind = 0; ind < 1024; ind = ind + 1) begin
            
        end
    end
end


endmodule