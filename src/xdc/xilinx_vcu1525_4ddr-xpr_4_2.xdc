# *************************************************************************
#    ____  ____
#   /   /\/   /
#  /___/  \  /
#  \   \   \/    � Copyright 2017 Xilinx, Inc. All rights reserved.
#   \   \        This file contains confidential and proprietary
#   /   /        information of Xilinx, Inc. and is protected under U.S.
#  /___/   /\    and international copyright and other intellectual
#  \   \  /  \   property laws.
#   \___\/\___\
#
#
# *************************************************************************
#
# Disclaimer:
#
#       This disclaimer is not a license and does not grant any rights to
#       the materials distributed herewith. Except as otherwise provided in
#       a valid license issued to you by Xilinx, and to the maximum extent
#       permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE
#       "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL
#       WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
#       INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY,
#       NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#       (2) Xilinx shall not be liable (whether in contract or tort,
#       including negligence, or under any other theory of liability) for
#       any loss or damage of any kind or nature related to, arising under
#       or in connection with these materials, including for any direct, or
#       any indirect, special, incidental, or consequential loss or damage
#       (including loss of data, profits, goodwill, or any type of loss or
#       damage suffered as a result of any action brought by a third party)
#       even if such damage or loss was reasonably foreseeable or Xilinx
#       had been advised of the possibility of the same.
#
# Critical Applications:
#
#       Xilinx products are not designed or intended to be fail-safe, or
#       for use in any application requiring fail-safe performance, such as
#       life-support or safety devices or systems, Class III medical
#       devices, nuclear facilities, applications related to the deployment
#       of airbags, or any other applications that could lead to death,
#       personal injury, or severe property or environmental damage
#       (individually and collectively, "Critical Applications"). Customer
#       assumes the sole risk and liability of any use of Xilinx products
#       in Critical Applications, subject only to applicable laws and
#       regulations governing limitations on product liability.
#
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS
# FILE AT ALL TIMES.
#
# *************************************************************************

# Clocks
# ------------------------------------------------------------------------------
create_clock -period 10.000 -name ref_clk [get_ports {ref_clk_clk_p[0]}]

# Clock domain priority
# ------------------------------------------------------------------------------
set_property HIGH_PRIORITY true [get_nets xcl_design_i/base_region/base_clocking/clkwiz_sysclks/inst/clk_out1]
set_property HIGH_PRIORITY true [get_nets xcl_design_i/expanded_region/memc/ddrmem_0/inst/u_ddr4_infrastructure/div_clk]
set_property HIGH_PRIORITY true [get_nets xcl_design_i/base_region/memc/ddrmem_1/inst/u_ddr4_infrastructure/div_clk]
set_property HIGH_PRIORITY true [get_nets xcl_design_i/expanded_region/memc/ddrmem_2/inst/u_ddr4_infrastructure/div_clk]
set_property HIGH_PRIORITY true [get_nets xcl_design_i/expanded_region/memc/ddrmem_3/inst/u_ddr4_infrastructure/div_clk]
set_property HIGH_PRIORITY true [get_nets xcl_design_i/base_region/pcie/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/CLK_CORECLK]

# Additional timing constraints
# ------------------------------------------------------------------------------
create_property MAX_PROG_DELAY net
set_property MAX_PROG_DELAY 3 [get_nets [list xcl_design_i/base_region/pcie/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/CLK_PCLK2_GT xcl_design_i/base_region/pcie/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/CLK_CORECLK]]

# Configuration
# ------------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 1.8                        [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable    [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE           [current_design]
set_property CONFIG_MODE SPIx4                         [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4           [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN disable [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES        [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup         [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes       [current_design]

# IO constraints
# ------------------------------------------------------------------------------
# ref_clk
set_property PACKAGE_PIN AM11                    [get_ports {ref_clk_clk_p[0]}]

# perst_n
set_property PACKAGE_PIN BD21                    [get_ports perst_n]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 4} [get_ports perst_n]

# init_calib_complete
set_property PACKAGE_PIN BB21                    [get_ports init_calib_complete]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 4} [get_ports init_calib_complete]

# LED0 - link up
set_property PACKAGE_PIN BC21                    [get_ports led_0]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 4} [get_ports led_0]

# I2C pins
set_property PACKAGE_PIN BF20                    [get_ports iic_scl_io]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 4} [get_ports iic_scl_io]
set_property PACKAGE_PIN BF17                    [get_ports iic_sda_io]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 4} [get_ports iic_sda_io]
set_property PACKAGE_PIN BF19                    [get_ports iic_reset_n]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 4} [get_ports iic_reset_n]

# AXI QSPI Constraints
set tdata_trace_delay_max 0.47
set tdata_trace_delay_min 0.35
set tclk_trace_delay_max 0.37
set tclk_trace_delay_min 0.31
set tco_max 7.7
set tco_min 0.25
set tsu 1.75
set th 2.5
create_generated_clock -name clk_sck -source [get_pins -hierarchical *flash_programmer/ext_spi_clk] [get_pins -hierarchical *inst/CCLK] -edges {1 3 5}
set_input_delay -clock clk_sck -max [expr $tco_max + $tdata_trace_delay_max + $tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_input_delay -clock clk_sck -min [expr $tco_min + $tdata_trace_delay_min + $tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_multicycle_path 2 -setup -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]]
set_multicycle_path 1 -hold -end -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]]
set_output_delay -clock clk_sck -max [expr $tsu + $tdata_trace_delay_max - $tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_output_delay -clock clk_sck -min [expr $tdata_trace_delay_min -$th - $tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
#set_multicycle_path 2 -setup -start -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to clk_sck
set_multicycle_path 1 -hold -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to clk_sck

# Primitive locations and properties
# ------------------------------------------------------------------------------
set_property LOC PCIE40E4_X1Y2 [get_cells xcl_design_i/base_region/pcie/inst/pcie_4_0_pipe_inst/pcie_4_0_e4_inst]

# SDx Feature ROM identification
# ------------------------------------------------------------------------------
create_property -type bool -default_value false SDX_FEATURE_ROM cell
set_property SDX_FEATURE_ROM true [get_cells -hierarchical -filter {PRIMITIVE_TYPE =~ BLOCKRAM.BRAM.* && NAME =~ *base_region*feature_rom*}]

# Floorplanning
# ------------------------------------------------------------------------------
set_property DONT_TOUCH true [get_cells xcl_design_i/expanded_region/u_ocl_region]
set_property DONT_TOUCH true [get_cells xcl_design_i/expanded_region]
set_property HD.RECONFIGURABLE true [get_cells xcl_design_i/expanded_region]

# Expanded region pblock
create_pblock pblock_expanded_region
add_cells_to_pblock [get_pblocks pblock_expanded_region] [get_cells [list xcl_design_i/expanded_region]]
resize_pblock [get_pblocks pblock_expanded_region] -add {CLOCKREGION_X0Y0:CLOCKREGION_X5Y4}
resize_pblock [get_pblocks pblock_expanded_region] -add {CLOCKREGION_X0Y5:CLOCKREGION_X2Y9}
resize_pblock [get_pblocks pblock_expanded_region] -add {CLOCKREGION_X0Y10:CLOCKREGION_X5Y14}
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_expanded_region]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_expanded_region]
set_property SNAPPING_MODE ON [get_pblocks pblock_expanded_region]

# Lower SLR pblock
create_pblock pblock_lower
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/memc/ddrmem_0]]
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/memc/axicc_ddrmem_0_ctrl]]
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/m00_exit_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/m00_nodes]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/m00_sc2axi]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_ar_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_aw_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_b_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_r_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_w_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s01_nodes/s01_ar_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s01_nodes/s01_aw_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s01_nodes/s01_b_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s01_nodes/s01_r_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s01_nodes/s01_w_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_lower] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/switchboards]] -quiet
resize_pblock [get_pblocks pblock_lower] -add {CLOCKREGION_X0Y0:CLOCKREGION_X5Y4}
set_property SNAPPING_MODE ON [get_pblocks pblock_lower]
set_property PARENT pblock_expanded_region [get_pblocks pblock_lower]

