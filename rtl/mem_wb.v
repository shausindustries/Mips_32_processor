module mem_wb(
    input [31:0]dr1,dr2,
    input [4:0]dr3,
    input dr4,dr5,
    input clk,
    output reg [31:0]do1,do2,
    output reg [4:0]do3,
    output reg do4,do5
);
  always @(posedge clk) begin
    do1 <= dr1;
    do2 <= dr2;
    do3 <= dr3;
    do4 <= dr4;
    do5 <= dr5;
  end  
endmodule