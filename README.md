**_MIPS-32 Processor_**
This is a simple implementation of a single cycle MIPS-32 processor using Verilog and Computer Architecture. MIPS is a subset of the RISC (Reduced Instruction Set Computer).

**_Features_**
- Supports execution of basic R, I and J type instructions
- List of instruction till now:
  *  R-Type: add,sub,and,or
  *  I-type: lw,sw,addi,subi,ori,andi
  *  J-type: beq,j

**_Installation_**
- To install it clone the repository.
- Open the tcl console of a verilog editor (Xilinx Vivado in my case).
- Access the path to your cloned repository and the tcl_script file
- Run source create_project.tcl
// You can use it to remake the project for yourself, simulate it or implement it on an fpga kit.

**_Improvements_**
- Expand the number of executable instructions like jal,bne etc.
- Develop the control system for the latter.
- Develop the mulicycle and pipelined versions of the MIPS-32 processor
