# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    set ::env(RT_TMP) "C:/vhdl_cpu/rtl_model/vivado_project/cpu_rtl.runs/synth_1/.Xil/Vivado-588-/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7k70tfbv676-1
    source $::env(HRT_TCL_PATH)/rtSynthParallelPrep.tcl

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_vhdl -lib xil_defaultlib {
      C:/vhdl_cpu/rtl_model/cpu_subprogram_pack.vhd
      C:/vhdl_cpu/rtl_model/cpu_defs_pack.vhd
      C:/vhdl_cpu/rtl_model/Test/cpu_textio_pack.vhd
      C:/vhdl_cpu/rtl_model/Test/cpu_memory_pack.vhd
      C:/vhdl_cpu/rtl_model/bootloader_program_pack.vhd
      C:/vhdl_cpu/rtl_model/logic_unit.vhd
      C:/vhdl_cpu/rtl_model/register.vhd
      C:/vhdl_cpu/rtl_model/multiplexer.vhd
      C:/vhdl_cpu/rtl_model/memory.vhd
      C:/vhdl_cpu/rtl_model/instruction_decoder.vhd
      C:/vhdl_cpu/rtl_model/adder_subcomponents.vhd
      C:/vhdl_cpu/rtl_model/adder_unit.vhd
      C:/vhdl_cpu/rtl_model/fsm.vhd
      C:/vhdl_cpu/rtl_model/InDevice.vhd
      C:/vhdl_cpu/rtl_model/inc.vhd
      C:/vhdl_cpu/rtl_model/controller.vhd
      C:/vhdl_cpu/rtl_model/shifter_unit.vhd
      C:/vhdl_cpu/rtl_model/OutDevice.vhd
      C:/vhdl_cpu/rtl_model/Test/cpu_IN_OUT_pack.vhd
      C:/vhdl_cpu/rtl_model/Test/IO_Testbench.vhd
      C:/vhdl_cpu/rtl_model/alu.vhd
      C:/vhdl_cpu/rtl_model/datapath.vhd
      C:/vhdl_cpu/rtl_model/cpu.vhd
      C:/vhdl_cpu/rtl_model/system.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top System
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
    rt::set_parameter webTalkPath {C:/vhdl_cpu/rtl_model/vivado_project/cpu_rtl.cache/wt}
    rt::set_parameter enableSplitFlowPath "C:/vhdl_cpu/rtl_model/vivado_project/cpu_rtl.runs/synth_1/.Xil/Vivado-588-/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
      rt::run_synthesis -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    rt::HARTNDb_reportJobStats "Synthesis Optimization Runtime"
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  if { [info exists rt::helper_shm_key] && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $rt::helper_shm_key
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
