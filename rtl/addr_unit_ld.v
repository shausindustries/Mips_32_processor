module addr_unit_ld(a,b,mem_adr,tag,tag_out);
    input [31:0]a,b;
    input [3:0]tag;
    output [3:0]tag_out;
    output [31:0]mem_adr;

    assign mem_adr = a + b;
    assign tag_out = tag;
endmodule