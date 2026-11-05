module packed_logic (op,pab,pah,psb,psh);
input [5:0]op;
output reg pab,pah,psb,psh;

always@ (*)
begin
    if (op == 6'b000010) begin
        pab <= 1'b1;
    end
    else if (op == 6'b000000) begin
        pah <= 1'b1;
    end
    else if (op == 6'b100010) begin
        psb <= 1'b1;
    end
    else if (op == 6'b100000) begin
        psh <= 1'b1;
    end
    else begin
        psh <= 1'b0;
        psb <= 1'b0;
        pah <= 1'b0;
        pab <= 1'b0;
    end
end
endmodule