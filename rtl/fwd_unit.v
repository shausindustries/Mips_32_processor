module fwd_unit(
    input [4:0]rd1,rd2,rs,rt,
    input regw,clk,
    output reg [1:0]sel1mf,sel2mf
);
    always @(posedge clk) begin
        sel1mf <= 2'b00;
        sel2mf <= 2'b00;
        if ((regw == 1'b1) && (rd1 != 5'b00000 && rd1 == rs)) begin
            sel1mf <= 2'b10;
        end
        else if ((regw == 1'b1) && (rd2 != 5'b00000 && rd2 == rs)) begin
            sel1mf <= 2'b01;
        end

        if ((regw == 1'b1) && (rd1 != 5'b00000 && rd1 == rt)) begin
            sel2mf <= 2'b01;
        end
        else if ((regw == 1'b1) && (rd2 != 5'b00000 && rd2 == rt)) begin
            sel2mf <= 2'b10;
        end
    end
endmodule