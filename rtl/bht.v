module bht(
    input [3:0]ind,
    input [26:0] ver,
    input [31:0]bta,
    input val,clk,br,
    output reg taken,
    output reg [31:0]btp
);

reg [3:0] index [0:15];
reg [26:0] tag [0:15];
reg [1:0] stat [0:15];
reg [31:0] btb [0:15];

integer i;



always @(*) begin
    for (i=0; i<16; i = i+1) begin
        if (br == 1'b1) begin
            stat[i] = ind;
            tag[i] = ver;
            btb[i] = bta;
            case (stat[i])
                0 : begin
                        if (val == 1'b1) begin
                            stat[i] <= 2'b01;
                        end
                        else begin
                            stat[i] <= 2'b00;
                        end
                    end

                1 : begin
                        if (val == 1'b1) begin
                            stat[i] <= 2'b10;
                        end
                        else begin
                            stat[i] <= 2'b00;
                        end
                    end

                2 : begin
                        if (val == 1'b1) begin
                            stat[i] <= 2'b11;
                        end
                        else begin
                            stat[i] <= 2'b01;
                        end
                    end

                3 : begin
                        if (val != 1'b1) begin
                            stat[i] <= 2'b10;
                        end
                    end
                    default : stat[i] = 2'b00;
        endcase
        end
        if (ind == stat[i] && ver == tag[i]) begin
            if (stat[i] == 2'b10 || stat[i] == 2'b11) begin
                taken = 1'b1;
            end
            else begin
                taken = 1'b0;
            end
        end
        else begin
            taken = 1'b0;
        end
    end
end
endmodule