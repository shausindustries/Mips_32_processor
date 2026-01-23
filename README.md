**_MIPS-32 Processor:_**
MIPS is a subset of the RISC (Reduced Instruction Set Computer) architecture. It is easier to understand and implement as compared to the
x86 architecture which belongs to the CISC (Complex Instruction Set Computer) architectural family.
This repository contains the evolutionary stages a MIPS32 processor.

**_Version 1:_**
- First, an implementation of a very basic single cycle MIPS processor was done using Verilog using Xilinx Vivado.
- Then, the single cycle design was redesigned into a very straightforward 5 stage pipeline.
  1. IF - Instruction Fetch
  2. ID - Instruction Decode
  3. EX - Execution
  4. MEM - Memory
  5. WB - WriteBack

- **_Features:_**
  * 5 stage pipeline to increase efficiency of the processor.
  * Separate data and instruction memory.
  * Execution of R and I type instructions.

- **_Limitations:_**
  * Incomplete design without control unit.
  * Could not execute J - type instructions.
  * Could not handle hazards.
  * Program Counter input priority was not defined.



**_Version 2:_**
- Design upgraded to execute J - type instructions.
- Implemented a control unit for the pipelined processor.
- Pipeline registers were defined explicitly as separate modules.
- The scale of instructions executed was increased.

**_Note:_** Some of the instructions have the same implementation as the ones already implemented (like subu,addu etc), hence they have been eschewed.
  
- **_Features:_**
  * Well defined control unit with a main decoder and ALU decoder.
  * Executes insrtructions like jump.
  * Flexibility in controlling pipeline stages.
  * Prioritized PC input.

- **_Limitations:_**
  * Could not handle data and control hazards.
  * Negligible parallelism.



**_Version 3: (current)_**
- Implemented stall unit, forwarding unit and static branch not taken.
- Switched from Xilinx Vivado to VS Code in Ubuntu 24.04 LTS.
- Introduced Dynamic Branch Prediction.
- Synthesised the RTL design to Logical Design using Yosys and sky130A pdk.

- **_Features:_**
  * Handles Data Hazards via stalling and forwarding.
  * Handles Control Hazards via stalling and branch not taken.
  * Reduces instruction penalty using a Branch History Table.
  * Reliable prediction using a 2-bit Branch Target Buffer.

- **_Limitation:_**
  * Minimum parallelism.
  * Branch delay slot.

- **_Future Improvements:_**
  * Superscalar design.
  * Static and Dynamic Multiple Issue.
  * Deep pipeline.
  * Multicore and Multithread design.

