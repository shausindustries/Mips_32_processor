module simd_decoder(op,pab,pah,psb,psh);
input [5:0]op;
output reg pab,pah,psb,psh;

always @(*)
begin
    case (op)
        66 : begin
                pab <= 1'b1;
             end
        64 : begin
                pah <= 1'b1;
             end
        98 : begin
                psb <= 1'b1;
             end
        96 : begin
                psh <= 1'b1;
             end
        default: begin
                    pab <= 1'b0;
                    pah <= 1'b0;
                    psb <= 1'b0;
                    psh <= 1'b0;
                end
    endcase 
end
endmodule