module dmux_32 (in,a,b,sel);
input sel;
input [31:0]in;
output reg [31:0]a,b;

always@ (*)
begin
    case (sel)
        0 : a = in;
        1 : b = in;
        default: a = in;
    endcase
end
endmodule