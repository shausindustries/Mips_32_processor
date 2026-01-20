`timescale 1ns / 1ps

module prog_counter_tb;

    reg clk;
    wire [31:0] pco; 

    prog_counter uut (
        .clk(clk),
        .pco(pco)
    );

    always #5 clk = ~clk;  

    initial begin
        $dumpfile("prog_counter_tb.vcd"); 
        $dumpvars(0, prog_counter_tb);
        
        clk = 0;  
        #100;
        $finish;  
    end

endmodule