# VeriRisc Processor (Verilog)

This project is the implementation of a simple RISC processor in Verilog, developed as part of the "Verilog Language and Application" (VLA) academic course from Cadence. The design includes all the essential components of a CPU, such as an Arithmetic Logic Unit (ALU), a Control Unit (FSM), registers, and memory.

The repository also contains three diagnostic programs used to verify the processor's functionality. These tests range from basic instruction validation to running a complete algorithm to calculate the Fibonacci sequence.

## Architecture Overview

The processor is built from the following Verilog modules:

* **`controller.v`**: The Control Unit. This is the processor's brain, implemented as a Finite State Machine (FSM). It receives the instruction `opcode`, the current `phase` (clock cycle state), and the `zero` flag from the ALU. Based on these inputs, it generates all necessary control signals for the datapath, such as `rd` (read), `wr` (write), `ld_pc` (load PC), `ld_ac` (load accumulator), and `halt`.
* **`alu.v`**: The Arithmetic Logic Unit. This unit performs mathematical and logical operations. It implements `ADD`, `AND`, and `XOR`. It also outputs a `a_is_zero` flag, which is used by the controller for conditional instructions.
* **`memory.v`**: A synchronous RAM module. It is used to store both the program instructions and the data it manipulates.
* **`counter.v`**: A generic counter module. This is used as the **Program Counter (PC)**, responsible for pointing to the address of the next instruction to be executed. It supports `load` (for jumps), `enab` (for incrementing), and `rst` (reset).
* **`multiplexor.v`**: A standard 2-to-1 multiplexer, used for selecting data sources within the datapath.
* **`driver.v`**: A tri-state driver. This is essential for managing the shared `data` bus, allowing multiple components (like the ALU and memory) to write to the bus without conflict.

## Implemented Instruction Set

Based on the controller logic and test programs, the processor implements the following 8 instructions:

| Instruction | Opcode (bin) | Description |
| :--- | :--- | :--- |
| **HLT** | `000` | Halts the processor's execution. |
| **SKZ** | `001` | Skips the next instruction if the accumulator is zero. |
| **ADD** | `010` | Adds the value from memory to the accumulator. |
| **AND** | `011` | Performs a bitwise AND between the accumulator and a value from memory. |
| **XOR** | `100` | Performs a bitwise XOR between the accumulator and a value from memory. |
| **LDA** | `101` | Loads a value from memory into the accumulator. |
| **STO** | `110` | Stores the value from the accumulator into memory. |
| **JMP** | `111` | Jumps to a specific memory address. |

## Test Programs

The CPU's functionality is verified using three test programs. The processor loads its program from the `memory.v` module, which would be pre-initialized with one of these programs.

### 1. `CPUtest1.txt`
This is a diagnostic program that tests the basic instruction set.
* **Objective:** To validate `JMP`, `HLT`, `LDA`, `SKZ`, `STO`, and `XOR`.
* **Success Condition:** The processor must halt at the `HLT` instruction at address `0x17`. Halting at any other `HLT` indicates a failure in the preceding instruction.

### 2. `CPUtest2.txt`
This diagnostic tests the "advanced" instruction set.
* **Objective:** To validate `AND` and `ADD` operations, including overflow/wrap-around logic.
* **Success Condition:** The processor must halt at the `HLT` instruction at address `0x10`. Halting at any other location indicates a failure.

### 3. `CPUtest3.txt`
This is a complete application that calculates the Fibonacci number sequence.
* **Objective:** To demonstrate that the processor can execute a real-world algorithm involving loops, memory access (`LDA`, `STO`), and arithmetic (`ADD`).
* **Functionality:** The program uses variables `FN1`, `FN2`, and `TEMP` to iteratively calculate the sequence (0, 1, 1, 2, 3...) until it reaches the `LIMIT` value of 144.

## How to use
**1)** Download all files into a single folder.
**2)** Install the Open Source Verilog compiler Icarus Verilog
**3)** In the folder with the .txt and .v files, open the terminal in your Linux System and execute:
```
iverilog *.v -o testbench.vvp
vvp testbench.vvp 
```
**4)** You must see the message:
```
Testing reset
Testing HLT instruction
Depois TEST HTL:time=4
Depois Clock HTL: time=14
Testing JMP instruction
Depois Testing JMP: time=14
Testing SKZ instruction
time=40
Testing LDA instruction
Testing STO instruction
Testing AND instruction
Testing XOR instruction
Testing ADD instruction
Doing test CPUtest1.txt
Doing test CPUtest2.txt
Doing test CPUtest3.txt
TEST PASSED
risc_test.v:168: $finish called at 2898 (1s)
```
