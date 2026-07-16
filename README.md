# Tiny Processor in Verilog

An 8-bit accumulator-based processor designed and implemented in **Verilog HDL** using **Xilinx Vivado** as part of a digital design course project.

The processor executes a custom instruction set and demonstrates the fundamental concepts of processor design, including instruction fetch, decode, execution, arithmetic and logical operations, memory access, and program control.

---

## Features

- 8-bit accumulator-based architecture
- 16 General Purpose Registers (GPRs)
- 8-bit instruction format
- Custom Instruction Set Architecture (ISA)
- Arithmetic, logical, data transfer, and branching instructions
- Behavioural implementation in Verilog HDL
- Functional verification using a Verilog testbench

---

## Processor Architecture

The processor consists of the following components:

- Program Counter (PC)
- Instruction Memory
- Register File (16 × 8-bit registers)
- Accumulator (ACC)
- ALU
- Carry Flag
- Instruction Decoder
- Control Logic

The processor follows the standard instruction cycle:

```
Fetch → Decode → Execute → Update PC
```

---

## Instruction Set

| Category | Instructions |
|----------|--------------|
| Data Transfer | LDA, STA |
| Arithmetic | ADD, SUB, MUL |
| Logical | AND, XOR |
| Compare | CMP |
| Control Flow | JMP, BR |
| Miscellaneous | NOP, INC, DEC, LSL, LSR, CIR, CIL, ASR, HLT |

---

## Repository Structure

```
Tiny-Processor/
│
├── src/
│   └── tiny_processor.v
│
├── sim/
│   └── tiny_processor_tb.v
│
├── vivado/
│   └── Vivado project files
│
└── README.md
```

---

## Simulation

The processor was verified using a Verilog testbench that initializes the instruction memory and register file before executing a sample program.

The testbench demonstrates:

- Instruction execution
- Register operations
- Arithmetic and logical operations
- Branch instructions
- Program termination using the `HLT` instruction

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Behavioural Simulation

---

## Learning Outcomes

Through this project, I gained hands-on experience with:

- Digital system design using Verilog HDL
- Processor architecture fundamentals
- Instruction set design
- Register-transfer level (RTL) design
- Sequential logic and finite state execution
- Functional verification using testbenches

---

## Future Improvements

- Modularize the processor into separate RTL blocks (ALU, Register File, Control Unit, Program Counter)
- Add data memory support
- Expand the instruction set
- Develop a simple assembler for the custom ISA
- Implement a pipelined version of the processor

---

## Author
**Yash Sonone**
B.Tech–M.Tech (Electrical Engineering)  
Indian Institute of Technology Gandhinagar
