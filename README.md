<p align="center">
  <a>
    <img src="logo.png" alt="Logo" height="100">
  </a>

<h2 align="center">University of Prishtina : Faculty of Electrical and Computer Engineering</h2>
<h3 align="center">Course: Computer Architecture</h3>
<h2 align="center">Project: Single Cycle CPU 16 bit with Verilog</h2>
<p align="left">Professor: Valon Raça</p>
<p align="left">Assistant: Synim Selimi</p>

<p align="left">Student: Edon Gashi</p>


## Project summary

This repository contains a 16-bit single-cycle CPU designed and implemented in Verilog. The CPU architecture is inspired by the MIPS instruction set, with a simplified design suitable for educational purposes and basic operations. The CPU includes:

 - `Register File`: 4 general-purpose registers for storing data.
 - `Data Memory`: A small memory module to store data for computation.
 - `Instruction Memory`: A memory module for fetching instructions.
The CPU supports basic arithmetic and logical operations, including add, subtract, and basic control operations. It executes instructions in a single clock cycle, making it a simple yet effective platform to study CPU design and MIPS-based instruction execution.
<br>

 
 
## Module diagrams

  ### ALU 1 bit diagram
<br>
<p align="center"> ALU 1 bit diagram and functions
  <br>
<a>
    <img src="alu1bit.png" alt="ALU 1 bit" height="430" align="center">
  </a>
  </p>
<br><br>

  ### ALU 16 bit diagram
  <br>
<p align="center"> ALU 16 bit diagram and functions
  <br>
<a>
    <img src="alu16bit.png" alt="ALU 16 bit" height="800" align="center">
  </a>
  </p>
<br><br>

  ### Control unit signals for each instruction.
  <br>
<p align="center"> ALU 16 bit diagram and functions
  </p>
  
| Instruction|Instruction|ALU Operation|ALU Operation|ALU Operation|ALU Operation| .          |Control Unit|Control Unit|Control Unit|Control Unit|Control Unit|Control Unit|Control Unit|Control Unit|
|---------------|------------------|----------------|---------|------|------|------------|--------|---------|-----------|-----------|----------|-----------|--------|--------|
| OPCODE        | Funct            | Bnegate        | Bit1    | Bit2 | Bit3 | OPERATION  | RegDst | ALU Src | Mem toReg | Reg Write | Mem Read | Mem Write | ALU Op | Branch |
| 0000          | 00               | 0              | 0       | 0    | 0    | AND        | 1      | 0       | 0         | 1         | 0        | 0         | 10     | 0      |
| 1011          | xx               | 0              | 0       | 0    | 1    | SLTI       | 0      | 1       | 0         | 1         | 0        | 0         | 11     | 0      |
| 0000          | 01               | 0              | 0       | 1    | 0    | OR         | 1      | 0       | 0         | 1         | 0        | 0         | 10     | 0      |
| 0000          | 10               | 0              | 0       | 1    | 1    | XOR        | 1      | 0       | 0         | 1         | 0        | 0         | 10     | 0      |
| 0001/0001     | 00/01            | 0/1            | 0       | 0    | 0    | ADD/SUB    | 1/1    | 0/0     | 0/0       | 1/1       | 0/0      | 0/0       | 10/10  | 0/0    |
| 1001/1010     | xx               | 0/1            | 0       | 0    | 0    | ADDI/SUBI  | 0/0    | 1/1     | 0/0       | 1/1       | 0/0      | 0/0       | 11/11  | 0/0    |
| 0010          | 00               | 0              | 1       | 0    | 0    | SLL        | 1      | x       | 0         | 1         | 0        | 0         | 10     | 1      |
| 0010          | 01               | 0              | 1       | 0    | 1    | SRA        | 1      | x       | 0         | 1         | 0        | 0         | 10     | 1      |
| 1100          | xx               | 0              | 1       | 0    | 0    | LW         | 0      | 1       | 1         | 1         | 1        | 0         | 00     | 0      |
| 1101          | xx               | 0              | 1       | 0    | 0    | SW         | x      | 1       | 0         | 0         | 0        | 1         | 00     | 0      |
| 1111          | xx               | 1              | 1       | 0    | 0    | BEQ        | 0      | 0       | 0         | 0         | 0        | 0         | 01     | 1      |

<br>
<br>


 ### Data path diagram
<br>
<p align="center"> Data path diagram
  <br>
<a>
    <img src="dataPath.png" alt="Data Path" height="580" align="center">
  </a>
  </p>
<br><br>

 ### CPU diagram
<br>
<p align="center"> CPU diagram
  <br>
<a>
    <img src="cpu.png" alt="CPU" height="430" align="center">
  </a>
  </p>
<br><br>


1. Clone this project:
   ```bash
   git clone https://github.com/EdonFGashi/CPU_16bit_Single_Cycle_with_Verilog.git
<br><br>
   <a href="#top">Return in the top of page ↑</a>
