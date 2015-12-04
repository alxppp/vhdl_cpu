# VHDL CPU

## Spec
[Link](https://github.com/alxppp/vhdl_cpu/blob/master/spec.pdf)

### We're almost done!
*What is still left to do until Friday? (Feel free to add stuff, sorted by highest priority)*
- [ ] Again study testbenches and trace files. Especially compare Flag behaviour with specification! @RobMa @alxpp @maxcpu @OrestisAlpos
- [ ] Put together all-in-one test @alxppp (include assembler) & @RobMa
- [ ] Memory Dump seems to work, but some additional tests would be nice @???
- [ ] Documentation: add comments describing the creator of code/functions... @???
- [ ] Tidy up the code @???

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
| Adder | @maxcpu   |
| IO Devices | @OrestisAlpos   |

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
| NOP	| @RobMa [x]|
| STOP	| @RobMa [x]|
| ADD	| @maxcpu |
| ADDC	| @maxcpu |
| SUB	| @OrestisAlpos [x]|
| SUBC	| @OrestisAlpos [x]|
| NOT	| @alxppp |
| AND	| @alxppp |
| OR	| @alxppp |
| XOR	| @alxppp |
| REA	| @RobMa [x]|
| REO	| @RobMa [x]|
| REX	| @RobMa [x]|
| SLL	| @maxcpu |
| SRL	| @maxcpu |
| SRA	| @maxcpu |
| ROL	| @RobMa [x]|
| ROLC	| @RobMa [x]|
| ROR	| @RobMa [x]|
| RORC	| @RobMa [x]|
| LDC	| @OrestisAlpos [x]|
| LDD	| @OrestisAlpos [x]|
| LDR	| @OrestisAlpos [x]|
| STD	| @OrestisAlpos [x]|
| STR	| @OrestisAlpos [x]|
| IN	| @maxcpu |
| OUT	| @maxcpu |
| LDPC	| @alxppp |
| STPC	| @alxppp |
| JMP	| @alxppp |
| JZ	| @alxppp |
| JC	| @alxppp |
| JN	| @OrestisAlpos [x]|
| JO	| @OrestisAlpos [x]|
| JNZ	| @maxcpu |
| JNC	| @maxcpu |
| JNN	| @maxcpu |
| JNO	| @RobMa [x]|

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
