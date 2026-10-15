module sbr_unit(
    input clk,bres,
    output reg flush
);
    always @(posedge clk) begin
        if (bres == 1'b1) begin
            flush <= 1'b1;
        end
        else begin
            flush <= 1'b0;
        end
    end
endmodule