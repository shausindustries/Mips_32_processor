**_MIPS-32 Processor:_**
MIPS is a subset of the RISC (Reduced Instruction Set Computer) architecture. It is easier to understand and implement as compared to the
x86 architecture which belongs to the CISC (Complex Instruction Set Computer) architectural family.
This is a simple implementation of a single core 5-stage pipelined MIPS-32 (i.e 32-bit) processor using Verilog and Computer Architecture. 

**_Features:_**
- Supports execution of basic R, I and J type instructions
- List of instructions till now:
  *  R-Type: add,sub,and,or,xor,mul.
  *  I-type: lw,sw,addi,subi,ori,andi,addiu.
  *  J-type: beq,j,bne.
- This design now supports Data Hazard handling via Stalling and Forwarding.

**_Note:_** Some of the instructions have the same implementation as the ones already implemented (like subu,addu etc), hence they have been eschewed.

**_Structure:_**
- The **RTL** directory contains all the submodules used in designing the processor.
- The **Synth** directory contains the logical netlist of the processor (i.r top).
- The **Viz** directiory contains various schematic views of different phases of the VLSI Flow.
  * RTL_Schem shows the top level hierarchial view (functional).
  * Rest are the snapshots of the final GDS file
 

Sources:
- Digital Design and Computer Architecture
- Computer Architecture and Design
