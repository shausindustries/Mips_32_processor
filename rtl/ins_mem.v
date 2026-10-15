`timescale 1ns / 1ps
module ins_mem(
    input  [31:0] a,
    output reg [31:0] rd
);

always @(*) begin
    case (a)

        // ---------------------------
        // 1️⃣ Forwarding Test (RAW hazard)
        // ---------------------------

        32'h00000000: rd = 32'h20080005; // addi $t0,$zero,5
        32'h00000004: rd = 32'h01084020; // add  $t0,$t0,$t0   (t0 = 10)
        32'h00000008: rd = 32'h01084820; // add  $t1,$t0,$t0   (needs forwarding)

        // ---------------------------
        // 2️⃣ Load-Use Hazard (needs stall)
        // ---------------------------

        32'h0000000C: rd = 32'hAC080000; // sw   $t0,0($zero)
        32'h00000010: rd = 32'h8C0A0000; // lw   $t2,0($zero)
        32'h00000014: rd = 32'h014A5020; // add  $t2,$t2,$t2  (load-use hazard)

        // ---------------------------
        // 3️⃣ Control Hazard (branch)
        // ---------------------------

        32'h00000018: rd = 32'h200B0001; // addi $t3,$zero,1
        32'h0000001C: rd = 32'h200C0001; // addi $t4,$zero,1
        32'h00000020: rd = 32'h116C0002; // beq  $t3,$t4, +2 (should branch)

        32'h00000024: rd = 32'h200D0005; // addi $t5,$zero,5 (should flush if branch works)
        32'h00000028: rd = 32'h200D0006; // addi $t5,$zero,6 (should flush if branch works)

        32'h0000002C: rd = 32'h200E0009; // addi $t6,$zero,9 (branch target)

        default: rd = 32'h00000000;

    endcase
end

endmodule