module issue_logic(clk,instr,add_i,br_i,we3,wq,sel,addr,br,fl,ilt,r1,r2,q1,q2,a_r1o,
a_r2o,a_q1o,a_q2o, b_r1o,b_r2o,b_q1o,b_q2o,a_addr,b_addr);
input [5:0]instr;
input [31:0] r1,r2,addr;
input [3:0]q1,q2;
input clk,fl;
output reg [31:0] a_r1o,a_r2o,b_r1o,b_r2o,a_addr,b_addr;
output reg [3:0] a_q1o,a_q2o,b_q1o,b_q2o;
output reg [5:0] add_i, br_i;
output reg we3,wq,sel,br,ilt;

always@ (clk) begin
    case (instr[5:0])
        0 : begin
            sel <= 1'b1;
            case (instr[5:0])
                20 : begin
                        add_i <= instr;
                        a_r1o <= r1;
                        a_r2o <= r2;
                        a_q1o <= q1;
                        a_q2o <= q2;
                        a_addr <= addr;
                end
            endcase
            end
        4 : begin
                br_i <= instr;
                b_r1o <= r1;
                b_r2o <= r2;
                b_addr <= addr;
                b_q1o <= q1;
                b_q2o <= q2;
                br <= 1'b1;
                if (fl == 1'b1) begin
                    ilt <= 1'b1;
                end
                else
                    ilt <= 1'b0;
        end
        5 : begin
                br_i <= instr;
                br <= 1'b1;
                b_r1o <= r1;
                b_r2o <= r2;
                b_addr <= addr;
                b_q1o <= q1;
                b_q2o <= q2;
                br <= 1'b1;
                if (fl == 1'b1) begin
                    ilt <= 1'b0;
                end
                else
                    ilt <= 1'b1;
        end
        default : begin
                    sel <= 1'b0;
                    br <= 1'b0;
        end
    endcase
end
endmodule