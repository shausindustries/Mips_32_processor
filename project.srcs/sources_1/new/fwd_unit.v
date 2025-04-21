`timescale 1ns / 1ps
module fwd_unit(fwd1,fwd2,br14,dr3,cr4,br12,cr5,dr4);
input [4:0]br14,br12,cr4,dr3;
input cr5,dr4;
output reg [1:0]fwd1,fwd2;

always@ (*)
    begin
        if (((br14 != 5'b00000) && (br14 == cr4) && cr5) && ((br12 != 0) && (br12 == cr4) && cr5))
            begin
                fwd1 = 2'b10;
                fwd2 = 2'b10;
            end
        else if (((br14 != 5'b00000) && (br14 == dr3) && dr4) && ((br12 != 0) && (br12 == dr3) && dr4))
            begin
                fwd1 = 2'b01;
                fwd2 = 2'b01;
            end
        else
            begin
                fwd1 = 2'b00;
                fwd2 = 2'b00;
            end
    end
endmodule
