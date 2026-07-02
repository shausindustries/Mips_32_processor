module if_id(ar1,ar2,clk,ao1,ao2,flush,stall,nop,rst);
    input [31:0]ar1,ar2;
    input clk,nop,stall,flush,rst;
    output reg [31:0]ao1,ao2;

    always@ (posedge clk)
    begin
        if (rst == 1'b1)begin
            ao1 <= 32'b0;
            ao2 <= 32'b0;
        end
        else begin
            if (flush == 1'b1) begin
            ao1 <= 32'b0;
            ao2 <= 32'b0;
            end
            else if (stall == 1'b0) begin
            ao1 <= ar1;
            ao2 <= ar2;
            end
        end
        
    end
endmodule