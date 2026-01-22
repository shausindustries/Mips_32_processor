module if_id(ar1,ar2,clk,ao1,ao2,flush,stall,nop,ar3,ao3);
    input [31:0]ar1,ar2;
    input clk,nop,stall,flush,ar3;
    output reg [31:0]ao1,ao2;
    output reg ao3;

    always@ (posedge clk)
    begin
        if (flush == 1'b1) begin
            ao1 <= 32'b0;
            ao2 <= 32'b0;
        end
        else if (stall == 1'b0) begin
            ao1 <= ar1;
            ao2 <= ar2;
            ao3 <= ar3;
        end
    end
endmodule