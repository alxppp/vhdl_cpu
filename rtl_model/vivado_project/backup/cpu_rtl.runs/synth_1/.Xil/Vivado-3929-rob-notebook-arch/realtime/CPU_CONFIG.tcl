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
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "./.Xil/Vivado-3929-rob-notebook-arch/realtime/tmp"
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
      /home/robert/vhdl_cpu/rtl_model/cpu_subprogram_pack.vhd
      /home/robert/vhdl_cpu/rtl_model/cpu_defs_pack.vhd
      /home/robert/vhdl_cpu/rtl_model/logic_unit.vhd
      /home/robert/vhdl_cpu/rtl_model/alu.vhd
      /home/robert/vhdl_cpu/rtl_model/register.vhd
      /home/robert/vhdl_cpu/rtl_model/multiplexer.vhd
      /home/robert/vhdl_cpu/rtl_model/memory.vhd
      /home/robert/vhdl_cpu/rtl_model/instruction_decoder.vhd
      /home/robert/vhdl_cpu/rtl_model/datapath.vhd
      /home/robert/vhdl_cpu/rtl_model/fsm.vhd
      /home/robert/vhdl_cpu/rtl_model/adder_unit.vhd
      /home/robert/vhdl_cpu/rtl_model/adder_subcomponents.vhd
      /home/robert/vhdl_cpu/rtl_model/controller.vhd
      /home/robert/vhdl_cpu/rtl_model/InDevice.vhd
      /home/robert/vhdl_cpu/rtl_model/inc.vhd
      /home/robert/vhdl_cpu/rtl_model/cpu.vhd
      /home/robert/vhdl_cpu/rtl_model/shifter_unit.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top CPU_CONFIG
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
    rt::set_parameter webTalkPath {/home/robert/vhdl_cpu/rtl_model/vivado_project/cpu_rtl.cache/wt}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-3929-rob-notebook-arch/"
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