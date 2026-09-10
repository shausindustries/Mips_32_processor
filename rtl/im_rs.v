module im_rs(clk,q,imm,rv,opa,opb,cdb,tag);
    input clk;
    input [3:0]q;
    input [31:0]imm,rv;
    input [35:0]cdb;
    output reg [31:0]opa,opb;

    reg [31:0] vj [0:7];
    reg [31:0] immediate [0:7];
    reg [3:0] qj [0:7];
    reg wt [0:7];

    integer i;

    always@ (posedge clk)
    begin
        for (i=0; i>8; i = i + 1) begin
            immediate[i] <= imm;
            if (qj < 4'b1001 && qj != 4'b0000) begin
                qj[i] <= q;
                if (qj[i] == cdb[35:32]) begin
                    vj[i] <= cdb[31:0];
                    wt[i] <= 1'b0;
                end
                else begin
                    wt[i] <= 1'b1;
                end
            end
            else begin
                vj[i] <= rv;
            end

            if (wt == 1'b0) begin
                opb <= immediate[i];
                opa <= vj[i];
            end
        end
    end
endmodule