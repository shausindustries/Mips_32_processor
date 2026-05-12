module rob(op, dr, val_u, altadr, val, rdy, s, clk, ready, empty, rst, rn, commit);
input clk, rst, commit;
input [5:0]op;
input [4:0]dr;
input [31:0]val_u;
input [31:0]altadr;
output ready, empty, rdy, val, s;
output reg [31:0]out;
output reg [3:0]rn;

reg [31:0] mem [0:7];
reg [2:0] op_ptr;
reg [2:0] ip_ptr;

assign empty = (op_ptr == ip_ptr) ? 1'b1 : 1'b0;
assign ready = ((ip_ptr == 3'b111) && (op_ptr != ip_ptr)) ? 1'b0 : 1'b1; 
always@ (posedge clk)
begin
    if (rst) begin
        ip_ptr <= 3'b0;
        op_ptr <= 3'b0;
    end
    else begin
        if (ready) begin
        mem[ip_ptr] <= in;
        rn <= {1'b0, ip_ptr} + 1'b1;
        if (ip_ptr == 3'b111) begin
            ip_ptr <= 3'b000;
        end
        else begin
            ip_ptr <= ip_ptr + 1'b1;
        end
        end
        if (commit == 1'b1) begin
            if (!empty) begin
            out <= mem[op_ptr];
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