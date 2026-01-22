module id_ex(
    input [31:0]br1,br2,br3,br4,
    input [4:0]br5,
    input br6,br7,br8,br9,br10,br11,br15,br16,
    input clk,nop,
    input [4:0]br12,br13,br14,
    output reg [31:0]bo1,bo2,bo3,bo4,
    output reg [2:0]bo5,
    output reg bo6,bo7,bo8,bo9,bo10,bo11,bo15,bo16,
    output reg [4:0]bo12,bo13,bo14
    );

    always@ (posedge clk)
    begin
        if (nop == 1'b1) begin
            bo5 <= 2'b00;

            bo6 <= 1'b0;
            bo7 <= 1'b0;
            bo8 <= 1'b0;
            bo9 <= 1'b0;
            bo10 <= 1'b0;
            bo11 <= 1'b0;
            bo15 <= 1'b0;
            bo16 <= 1'b0;
            
        end
        else begin
            bo1 <= br1;
            bo2 <= br2;
            bo3 <= br3;
            bo4 <= br4;
            bo5 <= br5;
            bo6 <= br6;
            bo7 <= br7;
            bo8 <= br8;
            bo9 <= br9;
            bo10 <= br10;
            bo11 <= br11;
            bo12 <= br12;
            bo13 <= br13;
            bo14 <= br14;
            bo15 <= br15;
            bo16 <= br16;
        end
    end
endmodule