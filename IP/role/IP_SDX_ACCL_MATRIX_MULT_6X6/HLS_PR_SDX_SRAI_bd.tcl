
################################################################
# This is a generated script based on design: HLS_PR_SDX_SRAI
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source HLS_PR_SDX_SRAI_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu9p-fsgd2104-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name HLS_PR_SDX_SRAI

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir .

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_register_slice:2.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:ddr4:2.2\
xilinx.com:ip:axi_clock_converter:2.1\
xilinx.com:hls:sdx_cppKernel_top:1.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: HLS_ip
proc create_hier_cell_HLS_ip { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_HLS_ip() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  # Create pins
  create_bd_pin -dir I -type rst ARESETN_125M
  create_bd_pin -dir I -type rst ARESETN_250M
  create_bd_pin -dir I -type rst AXI_RESET_N
  create_bd_pin -dir I -type clk CLK_125M
  create_bd_pin -dir I -type clk CLK_250M
  create_bd_pin -dir I -type clk HLS_ip_clk

  # Create instance: axi_clock_converter_0, and set properties
  set axi_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_0 ]

  # Create instance: axi_clock_converter_1, and set properties
  set axi_clock_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_1 ]

  # Create instance: proc_sys_reset_PROG, and set properties
  set proc_sys_reset_PROG [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_PROG ]

  # Create instance: sdx_cppKernel_top_0, and set properties
  set sdx_cppKernel_top_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:sdx_cppKernel_top:1.0 sdx_cppKernel_top_0 ]

  set_property -dict [ list \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.MAX_BURST_LENGTH {1} \
 ] [get_bd_intf_pins /HLS_ip/sdx_cppKernel_top_0/s_axi_control]

  # Create interface connections
  connect_bd_intf_net -intf_net AXI_LITE_3Stage_reg_M_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_clock_converter_0/S_AXI]
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins sdx_cppKernel_top_0/s_axi_control]
  connect_bd_intf_net -intf_net axi_clock_converter_1_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_clock_converter_1/M_AXI]
  connect_bd_intf_net -intf_net sdx_cppKernel_top_0_m_axi_gmem [get_bd_intf_pins axi_clock_converter_1/S_AXI] [get_bd_intf_pins sdx_cppKernel_top_0/m_axi_gmem]

  # Create port connections
  connect_bd_net -net AXI_RESET_N_1 [get_bd_pins AXI_RESET_N] [get_bd_pins proc_sys_reset_PROG/ext_reset_in]
  connect_bd_net -net CLK_IN_125M_1 [get_bd_pins CLK_125M] [get_bd_pins axi_clock_converter_0/s_axi_aclk]
  connect_bd_net -net CLK_IN_250_1 [get_bd_pins CLK_250M] [get_bd_pins axi_clock_converter_1/m_axi_aclk]
  connect_bd_net -net m_axi_aclk_1 [get_bd_pins HLS_ip_clk] [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins axi_clock_converter_1/s_axi_aclk] [get_bd_pins proc_sys_reset_PROG/slowest_sync_clk] [get_bd_pins sdx_cppKernel_top_0/ap_clk]
  connect_bd_net -net m_axi_aresetn_1 [get_bd_pins axi_clock_converter_0/m_axi_aresetn] [get_bd_pins axi_clock_converter_1/s_axi_aresetn] [get_bd_pins proc_sys_reset_PROG/peripheral_aresetn] [get_bd_pins sdx_cppKernel_top_0/ap_rst_n]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins ARESETN_125M] [get_bd_pins axi_clock_converter_0/s_axi_aresetn]
  connect_bd_net -net proc_sys_reset_250_peripheral_aresetn [get_bd_pins ARESETN_250M] [get_bd_pins axi_clock_converter_1/m_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: DDR_SUB_SYS
proc create_hier_cell_DDR_SUB_SYS { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_DDR_SUB_SYS() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 C0_DDR4_S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 C0_DDR4_S_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 C0_DDR4_S_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 C0_DDR4_S_AXI_CTRL
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 C0_DDR4_S_AXI_CTRL1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 C0_DDR4_S_AXI_CTRL2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C0_SYS_CLK
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C2_SYS_CLK
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C3_SYS_CLK
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c2_ddr4
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c3_ddr4

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst c0_ddr4_aresetn
  create_bd_pin -dir O -from 0 -to 0 -type rst c0_ddr4_aresetn1
  create_bd_pin -dir O -type clk c0_ddr4_ui_clk
  create_bd_pin -dir O -type clk c0_ddr4_ui_clk1
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn
  create_bd_pin -dir O -type clk slowest_sync_clk
  create_bd_pin -dir I -type rst sys_rst_ddr_0
  create_bd_pin -dir I -type rst sys_rst_ddr_2
  create_bd_pin -dir I -type rst sys_rst_ddr_3

  # Create instance: ddr4_0, and set properties
  set ddr4_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {250} \
   CONFIG.C0.BANK_GROUP_WIDTH {2} \
   CONFIG.C0.CKE_WIDTH {1} \
   CONFIG.C0.CS_WIDTH {1} \
   CONFIG.C0.DDR4_AxiAddressWidth {34} \
   CONFIG.C0.DDR4_AxiDataWidth {512} \
   CONFIG.C0.DDR4_CLKFBOUT_MULT {5} \
   CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5} \
   CONFIG.C0.DDR4_CasLatency {17} \
   CONFIG.C0.DDR4_CasWriteLatency {12} \
   CONFIG.C0.DDR4_DIVCLK_DIVIDE {1} \
   CONFIG.C0.DDR4_DataMask {NONE} \
   CONFIG.C0.DDR4_DataWidth {72} \
   CONFIG.C0.DDR4_Ecc {true} \
   CONFIG.C0.DDR4_InputClockPeriod {3332} \
   CONFIG.C0.DDR4_MemoryPart {MTA18ASF2G72PZ-2G3} \
   CONFIG.C0.DDR4_MemoryType {RDIMMs} \
   CONFIG.C0.DDR4_TimePeriod {833} \
   CONFIG.C0.ODT_WIDTH {1} \
 ] $ddr4_0

  # Create instance: ddr4_2, and set properties
  set ddr4_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_2 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {250} \
   CONFIG.C0.BANK_GROUP_WIDTH {2} \
   CONFIG.C0.CKE_WIDTH {1} \
   CONFIG.C0.CS_WIDTH {1} \
   CONFIG.C0.DDR4_AxiAddressWidth {34} \
   CONFIG.C0.DDR4_AxiDataWidth {512} \
   CONFIG.C0.DDR4_CLKFBOUT_MULT {5} \
   CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5} \
   CONFIG.C0.DDR4_CasLatency {17} \
   CONFIG.C0.DDR4_CasWriteLatency {12} \
   CONFIG.C0.DDR4_DIVCLK_DIVIDE {1} \
   CONFIG.C0.DDR4_DataMask {NONE} \
   CONFIG.C0.DDR4_DataWidth {72} \
   CONFIG.C0.DDR4_Ecc {true} \
   CONFIG.C0.DDR4_InputClockPeriod {3332} \
   CONFIG.C0.DDR4_MemoryPart {MTA18ASF2G72PZ-2G3} \
   CONFIG.C0.DDR4_MemoryType {RDIMMs} \
   CONFIG.C0.DDR4_TimePeriod {833} \
   CONFIG.C0.ODT_WIDTH {1} \
 ] $ddr4_2

  # Create instance: ddr4_3, and set properties
  set ddr4_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_3 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {250} \
   CONFIG.C0.BANK_GROUP_WIDTH {2} \
   CONFIG.C0.CKE_WIDTH {1} \
   CONFIG.C0.CS_WIDTH {1} \
   CONFIG.C0.DDR4_AxiAddressWidth {34} \
   CONFIG.C0.DDR4_AxiDataWidth {512} \
   CONFIG.C0.DDR4_CLKFBOUT_MULT {5} \
   CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5} \
   CONFIG.C0.DDR4_CasLatency {17} \
   CONFIG.C0.DDR4_CasWriteLatency {12} \
   CONFIG.C0.DDR4_DIVCLK_DIVIDE {1} \
   CONFIG.C0.DDR4_DataMask {NONE} \
   CONFIG.C0.DDR4_DataWidth {72} \
   CONFIG.C0.DDR4_Ecc {true} \
   CONFIG.C0.DDR4_InputClockPeriod {3332} \
   CONFIG.C0.DDR4_MemoryPart {MTA18ASF2G72PZ-2G3} \
   CONFIG.C0.DDR4_MemoryType {RDIMMs} \
   CONFIG.C0.DDR4_TimePeriod {833} \
   CONFIG.C0.ODT_WIDTH {1} \
 ] $ddr4_3

  # Create instance: proc_sys_reset_MIG_A, and set properties
  set proc_sys_reset_MIG_A [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_MIG_A ]

  # Create instance: proc_sys_reset_MIG_B, and set properties
  set proc_sys_reset_MIG_B [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_MIG_B ]

  # Create instance: proc_sys_reset_MIG_D, and set properties
  set proc_sys_reset_MIG_D [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_MIG_D ]

  # Create interface connections
  connect_bd_intf_net -intf_net C0_SYS_CLK_0_1 [get_bd_intf_pins C2_SYS_CLK] [get_bd_intf_pins ddr4_2/C0_SYS_CLK]
  connect_bd_intf_net -intf_net C0_SYS_CLK_1_1 [get_bd_intf_pins C0_SYS_CLK] [get_bd_intf_pins ddr4_0/C0_SYS_CLK]
  connect_bd_intf_net -intf_net C0_SYS_CLK_2_1 [get_bd_intf_pins C3_SYS_CLK] [get_bd_intf_pins ddr4_3/C0_SYS_CLK]
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins C0_DDR4_S_AXI_CTRL] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI_CTRL]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins C0_DDR4_S_AXI_CTRL1] [get_bd_intf_pins ddr4_2/C0_DDR4_S_AXI_CTRL]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins C0_DDR4_S_AXI_CTRL2] [get_bd_intf_pins ddr4_3/C0_DDR4_S_AXI_CTRL]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins C0_DDR4_S_AXI] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins C0_DDR4_S_AXI1] [get_bd_intf_pins ddr4_2/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins C0_DDR4_S_AXI2] [get_bd_intf_pins ddr4_3/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_pins c0_ddr4] [get_bd_intf_pins ddr4_0/C0_DDR4]
  connect_bd_intf_net -intf_net ddr4_2_C0_DDR4 [get_bd_intf_pins c2_ddr4] [get_bd_intf_pins ddr4_2/C0_DDR4]
  connect_bd_intf_net -intf_net ddr4_3_C0_DDR4 [get_bd_intf_pins c3_ddr4] [get_bd_intf_pins ddr4_3/C0_DDR4]

  # Create port connections
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk [get_bd_pins c0_ddr4_ui_clk] [get_bd_pins ddr4_0/c0_ddr4_ui_clk] [get_bd_pins proc_sys_reset_MIG_A/slowest_sync_clk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_0/c0_ddr4_ui_clk_sync_rst] [get_bd_pins proc_sys_reset_MIG_A/ext_reset_in]
  connect_bd_net -net ddr4_2_c0_ddr4_ui_clk [get_bd_pins c0_ddr4_ui_clk1] [get_bd_pins ddr4_2/c0_ddr4_ui_clk] [get_bd_pins proc_sys_reset_MIG_B/slowest_sync_clk]
  connect_bd_net -net ddr4_2_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_2/c0_ddr4_ui_clk_sync_rst] [get_bd_pins proc_sys_reset_MIG_B/ext_reset_in]
  connect_bd_net -net ddr4_3_c0_ddr4_ui_clk [get_bd_pins slowest_sync_clk] [get_bd_pins ddr4_3/c0_ddr4_ui_clk] [get_bd_pins proc_sys_reset_MIG_D/slowest_sync_clk]
  connect_bd_net -net ddr4_3_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_3/c0_ddr4_ui_clk_sync_rst] [get_bd_pins proc_sys_reset_MIG_D/ext_reset_in]
  connect_bd_net -net proc_sys_reset_MIG_A_peripheral_aresetn [get_bd_pins c0_ddr4_aresetn] [get_bd_pins ddr4_0/c0_ddr4_aresetn] [get_bd_pins proc_sys_reset_MIG_A/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_MIG_B_peripheral_aresetn [get_bd_pins c0_ddr4_aresetn1] [get_bd_pins ddr4_2/c0_ddr4_aresetn] [get_bd_pins proc_sys_reset_MIG_B/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_MIG_D_peripheral_aresetn [get_bd_pins peripheral_aresetn] [get_bd_pins ddr4_3/c0_ddr4_aresetn] [get_bd_pins proc_sys_reset_MIG_D/peripheral_aresetn]
  connect_bd_net -net sys_rst_0_1 [get_bd_pins sys_rst_ddr_0] [get_bd_pins ddr4_0/sys_rst]
  connect_bd_net -net sys_rst_0_2 [get_bd_pins sys_rst_ddr_2] [get_bd_pins ddr4_2/sys_rst]
  connect_bd_net -net sys_rst_0_3 [get_bd_pins sys_rst_ddr_3] [get_bd_pins ddr4_3/sys_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: AXI_MM_INPUT_REG
proc create_hier_cell_AXI_MM_INPUT_REG { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_MM_INPUT_REG() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_0

  # Create pins
  create_bd_pin -dir I -type rst AXI_RESET_N
  create_bd_pin -dir I -type clk CLK_IN_250
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn

  # Create instance: axi_register_slice_0, and set properties
  set axi_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_0 ]

  # Create instance: axi_register_slice_1, and set properties
  set axi_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_1 ]

  # Create instance: proc_sys_reset_250, and set properties
  set proc_sys_reset_250 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_250 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI_0] [get_bd_intf_pins axi_register_slice_0/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins axi_register_slice_1/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_1_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_register_slice_1/M_AXI]

  # Create port connections
  connect_bd_net -net AXI_RESET_N_1 [get_bd_pins AXI_RESET_N] [get_bd_pins proc_sys_reset_250/ext_reset_in]
  connect_bd_net -net CLK_IN_250_1 [get_bd_pins CLK_IN_250] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins axi_register_slice_1/aclk] [get_bd_pins proc_sys_reset_250/slowest_sync_clk]
  connect_bd_net -net proc_sys_reset_250_peripheral_aresetn1 [get_bd_pins peripheral_aresetn] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins axi_register_slice_1/aresetn] [get_bd_pins proc_sys_reset_250/peripheral_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: AXI_MM_3_stage_reg
proc create_hier_cell_AXI_MM_3_stage_reg { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_MM_3_stage_reg() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  # Create pins
  create_bd_pin -dir I -type clk m_axi_aclk
  create_bd_pin -dir I -type rst m_axi_aresetn

  # Create instance: axi_register_slice_1, and set properties
  set axi_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_1 ]

  # Create instance: axi_register_slice_2, and set properties
  set axi_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_register_slice_2/M_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_register_slice_1/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_1_M_AXI [get_bd_intf_pins axi_register_slice_1/M_AXI] [get_bd_intf_pins axi_register_slice_2/S_AXI]

  # Create port connections
  connect_bd_net -net m_axi_aclk_1 [get_bd_pins m_axi_aclk] [get_bd_pins axi_register_slice_1/aclk] [get_bd_pins axi_register_slice_2/aclk]
  connect_bd_net -net m_axi_aresetn_1 [get_bd_pins m_axi_aresetn] [get_bd_pins axi_register_slice_1/aresetn] [get_bd_pins axi_register_slice_2/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: AXI_LITE_3Stage_reg
proc create_hier_cell_AXI_LITE_3Stage_reg { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_LITE_3Stage_reg() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  # Create pins
  create_bd_pin -dir I -type rst AXI_RESET_N
  create_bd_pin -dir I -type clk S_aclk
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn

  # Create instance: axi_register_slice_0, and set properties
  set axi_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_0 ]
  set_property -dict [ list \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
 ] $axi_register_slice_0

  # Create instance: axi_register_slice_2, and set properties
  set axi_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_2 ]
  set_property -dict [ list \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
 ] $axi_register_slice_2

  # Create instance: proc_sys_reset_125, and set properties
  set proc_sys_reset_125 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_125 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_register_slice_2/M_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_register_slice_0/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins axi_register_slice_2/S_AXI]

  # Create port connections
  connect_bd_net -net AXI_RESET_N_1 [get_bd_pins AXI_RESET_N] [get_bd_pins proc_sys_reset_125/ext_reset_in]
  connect_bd_net -net aclk_1 [get_bd_pins S_aclk] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins axi_register_slice_2/aclk] [get_bd_pins proc_sys_reset_125/slowest_sync_clk]
  connect_bd_net -net aresetn_1 [get_bd_pins peripheral_aresetn] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins axi_register_slice_2/aresetn] [get_bd_pins proc_sys_reset_125/peripheral_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set C0_SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C0_SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $C0_SYS_CLK
  set C2_SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C2_SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $C2_SYS_CLK
  set C3_SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C3_SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $C3_SYS_CLK
  set M_AXI_TO_STATIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_TO_STATIC ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.CLK_DOMAIN {PCIe_Bridge_ICAP_complex_xdma_0_0_axi_aclk} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.PROTOCOL {AXI4} \
   ] $M_AXI_TO_STATIC
  set S_AXI_FROM_STATIC [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_FROM_STATIC ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {PCIe_Bridge_ICAP_complex_xdma_0_0_axi_aclk} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {4} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {32} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {32} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S_AXI_FROM_STATIC
  set S_AXI_LITE_FROM_STATIC [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE_FROM_STATIC ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {PCIe_Bridge_ICAP_complex_xdma_0_0_axi_aclk} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S_AXI_LITE_FROM_STATIC
  set c0_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4 ]
  set c2_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c2_ddr4 ]
  set c3_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c3_ddr4 ]

  # Create ports
  set AXI_RESET_N [ create_bd_port -dir I -type rst AXI_RESET_N ]
  set CLK_IN_125M [ create_bd_port -dir I -type clk CLK_IN_125M ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S_AXI_LITE_FROM_STATIC} \
   CONFIG.CLK_DOMAIN {PCIe_Bridge_ICAP_complex_xdma_0_0_axi_aclk} \
   CONFIG.FREQ_HZ {250000000} \
 ] $CLK_IN_125M
  set CLK_IN_250 [ create_bd_port -dir I -type clk CLK_IN_250 ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M_AXI_TO_STATIC:S_AXI_FROM_STATIC} \
   CONFIG.ASSOCIATED_RESET {AXI_RESET_N} \
   CONFIG.CLK_DOMAIN {PCIe_Bridge_ICAP_complex_xdma_0_0_axi_aclk} \
   CONFIG.FREQ_HZ {250000000} \
 ] $CLK_IN_250
  set CLK_IN_PROG [ create_bd_port -dir I -type clk CLK_IN_PROG ]
  set_property -dict [ list \
   CONFIG.CLK_DOMAIN {PCIe_Bridge_ICAP_complex_xdma_0_0_axi_aclk} \
   CONFIG.FREQ_HZ {400000000} \
 ] $CLK_IN_PROG
  set sys_rst_ddr_0 [ create_bd_port -dir I -type rst sys_rst_ddr_0 ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $sys_rst_ddr_0
  set sys_rst_ddr_2 [ create_bd_port -dir I -type rst sys_rst_ddr_2 ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $sys_rst_ddr_2
  set sys_rst_ddr_3 [ create_bd_port -dir I -type rst sys_rst_ddr_3 ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $sys_rst_ddr_3

  # Create instance: AXI_LITE_3Stage_reg
  create_hier_cell_AXI_LITE_3Stage_reg [current_bd_instance .] AXI_LITE_3Stage_reg

  # Create instance: AXI_MM_3_stage_reg
  create_hier_cell_AXI_MM_3_stage_reg [current_bd_instance .] AXI_MM_3_stage_reg

  # Create instance: AXI_MM_INPUT_REG
  create_hier_cell_AXI_MM_INPUT_REG [current_bd_instance .] AXI_MM_INPUT_REG

  # Create instance: DDR_SUB_SYS
  create_hier_cell_DDR_SUB_SYS [current_bd_instance .] DDR_SUB_SYS

  # Create instance: HLS_ip
  create_hier_cell_HLS_ip [current_bd_instance .] HLS_ip

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
 ] $axi_interconnect_1

  # Create interface connections
  connect_bd_intf_net -intf_net AXI_LITE_3Stage_reg_M_AXI [get_bd_intf_pins AXI_LITE_3Stage_reg/M_AXI] [get_bd_intf_pins axi_interconnect_1/S00_AXI]
  connect_bd_intf_net -intf_net AXI_MM_3_stage_reg_M_AXI [get_bd_intf_ports M_AXI_TO_STATIC] [get_bd_intf_pins AXI_MM_3_stage_reg/M_AXI]
  connect_bd_intf_net -intf_net C0_SYS_CLK_0_1 [get_bd_intf_ports C2_SYS_CLK] [get_bd_intf_pins DDR_SUB_SYS/C2_SYS_CLK]
  connect_bd_intf_net -intf_net C0_SYS_CLK_1_1 [get_bd_intf_ports C0_SYS_CLK] [get_bd_intf_pins DDR_SUB_SYS/C0_SYS_CLK]
  connect_bd_intf_net -intf_net C0_SYS_CLK_2_1 [get_bd_intf_ports C3_SYS_CLK] [get_bd_intf_pins DDR_SUB_SYS/C3_SYS_CLK]
  connect_bd_intf_net -intf_net HLS_ip_M_AXI [get_bd_intf_pins HLS_ip/M_AXI] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net S_AXI_0_1 [get_bd_intf_ports S_AXI_FROM_STATIC] [get_bd_intf_pins AXI_MM_INPUT_REG/S_AXI_0]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins HLS_ip/S_AXI] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net S_AXI_LITE_FROM_STATIC_1 [get_bd_intf_ports S_AXI_LITE_FROM_STATIC] [get_bd_intf_pins AXI_LITE_3Stage_reg/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins AXI_MM_3_stage_reg/S_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins DDR_SUB_SYS/C0_DDR4_S_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins DDR_SUB_SYS/C0_DDR4_S_AXI1] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins DDR_SUB_SYS/C0_DDR4_S_AXI2] [get_bd_intf_pins axi_interconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins DDR_SUB_SYS/C0_DDR4_S_AXI_CTRL] [get_bd_intf_pins axi_interconnect_1/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M02_AXI [get_bd_intf_pins DDR_SUB_SYS/C0_DDR4_S_AXI_CTRL1] [get_bd_intf_pins axi_interconnect_1/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M03_AXI [get_bd_intf_pins DDR_SUB_SYS/C0_DDR4_S_AXI_CTRL2] [get_bd_intf_pins axi_interconnect_1/M03_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_1_M_AXI [get_bd_intf_pins AXI_MM_INPUT_REG/M_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_ports c0_ddr4] [get_bd_intf_pins DDR_SUB_SYS/c0_ddr4]
  connect_bd_intf_net -intf_net ddr4_2_C0_DDR4 [get_bd_intf_ports c2_ddr4] [get_bd_intf_pins DDR_SUB_SYS/c2_ddr4]
  connect_bd_intf_net -intf_net ddr4_3_C0_DDR4 [get_bd_intf_ports c3_ddr4] [get_bd_intf_pins DDR_SUB_SYS/c3_ddr4]

  # Create port connections
  connect_bd_net -net AXI_RESET_N_1 [get_bd_ports AXI_RESET_N] [get_bd_pins AXI_LITE_3Stage_reg/AXI_RESET_N] [get_bd_pins AXI_MM_INPUT_REG/AXI_RESET_N] [get_bd_pins HLS_ip/AXI_RESET_N] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN]
  connect_bd_net -net CLK_IN_125M_1 [get_bd_ports CLK_IN_125M] [get_bd_pins AXI_LITE_3Stage_reg/S_aclk] [get_bd_pins HLS_ip/CLK_125M] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK]
  connect_bd_net -net CLK_IN_250_1 [get_bd_ports CLK_IN_250] [get_bd_pins AXI_MM_3_stage_reg/m_axi_aclk] [get_bd_pins AXI_MM_INPUT_REG/CLK_IN_250] [get_bd_pins HLS_ip/CLK_250M] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK]
  connect_bd_net -net CLK_IN_PROG_1 [get_bd_ports CLK_IN_PROG] [get_bd_pins HLS_ip/HLS_ip_clk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk [get_bd_pins DDR_SUB_SYS/c0_ddr4_ui_clk] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_1/M01_ACLK]
  connect_bd_net -net ddr4_2_c0_ddr4_ui_clk [get_bd_pins DDR_SUB_SYS/c0_ddr4_ui_clk1] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_1/M02_ACLK]
  connect_bd_net -net ddr4_3_c0_ddr4_ui_clk [get_bd_pins DDR_SUB_SYS/slowest_sync_clk] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_1/M03_ACLK]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins AXI_LITE_3Stage_reg/peripheral_aresetn] [get_bd_pins HLS_ip/ARESETN_125M]
  connect_bd_net -net proc_sys_reset_250_peripheral_aresetn [get_bd_pins AXI_MM_3_stage_reg/m_axi_aresetn] [get_bd_pins AXI_MM_INPUT_REG/peripheral_aresetn] [get_bd_pins HLS_ip/ARESETN_250M] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN]
  connect_bd_net -net proc_sys_reset_MIG_A_peripheral_aresetn [get_bd_pins DDR_SUB_SYS/c0_ddr4_aresetn] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_1/M01_ARESETN]
  connect_bd_net -net proc_sys_reset_MIG_B_peripheral_aresetn [get_bd_pins DDR_SUB_SYS/c0_ddr4_aresetn1] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_1/M02_ARESETN]
  connect_bd_net -net proc_sys_reset_MIG_D_peripheral_aresetn [get_bd_pins DDR_SUB_SYS/peripheral_aresetn] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_1/M03_ARESETN]
  connect_bd_net -net sys_rst_0_1 [get_bd_ports sys_rst_ddr_0] [get_bd_pins DDR_SUB_SYS/sys_rst_ddr_0]
  connect_bd_net -net sys_rst_0_2 [get_bd_ports sys_rst_ddr_2] [get_bd_pins DDR_SUB_SYS/sys_rst_ddr_2]
  connect_bd_net -net sys_rst_0_3 [get_bd_ports sys_rst_ddr_3] [get_bd_pins DDR_SUB_SYS/sys_rst_ddr_3]

  # Create address segments
  create_bd_addr_seg -range 0x001000000000 -offset 0x00000000 [get_bd_addr_spaces HLS_ip/sdx_cppKernel_top_0/Data_m_axi_gmem] [get_bd_addr_segs M_AXI_TO_STATIC/Reg] SEG_M_AXI_TO_STATIC_Reg
  create_bd_addr_seg -range 0x000400000000 -offset 0x001000000000 [get_bd_addr_spaces HLS_ip/sdx_cppKernel_top_0/Data_m_axi_gmem] [get_bd_addr_segs DDR_SUB_SYS/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_0_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x000400000000 -offset 0x001400000000 [get_bd_addr_spaces HLS_ip/sdx_cppKernel_top_0/Data_m_axi_gmem] [get_bd_addr_segs DDR_SUB_SYS/ddr4_2/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_2_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x000400000000 -offset 0x001800000000 [get_bd_addr_spaces HLS_ip/sdx_cppKernel_top_0/Data_m_axi_gmem] [get_bd_addr_segs DDR_SUB_SYS/ddr4_3/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_3_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x001000000000 -offset 0x00000000 [get_bd_addr_spaces S_AXI_FROM_STATIC] [get_bd_addr_segs M_AXI_TO_STATIC/Reg] SEG_M_AXI_TO_STATIC_Reg
  create_bd_addr_seg -range 0x000400000000 -offset 0x001000000000 [get_bd_addr_spaces S_AXI_FROM_STATIC] [get_bd_addr_segs DDR_SUB_SYS/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_0_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00004000 -offset 0x001D0000 [get_bd_addr_spaces S_AXI_LITE_FROM_STATIC] [get_bd_addr_segs DDR_SUB_SYS/ddr4_0/C0_DDR4_MEMORY_MAP_CTRL/C0_REG] SEG_ddr4_0_C0_REG
  create_bd_addr_seg -range 0x000400000000 -offset 0x001400000000 [get_bd_addr_spaces S_AXI_FROM_STATIC] [get_bd_addr_segs DDR_SUB_SYS/ddr4_2/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_2_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00004000 -offset 0x001E0000 [get_bd_addr_spaces S_AXI_LITE_FROM_STATIC] [get_bd_addr_segs DDR_SUB_SYS/ddr4_2/C0_DDR4_MEMORY_MAP_CTRL/C0_REG] SEG_ddr4_2_C0_REG
  create_bd_addr_seg -range 0x000400000000 -offset 0x001800000000 [get_bd_addr_spaces S_AXI_FROM_STATIC] [get_bd_addr_segs DDR_SUB_SYS/ddr4_3/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_3_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00004000 -offset 0x001F0000 [get_bd_addr_spaces S_AXI_LITE_FROM_STATIC] [get_bd_addr_segs DDR_SUB_SYS/ddr4_3/C0_DDR4_MEMORY_MAP_CTRL/C0_REG] SEG_ddr4_3_C0_REG
  create_bd_addr_seg -range 0x00010000 -offset 0x00100000 [get_bd_addr_spaces S_AXI_LITE_FROM_STATIC] [get_bd_addr_segs HLS_ip/sdx_cppKernel_top_0/s_axi_control/Reg] SEG_sdx_cppKernel_top_0_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


