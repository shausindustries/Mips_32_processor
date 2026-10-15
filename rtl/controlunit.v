module controlunit (op,func,dr,wq,adr,subr,mulr,divr,ld,sw,adi,beq,bne);
input [5:0]op;
input [5:0]func;
output reg dr,wq,adr,subr,mulr,divr,ld,sw,adi,beq,bne;

always@(*)
begin
    case (op)
        0 : begin
                dr = 1'b1;
                case (func) 
                    32 : adr = 1'b1;
                    34 : subr = 1'b1;
                    26 : divr = 1'b1;
                endcase
            end
        4 : beq = 1'b1;
        5 : bne = 1'b1;
        8 : adi = 1'b1;
        28 : mulr = 1'b1;
        35 : ld = 1'b1;
        43 : begin
                sw = 1'b1;
                wq = 1'b0;
            end

        default: begin
            adi = 1'b0;
            adr = 1'b0;
            subr = 1'b0;
            mulr = 1'b0;
            divr = 1'b0;
            wq = 1'b1;
            ld = 1'b0;
            sw = 1'b0;
            dr = 1'b0;
            beq = 1'b0;
            bne = 1'b0;
        end
        endcase
end
endmodule