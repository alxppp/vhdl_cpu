
w
Command: %s
53*	vivadotcl2F
2synth_design -top CPU_CONFIG -part xc7k70tfbv676-12default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7k70t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7k70t2default:defaultZ17-349h px� 
�
%s*synth2�
�Starting Synthesize : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 965.535 ; gain = 134.918 ; free physical = 4610 ; free virtual = 13352
2default:defaulth px� 
�
synthesizing module '%s'638*oasys2

CPU_CONFIG2default:default2=
'/home/robert/vhdl_cpu/rtl_model/cpu.vhd2default:default2
742default:default8@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
datapath2default:default2B
,/home/robert/vhdl_cpu/rtl_model/datapath.vhd2default:default2
242default:default8@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
alu2default:default2=
'/home/robert/vhdl_cpu/rtl_model/alu.vhd2default:default2
112default:default8@Z8-638h px� 
�
synthesizing module '%s'638*oasys2

logic_unit2default:default2D
./home/robert/vhdl_cpu/rtl_model/logic_unit.vhd2default:default2
142default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

logic_unit2default:default2
12default:default2
12default:default2D
./home/robert/vhdl_cpu/rtl_model/logic_unit.vhd2default:default2
142default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2

ADDER_UNIT2default:default2D
./home/robert/vhdl_cpu/rtl_model/adder_unit.vhd2default:default2
122default:default8@Z8-638h px� 
�
synthesizing module '%s'638*oasys2$
RippleCarryAdder2default:default2M
7/home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd2default:default2
562default:default8@Z8-638h px� 
W
%s*synth2?
+	Parameter N bound to: 11 - type: integer 
2default:defaulth px� 
�
synthesizing module '%s'638*oasys2!
FULLADDER_rtl2default:default2M
7/home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd2default:default2
222default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2!
FULLADDER_rtl2default:default2
22default:default2
12default:default2M
7/home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd2default:default2
222default:default8@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2$
RippleCarryAdder2default:default2
32default:default2
12default:default2M
7/home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd2default:default2
562default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	HALFADDER2default:default2M
7/home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd2default:default2
62default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	HALFADDER2default:default2
42default:default2
12default:default2M
7/home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd2default:default2
62default:default8@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

ADDER_UNIT2default:default2
52default:default2
12default:default2D
./home/robert/vhdl_cpu/rtl_model/adder_unit.vhd2default:default2
122default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2 
SHIFTER_UNIT2default:default2F
0/home/robert/vhdl_cpu/rtl_model/shifter_unit.vhd2default:default2
122default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2 
SHIFTER_UNIT2default:default2
62default:default2
12default:default2F
0/home/robert/vhdl_cpu/rtl_model/shifter_unit.vhd2default:default2
122default:default8@Z8-256h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
FLAGS_SU2default:default2=
'/home/robert/vhdl_cpu/rtl_model/alu.vhd2default:default2
332default:default8@Z8-614h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2
RES_SU2default:default2=
'/home/robert/vhdl_cpu/rtl_model/alu.vhd2default:default2
332default:default8@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
alu2default:default2
72default:default2
12default:default2=
'/home/robert/vhdl_cpu/rtl_model/alu.vhd2default:default2
112default:default8@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
datapath2default:default2
82default:default2
12default:default2B
,/home/robert/vhdl_cpu/rtl_model/datapath.vhd2default:default2
242default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2

