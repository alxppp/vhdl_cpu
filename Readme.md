# VHDL CPU

## How to run/test the rtl model
There are two possibilities to run testbench hex programs on the rtl-model.
### Fast&Simple way (By Max)
Simulate the system_behavioural architecure, it loads the Memory.hex file in the same directory and works just like 
in functional model

### Using the Bootloader (By Robert)
Simulate the system_bootloader architecture.
This System uses a bootloader to load the program/testbench hex-file into the memory
Use the python3 script memory_generate.py [path-to-testbench.hex] in the rtl_model directory 
to generate the Memory.hex file which is then loaded using the IO-Device.
The bootloader needs 530,045ns to load, when it's done it jumps to Mem(0) and starts the loaded program.

## Spec
[Link](https://github.com/alxppp/vhdl_cpu/blob/master/spec.pdf)

## Aufteilung Befehle

### RTL

| Task   | Ersteller |
|------|-----------|
| Memory  | @alxppp   |
| Register  | @alxppp   |
| Muxes  | @alxppp   |
| Simple shift  | @alxppp   |
| FSM  | @RobMa   |
| OP decode | @maxcpu   |
| Adder | @RobMa   |
| Out Device | @OrestisAlpos   |
| In Device  | @maxcpu  |

### Implementierung

| OP   | Ersteller |
|------|-----------|
| LDC  | @alxppp   |
| LDD  | @alxppp   |
| LDR  | @alxppp   |
| STD  | @alxppp   |
| STR  | @maxcpu   |
| LDPC | @maxcpu   |
| STPC | @maxcpu   |
| JMP  | @maxcpu   |
| JZ   | @RobMa [x] |
| JC   | @RobMa [x] |
| JN   | @RobMa [x] |
| JO   | @RobMa [x] |
| JNZ  |@OrestisAlpos[x]|
| JNC  |@OrestisAlpos[x]|
| JNN  |@OrestisAlpos[x]|
| JNO  |@OrestisAlpos[x]|
| EXEC_ROL  | @maxcpu |
| EXEC_ROLC | @maxcpu |
| EXEC_ROR  | @maxcpu |
| EXEC_RORC | @maxcpu |
| EXEC_SUB  | @RobMa |
| EXEC_SUBC | @RobMa |
| set_flags_logic | @RobMa [x]|
| set_flags_load  | @RobMa [x]|
| EXEC_REA | @OrestisAlpos [x]|
| EXEC_REO | @OrestisAlpos [x]|
| EXEC_REX | @OrestisAlpos [x]|
| EXEC_SLL | @alxppp |
| EXEC_SRL | @alxppp |
| EXEC_SRA | @alxppp |
| IN | @OrestisAlpos |
| OUT | @OrestisAlpos |
| Trace_pack | @maxcpu |
| init_memory | @RobMa |

### Test

| OP	| Tester |
|-------|--------|
| NOP	| @RobMa [xx]|
| STOP	| @RobMa [xx]|
| ADD	| @maxcpu [x]|
| ADDC	| @maxcpu [x]|
| SUB	| @OrestisAlpos [x]|
| SUBC	| @OrestisAlpos [x]|
| NOT	| @alxppp |
| AND	| @alxppp |
| OR	| @alxppp |
| XOR	| @alxppp |
| REA	| @RobMa [x][x]|
| REO	| @RobMa [x][x]|
| REX	| @RobMa [x][x]|
| SLL	| @maxcpu [x]|
| SRL	| @maxcpu [x]|
| SRA	| @maxcpu [x]|
| ROL	| @RobMa [x][x]|
| ROLC	| @RobMa [x][x]|
| ROR	| @RobMa [x][x]|
| RORC	| @RobMa [x][x]|
| LDC	| @OrestisAlpos [x]|
| LDD	| @OrestisAlpos [x]|
| LDR	| @OrestisAlpos [x]|
| STD	| @OrestisAlpos [x]|
| STR	| @OrestisAlpos [x]|
| IN	| @maxcpu [x]|
| OUT	| @maxcpu [x]|
| LDPC	| @alxppp |
| STPC	| @alxppp |
| JMP	| @alxppp |
| JZ	| @alxppp |
| JC	| @alxppp |
| JN	| @OrestisAlpos [x]|
| JO	| @OrestisAlpos [x]|
| JNZ	| @maxcpu [x]|
| JNC	| @maxcpu [x]|
| JNN	| @maxcpu [x]|
| JNO	| @RobMa [x][x]|

## Assembler documentation

### Usage
`maxcpu_asm [-o outfile] [options] filename`

maxcpu_asm reads assembly code from stdin and writes the resulting op code to stdout. You can redirect the output to a file with the -o option. Run `maxcpu_asm -h` for help.

### Installation
* **UNIX machines**

  Run `./maxcpu_asm`.

* **Windows**

  There are two ways to run the assembler on Windows.
  1. The easy way is to run `maxcpu_asm.exe` from the command line.
     Example to assemble sample_program.asm:
     ```
       cd C:\vhdl_cpu\assembler\
       .\maxcpu_asm.exe sample_program.asm
     ```

  2. The other way is to install the Ruby interpreter and run the program with `ruby maxcpu_asm`. This option allows you to modify the source code.
