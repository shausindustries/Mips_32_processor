`timescale 1ns / 1ps
module p_mux(a,b,sel,o);
    input [4:0]a,b;
    input sel;
    output reg [4:0]o;
    
    always@ (*)
        begin
            case (sel)
                0 : o = a;
                1 : o = b;
            endcase
        end
endmodule
