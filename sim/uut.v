`timescale 1ns/1ps

module top_tb;

    reg clk;
    reg rst;
    wire of;

    top uut (
        .clk(clk),
        .rst(rst),
        .of(of)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        rst = 1;
        #15;
        rst = 0;
    end

    // Dump
    initial begin
        $dumpfile("mips32.vcd");
        $dumpvars(0, top_tb);
    end

    // 🔥 ADD THIS BLOCK HERE
    initial begin
    #300;
    $display("mem[8] = %d", uut.rf1.mem[8]);
    $display("mem[9] = %d", uut.rf1.mem[9]);
    $display("mem[10] = %d", uut.rf1.mem[10]);
end

    // Finish simulation
    initial begin
        #500;
        $finish;
    end

endmodule