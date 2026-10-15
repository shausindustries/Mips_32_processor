module bht(
    input [3:0]in_ind,mis_ind,
    input [26:0]in_ver,mis_ver,
    input [31:0]bta,mis_tg,
    input m,br,
    output reg taken,miss,
    output reg [31:0]btp,recovery
);

wire val;
assign val = miss;
reg [3:0] index [0:15];
reg [26:0] tag [0:15];
reg [1:0] stat [0:15];
reg [31:0] btb [0:15];

integer i;

always @(*) begin
    for (i=0; i<16; i = i+1) begin
        if (br == 1'b1) begin
            if (in_ind == index[i] && in_ver == tag[i]) begin
                if (stat[i] == 2'b10 || stat[i] == 2'b11) begin
                    taken = 1'b1;
                    btp <= btb[i];
                end
                else begin
                    index[i] = in_ind;
                    tag[i] = in_ver;
                    stat[i] = 2'b00;
                    btb[i] = bta;
                    taken = 1'b0;
                end
            end
            else begin
                
            end
        end
    end
        
    for (i=0; i <16; i=i+1) begin
        if (index[i] == mis_ind && tag[i] == mis_ver) begin
            if ((stat[i] == 2'b00 && m == 1'b0) || (stat[i] == 2'b01 && m == 1'b0)) begin
                if (btb[i] != mis_tg) begin
                    btb[i] = mis_tg;
                    miss = 1'b1;
                    recovery = mis_tg;
                end
                else begin
                    miss = 1'b0;
                end
            end

            else if ((stat[i] == 2'b11 && m == 1'b1) || (stat[i] == 2'b10 && m == 1'b1)) begin
                if (btb[i] != mis_tg) begin
                    btb[i] = mis_tg;
                    miss = 1'b1;
                    recovery = mis_tg;
                end
                else begin
                    miss = 1'b0;
                end
            end

            else if ((stat[i] == 2'b00 && m == 1'b1) || (stat[i] == 2'b01 && m == 1'b1)) begin
                miss = 1'b1;
                if (btb[i] != mis_tg) begin
                    btb[i] = mis_tg;
                    recovery = mis_tg;
                end
                else begin
                    recovery = btb[i];
                end
            end

            else if ((stat[i] == 2'b11 && m == 1'b0) || (stat[i] == 2'b10 && m == 1'b0)) begin
                miss = 1'b1;
                recovery = ({mis_ind,mis_ver} + 32'b100);
                if (btb[i] != mis_tg) begin
                    btb[i] = mis_tg;
                end
            end

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
                                stat[i] <= 2'b01;
                            end
                        end

                    2 : begin
                            if (val == 1'b1) begin
                                stat[i] <= 2'b11;
                            end
                            else begin
                                stat[i] <= 2'b10;
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
    end
end
endmodule