module ex_mem(
    input [31:0]cr1,cr2,cr3,
    input [4:0]cr4,
    input cr5,cr6,cr7,cr8,
    input clk,
    output reg [31:0]co1,co2,co3,
    output reg [4:0]co4,
    output reg co5,co6,co7,co8
);
    always @(posedge clk) begin
        co1 <= cr1;
        co2 <= cr2;
        co3 <= cr3;
        co4 <= cr4;
        co5 <= cr5;
        co6 <= cr6;
        co7 <= cr7;
        co8 <= cr8;
    end
endmodule