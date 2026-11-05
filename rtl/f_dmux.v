module f_dmux (in,a,b,sel);
input [3:0]in;
input sel;
output reg [3:0]a,b;

always@ (*)
begin
    case (sel)
        0 : a = in;
        1 : b = in; 
        default: a = in;
    endcase
end
endmodule