CONTROLLER2default:default2D
./home/robert/vhdl_cpu/rtl_model/controller.vhd2default:default2
292default:default8@Z8-638h px� 
�
synthesizing module '%s'638*oasys2'
instruction_decoder2default:default2M
7/home/robert/vhdl_cpu/rtl_model/instruction_decoder.vhd2default:default2
292default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2'
instruction_decoder2default:default2
92default:default2
12default:default2M
7/home/robert/vhdl_cpu/rtl_model/instruction_decoder.vhd2default:default2
292default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
FSM2default:default2=
'/home/robert/vhdl_cpu/rtl_model/fsm.vhd2default:default2
312default:default8@Z8-638h px� 
�
&ignoring unsynthesizable construct: %s312*oasys2'
assertion statement2default:default2=
'/home/robert/vhdl_cpu/rtl_model/fsm.vhd2default:default2
762default:default8@Z8-312h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
FSM2default:default2
102default:default2
12default:default2=
'/home/robert/vhdl_cpu/rtl_model/fsm.vhd2default:default2
312default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	D_REG12RE2default:default2B
,/home/robert/vhdl_cpu/rtl_model/register.vhd2default:default2
112default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	D_REG12RE2default:default2
112default:default2
12default:default2B
,/home/robert/vhdl_cpu/rtl_model/register.vhd2default:default2
112default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
INC2default:default2=
'/home/robert/vhdl_cpu/rtl_model/inc.vhd2default:default2
72default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
INC2default:default2
122default:default2
12default:default2=
'/home/robert/vhdl_cpu/rtl_model/inc.vhd2default:default2
72default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	mux12_2x12default:default2E
//home/robert/vhdl_cpu/rtl_model/multiplexer.vhd2default:default2
102default:default8@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	mux12_2x12default:default2
132default:default2
12default:default2E
//home/robert/vhdl_cpu/rtl_model/multiplexer.vhd2default:default2
102default:default8@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	mux12_4x12default:default2E
//home/robert/vhdl_cpu/rtl_model/multiplexer.vhd2default:default2
342default:default8@Z8-638h px� 
�
Esignal '%s' is read in the process but is not in the sensitivity list614*oasys2 
select_input2default:default2E
//home/robert/vhdl_cpu/rtl_model/multiplexer.vhd2default:default2
362default:default8@Z8-614h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	mux12_4x12default:default2
142default:default2
12default:default2E
//home/robert/vhdl_cpu/rtl_model/multiplexer.vhd2default:default2
342default:default8@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

CONTROLLER2default:default2
152default:default2
12default:default2D
./home/robert/vhdl_cpu/rtl_model/controller.vhd2default:default2
292default:default8@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

CPU_CONFIG2default:default2
162default:default2
12default:default2=
'/home/robert/vhdl_cpu/rtl_model/cpu.vhd2default:default2
742default:default8@Z8-256h px� 
�
%s*synth2�
�Finished Synthesize : Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 1005.918 ; gain = 175.301 ; free physical = 4567 ; free virtual = 13309
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
�
%s*synth2�
�Finished Constraint Validation : Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 1005.918 ; gain = 175.301 ; free physical = 4567 ; free virtual = 13309
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
V
%s*synth2>
*Start Loading Part and Timing Information
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
J
%s*synth22
Loading part: xc7k70tfbv676-1
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 1013.918 ; gain = 183.301 ; free physical = 4567 ; free virtual = 13309
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
V
Loading part %s157*device2#
xc7k70tfbv676-12default:defaultZ21-403h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

REG_reg[0]2default:default2
22default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

REG_reg[1]2default:default2
22default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

REG_reg[2]2default:default2
22default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

REG_reg[3]2default:default2
22default:default2
52default:defaultZ8-5544h px� 
u
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
STORE2default:defaultZ8-5546h px� 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
CMD_CALC2default:defaultZ8-5546h px� 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	CMD_CONST2default:defaultZ8-5546h px� 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
CMD_DIR2default:defaultZ8-5546h px� 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
CMD_REG2default:defaultZ8-5546h px� 
v
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
CMD_IO2default:defaultZ8-5546h px� 
v
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
CMD_PC2default:defaultZ8-5546h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2
CMD_JMP2default:defaultZ8-5587h px� 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
CMD_STOP2default:defaultZ8-5546h px� 
�
6No Re-encoding of one hot register '%s' in module '%s'3445*oasys2
s_STATE_reg2default:default2
FSM2default:defaultZ8-3898h px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1038.945 ; gain = 208.328 ; free physical = 4547 ; free virtual = 13289
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
E
%s*synth2-

