module bu(in1,in2,cdb,imm,tag,brsig,op);
input [31:0]in1,in2,imm;
input [5:0]op;
input [3:0]tag;
output reg [35:0]cdb;
output reg brsig;

always@ (*) begin
    if (in1 == in2) begin
        if (op == 6'b000100) begin
            brsig <= 1'b1;
            cdb <= {tag,imm};
        end
        else begin
            brsig <= 1'b0;
            cdb <= {tag,imm};
        end
    end
    else begin
        if (op == 6'b000100) begin
            brsig <= 1'b0;
            cdb <= {tag,imm};
        end
        else begin
            brsig <= 1'b1;
            cdb <= {tag,imm};
        end
    end
    
end
endmodule