**_MIPS-32 Processor:_**
MIPS is a subset of the RISC (Reduced Instruction Set Computer) architecture. It is easier to understand and implement as compared to the
x86 architecture which belongs to the CISC (Complex Instruction Set Computer) architectural family.
This is a simple implementation of a single cycle MIPS-32 (i.e 32-bit) processor using Verilog and Computer Architecture. 
In the schematic.pdf, you can see the updated RTL Design of the processor.

**_Features:_**
- Supports execution of basic R, I and J type instructions
- List of instruction till now:
  *  R-Type: add,sub,and,or,xor,mul
  *  I-type: lw,sw,addi,subi,ori,andi,addiu
  *  J-type: beq,j,bne

**_Installation:_**
- To install it clone the repository.
- Open the tcl console of a verilog editor (Xilinx Vivado in my case).
- Access the path to your cloned repository and the tcl_script file
- Run source create_project.tcl
// You can use it to remake the project for yourself, simulate it or implement it on an fpga kit.

**_Improvements:_**
- Expand the number of executable instructions like jal,bne etc.
- Develop the control system for the latter.
- Develop a pipelined version of the MIPS-32 processor.
- Hazard handling.
