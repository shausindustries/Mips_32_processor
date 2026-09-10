module dm_cache (rd,wd,addr_in,addr_out,w,clk,m);
input w,clk;
input [31:0] wd,addr_in;
output reg [31:0]addr_out,rd;
output reg m;

wire [0:9]index;
assign index = addr_in[31:21];

reg val [0:1023];
reg [21:0] tag [0:1023];
reg [31:0] data [0:1023];
reg dirty [0:1023];

always@ (posedge clk)
begin
    if (w != 1'b1) begin
       if (val[index] == 1'b1) begin
        if (tag[index] == addr_in[20:0]) begin
            rd <= data[index];
            m <= 1'b0; 
        end
        else begin
            addr_out <= addr_in;
            data[index] <= wd;
            m <= 1'b1;
        end
        end
        else begin
            addr_out <= addr_in;
            data[index] <= wd;
            m <= 1'b1;
            end
    end
    else begin
        if (val[index] == 1'b1) begin
            if (tag[index] == addr_in[20:0]) begin
                data[index] <= wd;;
                m <= 1'b0;
            end
            else begin
                addr_out <= addr_in;
                data[index] <= wd;
                m <= 1'b1;
            end
        end
        else begin
            addr_out <= addr_in;
            data[index] <= wd;
            m <= 1'b1;
            end
    end
end

endmodule