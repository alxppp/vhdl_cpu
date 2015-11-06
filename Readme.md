# VHDL CPU

## Spec
[Link](https://github.com/alxppp/vhdl_cpu/blob/master/spec.pdf)

## Aufteilung Befehle

| OP   | Ersteller | Tester |
|------|-----------|--------|
| LDC  | @alxppp   |        |
| LDD  | @alxppp   |        |
| LDR  | @alxppp   |        |
| STD  | @alxppp   |        |
| STR  | @maxcpu   |        |
| LDPC | @maxcpu   |        |
| STPC | @maxcpu   |        |
| JMP  | @maxcpu   |        |
| JZ   | @RobMa [x] |        |
| JC   | @RobMa [x] |        |
| JN   | @RobMa [x] |        |
| JO   | @RobMa [x] |        |
| JNZ  |@OrestisAlpos|        |
| JNC  |@OrestisAlpos|        |
| JNN  |@OrestisAlpos|        |
| JNO  |@OrestisAlpos|        |
| EXEC_ROL  | @maxcpu
| EXEC_ROLC | @maxcpu
| EXEC_ROR  | @maxcpu
| EXEC_RORC | @maxcpu
| EXEC_SUB  | @RobMa | |    |
| EXEC_SUBC | @RobMa | |    |
| set_flags_logic | @RobMa [x]| |    |
| set_flags_load  | @RobMa [x]| |    |
| EXEC_REA | @OrestisAlpos |	|
| EXEC_REO | @OrestisAlpos |	|
| EXEC_REX | @OrestisAlpos |	|
| EXEC_SLL | @alxppp |	|
| EXEC_SRL | @alxppp |	|
| EXEC_SRA | @alxppp |	|
| Trace_pack | @maxcpu


Hello! just a notice. It would be good if we all write the flag parameters always in the following order: Zero, Carry, Negative, Overflow. 
I think this would be very useful in order to avoid mistakes later when calling the EXEC_functions. Do you agree?
	->Yes, good idea! (@RobMa)
	-> Good idea! changed my procedures (@maxcpu)
	-> Yup, nice! (@alxppp)
