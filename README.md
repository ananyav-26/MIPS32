This is a Verilog-based implementation of a simplified 32-bit MIPS processor using a classic 5-stage pipeline architecture. The design includes all essential pipeline stages: Fetch, Decode, Execute, Memory, and Writeback, supporting both arithmetic and memory operations.

This project was made to learn the fundamentals of pipelined processor design, and increase proficiency in Verilog.

## Features

-  32-bit data path  
-  32 general-purpose registers  
-  1024-word memory  
-  5-stage pipeline: IF, ID, EX, MEM, WB  
-  Basic instruction set:
  - Arithmetic: `ADD`, `SUB`, `MUL`, `AND`, `OR`, `SLT`
  - Immediate: `ADDI`, `SUBI`, `SLTI`
  - Memory: `LW`, `SW`
  - Branch: `BEQZ`, `BNEQZ`
  - Control: `HLT`
-  Simple branch handling with conditional logic

## 🧩 Pipeline Stages

1. **IF (Instruction Fetch)**  
   - Fetches instruction from memory  
   - Handles PC update logic and branch redirection
2. **ID (Instruction Decode)**  
   - Decodes instruction  
   - Reads registers and generates control signals
3. **EX (Execute)**  
   - Performs ALU operations or computes memory addresses
4. **MEM (Memory Access)**  
   - Loads/stores data from/to memory
5. **WB (Write Back)**  
   - Writes results back to register file
  
## Waveform Output
https://github.com/ananyav-26/MIPS32/blob/main/images/mips_waveform.png
