# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl

set TOP_module VU9P_AXI_ICAP_PR_DESIGN_top
set ROLE_CLK_PERIOD 4.000
set NORTH_ROLE_NAME IP_SDX_ACCL_KERNEL_PASSTHRU 
proc synth_hls_pr_NORTH {ARGV_0} { 

upvar 1 $ARGV_0 ROLE_NAME

    create_project -in_memory -part [DEVICE_TYPE] 

    read_bd "../IP/role/$ROLE_NAME/HLS_PR_SDX_SRAI/HLS_PR_SDX_SRAI.bd"

    read_ip " ../IP/role/debug_bridge_PR/debug_bridge_PR.xci"

    read_verilog {
    ../src/srai_accel_intfc.sv
    ../src/role_NORTH/role_NORTH.sv
    }

    read_xdc -mode out_of_context -ref role_NORTH "
    ../src/role_NORTH/xdc/role_NORTH.xdc
    "

    synth_design -keep_equivalent_registers -shreg_min_size 8 -include_dirs ../src -top role_NORTH -verilog_define XSDB_SLV_DIS -mode out_of_context  -part [DEVICE_TYPE] 
    
    opt_design -verbose -directive Explore

    write_checkpoint -force ../checkpoints/role_NORTH.$ROLE_NAME.post_synth_opt.dcp
    close_project
}

proc build_design {ARGV_0 ARGV_1 ARGV_2} { 
upvar 1 $ARGV_0 TOP_module
upvar 1 $ARGV_1 NORTH_ROLE_NAME
upvar 1 $ARGV_2 ROLE_CLK_PERIOD
    create_project -in_memory -part [DEVICE_TYPE] 
    add_files  ../checkpoints/$TOP_module.routed_BB.dcp
    read_checkpoint -cell U_role_NORTH ../checkpoints/role_NORTH.$NORTH_ROLE_NAME.post_synth_opt.dcp
    link_design -top $TOP_module -part [DEVICE_TYPE] -reconfig_partitions {U_role_NORTH}
    opt_design -verbose -directive Explore

    create_clock -name SRAI_PROG_CLK -period $ROLE_CLK_PERIOD [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_PROG/inst/CLK_CORE_DRP_I/clk_inst/mmcme4_adv_inst/CLKOUT0]
    set_false_path -through [get_pins {U_shell_top/PCIe_Bridge_ICAP_complex_i/axi_gpio_0/gpio_io_*[*]}]
    set_clock_groups -name SRAI_CG_PROG_CLK -asynchronous -group [ get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_PROG/inst/CLK_CORE_DRP_I/clk_inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks [list  [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT1]]]]

    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_synth_opt.dcp
    place_design -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_place.dcp
    phys_opt_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_place_phys_opt.dcp
    route_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_route.dcp
    phys_opt_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_route_phys_opt.dcp
    write_debug_probes ./$TOP_module.$NORTH_ROLE_NAME.ltx
    report_timing_summary -file $TOP_module.$NORTH_ROLE_NAME.timing_summary.rpt
    report_drc -file $TOP_module.$NORTH_ROLE_NAME.drc.rpt

    write_checkpoint -force -cell U_role_NORTH ../checkpoints/U_role_NORTH.$NORTH_ROLE_NAME.post_route_phys_opt.dcp

    set_param bitstream.enablePR 4123
    set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
    set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
    set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
    set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
    set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
    set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN Disable [current_design]
    set_property CONFIG_MODE SPIx4 [current_design]
    set_property CONFIG_VOLTAGE 1.8 [current_design]
    set_property CFGBVS GND [current_design]
    write_bitstream -bin_file $TOP_module.$NORTH_ROLE_NAME.bit      
    close_project
}
synth_hls_pr_NORTH NORTH_ROLE_NAME
build_design TOP_module NORTH_ROLE_NAME ROLE_CLK_PERIOD 
