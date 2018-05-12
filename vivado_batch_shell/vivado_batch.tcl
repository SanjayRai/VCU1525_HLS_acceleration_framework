# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl

set TOP_module VU9P_AXI_ICAP_PR_DESIGN_top
set ROLE_CLK_PERIOD 4.000
#set NORTH_ROLE_NAME IP_SDX_ACCL_MATRIX_MULT_6X6
set NORTH_ROLE_NAME IP_SDX_ACCL_KERNEL_FP_VECTOR_MULT
#set NORTH_ROLE_NAME IP_SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL
#set NORTH_ROLE_NAME IP_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL
#set NORTH_ROLE_NAME IP_SDX_ACCL_KERNEL_PASSTHRU

proc synth_hls_pr_NORTH {ARGV_0} { 

upvar 1 $ARGV_0 ROLE_NAME

    create_project -in_memory -part [DEVICE_TYPE] 

    read_bd "../IP/role/$ROLE_NAME/HLS_PR_SDX_SRAI/HLS_PR_SDX_SRAI.bd"

    read_verilog {
    ../src/srai_accel_intfc.sv
    ../src/role_NORTH/role_NORTH.sv
    }

    synth_design -keep_equivalent_registers -shreg_min_size 8 -include_dirs ../src -top role_NORTH -mode out_of_context  -part [DEVICE_TYPE] 
    opt_design -verbose -directive Explore

    write_checkpoint -force ../checkpoints/role_NORTH.$ROLE_NAME.post_synth_opt.dcp
    close_project
}

proc build_design {ARGV_0 ARGV_1 ARGV_2} { 
upvar 1 $ARGV_0 TOP_module
upvar 1 $ARGV_1 NORTH_ROLE_NAME
upvar 1 $ARGV_2 ROLE_CLK_PERIOD
    create_project -in_memory -part [DEVICE_TYPE] 

    read_bd {
    ../IP/shell/PCIe_Bridge_ICAP_complex/PCIe_Bridge_ICAP_complex.bd
    }

    read_verilog "
    ../src/srai_accel_intfc.sv
    ../src/role_NORTH_BB.sv
    ../src/shell_top.sv
    ../src/$TOP_module.sv
    "

    read_xdc "
    ../src/xdc/$TOP_module.xdc
    "

    synth_design -keep_equivalent_registers -shreg_min_size 8 -include_dirs ../src -top $TOP_module -part [DEVICE_TYPE] 
    read_checkpoint -cell U_role_NORTH ../checkpoints/role_NORTH.$NORTH_ROLE_NAME.post_synth_opt.dcp
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_synth.dcp
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
    write_debug_probes ./$TOP_module.ltx
    report_timing_summary -file $TOP_module.$NORTH_ROLE_NAME.timing_summary.rpt
    report_drc -file $TOP_module.drc.rpt

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
    write_cfgmem  -format mcs -size 512 -interface SPIx4 -loadbit "up 0x00000000 $TOP_module.$NORTH_ROLE_NAME.bit " -file "$TOP_module.$NORTH_ROLE_NAME.mcs"

    write_checkpoint -force -cell U_role_NORTH ../checkpoints/role_NORTH.$NORTH_ROLE_NAME.post_route_phys_opt.dcp

    update_design -cell U_role_NORTH -black_box
    lock_design -level routing
    write_checkpoint -force ../checkpoints/$TOP_module.routed_BB.dcp
}
synth_hls_pr_NORTH NORTH_ROLE_NAME
build_design TOP_module NORTH_ROLE_NAME ROLE_CLK_PERIOD 
