module rob(dr,cdb,clk,empty,rst,rn,commit,out,full,tg,w,rec_adr,op,ins_adr,br_adr,brn);
input clk,rst,brn;
input [5:0]op;
input [4:0]dr;
input [31:0]rec_adr;
input [35:0]cdb;
output reg commit,full,empty,w;
output reg [36:0]out;
output reg [3:0]rn,tg;
output reg [31:0]ins_adr,br_adr;

reg [5:0] opc [0:15];
reg [3:0] tag [0:15];
reg [31:0] rec_path [0:15];
reg [4:0] rd [0:15]; 
reg [31:0] value [0:15];
reg m [0:15];
reg ready [0:15];

reg [2:0] op_ptr;
reg [2:0] ip_ptr;
reg [2:0] stl_ptr;

integer i,j;

always@ (posedge clk)
begin
    if (rst) begin
        ip_ptr <= 4'b000;
        op_ptr <= 4'b000;
        for (i = 0; i<16 ; i = i+1) begin
            tag[i] <= 4'b0000;
            rd[i] <= 5'b00000;
            value[i] <= 32'b0;
        end
    end
    else begin
        opc[ip_ptr] <= op;
        rd[ip_ptr] <= dr;
        rec_path[ip_ptr] <= rec_adr;
        tag[ip_ptr] <= {1'b0, ip_ptr} + 1'b1; 
        rn = tag[ip_ptr];

        ip_ptr <= ip_ptr + 1'b1;

        for (j=0; j<16; j=j+1) begin
            if (cdb[35:32] == tag[j]) begin
                if (opc[j] == 6'b000100 || opc[j] == 6'b000101) begin
                    m[j] <= brn;
                end
                value[cdb[35:32]] <= cdb[31:0];
                ready[cdb[35:32]] <= 1'b1;
                end
            else begin
                ready[tag[j]] <= 1'b0;
            end

        if (ip_ptr == 3'b111) begin
            full <= 1'b1;
            for (i=0; i<16; i=i+1) begin
                if (ready[i] == 1'b0) begin
                    commit <= 1'b0;
                end
                else begin
                    commit <= 1'b1;
                end
            end
        end
        else begin
            full <= 1'b0;
        end
        end

        if (commit == 1'b1) begin
            if (opc[op_ptr] == 6'b101011) begin
                tg <= tag[op_ptr];
                w <= 1'b1;
                op_ptr <= op_ptr + 1'b1;
            end
            else if (opc[op_ptr] == 6'b000100 || opc[op_ptr] == 6'b000101) begin
                ins_adr <= rec_path[op_ptr];
                br_adr <= value[op_ptr];
                w <= 1'b0;
                op_ptr <= op_ptr + 1'b1;
            end 
            else begin
                out <= {dr[op_ptr],value[op_ptr]};
                w <= 1'b0;
                op_ptr <= op_ptr + 1'b1;
            end
            if (op_ptr == 3'b111) begin
                ip_ptr <= 3'b000;
                op_ptr <= 3'b000;
                empty <= 1'b1;
            end
            else begin
                empty <= 1'b0;
            end
        end
    end
end
endmodule