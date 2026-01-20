module stall_unit(
    input memr, clk,
    input [4:0]rs,rt,rtn,
    output nop,stall
);
    always @(posedge clk) begin
       if ((memr == 1'b1) && (rtn == rs || rtn == rt)) begin
        nop <= 1'b1;
        stall <= 1'b1;
        end 
    end
endmodule