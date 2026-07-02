module rob(dr, val_u, altadr, s, clk, ready, empty, rst, rn, commit, out,rdy);
input clk, rst, commit;
input [4:0]dr;
input [35:0]val_u;
input [31:0]altadr;
output ready,empty,s,rdy;
output reg [36:0]out;
output reg [3:0]rn;

reg [4:0] rd [0:7]; 
reg [31:0] value [0:7];
reg s [0:7];
reg ready [0:7];

reg [2:0] op_ptr;
reg [2:0] ip_ptr;

integer i;

assign empty = (op_ptr == ip_ptr) ? 1'b1 : 1'b0;
assign rdy = ((ip_ptr == 3'b111) && (op_ptr != ip_ptr)) ? 1'b0 : 1'b1; 

always@ (posedge clk)
begin
    if (rst) begin
        ip_ptr <= 3'b0;
        op_ptr <= 3'b0;
        for (i = 0; i<8; i = i+1) begin
            rd[i] <= 5'b00000;
            value[i] <= 32'b0;
        end
    end
    else begin
        rd[ip_ptr] <= dr; 
        if (ip_ptr == 3'b111) begin
                ip_ptr <= 3'b000;
            end
        else begin
                ip_ptr <= ip_ptr + 1'b1;
        end
        rn <= {1'b0, ip_ptr} + 1'b1;

        if (ready) begin
            value[val_u[34:32]] <= val_u[31:0];
            s[val_u[35:32]] <= 1'b1;
        end
        if (commit == 1'b1) begin
            if (!empty) begin
                out <= {dr[op_ptr],value[op_ptr]};
                if (op_ptr == 3'b111) begin
                    op_ptr <= 3'b000;
                end
                else begin
                    op_ptr <= op_ptr + 1'b1;
                end
        end
        end
    end
end
endmodule