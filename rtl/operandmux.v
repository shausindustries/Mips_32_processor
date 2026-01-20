module operandmux(
    input [31:0]a,b,c,
    input [1:0]sel,
    output [31:0]o
);
    always@(*)
    begin
        sel = 2'b00;
        case (sel)
            0 : o = a;
            1 : o = b;
            2 : o = c;
        endcase
    end    
endmodule