# Middle SLR pblock
create_pblock pblock_middle
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/memc/ddrmem_2]]
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/u_ocl_region]]
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect_axilite]]
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_host]]
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_axi2sc]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_entry_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_ar_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_aw_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_b_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_r_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem0/inst/s00_nodes/s00_w_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s00_axi2sc]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s00_entry_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s00_nodes]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/m00_exit_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/m00_nodes]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/m00_sc2axi]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s01_nodes/s01_ar_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s01_nodes/s01_aw_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s01_nodes/s01_b_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s01_nodes/s01_r_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/s01_nodes/s01_w_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem1/inst/switchboards]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s00_axi2sc]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s00_entry_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s00_nodes]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/m00_exit_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/m00_nodes]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/m00_sc2axi]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s01_nodes/s01_ar_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s01_nodes/s01_aw_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s01_nodes/s01_b_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s01_nodes/s01_r_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/s01_nodes/s01_w_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem2/inst/switchboards]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_axi2sc]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_entry_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_ar_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_aw_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_b_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_r_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_middle] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_w_node/inst/inst_si_handler]] -quiet
resize_pblock [get_pblocks pblock_middle] -add {CLOCKREGION_X0Y5:CLOCKREGION_X2Y9}
set_property SNAPPING_MODE ON [get_pblocks pblock_middle]
set_property PARENT pblock_expanded_region [get_pblocks pblock_middle]

# Upper SLR pblock
create_pblock pblock_upper
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/memc/ddrmem_3]]
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/memc/axicc_ddrmem_3_ctrl]]
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/m00_exit_pipeline]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/m00_nodes]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/m00_sc2axi]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_ar_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_aw_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_b_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_r_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s00_nodes/s00_w_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s01_nodes/s01_ar_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s01_nodes/s01_aw_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s01_nodes/s01_b_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s01_nodes/s01_r_node/inst/inst_si_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/s01_nodes/s01_w_node/inst/inst_mi_handler]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells [list xcl_design_i/expanded_region/interconnect/interconnect_aximm_ddrmem3/inst/switchboards]] -quiet
add_cells_to_pblock [get_pblocks pblock_upper] [get_cells -filter {NAME =~ *interconnect_aximm_ddrmem3*} -of [get_pins -leaf -of [get_nets xcl_design_i/expanded_region/memc/ddrmem_3/inst/u_ddr4_infrastructure/div_clk]]] -quiet
resize_pblock [get_pblocks pblock_upper] -add {CLOCKREGION_X0Y10:CLOCKREGION_X5Y14}
set_property SNAPPING_MODE ON [get_pblocks pblock_upper]
set_property PARENT pblock_expanded_region [get_pblocks pblock_upper]

# APM pblock
create_pblock pblock_apm
add_cells_to_pblock [get_pblocks pblock_apm] [get_cells [list xcl_design_i/expanded_region/apm_sys/xilmonitor_subset0]]
add_cells_to_pblock [get_pblocks pblock_apm] [get_cells [list xcl_design_i/expanded_region/apm_sys/xilmonitor_fifo0]]
add_cells_to_pblock [get_pblocks pblock_apm] [get_cells [list xcl_design_i/expanded_region/apm_sys/xilmonitor_apm]]
resize_pblock [get_pblocks pblock_apm] -add {CLOCKREGION_X0Y6:CLOCKREGION_X0Y8}
set_property SNAPPING_MODE ON [get_pblocks pblock_apm]
set_property PARENT pblock_middle [get_pblocks pblock_apm]

# Optional DDR4 IP pblocks - enable as needed for timing predictability
## # DDR4 IP channel 0 pblock
## create_pblock pblock_ddrmem_0
## add_cells_to_pblock [get_pblocks pblock_ddrmem_0] [get_cells [list xcl_design_i/expanded_region/memc/ddrmem_0]]
## resize_pblock [get_pblocks pblock_ddrmem_0] -add {CLOCKREGION_X2Y1:CLOCKREGION_X2Y3}
## set_property SNAPPING_MODE ON [get_pblocks pblock_ddrmem_0]
## set_property PARENT pblock_lower [get_pblocks pblock_ddrmem_0]
##
## # DDR4 IP channel 1 pblock
## create_pblock pblock_ddrmem_1
## add_cells_to_pblock [get_pblocks pblock_ddrmem_1] [get_cells [list xcl_design_i/base_region/memc/ddrmem_1]]
## resize_pblock [get_pblocks pblock_ddrmem_1] -add {CLOCKREGION_X4Y6:CLOCKREGION_X4Y8}
## set_property SNAPPING_MODE ON [get_pblocks pblock_ddrmem_1]
##
## # DDR4 IP channel 2 pblock
## create_pblock pblock_ddrmem_2
## add_cells_to_pblock [get_pblocks pblock_ddrmem_2] [get_cells [list xcl_design_i/expanded_region/memc/ddrmem_2]]
## resize_pblock [get_pblocks pblock_ddrmem_2] -add {CLOCKREGION_X2Y7:CLOCKREGION_X2Y9}
## set_property SNAPPING_MODE ON [get_pblocks pblock_ddrmem_2]
## set_property PARENT pblock_middle [get_pblocks pblock_ddrmem_2]
##
## # DDR4 IP channel 3 pblock
## create_pblock pblock_ddrmem_3
## add_cells_to_pblock [get_pblocks pblock_ddrmem_3] [get_cells [list xcl_design_i/expanded_region/memc/ddrmem_3]]
## resize_pblock [get_pblocks pblock_ddrmem_3] -add {CLOCKREGION_X4Y11:CLOCKREGION_X4Y13}
## set_property SNAPPING_MODE ON [get_pblocks pblock_ddrmem_3]
## set_property PARENT pblock_upper [get_pblocks pblock_ddrmem_3]

# Relevant constraints from DDR4 IP
# ------------------------------------------------------------------------------

set_property PACKAGE_PIN AY37       [get_ports c0_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c0_sys_clk_p]
set_property PACKAGE_PIN AY38       [get_ports c0_sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c0_sys_clk_n]

set_property PACKAGE_PIN AW20       [get_ports c1_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c1_sys_clk_p]
set_property PACKAGE_PIN AW19       [get_ports c1_sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c1_sys_clk_n]

set_property PACKAGE_PIN F32        [get_ports c2_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c2_sys_clk_p]
set_property PACKAGE_PIN E32        [get_ports c2_sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c2_sys_clk_n]

set_property PACKAGE_PIN J16        [get_ports c3_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c3_sys_clk_p]
set_property PACKAGE_PIN H16        [get_ports c3_sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c3_sys_clk_n]

