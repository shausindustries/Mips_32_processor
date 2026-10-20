module dm_cache (rd,wd,addr,w,clk,m,addr_m,mrd,mwd,rst,wr);
input w,clk,rst;
input [31:0] wd,addr,mrd;
output reg [31:0]rd,addr_m,mwd;
output reg m,wr;

reg lru [0:1023];
reg vd1 [0:1023];
reg vd2[0:1023];
reg [21:0] tag1 [0:1023];
reg [21:0] tag2 [0:1023];
reg [31:0] data1 [0:1023];
reg [31:0] data2 [0:1023];
reg dirty1 [0:1023];
reg dirty2 [0:1023];

wire [9:0]index;
integer ind;

assign index = addr[9:0];

always @(posedge clk) begin
    if (rst == 1'b1) begin
        for (ind=0; ind < 1024; ind = ind + 1) begin
            vd1[ind] = 1'b0;
            vd2[ind] = 1'b0;
        end
    end
    else begin
        if (w == 1'b0) begin
            if (vd1[index] == 1'b1 || vd2[index] == 1'b1) begin
                if (tag1[index] == addr[31:10]) begin
                    rd <= data1[index];
                    m <= 1'b0;
                    lru[index] = 1'b1;
                end
                else if (tag2[index] == addr[31:10]) begin
                    rd <= data2[index];
                    m <= 1'b0;
                    lru[index] = 1'b0;
                end
                else begin
                    if (lru[index] == 1'b0) begin
                        if (dirty1[index] == 1'b1) begin
                            m <= 1'b1;
                            wr <= 1'b1;
                            addr_m <= {tag1[index],index};
                            mwd <= data1[index];
                            dirty1[index] = 1'b0;
                            addr_m <= addr;
                            tag1[index] = addr[31:10];
                            data1[index] = mrd;
                            lru[index] = 1'b1;
                        end
                        else begin
                            m <= 1'b1;
                            addr_m <= addr;
                            tag1[index] = addr[31:10];
                            data1[index] = mrd;
                            lru[index] = 1'b1;
                        end
                    end
                    else begin
                        if (dirty2[index] == 1'b1) begin
                            m <= 1'b1;
                            wr <= 1'b1;
                            addr_m <= {tag2[index],index};
                            mwd <= data2[index];
                            dirty2[index] = 1'b0;
                            addr_m <= addr;
                            tag2[index] = addr[31:10];
                            data2[index] = mrd;
                            lru[index] = 1'b0;
                        end
                        else begin
                            m <= 1'b1;
                            addr_m <= addr;
                            tag2[index] = addr[31:10];
                            data2[index] = mrd;
                            lru[index] = 1'b0;
                        end
                    end
                end
            end
            else if (vd1[index] == 1'b0) begin
                addr_m <= addr;
                tag1[index] = addr[31:10];
                data1[index] = mrd;
                rd <= data1[index];
                vd1[index] = 1'b1;
                lru[index] = 1'b1;
            end
            else if (vd2[index] == 1'b0) begin
                addr_m <= addr;
                tag2[index] = addr[31:10];
                data2[index] = mrd;
                rd <= data2[index];
                vd2[index] = 1'b1;
                lru[index] = 1'b0;
            end
        end
        else begin
            if (vd1[index] == 1'b1 || vd2[index] == 1'b1) begin
                if (tag1[index] == addr[31:10]) begin
                    data1[index] = wd;
                    m <= 1'b0;
                    dirty1[index] = 1'b1;
                    lru[index] = 1'b1;
                end
                else if (tag2[index] == addr[31:10]) begin
                    data2[index] = wd;
                    m <= 1'b0;
                    dirty2[index] = 1'b1;
                    lru[index] = 1'b0;
                end
                else begin
                    if (lru[index] == 1'b0) begin
                        if (dirty1[index] == 1'b1) begin
                            m <= 1'b1;
                            wr <= 1'b1;
                            addr_m <= {tag1[index],index};
                            mwd <= data1[index];
                            dirty1[index] = 1'b0;
                            tag1[index] = addr[31:10];
                            data1[index] = wd;
                            dirty1[index] = 1'b1;
                            lru[index] = 1'b1;
                        end
                        else begin
                            m <= 1'b1;
                            tag1[index] = addr[31:10];
                            data1[index] = wd;
                            dirty1[index] = 1'b1;
                            lru[index] = 1'b1;
                        end
                    end
                    else begin
                        if (dirty2[index] == 1'b1) begin
                            m <= 1'b1;
                            wr <= 1'b1;
                            addr_m <= {tag2[index],index};
                            mwd <= data2[index];
                            dirty2[index] = 1'b0;
                            tag2[index] = addr[31:10];
                            data2[index] = wd;
                            dirty2[index] = 1'b1;
                            lru[index] = 1'b0;
                        end
                        else begin
                            m <= 1'b1;
                            tag2[index] = addr[31:10];
                            data2[index] = wd;
                            dirty2[index] = 1'b1;
                            lru[index] = 1'b0;
                        end
                    end 
                end
            end
            else if (vd1[index] == 1'b0) begin
                addr_m <= addr;
                tag1[index] = addr[31:10];
                data1[index] = wd;
                mwd <= data1[index];
                vd1[index] = 1'b1;
                dirty1[index] = 1'b1;
                lru[index] = 1'b1;
            end
            else if (vd2[index] == 1'b0) begin
                addr_m <= addr;
                tag2[index] = addr[31:10];
                data2[index] = wd;
                mwd <= data2[index];
                vd2[index] = 1'b1;
                dirty2[index] = 1'b1;
                lru[index] = 1'b0;
            end
        end
    end
    for (ind = 0; ind < 1024; ind = ind + 1) begin
        if (dirty1[ind] == 1'b1) begin
            wr <= 1'b1;
            addr_m <= {tag1[ind],index};
            mwd <= data1[ind];
            dirty1[ind] = 1'b0;
        end
        else if (dirty2[ind] == 1'b1) begin
            wr <= 1'b1;
            addr_m <= {tag2[ind],index};
            mwd <= data2[ind];
            dirty2[ind] = 1'b0;
        end
    end
end
endmodule