Report RTL Partitions: 
2default:defaulth px� 
W
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px� 
W
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px� 
W
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px� 
W
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
L
%s*synth24
 Start RTL Component Statistics 
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit         XORs := 2     
2default:defaulth px� 
Z
%s*synth2B
.	  12 Input      1 Bit         XORs := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   3 Input      1 Bit         XORs := 11    
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit         XORs := 19    
2default:defaulth px� 
=
%s*synth2%
+---Registers : 
2default:defaulth px� 
Z
%s*synth2B
.	               12 Bit    Registers := 7     
2default:defaulth px� 
Z
%s*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth px� 
Z
%s*synth2B
.	                4 Bit    Registers := 1     
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit        Muxes := 7     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input     12 Bit        Muxes := 5     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input      5 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   6 Input      5 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      4 Bit        Muxes := 2     
2default:defaulth px� 
Z
%s*synth2B
.	   8 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      3 Bit        Muxes := 5     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input      2 Bit        Muxes := 2     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit        Muxes := 4     
2default:defaulth px� 
Z
%s*synth2B
.	  21 Input      1 Bit        Muxes := 9     
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
O
%s*synth27
#Finished RTL Component Statistics 
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
Y
%s*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
O
%s*synth27
#Hierarchical RTL Component report 
2default:defaulth px� 
?
%s*synth2'
Module logic_unit 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit         XORs := 1     
2default:defaulth px� 
Z
%s*synth2B
.	  12 Input      1 Bit         XORs := 1     
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth px� 
B
%s*synth2*
Module FULLADDER_rtl 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   3 Input      1 Bit         XORs := 1     
2default:defaulth px� 
>
%s*synth2&
Module HALFADDER 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit         XORs := 1     
2default:defaulth px� 
?
%s*synth2'
Module ADDER_UNIT 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit         XORs := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit         XORs := 4     
2default:defaulth px� 
A
%s*synth2)
Module SHIFTER_UNIT 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit         XORs := 1     
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   8 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
8
%s*synth2 
Module alu 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input     12 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input      2 Bit        Muxes := 2     
2default:defaulth px� 
=
%s*synth2%
Module datapath 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
=
%s*synth2%
+---Registers : 
2default:defaulth px� 
Z
%s*synth2B
.	               12 Bit    Registers := 4     
2default:defaulth px� 
Z
%s*synth2B
.	                4 Bit    Registers := 1     
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit        Muxes := 2     
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input     12 Bit        Muxes := 3     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      4 Bit        Muxes := 2     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      3 Bit        Muxes := 2     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit        Muxes := 4     
2default:defaulth px� 
H
%s*synth20
Module instruction_decoder 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	  21 Input      1 Bit        Muxes := 9     
2default:defaulth px� 
8
%s*synth2 
Module FSM 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
=
%s*synth2%
+---Registers : 
2default:defaulth px� 
Z
%s*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input      5 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   6 Input      5 Bit        Muxes := 1     
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth px� 
>
%s*synth2&
Module D_REG12RE 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
=
%s*synth2%
+---Registers : 
2default:defaulth px� 
Z
%s*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth px� 
8
%s*synth2 
Module INC 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
8
%s*synth2 
+---XORs : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input      1 Bit         XORs := 12    
2default:defaulth px� 
>
%s*synth2&
Module mux12_2x1 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth px� 
>
%s*synth2&
Module mux12_4x1 
2default:defaulth px� 
K
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px� 
9
%s*synth2!
+---Muxes : 
2default:defaulth px� 
Z
%s*synth2B
.	   4 Input     12 Bit        Muxes := 1     
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
[
%s*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
H
%s*synth20
Start Part Resource Summary
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 