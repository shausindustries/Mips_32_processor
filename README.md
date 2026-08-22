# 32-Bit Pipelined & Out-of-Order Processor Architecture

![HDL](https://img.shields.io/badge/HDL-Verilog%20%7C%20SystemVerilog-blue)
![PDK](https://img.shields.io/badge/PDK-SkyWater%20130nm-green)
![Simulation](https://img.shields.io/badge/Simulation-Icarus%20Verilog%20%7C%20GTKWave-orange)
![Synthesis](https://img.shields.io/badge/Synthesis-Yosys%20Open%20Flow-purple)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

A modular, synthesizable 32-bit processor core demonstrating progressive microarchitectural evolution: from a single-cycle baseline to a 5-stage hazard-resolved pipelined datapath, dynamic branch prediction, and an Out-of-Order execution engine based on the Tomasulo algorithm.

---

## 🏛️ Microarchitectural Progression

The processor architecture is structured into five evolutionary stages:
V1: Single-Cycle Baseline Datapath
V2: 5-Stage In-Order Pipelined Datapath (IF -> ID -> EX -> MEM -> WB)
V3: Integrated Control Unit, Explicit Pipeline Registers, & J-Type Decoding
V4: Data Forwarding, Hazard Stalls, & 2-Bit Dynamic Branch Prediction (BHT/BTB)
V5: Out-of-Order Engine (Instruction Queue, Reservation Stations, ROB, CDB)


---

## 🏗️ 5-Stage Pipelined Datapath (In-Order Core)
## 🏗️ 5-Stage Pipelined Datapath (In-Order Core)

## 🏗️ 5-Stage Pipelined Datapath (In-Order Core)

```mermaid
graph LR
    subgraph IF ["1. Instruction Fetch (IF)"]
        PC["Program Counter"] --> IMEM["Instruction Memory"]
        BHT["2-Bit BHT / BTB"] -.-> PC
    end

    subgraph ID ["2. Instruction Decode (ID)"]
        IMEM --> IF_ID["IF/ID Register"]
        IF_ID --> CTRL["Main & ALU Decoder"]
        IF_ID --> RF["32x32 Register File"]
    end

    subgraph EX ["3. Execution (EX)"]
        CTRL --> ID_EX["ID/EX Register"]
        RF --> ID_EX
        ID_EX --> FWD["Hazard & Forwarding Unit"]
        FWD --> ALU["32-bit Arithmetic Unit"]
        ALU --> BR_EVAL["Branch Resolution Unit"]
    end

    subgraph MEM ["4. Memory Access (MEM)"]
        ALU --> EX_MEM["EX/MEM Register"]
        EX_MEM --> DMEM["Data Memory"]
    end

    subgraph WB ["5. Write-Back (WB)"]
        DMEM --> MEM_WB["MEM/WB Register"]
        EX_MEM --> MEM_WB
        MEM_WB --> RF
    end

⚡ Dynamic Branch Prediction & Hazard Resolution (V4)
Data Hazard Resolution:
EX -> EX Forwarding: Feeds ALU result directly to the next instruction's ALU input.
MEM -> EX Forwarding: Feeds memory load or delayed ALU result to the execute stage.
Load-Use Interlock: Automatic single-cycle stall inserted when a load instruction is followed immediately by a dependent instruction.
Control Hazard Resolution:
Branch History Table (BHT): 2-bit saturating counter state machine (Strongly Not Taken 
↔
↔ Weakly Not Taken 
↔
↔ Weakly Taken 
↔
↔ Strongly Taken).
Branch Target Buffer (BTB): Caches target branch addresses to fetch target instructions with zero bubble penalty on branch predictions.
Mispredict Recovery: Flushes speculative instructions in IF/ID and restores correct sequential PC.