set_property PACKAGE_PIN AR33       [get_ports {c0_ddr4_cs_n[0]}]
set_property PACKAGE_PIN AN36       [get_ports {c0_ddr4_adr[13]}]
set_property PACKAGE_PIN AR36       [get_ports {c0_ddr4_adr[16]}]
set_property PACKAGE_PIN AP36       [get_ports {c0_ddr4_adr[15]}]
set_property PACKAGE_PIN AP35       [get_ports {c0_ddr4_adr[14]}]
set_property PACKAGE_PIN AP34       [get_ports {c0_ddr4_odt[0]}]
set_property PACKAGE_PIN AT35       [get_ports {c0_ddr4_ba[0]}]
set_property PACKAGE_PIN AR35       [get_ports {c0_ddr4_adr[10]}]
set_property PACKAGE_PIN AT34       [get_ports {c0_ddr4_ba[1]}]
set_property PACKAGE_PIN AU36       [get_ports {c0_ddr4_par}]
set_property PACKAGE_PIN AT36       [get_ports {c0_ddr4_adr[0]}]
set_property PACKAGE_PIN AW38       [get_ports {c0_ddr4_ck_c[0]}]
set_property PACKAGE_PIN AV38       [get_ports {c0_ddr4_ck_t[0]}]
set_property PACKAGE_PIN AV37       [get_ports {c0_ddr4_adr[2]}]
set_property PACKAGE_PIN AV36       [get_ports {c0_ddr4_adr[1]}]
set_property PACKAGE_PIN AW36       [get_ports {c0_ddr4_adr[4]}]
set_property PACKAGE_PIN AW35       [get_ports {c0_ddr4_adr[3]}]
set_property PACKAGE_PIN BB37       [get_ports {c0_ddr4_adr[9]}]
set_property PACKAGE_PIN AY36       [get_ports {c0_ddr4_adr[5]}]
set_property PACKAGE_PIN AY35       [get_ports {c0_ddr4_adr[6]}]
set_property PACKAGE_PIN BA37       [get_ports {c0_ddr4_adr[8]}]
set_property PACKAGE_PIN BA40       [get_ports {c0_ddr4_adr[7]}]
set_property PACKAGE_PIN BA39       [get_ports {c0_ddr4_adr[11]}]
set_property PACKAGE_PIN BC39       [get_ports {c0_ddr4_bg[1]}]
set_property PACKAGE_PIN BB40       [get_ports {c0_ddr4_adr[12]}]
set_property PACKAGE_PIN BB39       [get_ports {c0_ddr4_act_n}]
set_property PACKAGE_PIN BC38       [get_ports {c0_ddr4_cke[0]}]
set_property PACKAGE_PIN BC37       [get_ports {c0_ddr4_bg[0]}]
set_property PACKAGE_PIN BD40       [get_ports {c0_ddr4_dq[64]}]
set_property PACKAGE_PIN BD39       [get_ports {c0_ddr4_dq[65]}]
set_property PACKAGE_PIN BF43       [get_ports {c0_ddr4_dq[66]}]
set_property PACKAGE_PIN BF42       [get_ports {c0_ddr4_dq[67]}]
set_property PACKAGE_PIN BF38       [get_ports {c0_ddr4_dqs_c[16]}]
set_property PACKAGE_PIN BE38       [get_ports {c0_ddr4_dqs_t[16]}]
set_property PACKAGE_PIN BF41       [get_ports {c0_ddr4_dq[71]}]
set_property PACKAGE_PIN BE40       [get_ports {c0_ddr4_dq[70]}]
set_property PACKAGE_PIN BF37       [get_ports {c0_ddr4_dq[68]}]
set_property PACKAGE_PIN BE37       [get_ports {c0_ddr4_dq[69]}]
set_property PACKAGE_PIN BF40       [get_ports {c0_ddr4_dqs_c[17]}]
set_property PACKAGE_PIN BF39       [get_ports {c0_ddr4_dqs_t[17]}]
set_property PACKAGE_PIN AM30       [get_ports {c0_ddr4_dq[33]}]
set_property PACKAGE_PIN AL30       [get_ports {c0_ddr4_dq[32]}]
set_property PACKAGE_PIN AU32       [get_ports {c0_ddr4_dq[34]}]
set_property PACKAGE_PIN AT32       [get_ports {c0_ddr4_dq[35]}]
set_property PACKAGE_PIN AM32       [get_ports {c0_ddr4_dqs_c[8]}]
set_property PACKAGE_PIN AM31       [get_ports {c0_ddr4_dqs_t[8]}]
set_property PACKAGE_PIN AR32       [get_ports {c0_ddr4_dq[38]}]
set_property PACKAGE_PIN AR31       [get_ports {c0_ddr4_dq[39]}]
set_property PACKAGE_PIN AN32       [get_ports {c0_ddr4_dq[37]}]
set_property PACKAGE_PIN AN31       [get_ports {c0_ddr4_dq[36]}]
set_property PACKAGE_PIN AP31       [get_ports {c0_ddr4_dqs_c[9]}]
set_property PACKAGE_PIN AP30       [get_ports {c0_ddr4_dqs_t[9]}]
set_property PACKAGE_PIN AU31       [get_ports {c0_ddr4_reset_n}]
set_property PACKAGE_PIN AW34       [get_ports {c0_ddr4_dq[27]}]
set_property PACKAGE_PIN AV34       [get_ports {c0_ddr4_dq[26]}]
set_property PACKAGE_PIN AV32       [get_ports {c0_ddr4_dq[25]}]
set_property PACKAGE_PIN AV31       [get_ports {c0_ddr4_dq[24]}]
set_property PACKAGE_PIN AW33       [get_ports {c0_ddr4_dqs_c[6]}]
set_property PACKAGE_PIN AV33       [get_ports {c0_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN AY31       [get_ports {c0_ddr4_dq[29]}]
set_property PACKAGE_PIN AW31       [get_ports {c0_ddr4_dq[28]}]
set_property PACKAGE_PIN BA35       [get_ports {c0_ddr4_dq[30]}]
set_property PACKAGE_PIN BA34       [get_ports {c0_ddr4_dq[31]}]
set_property PACKAGE_PIN BA33       [get_ports {c0_ddr4_dqs_c[7]}]
set_property PACKAGE_PIN BA32       [get_ports {c0_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN AY33       [get_ports {c0_ddr4_dq[19]}]
set_property PACKAGE_PIN AY32       [get_ports {c0_ddr4_dq[18]}]
set_property PACKAGE_PIN BB32       [get_ports {c0_ddr4_dq[17]}]
set_property PACKAGE_PIN BB31       [get_ports {c0_ddr4_dq[16]}]
set_property PACKAGE_PIN BB36       [get_ports {c0_ddr4_dqs_c[4]}]
set_property PACKAGE_PIN BB35       [get_ports {c0_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN BC33       [get_ports {c0_ddr4_dq[21]}]
set_property PACKAGE_PIN BC32       [get_ports {c0_ddr4_dq[20]}]
set_property PACKAGE_PIN BC34       [get_ports {c0_ddr4_dq[23]}]
set_property PACKAGE_PIN BB34       [get_ports {c0_ddr4_dq[22]}]
set_property PACKAGE_PIN BD31       [get_ports {c0_ddr4_dqs_c[5]}]
set_property PACKAGE_PIN BC31       [get_ports {c0_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN BD35       [get_ports {c0_ddr4_dq[59]}]
set_property PACKAGE_PIN BD34       [get_ports {c0_ddr4_dq[56]}]
set_property PACKAGE_PIN BE33       [get_ports {c0_ddr4_dq[58]}]
set_property PACKAGE_PIN BD33       [get_ports {c0_ddr4_dq[57]}]
set_property PACKAGE_PIN BE36       [get_ports {c0_ddr4_dqs_c[14]}]
set_property PACKAGE_PIN BE35       [get_ports {c0_ddr4_dqs_t[14]}]
set_property PACKAGE_PIN BF33       [get_ports {c0_ddr4_dq[61]}]
set_property PACKAGE_PIN BF32       [get_ports {c0_ddr4_dq[60]}]
set_property PACKAGE_PIN BF35       [get_ports {c0_ddr4_dq[63]}]
set_property PACKAGE_PIN BF34       [get_ports {c0_ddr4_dq[62]}]
set_property PACKAGE_PIN BE32       [get_ports {c0_ddr4_dqs_c[15]}]
set_property PACKAGE_PIN BE31       [get_ports {c0_ddr4_dqs_t[15]}]
set_property PACKAGE_PIN AN27       [get_ports {c0_ddr4_dq[42]}]
set_property PACKAGE_PIN AM27       [get_ports {c0_ddr4_dq[43]}]
set_property PACKAGE_PIN AP29       [get_ports {c0_ddr4_dq[40]}]
set_property PACKAGE_PIN AP28       [get_ports {c0_ddr4_dq[41]}]
set_property PACKAGE_PIN AL29       [get_ports {c0_ddr4_dqs_c[10]}]
set_property PACKAGE_PIN AL28       [get_ports {c0_ddr4_dqs_t[10]}]
set_property PACKAGE_PIN AR28       [get_ports {c0_ddr4_dq[47]}]
set_property PACKAGE_PIN AR27       [get_ports {c0_ddr4_dq[46]}]
set_property PACKAGE_PIN AN29       [get_ports {c0_ddr4_dq[44]}]
set_property PACKAGE_PIN AM29       [get_ports {c0_ddr4_dq[45]}]
set_property PACKAGE_PIN AT30       [get_ports {c0_ddr4_dqs_c[11]}]
set_property PACKAGE_PIN AR30       [get_ports {c0_ddr4_dqs_t[11]}]
set_property PACKAGE_PIN AT28       [get_ports {c0_ddr4_dq[48]}]
set_property PACKAGE_PIN AT27       [get_ports {c0_ddr4_dq[51]}]
set_property PACKAGE_PIN AV27       [get_ports {c0_ddr4_dq[49]}]
set_property PACKAGE_PIN AU27       [get_ports {c0_ddr4_dq[50]}]
set_property PACKAGE_PIN AU30       [get_ports {c0_ddr4_dqs_c[12]}]
set_property PACKAGE_PIN AU29       [get_ports {c0_ddr4_dqs_t[12]}]
set_property PACKAGE_PIN AV29       [get_ports {c0_ddr4_dq[52]}]
set_property PACKAGE_PIN AV28       [get_ports {c0_ddr4_dq[55]}]
set_property PACKAGE_PIN AY30       [get_ports {c0_ddr4_dq[53]}]
set_property PACKAGE_PIN AW30       [get_ports {c0_ddr4_dq[54]}]
set_property PACKAGE_PIN AY28       [get_ports {c0_ddr4_dqs_c[13]}]
set_property PACKAGE_PIN AY27       [get_ports {c0_ddr4_dqs_t[13]}]
set_property PACKAGE_PIN AW29       [get_ports {c0_ddr4_dq[1]}]
set_property PACKAGE_PIN AW28       [get_ports {c0_ddr4_dq[0]}]
set_property PACKAGE_PIN BA28       [get_ports {c0_ddr4_dq[2]}]
set_property PACKAGE_PIN BA27       [get_ports {c0_ddr4_dq[3]}]
set_property PACKAGE_PIN BB30       [get_ports {c0_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN BA30       [get_ports {c0_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN BC27       [get_ports {c0_ddr4_dq[6]}]
set_property PACKAGE_PIN BB27       [get_ports {c0_ddr4_dq[7]}]
set_property PACKAGE_PIN BB29       [get_ports {c0_ddr4_dq[4]}]
set_property PACKAGE_PIN BA29       [get_ports {c0_ddr4_dq[5]}]
set_property PACKAGE_PIN BC26       [get_ports {c0_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN BB26       [get_ports {c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN BE30       [get_ports {c0_ddr4_dq[10]}]
set_property PACKAGE_PIN BD30       [get_ports {c0_ddr4_dq[11]}]
set_property PACKAGE_PIN BF28       [get_ports {c0_ddr4_dq[9]}]
set_property PACKAGE_PIN BE28       [get_ports {c0_ddr4_dq[8]}]
set_property PACKAGE_PIN BD29       [get_ports {c0_ddr4_dqs_c[2]}]
set_property PACKAGE_PIN BD28       [get_ports {c0_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN BF27       [get_ports {c0_ddr4_dq[12]}]
set_property PACKAGE_PIN BE27       [get_ports {c0_ddr4_dq[13]}]
set_property PACKAGE_PIN BF30       [get_ports {c0_ddr4_dq[14]}]
set_property PACKAGE_PIN BF29       [get_ports {c0_ddr4_dq[15]}]
set_property PACKAGE_PIN BE26       [get_ports {c0_ddr4_dqs_c[3]}]
set_property PACKAGE_PIN BD26       [get_ports {c0_ddr4_dqs_t[3]}]

set_property PACKAGE_PIN AR13       [get_ports {c1_ddr4_dq[25]}]
set_property PACKAGE_PIN AP13       [get_ports {c1_ddr4_dq[27]}]
set_property PACKAGE_PIN AN13       [get_ports {c1_ddr4_dq[24]}]
set_property PACKAGE_PIN AM13       [get_ports {c1_ddr4_dq[26]}]
set_property PACKAGE_PIN AT13       [get_ports {c1_ddr4_dqs_c[6]}]
set_property PACKAGE_PIN AT14       [get_ports {c1_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN AM14       [get_ports {c1_ddr4_dq[28]}]
set_property PACKAGE_PIN AL14       [get_ports {c1_ddr4_dq[30]}]
set_property PACKAGE_PIN AT15       [get_ports {c1_ddr4_dq[31]}]
set_property PACKAGE_PIN AR15       [get_ports {c1_ddr4_dq[29]}]
set_property PACKAGE_PIN AP14       [get_ports {c1_ddr4_dqs_c[7]}]
set_property PACKAGE_PIN AN14       [get_ports {c1_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN AW13       [get_ports {c1_ddr4_dq[10]}]
set_property PACKAGE_PIN AW14       [get_ports {c1_ddr4_dq[11]}]
set_property PACKAGE_PIN AV13       [get_ports {c1_ddr4_dq[9]}]
set_property PACKAGE_PIN AU13       [get_ports {c1_ddr4_dq[8]}]
set_property PACKAGE_PIN AY15       [get_ports {c1_ddr4_dqs_c[2]}]
set_property PACKAGE_PIN AW15       [get_ports {c1_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN AV14       [get_ports {c1_ddr4_dq[14]}]
set_property PACKAGE_PIN AU14       [get_ports {c1_ddr4_dq[12]}]
set_property PACKAGE_PIN BA11       [get_ports {c1_ddr4_dq[15]}]
set_property PACKAGE_PIN AY11       [get_ports {c1_ddr4_dq[13]}]
set_property PACKAGE_PIN AY12       [get_ports {c1_ddr4_dqs_c[3]}]
set_property PACKAGE_PIN AY13       [get_ports {c1_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN BB12       [get_ports {c1_ddr4_dq[17]}]
set_property PACKAGE_PIN BA12       [get_ports {c1_ddr4_dq[16]}]
set_property PACKAGE_PIN BA13       [get_ports {c1_ddr4_dq[18]}]
set_property PACKAGE_PIN BA14       [get_ports {c1_ddr4_dq[19]}]
set_property PACKAGE_PIN BB10       [get_ports {c1_ddr4_dqs_c[4]}]
set_property PACKAGE_PIN BB11       [get_ports {c1_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN BA7        [get_ports {c1_ddr4_dq[22]}]
set_property PACKAGE_PIN BA8        [get_ports {c1_ddr4_dq[23]}]
set_property PACKAGE_PIN BC9        [get_ports {c1_ddr4_dq[20]}]
set_property PACKAGE_PIN BB9        [get_ports {c1_ddr4_dq[21]}]
set_property PACKAGE_PIN BA9        [get_ports {c1_ddr4_dqs_c[5]}]
set_property PACKAGE_PIN BA10       [get_ports {c1_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN BD8        [get_ports {c1_ddr4_dq[3]}]
set_property PACKAGE_PIN BD9        [get_ports {c1_ddr4_dq[0]}]
set_property PACKAGE_PIN BD7        [get_ports {c1_ddr4_dq[1]}]
set_property PACKAGE_PIN BC7        [get_ports {c1_ddr4_dq[2]}]
set_property PACKAGE_PIN BF9        [get_ports {c1_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN BF10       [get_ports {c1_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN BF7        [get_ports {c1_ddr4_dq[7]}]
set_property PACKAGE_PIN BE7        [get_ports {c1_ddr4_dq[6]}]
set_property PACKAGE_PIN BE10       [get_ports {c1_ddr4_dq[5]}]
set_property PACKAGE_PIN BD10       [get_ports {c1_ddr4_dq[4]}]
set_property PACKAGE_PIN BF8        [get_ports {c1_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN BE8        [get_ports {c1_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AN16       [get_ports {c1_ddr4_dq[59]}]
set_property PACKAGE_PIN AN17       [get_ports {c1_ddr4_dq[58]}]
set_property PACKAGE_PIN AM15       [get_ports {c1_ddr4_dq[56]}]
set_property PACKAGE_PIN AL15       [get_ports {c1_ddr4_dq[57]}]
set_property PACKAGE_PIN AR16       [get_ports {c1_ddr4_dqs_c[14]}]
set_property PACKAGE_PIN AP16       [get_ports {c1_ddr4_dqs_t[14]}]
set_property PACKAGE_PIN AL16       [get_ports {c1_ddr4_dq[63]}]
set_property PACKAGE_PIN AL17       [get_ports {c1_ddr4_dq[62]}]
set_property PACKAGE_PIN AR18       [get_ports {c1_ddr4_dq[60]}]
set_property PACKAGE_PIN AP18       [get_ports {c1_ddr4_dq[61]}]
set_property PACKAGE_PIN AM16       [get_ports {c1_ddr4_dqs_c[15]}]
set_property PACKAGE_PIN AM17       [get_ports {c1_ddr4_dqs_t[15]}]
set_property PACKAGE_PIN AR17       [get_ports {c1_ddr4_reset_n}]
set_property PACKAGE_PIN AV16       [get_ports {c1_ddr4_dq[48]}]
set_property PACKAGE_PIN AV17       [get_ports {c1_ddr4_dq[49]}]
set_property PACKAGE_PIN AU16       [get_ports {c1_ddr4_dq[50]}]
set_property PACKAGE_PIN AU17       [get_ports {c1_ddr4_dq[51]}]
set_property PACKAGE_PIN AW18       [get_ports {c1_ddr4_dqs_c[12]}]
set_property PACKAGE_PIN AV18       [get_ports {c1_ddr4_dqs_t[12]}]
set_property PACKAGE_PIN AT17       [get_ports {c1_ddr4_dq[55]}]
set_property PACKAGE_PIN AT18       [get_ports {c1_ddr4_dq[54]}]
set_property PACKAGE_PIN BB16       [get_ports {c1_ddr4_dq[53]}]
set_property PACKAGE_PIN BB17       [get_ports {c1_ddr4_dq[52]}]
set_property PACKAGE_PIN AY16       [get_ports {c1_ddr4_dqs_c[13]}]
set_property PACKAGE_PIN AW16       [get_ports {c1_ddr4_dqs_t[13]}]
set_property PACKAGE_PIN BA17       [get_ports {c1_ddr4_dq[41]}]
set_property PACKAGE_PIN BA18       [get_ports {c1_ddr4_dq[43]}]
set_property PACKAGE_PIN AY17       [get_ports {c1_ddr4_dq[40]}]
set_property PACKAGE_PIN AY18       [get_ports {c1_ddr4_dq[42]}]
set_property PACKAGE_PIN BC12       [get_ports {c1_ddr4_dqs_c[10]}]
set_property PACKAGE_PIN BC13       [get_ports {c1_ddr4_dqs_t[10]}]
set_property PACKAGE_PIN BB15       [get_ports {c1_ddr4_dq[45]}]
set_property PACKAGE_PIN BA15       [get_ports {c1_ddr4_dq[44]}]
set_property PACKAGE_PIN BD11       [get_ports {c1_ddr4_dq[47]}]
set_property PACKAGE_PIN BC11       [get_ports {c1_ddr4_dq[46]}]
set_property PACKAGE_PIN BC14       [get_ports {c1_ddr4_dqs_c[11]}]
set_property PACKAGE_PIN BB14       [get_ports {c1_ddr4_dqs_t[11]}]
set_property PACKAGE_PIN BF12       [get_ports {c1_ddr4_dq[34]}]
set_property PACKAGE_PIN BE13       [get_ports {c1_ddr4_dq[32]}]
set_property PACKAGE_PIN BD13       [get_ports {c1_ddr4_dq[35]}]
set_property PACKAGE_PIN BD14       [get_ports {c1_ddr4_dq[33]}]
set_property PACKAGE_PIN BE11       [get_ports {c1_ddr4_dqs_c[8]}]
set_property PACKAGE_PIN BE12       [get_ports {c1_ddr4_dqs_t[8]}]
set_property PACKAGE_PIN BD15       [get_ports {c1_ddr4_dq[36]}]
set_property PACKAGE_PIN BD16       [get_ports {c1_ddr4_dq[37]}]
set_property PACKAGE_PIN BF13       [get_ports {c1_ddr4_dq[39]}]
set_property PACKAGE_PIN BF14       [get_ports {c1_ddr4_dq[38]}]
set_property PACKAGE_PIN BF15       [get_ports {c1_ddr4_dqs_c[9]}]
set_property PACKAGE_PIN BE15       [get_ports {c1_ddr4_dqs_t[9]}]
set_property PACKAGE_PIN AP26       [get_ports {c1_ddr4_ba[1]}]
set_property PACKAGE_PIN AN26       [get_ports {c1_ddr4_adr[3]}]
set_property PACKAGE_PIN AM26       [get_ports {c1_ddr4_adr[10]}]
set_property PACKAGE_PIN AM25       [get_ports {c1_ddr4_adr[15]}]
set_property PACKAGE_PIN AL25       [get_ports {c1_ddr4_adr[14]}]
set_property PACKAGE_PIN AL24       [get_ports {c1_ddr4_adr[13]}]
set_property PACKAGE_PIN AN24       [get_ports {c1_ddr4_adr[0]}]
set_property PACKAGE_PIN AN23       [get_ports {c1_ddr4_adr[16]}]
set_property PACKAGE_PIN AU24       [get_ports {c1_ddr4_ba[0]}]
set_property PACKAGE_PIN AT24       [get_ports {c1_ddr4_adr[1]}]
set_property PACKAGE_PIN AT23       [get_ports {c1_ddr4_par}]
set_property PACKAGE_PIN AU25       [get_ports {c1_ddr4_ck_c[0]}]
set_property PACKAGE_PIN AT25       [get_ports {c1_ddr4_ck_t[0]}]
set_property PACKAGE_PIN AV24       [get_ports {c1_ddr4_adr[6]}]
set_property PACKAGE_PIN AV23       [get_ports {c1_ddr4_cs_n[0]}]
set_property PACKAGE_PIN AW26       [get_ports {c1_ddr4_bg[1]}]
set_property PACKAGE_PIN AW25       [get_ports {c1_ddr4_act_n}]
set_property PACKAGE_PIN BA25       [get_ports {c1_ddr4_adr[11]}]
set_property PACKAGE_PIN AW24       [get_ports {c1_ddr4_adr[2]}]
set_property PACKAGE_PIN AW23       [get_ports {c1_ddr4_odt[0]}]
set_property PACKAGE_PIN AY25       [get_ports {c1_ddr4_adr[8]}]
set_property PACKAGE_PIN AY23       [get_ports {c1_ddr4_adr[5]}]
set_property PACKAGE_PIN AY22       [get_ports {c1_ddr4_adr[4]}]
set_property PACKAGE_PIN BB25       [get_ports {c1_ddr4_cke[0]}]
set_property PACKAGE_PIN BA23       [get_ports {c1_ddr4_adr[9]}]
set_property PACKAGE_PIN BA22       [get_ports {c1_ddr4_adr[7]}]
set_property PACKAGE_PIN BC22       [get_ports {c1_ddr4_bg[0]}]
set_property PACKAGE_PIN BB22       [get_ports {c1_ddr4_adr[12]}]
set_property PACKAGE_PIN BE25       [get_ports {c1_ddr4_dq[67]}]
set_property PACKAGE_PIN BD25       [get_ports {c1_ddr4_dq[66]}]
set_property PACKAGE_PIN BF25       [get_ports {c1_ddr4_dq[64]}]
set_property PACKAGE_PIN BF24       [get_ports {c1_ddr4_dq[65]}]
set_property PACKAGE_PIN BD24       [get_ports {c1_ddr4_dqs_c[16]}]
set_property PACKAGE_PIN BC24       [get_ports {c1_ddr4_dqs_t[16]}]
set_property PACKAGE_PIN BF23       [get_ports {c1_ddr4_dq[70]}]
set_property PACKAGE_PIN BE23       [get_ports {c1_ddr4_dq[71]}]
set_property PACKAGE_PIN BD23       [get_ports {c1_ddr4_dq[68]}]
set_property PACKAGE_PIN BC23       [get_ports {c1_ddr4_dq[69]}]
set_property PACKAGE_PIN BF22       [get_ports {c1_ddr4_dqs_c[17]}]
set_property PACKAGE_PIN BE22       [get_ports {c1_ddr4_dqs_t[17]}]

set_property PACKAGE_PIN B27        [get_ports {c2_ddr4_dq[26]}]
set_property PACKAGE_PIN B26        [get_ports {c2_ddr4_dq[27]}]
set_property PACKAGE_PIN C26        [get_ports {c2_ddr4_dq[25]}]
set_property PACKAGE_PIN D26        [get_ports {c2_ddr4_dq[24]}]
set_property PACKAGE_PIN A28        [get_ports {c2_ddr4_dqs_c[6]}]
set_property PACKAGE_PIN A27        [get_ports {c2_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN C28        [get_ports {c2_ddr4_dq[31]}]
set_property PACKAGE_PIN C27        [get_ports {c2_ddr4_dq[30]}]
set_property PACKAGE_PIN A30        [get_ports {c2_ddr4_dq[29]}]
set_property PACKAGE_PIN A29        [get_ports {c2_ddr4_dq[28]}]
set_property PACKAGE_PIN B29        [get_ports {c2_ddr4_dqs_c[7]}]
set_property PACKAGE_PIN C29        [get_ports {c2_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN D28        [get_ports {c2_ddr4_dq[19]}]
set_property PACKAGE_PIN E28        [get_ports {c2_ddr4_dq[18]}]
set_property PACKAGE_PIN E27        [get_ports {c2_ddr4_dq[17]}]
set_property PACKAGE_PIN F27        [get_ports {c2_ddr4_dq[16]}]
set_property PACKAGE_PIN D30        [get_ports {c2_ddr4_dqs_c[4]}]
set_property PACKAGE_PIN D29        [get_ports {c2_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN F29        [get_ports {c2_ddr4_dq[23]}]
set_property PACKAGE_PIN F28        [get_ports {c2_ddr4_dq[22]}]
set_property PACKAGE_PIN G27        [get_ports {c2_ddr4_dq[20]}]
set_property PACKAGE_PIN G26        [get_ports {c2_ddr4_dq[21]}]
set_property PACKAGE_PIN H27        [get_ports {c2_ddr4_dqs_c[5]}]
set_property PACKAGE_PIN H26        [get_ports {c2_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN G29        [get_ports {c2_ddr4_dq[11]}]
set_property PACKAGE_PIN H29        [get_ports {c2_ddr4_dq[9]}]
set_property PACKAGE_PIN H28        [get_ports {c2_ddr4_dq[10]}]
set_property PACKAGE_PIN J28        [get_ports {c2_ddr4_dq[8]}]
set_property PACKAGE_PIN J26        [get_ports {c2_ddr4_dqs_c[2]}]
set_property PACKAGE_PIN J25        [get_ports {c2_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN K27        [get_ports {c2_ddr4_dq[15]}]
set_property PACKAGE_PIN L27        [get_ports {c2_ddr4_dq[13]}]
set_property PACKAGE_PIN K26        [get_ports {c2_ddr4_dq[14]}]
set_property PACKAGE_PIN K25        [get_ports {c2_ddr4_dq[12]}]
set_property PACKAGE_PIN L28        [get_ports {c2_ddr4_dqs_c[3]}]
set_property PACKAGE_PIN M27        [get_ports {c2_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN L25        [get_ports {c2_ddr4_dq[3]}]
set_property PACKAGE_PIN M25        [get_ports {c2_ddr4_dq[2]}]
set_property PACKAGE_PIN P25        [get_ports {c2_ddr4_dq[1]}]
set_property PACKAGE_PIN R25        [get_ports {c2_ddr4_dq[0]}]
set_property PACKAGE_PIN M26        [get_ports {c2_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN N26        [get_ports {c2_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN P26        [get_ports {c2_ddr4_dq[4]}]
set_property PACKAGE_PIN R26        [get_ports {c2_ddr4_dq[5]}]
set_property PACKAGE_PIN N28        [get_ports {c2_ddr4_dq[7]}]
set_property PACKAGE_PIN N27        [get_ports {c2_ddr4_dq[6]}]
set_property PACKAGE_PIN P28        [get_ports {c2_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN R28        [get_ports {c2_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN C31        [get_ports {c2_ddr4_bg[0]}]
set_property PACKAGE_PIN A33        [get_ports {c2_ddr4_adr[1]}]
set_property PACKAGE_PIN A32        [get_ports {c2_ddr4_adr[8]}]
set_property PACKAGE_PIN B32        [get_ports {c2_ddr4_adr[7]}]
set_property PACKAGE_PIN B31        [get_ports {c2_ddr4_act_n}]
set_property PACKAGE_PIN A35        [get_ports {c2_ddr4_adr[14]}]
set_property PACKAGE_PIN A34        [get_ports {c2_ddr4_adr[10]}]
set_property PACKAGE_PIN C33        [get_ports {c2_ddr4_adr[2]}]
set_property PACKAGE_PIN C32        [get_ports {c2_ddr4_adr[6]}]
set_property PACKAGE_PIN B36        [get_ports {c2_ddr4_ba[1]}]
set_property PACKAGE_PIN B35        [get_ports {c2_ddr4_cs_n[0]}]
set_property PACKAGE_PIN B34        [get_ports {c2_ddr4_ck_c[0]}]
set_property PACKAGE_PIN C34        [get_ports {c2_ddr4_ck_t[0]}]
set_property PACKAGE_PIN D31        [get_ports {c2_ddr4_adr[9]}]
set_property PACKAGE_PIN E31        [get_ports {c2_ddr4_adr[11]}]
set_property PACKAGE_PIN J30        [get_ports {c2_ddr4_bg[1]}]
set_property PACKAGE_PIN J29        [get_ports {c2_ddr4_adr[3]}]
set_property PACKAGE_PIN K30        [get_ports {c2_ddr4_adr[16]}]
set_property PACKAGE_PIN D33        [get_ports {c2_ddr4_ba[0]}]
set_property PACKAGE_PIN E33        [get_ports {c2_ddr4_odt[0]}]
set_property PACKAGE_PIN F33        [get_ports {c2_ddr4_adr[13]}]
set_property PACKAGE_PIN G30        [get_ports {c2_ddr4_cke[0]}]
set_property PACKAGE_PIN G32        [get_ports {c2_ddr4_adr[15]}]
set_property PACKAGE_PIN G31        [get_ports {c2_ddr4_adr[5]}]
set_property PACKAGE_PIN L29        [get_ports {c2_ddr4_adr[0]}]
set_property PACKAGE_PIN H31        [get_ports {c2_ddr4_adr[4]}]
set_property PACKAGE_PIN M30        [get_ports {c2_ddr4_adr[12]}]
set_property PACKAGE_PIN M29        [get_ports {c2_ddr4_par}]
set_property PACKAGE_PIN N29        [get_ports {c2_ddr4_dq[43]}]
set_property PACKAGE_PIN P29        [get_ports {c2_ddr4_dq[42]}]
set_property PACKAGE_PIN P30        [get_ports {c2_ddr4_dq[40]}]
set_property PACKAGE_PIN R30        [get_ports {c2_ddr4_dq[41]}]
set_property PACKAGE_PIN M31        [get_ports {c2_ddr4_dqs_c[10]}]
set_property PACKAGE_PIN N31        [get_ports {c2_ddr4_dqs_t[10]}]
set_property PACKAGE_PIN N32        [get_ports {c2_ddr4_dq[47]}]
set_property PACKAGE_PIN P31        [get_ports {c2_ddr4_dq[46]}]
set_property PACKAGE_PIN L32        [get_ports {c2_ddr4_dq[44]}]
set_property PACKAGE_PIN M32        [get_ports {c2_ddr4_dq[45]}]
set_property PACKAGE_PIN R31        [get_ports {c2_ddr4_dqs_c[11]}]
set_property PACKAGE_PIN T30        [get_ports {c2_ddr4_dqs_t[11]}]
set_property PACKAGE_PIN A38        [get_ports {c2_ddr4_dq[67]}]
set_property PACKAGE_PIN A37        [get_ports {c2_ddr4_dq[66]}]
set_property PACKAGE_PIN B37        [get_ports {c2_ddr4_dq[65]}]
set_property PACKAGE_PIN C36        [get_ports {c2_ddr4_dq[64]}]
set_property PACKAGE_PIN A39        [get_ports {c2_ddr4_dqs_c[16]}]
set_property PACKAGE_PIN B39        [get_ports {c2_ddr4_dqs_t[16]}]
set_property PACKAGE_PIN C39        [get_ports {c2_ddr4_dq[68]}]
set_property PACKAGE_PIN D39        [get_ports {c2_ddr4_dq[69]}]
set_property PACKAGE_PIN A40        [get_ports {c2_ddr4_dq[70]}]
set_property PACKAGE_PIN B40        [get_ports {c2_ddr4_dq[71]}]
set_property PACKAGE_PIN C38        [get_ports {c2_ddr4_dqs_c[17]}]
set_property PACKAGE_PIN C37        [get_ports {c2_ddr4_dqs_t[17]}]
set_property PACKAGE_PIN D36        [get_ports {c2_ddr4_reset_n}]
set_property PACKAGE_PIN D38        [get_ports {c2_ddr4_dq[34]}]
set_property PACKAGE_PIN E38        [get_ports {c2_ddr4_dq[33]}]
set_property PACKAGE_PIN E35        [get_ports {c2_ddr4_dq[35]}]
set_property PACKAGE_PIN F35        [get_ports {c2_ddr4_dq[32]}]
set_property PACKAGE_PIN E40        [get_ports {c2_ddr4_dqs_c[8]}]
set_property PACKAGE_PIN E39        [get_ports {c2_ddr4_dqs_t[8]}]
set_property PACKAGE_PIN F38        [get_ports {c2_ddr4_dq[38]}]
set_property PACKAGE_PIN G38        [get_ports {c2_ddr4_dq[39]}]
set_property PACKAGE_PIN E37        [get_ports {c2_ddr4_dq[37]}]
set_property PACKAGE_PIN E36        [get_ports {c2_ddr4_dq[36]}]
set_property PACKAGE_PIN F37        [get_ports {c2_ddr4_dqs_c[9]}]
set_property PACKAGE_PIN G37        [get_ports {c2_ddr4_dqs_t[9]}]
set_property PACKAGE_PIN H37        [get_ports {c2_ddr4_dq[58]}]
set_property PACKAGE_PIN J36        [get_ports {c2_ddr4_dq[59]}]
set_property PACKAGE_PIN G36        [get_ports {c2_ddr4_dq[57]}]
set_property PACKAGE_PIN H36        [get_ports {c2_ddr4_dq[56]}]
set_property PACKAGE_PIN H38        [get_ports {c2_ddr4_dqs_c[14]}]
set_property PACKAGE_PIN J38        [get_ports {c2_ddr4_dqs_t[14]}]
set_property PACKAGE_PIN G35        [get_ports {c2_ddr4_dq[62]}]
set_property PACKAGE_PIN G34        [get_ports {c2_ddr4_dq[63]}]
set_property PACKAGE_PIN K38        [get_ports {c2_ddr4_dq[61]}]
set_property PACKAGE_PIN K37        [get_ports {c2_ddr4_dq[60]}]
set_property PACKAGE_PIN H34        [get_ports {c2_ddr4_dqs_c[15]}]
set_property PACKAGE_PIN H33        [get_ports {c2_ddr4_dqs_t[15]}]
set_property PACKAGE_PIN J35        [get_ports {c2_ddr4_dq[48]}]
set_property PACKAGE_PIN K35        [get_ports {c2_ddr4_dq[49]}]
set_property PACKAGE_PIN K33        [get_ports {c2_ddr4_dq[51]}]
set_property PACKAGE_PIN L33        [get_ports {c2_ddr4_dq[50]}]
set_property PACKAGE_PIN L36        [get_ports {c2_ddr4_dqs_c[12]}]
set_property PACKAGE_PIN L35        [get_ports {c2_ddr4_dqs_t[12]}]
set_property PACKAGE_PIN J34        [get_ports {c2_ddr4_dq[52]}]
set_property PACKAGE_PIN J33        [get_ports {c2_ddr4_dq[53]}]
set_property PACKAGE_PIN N34        [get_ports {c2_ddr4_dq[54]}]
set_property PACKAGE_PIN P34        [get_ports {c2_ddr4_dq[55]}]
set_property PACKAGE_PIN L34        [get_ports {c2_ddr4_dqs_c[13]}]
set_property PACKAGE_PIN M34        [get_ports {c2_ddr4_dqs_t[13]}]

set_property PACKAGE_PIN A22        [get_ports {c3_ddr4_dq[33]}]
set_property PACKAGE_PIN A23        [get_ports {c3_ddr4_dq[32]}]
set_property PACKAGE_PIN B24        [get_ports {c3_ddr4_dq[34]}]
set_property PACKAGE_PIN B25        [get_ports {c3_ddr4_dq[35]}]
set_property PACKAGE_PIN A24        [get_ports {c3_ddr4_dqs_c[8]}]
set_property PACKAGE_PIN A25        [get_ports {c3_ddr4_dqs_t[8]}]
set_property PACKAGE_PIN C23        [get_ports {c3_ddr4_dq[39]}]
set_property PACKAGE_PIN C24        [get_ports {c3_ddr4_dq[38]}]
set_property PACKAGE_PIN B22        [get_ports {c3_ddr4_dq[36]}]
set_property PACKAGE_PIN C22        [get_ports {c3_ddr4_dq[37]}]
set_property PACKAGE_PIN D23        [get_ports {c3_ddr4_dqs_c[9]}]
set_property PACKAGE_PIN D24        [get_ports {c3_ddr4_dqs_t[9]}]
set_property PACKAGE_PIN G21        [get_ports {c3_ddr4_dq[59]}]
set_property PACKAGE_PIN G22        [get_ports {c3_ddr4_dq[58]}]
set_property PACKAGE_PIN E22        [get_ports {c3_ddr4_dq[57]}]
set_property PACKAGE_PIN F22        [get_ports {c3_ddr4_dq[56]}]
set_property PACKAGE_PIN E23        [get_ports {c3_ddr4_dqs_c[14]}]
set_property PACKAGE_PIN F23        [get_ports {c3_ddr4_dqs_t[14]}]
set_property PACKAGE_PIN E25        [get_ports {c3_ddr4_dq[61]}]
set_property PACKAGE_PIN F25        [get_ports {c3_ddr4_dq[62]}]
set_property PACKAGE_PIN F24        [get_ports {c3_ddr4_dq[60]}]
set_property PACKAGE_PIN G25        [get_ports {c3_ddr4_dq[63]}]
set_property PACKAGE_PIN H22        [get_ports {c3_ddr4_dqs_c[15]}]
set_property PACKAGE_PIN H23        [get_ports {c3_ddr4_dqs_t[15]}]
set_property PACKAGE_PIN G24        [get_ports {c3_ddr4_dq[11]}]
set_property PACKAGE_PIN H24        [get_ports {c3_ddr4_dq[10]}]
set_property PACKAGE_PIN J23        [get_ports {c3_ddr4_dq[9]}]
set_property PACKAGE_PIN J24        [get_ports {c3_ddr4_dq[8]}]
set_property PACKAGE_PIN H21        [get_ports {c3_ddr4_dqs_c[2]}]
set_property PACKAGE_PIN J21        [get_ports {c3_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN L23        [get_ports {c3_ddr4_dq[13]}]
set_property PACKAGE_PIN L24        [get_ports {c3_ddr4_dq[12]}]
set_property PACKAGE_PIN K21        [get_ports {c3_ddr4_dq[15]}]
set_property PACKAGE_PIN K22        [get_ports {c3_ddr4_dq[14]}]
set_property PACKAGE_PIN L22        [get_ports {c3_ddr4_dqs_c[3]}]
set_property PACKAGE_PIN M22        [get_ports {c3_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN R23        [get_ports {c3_ddr4_dq[3]}]
set_property PACKAGE_PIN T24        [get_ports {c3_ddr4_dq[2]}]
set_property PACKAGE_PIN N24        [get_ports {c3_ddr4_dq[1]}]
set_property PACKAGE_PIN P24        [get_ports {c3_ddr4_dq[0]}]
set_property PACKAGE_PIN R22        [get_ports {c3_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN T22        [get_ports {c3_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN N23        [get_ports {c3_ddr4_dq[4]}]
set_property PACKAGE_PIN P23        [get_ports {c3_ddr4_dq[6]}]
set_property PACKAGE_PIN P21        [get_ports {c3_ddr4_dq[5]}]
set_property PACKAGE_PIN R21        [get_ports {c3_ddr4_dq[7]}]
set_property PACKAGE_PIN N21        [get_ports {c3_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN N22        [get_ports {c3_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN C18        [get_ports {c3_ddr4_dq[41]}]
set_property PACKAGE_PIN C19        [get_ports {c3_ddr4_dq[40]}]
set_property PACKAGE_PIN B21        [get_ports {c3_ddr4_dq[43]}]
set_property PACKAGE_PIN C21        [get_ports {c3_ddr4_dq[42]}]
set_property PACKAGE_PIN B17        [get_ports {c3_ddr4_dqs_c[10]}]
set_property PACKAGE_PIN C17        [get_ports {c3_ddr4_dqs_t[10]}]
set_property PACKAGE_PIN A20        [get_ports {c3_ddr4_dq[46]}]
set_property PACKAGE_PIN B20        [get_ports {c3_ddr4_dq[47]}]
set_property PACKAGE_PIN A17        [get_ports {c3_ddr4_dq[45]}]
set_property PACKAGE_PIN A18        [get_ports {c3_ddr4_dq[44]}]
set_property PACKAGE_PIN A19        [get_ports {c3_ddr4_dqs_c[11]}]
set_property PACKAGE_PIN B19        [get_ports {c3_ddr4_dqs_t[11]}]
set_property PACKAGE_PIN D21        [get_ports {c3_ddr4_reset_n}]
set_property PACKAGE_PIN E17        [get_ports {c3_ddr4_dq[48]}]
set_property PACKAGE_PIN E18        [get_ports {c3_ddr4_dq[50]}]
set_property PACKAGE_PIN E20        [get_ports {c3_ddr4_dq[51]}]
set_property PACKAGE_PIN F20        [get_ports {c3_ddr4_dq[49]}]
set_property PACKAGE_PIN F17        [get_ports {c3_ddr4_dqs_c[12]}]
set_property PACKAGE_PIN F18        [get_ports {c3_ddr4_dqs_t[12]}]
set_property PACKAGE_PIN D19        [get_ports {c3_ddr4_dq[52]}]
set_property PACKAGE_PIN D20        [get_ports {c3_ddr4_dq[53]}]
set_property PACKAGE_PIN H18        [get_ports {c3_ddr4_dq[54]}]
set_property PACKAGE_PIN J18        [get_ports {c3_ddr4_dq[55]}]
set_property PACKAGE_PIN G19        [get_ports {c3_ddr4_dqs_c[13]}]
set_property PACKAGE_PIN H19        [get_ports {c3_ddr4_dqs_t[13]}]
set_property PACKAGE_PIN G17        [get_ports {c3_ddr4_dq[19]}]
set_property PACKAGE_PIN H17        [get_ports {c3_ddr4_dq[17]}]
set_property PACKAGE_PIN F19        [get_ports {c3_ddr4_dq[18]}]
set_property PACKAGE_PIN G20        [get_ports {c3_ddr4_dq[16]}]
set_property PACKAGE_PIN K20        [get_ports {c3_ddr4_dqs_c[4]}]
set_property PACKAGE_PIN L20        [get_ports {c3_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN J19        [get_ports {c3_ddr4_dq[23]}]
set_property PACKAGE_PIN J20        [get_ports {c3_ddr4_dq[20]}]
set_property PACKAGE_PIN L18        [get_ports {c3_ddr4_dq[22]}]
set_property PACKAGE_PIN L19        [get_ports {c3_ddr4_dq[21]}]
set_property PACKAGE_PIN K17        [get_ports {c3_ddr4_dqs_c[5]}]
set_property PACKAGE_PIN K18        [get_ports {c3_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN R17        [get_ports {c3_ddr4_dq[27]}]
set_property PACKAGE_PIN R18        [get_ports {c3_ddr4_dq[26]}]
set_property PACKAGE_PIN M19        [get_ports {c3_ddr4_dq[24]}]
set_property PACKAGE_PIN M20        [get_ports {c3_ddr4_dq[25]}]
set_property PACKAGE_PIN P18        [get_ports {c3_ddr4_dqs_c[6]}]
set_property PACKAGE_PIN P19        [get_ports {c3_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN N18        [get_ports {c3_ddr4_dq[30]}]
set_property PACKAGE_PIN N19        [get_ports {c3_ddr4_dq[31]}]
set_property PACKAGE_PIN R20        [get_ports {c3_ddr4_dq[28]}]
set_property PACKAGE_PIN T20        [get_ports {c3_ddr4_dq[29]}]
set_property PACKAGE_PIN M17        [get_ports {c3_ddr4_dqs_c[7]}]
set_property PACKAGE_PIN N17        [get_ports {c3_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN A13        [get_ports {c3_ddr4_adr[9]}]
set_property PACKAGE_PIN B13        [get_ports {c3_ddr4_adr[12]}]
set_property PACKAGE_PIN B16        [get_ports {c3_ddr4_cs_n[0]}]
set_property PACKAGE_PIN C16        [get_ports {c3_ddr4_odt[0]}]
set_property PACKAGE_PIN C13        [get_ports {c3_ddr4_adr[11]}]
set_property PACKAGE_PIN D13        [get_ports {c3_ddr4_bg[0]}]
set_property PACKAGE_PIN A15        [get_ports {c3_ddr4_adr[3]}]
set_property PACKAGE_PIN B15        [get_ports {c3_ddr4_adr[1]}]
set_property PACKAGE_PIN C14        [get_ports {c3_ddr4_adr[4]}]
set_property PACKAGE_PIN D14        [get_ports {c3_ddr4_adr[10]}]
set_property PACKAGE_PIN A14        [get_ports {c3_ddr4_adr[5]}]
set_property PACKAGE_PIN B14        [get_ports {c3_ddr4_adr[6]}]
set_property PACKAGE_PIN D15        [get_ports {c3_ddr4_adr[14]}]
set_property PACKAGE_PIN F14        [get_ports {c3_ddr4_adr[2]}]
set_property PACKAGE_PIN F15        [get_ports {c3_ddr4_adr[16]}]
set_property PACKAGE_PIN E15        [get_ports {c3_ddr4_adr[15]}]
set_property PACKAGE_PIN E13        [get_ports {c3_ddr4_adr[7]}]
set_property PACKAGE_PIN F13        [get_ports {c3_ddr4_adr[8]}]
set_property PACKAGE_PIN H13        [get_ports {c3_ddr4_act_n}]
set_property PACKAGE_PIN H14        [get_ports {c3_ddr4_ba[1]}]
set_property PACKAGE_PIN K13        [get_ports {c3_ddr4_cke[0]}]
set_property PACKAGE_PIN J13        [get_ports {c3_ddr4_bg[1]}]
set_property PACKAGE_PIN J14        [get_ports {c3_ddr4_par}]
set_property PACKAGE_PIN L13        [get_ports {c3_ddr4_ck_c[0]}]
set_property PACKAGE_PIN L14        [get_ports {c3_ddr4_ck_t[0]}]
set_property PACKAGE_PIN J15        [get_ports {c3_ddr4_ba[0]}]
set_property PACKAGE_PIN K16        [get_ports {c3_ddr4_adr[13]}]
set_property PACKAGE_PIN K15        [get_ports {c3_ddr4_adr[0]}]
set_property PACKAGE_PIN M16        [get_ports {c3_ddr4_dq[64]}]
set_property PACKAGE_PIN N16        [get_ports {c3_ddr4_dq[65]}]
set_property PACKAGE_PIN N13        [get_ports {c3_ddr4_dq[66]}]
set_property PACKAGE_PIN N14        [get_ports {c3_ddr4_dq[67]}]
set_property PACKAGE_PIN P15        [get_ports {c3_ddr4_dqs_c[16]}]
set_property PACKAGE_PIN R16        [get_ports {c3_ddr4_dqs_t[16]}]
set_property PACKAGE_PIN P13        [get_ports {c3_ddr4_dq[70]}]
set_property PACKAGE_PIN P14        [get_ports {c3_ddr4_dq[71]}]
set_property PACKAGE_PIN R15        [get_ports {c3_ddr4_dq[69]}]
set_property PACKAGE_PIN T15        [get_ports {c3_ddr4_dq[68]}]
set_property PACKAGE_PIN R13        [get_ports {c3_ddr4_dqs_c[17]}]
set_property PACKAGE_PIN T13        [get_ports {c3_ddr4_dqs_t[17]}]