module bht(
    input [3:0]ind,
    input [31:0]bta,
    input val,clk,br,
    output reg taken,
    output [31:0]btp
);

reg [1:0] stat [0:15];
reg [31:0] btb [0:15];

assign btp = btb[ind];
always @(*) begin
    if (stat[ind] == 2'b10 || stat[ind] == 2'b11) begin
        taken = 1'b1;
    end
    else begin
        taken = 1'b0;
    end
end

always @(posedge clk) begin
    if (br == 1'b1) begin
        case (stat[ind])
                0 : begin
                        if (val == 1'b1) begin
                            stat[ind] <= 2'b01;
                        end
                        else begin
                            stat[ind] <= 2'b00;
                        end
                    end

                1 : begin
                        if (val == 1'b1) begin
                            stat[ind] <= 2'b10;
                        end
                        else begin
                            stat[ind] <= 2'b00;
                        end
                    end

                2 : begin
                        if (val == 1'b1) begin
                            stat[ind] <= 2'b11;
                            btb[ind] <= bta;
                        end
                        else begin
                            stat[ind] <= 2'b01;
                        end
                    end

                3 : begin
                        if (val != 1'b1) begin
                            stat[ind] <= 2'b10;
                        end
                        else begin
                            stat[ind] <= 2'b11;
                            btb[ind] <= bta;
                        end
                    end
        endcase
    end
end
endmodule