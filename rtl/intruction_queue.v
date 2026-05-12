module instruction_queue(in, out, clk, ready, empty, rst);
input clk, rst;
input [31:0]in;
output ready, empty;
output reg [31:0]out;

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
        if (ip_ptr == 3'b111) begin
            ip_ptr <= 3'b000;
        end
        else begin
            ip_ptr <= ip_ptr + 1'b1;
        end
        end
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
endmodule