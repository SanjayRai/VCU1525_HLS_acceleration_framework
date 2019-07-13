//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Fri Jul 12 14:38:55 2019
//Host        : mc32gblnx running 64-bit CentOS Linux release 7.6.1810 (Core)
//Command     : generate_target PCIe_Bridge_ICAP_complex_wrapper.bd
//Design      : PCIe_Bridge_ICAP_complex_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module PCIe_Bridge_ICAP_complex_wrapper
   (C1_SYS_CLK_clk_n,
    C1_SYS_CLK_clk_p,
    DDR4_sys_rst,
    M_AXI_LITE_TO_HLS_PR_NORTH_araddr,
    M_AXI_LITE_TO_HLS_PR_NORTH_arprot,
    M_AXI_LITE_TO_HLS_PR_NORTH_arready,
    M_AXI_LITE_TO_HLS_PR_NORTH_arvalid,
    M_AXI_LITE_TO_HLS_PR_NORTH_awaddr,
    M_AXI_LITE_TO_HLS_PR_NORTH_awprot,
    M_AXI_LITE_TO_HLS_PR_NORTH_awready,
    M_AXI_LITE_TO_HLS_PR_NORTH_awvalid,
    M_AXI_LITE_TO_HLS_PR_NORTH_bready,
    M_AXI_LITE_TO_HLS_PR_NORTH_bresp,
    M_AXI_LITE_TO_HLS_PR_NORTH_bvalid,
    M_AXI_LITE_TO_HLS_PR_NORTH_rdata,
    M_AXI_LITE_TO_HLS_PR_NORTH_rready,
    M_AXI_LITE_TO_HLS_PR_NORTH_rresp,
    M_AXI_LITE_TO_HLS_PR_NORTH_rvalid,
    M_AXI_LITE_TO_HLS_PR_NORTH_wdata,
    M_AXI_LITE_TO_HLS_PR_NORTH_wready,
    M_AXI_LITE_TO_HLS_PR_NORTH_wstrb,
    M_AXI_LITE_TO_HLS_PR_NORTH_wvalid,
    M_AXI_MM_TO_HLS_PR_NORTH_araddr,
    M_AXI_MM_TO_HLS_PR_NORTH_arburst,
    M_AXI_MM_TO_HLS_PR_NORTH_arcache,
    M_AXI_MM_TO_HLS_PR_NORTH_arid,
    M_AXI_MM_TO_HLS_PR_NORTH_arlen,
    M_AXI_MM_TO_HLS_PR_NORTH_arlock,
    M_AXI_MM_TO_HLS_PR_NORTH_arprot,
    M_AXI_MM_TO_HLS_PR_NORTH_arqos,
    M_AXI_MM_TO_HLS_PR_NORTH_arready,
    M_AXI_MM_TO_HLS_PR_NORTH_arregion,
    M_AXI_MM_TO_HLS_PR_NORTH_arsize,
    M_AXI_MM_TO_HLS_PR_NORTH_arvalid,
    M_AXI_MM_TO_HLS_PR_NORTH_awaddr,
    M_AXI_MM_TO_HLS_PR_NORTH_awburst,
    M_AXI_MM_TO_HLS_PR_NORTH_awcache,
    M_AXI_MM_TO_HLS_PR_NORTH_awid,
    M_AXI_MM_TO_HLS_PR_NORTH_awlen,
    M_AXI_MM_TO_HLS_PR_NORTH_awlock,
    M_AXI_MM_TO_HLS_PR_NORTH_awprot,
    M_AXI_MM_TO_HLS_PR_NORTH_awqos,
    M_AXI_MM_TO_HLS_PR_NORTH_awready,
    M_AXI_MM_TO_HLS_PR_NORTH_awregion,
    M_AXI_MM_TO_HLS_PR_NORTH_awsize,
    M_AXI_MM_TO_HLS_PR_NORTH_awvalid,
    M_AXI_MM_TO_HLS_PR_NORTH_bid,
    M_AXI_MM_TO_HLS_PR_NORTH_bready,
    M_AXI_MM_TO_HLS_PR_NORTH_bresp,
    M_AXI_MM_TO_HLS_PR_NORTH_bvalid,
    M_AXI_MM_TO_HLS_PR_NORTH_rdata,
    M_AXI_MM_TO_HLS_PR_NORTH_rid,
    M_AXI_MM_TO_HLS_PR_NORTH_rlast,
    M_AXI_MM_TO_HLS_PR_NORTH_rready,
    M_AXI_MM_TO_HLS_PR_NORTH_rresp,
    M_AXI_MM_TO_HLS_PR_NORTH_rvalid,
    M_AXI_MM_TO_HLS_PR_NORTH_wdata,
    M_AXI_MM_TO_HLS_PR_NORTH_wlast,
    M_AXI_MM_TO_HLS_PR_NORTH_wready,
    M_AXI_MM_TO_HLS_PR_NORTH_wstrb,
    M_AXI_MM_TO_HLS_PR_NORTH_wvalid,
    S_AXI_MM_FROM_HLS_PR_NORTH_araddr,
    S_AXI_MM_FROM_HLS_PR_NORTH_arburst,
    S_AXI_MM_FROM_HLS_PR_NORTH_arcache,
    S_AXI_MM_FROM_HLS_PR_NORTH_arid,
    S_AXI_MM_FROM_HLS_PR_NORTH_arlen,
    S_AXI_MM_FROM_HLS_PR_NORTH_arlock,
    S_AXI_MM_FROM_HLS_PR_NORTH_arprot,
    S_AXI_MM_FROM_HLS_PR_NORTH_arqos,
    S_AXI_MM_FROM_HLS_PR_NORTH_arready,
    S_AXI_MM_FROM_HLS_PR_NORTH_arregion,
    S_AXI_MM_FROM_HLS_PR_NORTH_arsize,
    S_AXI_MM_FROM_HLS_PR_NORTH_arvalid,
    S_AXI_MM_FROM_HLS_PR_NORTH_awaddr,
    S_AXI_MM_FROM_HLS_PR_NORTH_awburst,
    S_AXI_MM_FROM_HLS_PR_NORTH_awcache,
    S_AXI_MM_FROM_HLS_PR_NORTH_awid,
    S_AXI_MM_FROM_HLS_PR_NORTH_awlen,
    S_AXI_MM_FROM_HLS_PR_NORTH_awlock,
    S_AXI_MM_FROM_HLS_PR_NORTH_awprot,
    S_AXI_MM_FROM_HLS_PR_NORTH_awqos,
    S_AXI_MM_FROM_HLS_PR_NORTH_awready,
    S_AXI_MM_FROM_HLS_PR_NORTH_awregion,
    S_AXI_MM_FROM_HLS_PR_NORTH_awsize,
    S_AXI_MM_FROM_HLS_PR_NORTH_awvalid,
    S_AXI_MM_FROM_HLS_PR_NORTH_bid,
    S_AXI_MM_FROM_HLS_PR_NORTH_bready,
    S_AXI_MM_FROM_HLS_PR_NORTH_bresp,
    S_AXI_MM_FROM_HLS_PR_NORTH_bvalid,
    S_AXI_MM_FROM_HLS_PR_NORTH_rdata,
    S_AXI_MM_FROM_HLS_PR_NORTH_rid,
    S_AXI_MM_FROM_HLS_PR_NORTH_rlast,
    S_AXI_MM_FROM_HLS_PR_NORTH_rready,
    S_AXI_MM_FROM_HLS_PR_NORTH_rresp,
    S_AXI_MM_FROM_HLS_PR_NORTH_rvalid,
    S_AXI_MM_FROM_HLS_PR_NORTH_wdata,
    S_AXI_MM_FROM_HLS_PR_NORTH_wlast,
    S_AXI_MM_FROM_HLS_PR_NORTH_wready,
    S_AXI_MM_FROM_HLS_PR_NORTH_wstrb,
    S_AXI_MM_FROM_HLS_PR_NORTH_wvalid,
    axi_reset_n_out,
    c1_ddr4_act_n,
    c1_ddr4_adr,
    c1_ddr4_ba,
    c1_ddr4_bg,
    c1_ddr4_ck_c,
    c1_ddr4_ck_t,
    c1_ddr4_cke,
    c1_ddr4_cs_n,
    c1_ddr4_dq,
    c1_ddr4_dqs_c,
    c1_ddr4_dqs_t,
    c1_ddr4_odt,
    c1_ddr4_par,
    c1_ddr4_reset_n,
    clk_out_125M,
    clk_out_250M,
    clk_out_PROG,
    pcie_mgt_rxn,
    pcie_mgt_rxp,
    pcie_mgt_txn,
    pcie_mgt_txp,
    sys_clk,
    sys_clk_gt,
    sys_rst_n);
  input C1_SYS_CLK_clk_n;
  input C1_SYS_CLK_clk_p;
  input DDR4_sys_rst;
  output [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_araddr;
  output [2:0]M_AXI_LITE_TO_HLS_PR_NORTH_arprot;
  input M_AXI_LITE_TO_HLS_PR_NORTH_arready;
  output M_AXI_LITE_TO_HLS_PR_NORTH_arvalid;
  output [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_awaddr;
  output [2:0]M_AXI_LITE_TO_HLS_PR_NORTH_awprot;
  input M_AXI_LITE_TO_HLS_PR_NORTH_awready;
  output M_AXI_LITE_TO_HLS_PR_NORTH_awvalid;
  output M_AXI_LITE_TO_HLS_PR_NORTH_bready;
  input [1:0]M_AXI_LITE_TO_HLS_PR_NORTH_bresp;
  input M_AXI_LITE_TO_HLS_PR_NORTH_bvalid;
  input [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_rdata;
  output M_AXI_LITE_TO_HLS_PR_NORTH_rready;
  input [1:0]M_AXI_LITE_TO_HLS_PR_NORTH_rresp;
  input M_AXI_LITE_TO_HLS_PR_NORTH_rvalid;
  output [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_wdata;
  input M_AXI_LITE_TO_HLS_PR_NORTH_wready;
  output [3:0]M_AXI_LITE_TO_HLS_PR_NORTH_wstrb;
  output M_AXI_LITE_TO_HLS_PR_NORTH_wvalid;
  output [63:0]M_AXI_MM_TO_HLS_PR_NORTH_araddr;
  output [1:0]M_AXI_MM_TO_HLS_PR_NORTH_arburst;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arcache;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arid;
  output [7:0]M_AXI_MM_TO_HLS_PR_NORTH_arlen;
  output [0:0]M_AXI_MM_TO_HLS_PR_NORTH_arlock;
  output [2:0]M_AXI_MM_TO_HLS_PR_NORTH_arprot;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arqos;
  input M_AXI_MM_TO_HLS_PR_NORTH_arready;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arregion;
  output [2:0]M_AXI_MM_TO_HLS_PR_NORTH_arsize;
  output M_AXI_MM_TO_HLS_PR_NORTH_arvalid;
  output [63:0]M_AXI_MM_TO_HLS_PR_NORTH_awaddr;
  output [1:0]M_AXI_MM_TO_HLS_PR_NORTH_awburst;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awcache;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awid;
  output [7:0]M_AXI_MM_TO_HLS_PR_NORTH_awlen;
  output [0:0]M_AXI_MM_TO_HLS_PR_NORTH_awlock;
  output [2:0]M_AXI_MM_TO_HLS_PR_NORTH_awprot;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awqos;
  input M_AXI_MM_TO_HLS_PR_NORTH_awready;
  output [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awregion;
  output [2:0]M_AXI_MM_TO_HLS_PR_NORTH_awsize;
  output M_AXI_MM_TO_HLS_PR_NORTH_awvalid;
  input [3:0]M_AXI_MM_TO_HLS_PR_NORTH_bid;
  output M_AXI_MM_TO_HLS_PR_NORTH_bready;
  input [1:0]M_AXI_MM_TO_HLS_PR_NORTH_bresp;
  input M_AXI_MM_TO_HLS_PR_NORTH_bvalid;
  input [511:0]M_AXI_MM_TO_HLS_PR_NORTH_rdata;
  input [3:0]M_AXI_MM_TO_HLS_PR_NORTH_rid;
  input M_AXI_MM_TO_HLS_PR_NORTH_rlast;
  output M_AXI_MM_TO_HLS_PR_NORTH_rready;
  input [1:0]M_AXI_MM_TO_HLS_PR_NORTH_rresp;
  input M_AXI_MM_TO_HLS_PR_NORTH_rvalid;
  output [511:0]M_AXI_MM_TO_HLS_PR_NORTH_wdata;
  output M_AXI_MM_TO_HLS_PR_NORTH_wlast;
  input M_AXI_MM_TO_HLS_PR_NORTH_wready;
  output [63:0]M_AXI_MM_TO_HLS_PR_NORTH_wstrb;
  output M_AXI_MM_TO_HLS_PR_NORTH_wvalid;
  input [63:0]S_AXI_MM_FROM_HLS_PR_NORTH_araddr;
  input [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_arburst;
  input [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_arcache;
  input [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_arid;
  input [7:0]S_AXI_MM_FROM_HLS_PR_NORTH_arlen;
  input [0:0]S_AXI_MM_FROM_HLS_PR_NORTH_arlock;
  input [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_arprot;
  input [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_arqos;
  output S_AXI_MM_FROM_HLS_PR_NORTH_arready;
  input [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_arregion;
  input [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_arsize;
  input S_AXI_MM_FROM_HLS_PR_NORTH_arvalid;
  input [63:0]S_AXI_MM_FROM_HLS_PR_NORTH_awaddr;
  input [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_awburst;
  input [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_awcache;
  input [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_awid;
  input [7:0]S_AXI_MM_FROM_HLS_PR_NORTH_awlen;
  input [0:0]S_AXI_MM_FROM_HLS_PR_NORTH_awlock;
  input [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_awprot;
  input [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_awqos;
  output S_AXI_MM_FROM_HLS_PR_NORTH_awready;
  input [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_awregion;
  input [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_awsize;
  input S_AXI_MM_FROM_HLS_PR_NORTH_awvalid;
  output [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_bid;
  input S_AXI_MM_FROM_HLS_PR_NORTH_bready;
  output [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_bresp;
  output S_AXI_MM_FROM_HLS_PR_NORTH_bvalid;
  output [511:0]S_AXI_MM_FROM_HLS_PR_NORTH_rdata;
  output [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_rid;
  output S_AXI_MM_FROM_HLS_PR_NORTH_rlast;
  input S_AXI_MM_FROM_HLS_PR_NORTH_rready;
  output [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_rresp;
  output S_AXI_MM_FROM_HLS_PR_NORTH_rvalid;
  input [511:0]S_AXI_MM_FROM_HLS_PR_NORTH_wdata;
  input S_AXI_MM_FROM_HLS_PR_NORTH_wlast;
  output S_AXI_MM_FROM_HLS_PR_NORTH_wready;
  input [63:0]S_AXI_MM_FROM_HLS_PR_NORTH_wstrb;
  input S_AXI_MM_FROM_HLS_PR_NORTH_wvalid;
  output [0:0]axi_reset_n_out;
  output c1_ddr4_act_n;
  output [16:0]c1_ddr4_adr;
  output [1:0]c1_ddr4_ba;
  output [1:0]c1_ddr4_bg;
  output [0:0]c1_ddr4_ck_c;
  output [0:0]c1_ddr4_ck_t;
  output [0:0]c1_ddr4_cke;
  output [0:0]c1_ddr4_cs_n;
  inout [71:0]c1_ddr4_dq;
  inout [17:0]c1_ddr4_dqs_c;
  inout [17:0]c1_ddr4_dqs_t;
  output [0:0]c1_ddr4_odt;
  output c1_ddr4_par;
  output c1_ddr4_reset_n;
  output clk_out_125M;
  output clk_out_250M;
  output clk_out_PROG;
  input [15:0]pcie_mgt_rxn;
  input [15:0]pcie_mgt_rxp;
  output [15:0]pcie_mgt_txn;
  output [15:0]pcie_mgt_txp;
  input sys_clk;
  input sys_clk_gt;
  input sys_rst_n;

  wire C1_SYS_CLK_clk_n;
  wire C1_SYS_CLK_clk_p;
  wire DDR4_sys_rst;
  wire [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_araddr;
  wire [2:0]M_AXI_LITE_TO_HLS_PR_NORTH_arprot;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_arready;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_arvalid;
  wire [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_awaddr;
  wire [2:0]M_AXI_LITE_TO_HLS_PR_NORTH_awprot;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_awready;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_awvalid;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_bready;
  wire [1:0]M_AXI_LITE_TO_HLS_PR_NORTH_bresp;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_bvalid;
  wire [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_rdata;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_rready;
  wire [1:0]M_AXI_LITE_TO_HLS_PR_NORTH_rresp;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_rvalid;
  wire [31:0]M_AXI_LITE_TO_HLS_PR_NORTH_wdata;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_wready;
  wire [3:0]M_AXI_LITE_TO_HLS_PR_NORTH_wstrb;
  wire M_AXI_LITE_TO_HLS_PR_NORTH_wvalid;
  wire [63:0]M_AXI_MM_TO_HLS_PR_NORTH_araddr;
  wire [1:0]M_AXI_MM_TO_HLS_PR_NORTH_arburst;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arcache;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arid;
  wire [7:0]M_AXI_MM_TO_HLS_PR_NORTH_arlen;
  wire [0:0]M_AXI_MM_TO_HLS_PR_NORTH_arlock;
  wire [2:0]M_AXI_MM_TO_HLS_PR_NORTH_arprot;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arqos;
  wire M_AXI_MM_TO_HLS_PR_NORTH_arready;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_arregion;
  wire [2:0]M_AXI_MM_TO_HLS_PR_NORTH_arsize;
  wire M_AXI_MM_TO_HLS_PR_NORTH_arvalid;
  wire [63:0]M_AXI_MM_TO_HLS_PR_NORTH_awaddr;
  wire [1:0]M_AXI_MM_TO_HLS_PR_NORTH_awburst;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awcache;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awid;
  wire [7:0]M_AXI_MM_TO_HLS_PR_NORTH_awlen;
  wire [0:0]M_AXI_MM_TO_HLS_PR_NORTH_awlock;
  wire [2:0]M_AXI_MM_TO_HLS_PR_NORTH_awprot;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awqos;
  wire M_AXI_MM_TO_HLS_PR_NORTH_awready;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_awregion;
  wire [2:0]M_AXI_MM_TO_HLS_PR_NORTH_awsize;
  wire M_AXI_MM_TO_HLS_PR_NORTH_awvalid;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_bid;
  wire M_AXI_MM_TO_HLS_PR_NORTH_bready;
  wire [1:0]M_AXI_MM_TO_HLS_PR_NORTH_bresp;
  wire M_AXI_MM_TO_HLS_PR_NORTH_bvalid;
  wire [511:0]M_AXI_MM_TO_HLS_PR_NORTH_rdata;
  wire [3:0]M_AXI_MM_TO_HLS_PR_NORTH_rid;
  wire M_AXI_MM_TO_HLS_PR_NORTH_rlast;
  wire M_AXI_MM_TO_HLS_PR_NORTH_rready;
  wire [1:0]M_AXI_MM_TO_HLS_PR_NORTH_rresp;
  wire M_AXI_MM_TO_HLS_PR_NORTH_rvalid;
  wire [511:0]M_AXI_MM_TO_HLS_PR_NORTH_wdata;
  wire M_AXI_MM_TO_HLS_PR_NORTH_wlast;
  wire M_AXI_MM_TO_HLS_PR_NORTH_wready;
  wire [63:0]M_AXI_MM_TO_HLS_PR_NORTH_wstrb;
  wire M_AXI_MM_TO_HLS_PR_NORTH_wvalid;
  wire [63:0]S_AXI_MM_FROM_HLS_PR_NORTH_araddr;
  wire [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_arburst;
  wire [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_arcache;
  wire [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_arid;
  wire [7:0]S_AXI_MM_FROM_HLS_PR_NORTH_arlen;
  wire [0:0]S_AXI_MM_FROM_HLS_PR_NORTH_arlock;
  wire [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_arprot;
  wire [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_arqos;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_arready;
  wire [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_arregion;
  wire [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_arsize;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_arvalid;
  wire [63:0]S_AXI_MM_FROM_HLS_PR_NORTH_awaddr;
  wire [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_awburst;
  wire [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_awcache;
  wire [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_awid;
  wire [7:0]S_AXI_MM_FROM_HLS_PR_NORTH_awlen;
  wire [0:0]S_AXI_MM_FROM_HLS_PR_NORTH_awlock;
  wire [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_awprot;
  wire [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_awqos;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_awready;
  wire [3:0]S_AXI_MM_FROM_HLS_PR_NORTH_awregion;
  wire [2:0]S_AXI_MM_FROM_HLS_PR_NORTH_awsize;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_awvalid;
  wire [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_bid;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_bready;
  wire [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_bresp;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_bvalid;
  wire [511:0]S_AXI_MM_FROM_HLS_PR_NORTH_rdata;
  wire [4:0]S_AXI_MM_FROM_HLS_PR_NORTH_rid;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_rlast;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_rready;
  wire [1:0]S_AXI_MM_FROM_HLS_PR_NORTH_rresp;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_rvalid;
  wire [511:0]S_AXI_MM_FROM_HLS_PR_NORTH_wdata;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_wlast;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_wready;
  wire [63:0]S_AXI_MM_FROM_HLS_PR_NORTH_wstrb;
  wire S_AXI_MM_FROM_HLS_PR_NORTH_wvalid;
  wire [0:0]axi_reset_n_out;
  wire c1_ddr4_act_n;
  wire [16:0]c1_ddr4_adr;
  wire [1:0]c1_ddr4_ba;
  wire [1:0]c1_ddr4_bg;
  wire [0:0]c1_ddr4_ck_c;
  wire [0:0]c1_ddr4_ck_t;
  wire [0:0]c1_ddr4_cke;
  wire [0:0]c1_ddr4_cs_n;
  wire [71:0]c1_ddr4_dq;
  wire [17:0]c1_ddr4_dqs_c;
  wire [17:0]c1_ddr4_dqs_t;
  wire [0:0]c1_ddr4_odt;
  wire c1_ddr4_par;
  wire c1_ddr4_reset_n;
  wire clk_out_125M;
  wire clk_out_250M;
  wire clk_out_PROG;
  wire [15:0]pcie_mgt_rxn;
  wire [15:0]pcie_mgt_rxp;
  wire [15:0]pcie_mgt_txn;
  wire [15:0]pcie_mgt_txp;
  wire sys_clk;
  wire sys_clk_gt;
  wire sys_rst_n;

  PCIe_Bridge_ICAP_complex PCIe_Bridge_ICAP_complex_i
       (.C1_SYS_CLK_clk_n(C1_SYS_CLK_clk_n),
        .C1_SYS_CLK_clk_p(C1_SYS_CLK_clk_p),
        .DDR4_sys_rst(DDR4_sys_rst),
        .M_AXI_LITE_TO_HLS_PR_NORTH_araddr(M_AXI_LITE_TO_HLS_PR_NORTH_araddr),
        .M_AXI_LITE_TO_HLS_PR_NORTH_arprot(M_AXI_LITE_TO_HLS_PR_NORTH_arprot),
        .M_AXI_LITE_TO_HLS_PR_NORTH_arready(M_AXI_LITE_TO_HLS_PR_NORTH_arready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_arvalid(M_AXI_LITE_TO_HLS_PR_NORTH_arvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awaddr(M_AXI_LITE_TO_HLS_PR_NORTH_awaddr),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awprot(M_AXI_LITE_TO_HLS_PR_NORTH_awprot),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awready(M_AXI_LITE_TO_HLS_PR_NORTH_awready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awvalid(M_AXI_LITE_TO_HLS_PR_NORTH_awvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_bready(M_AXI_LITE_TO_HLS_PR_NORTH_bready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_bresp(M_AXI_LITE_TO_HLS_PR_NORTH_bresp),
        .M_AXI_LITE_TO_HLS_PR_NORTH_bvalid(M_AXI_LITE_TO_HLS_PR_NORTH_bvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rdata(M_AXI_LITE_TO_HLS_PR_NORTH_rdata),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rready(M_AXI_LITE_TO_HLS_PR_NORTH_rready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rresp(M_AXI_LITE_TO_HLS_PR_NORTH_rresp),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rvalid(M_AXI_LITE_TO_HLS_PR_NORTH_rvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wdata(M_AXI_LITE_TO_HLS_PR_NORTH_wdata),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wready(M_AXI_LITE_TO_HLS_PR_NORTH_wready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wstrb(M_AXI_LITE_TO_HLS_PR_NORTH_wstrb),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wvalid(M_AXI_LITE_TO_HLS_PR_NORTH_wvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_araddr(M_AXI_MM_TO_HLS_PR_NORTH_araddr),
        .M_AXI_MM_TO_HLS_PR_NORTH_arburst(M_AXI_MM_TO_HLS_PR_NORTH_arburst),
        .M_AXI_MM_TO_HLS_PR_NORTH_arcache(M_AXI_MM_TO_HLS_PR_NORTH_arcache),
        .M_AXI_MM_TO_HLS_PR_NORTH_arid(M_AXI_MM_TO_HLS_PR_NORTH_arid),
        .M_AXI_MM_TO_HLS_PR_NORTH_arlen(M_AXI_MM_TO_HLS_PR_NORTH_arlen),
        .M_AXI_MM_TO_HLS_PR_NORTH_arlock(M_AXI_MM_TO_HLS_PR_NORTH_arlock),
        .M_AXI_MM_TO_HLS_PR_NORTH_arprot(M_AXI_MM_TO_HLS_PR_NORTH_arprot),
        .M_AXI_MM_TO_HLS_PR_NORTH_arqos(M_AXI_MM_TO_HLS_PR_NORTH_arqos),
        .M_AXI_MM_TO_HLS_PR_NORTH_arready(M_AXI_MM_TO_HLS_PR_NORTH_arready),
        .M_AXI_MM_TO_HLS_PR_NORTH_arregion(M_AXI_MM_TO_HLS_PR_NORTH_arregion),
        .M_AXI_MM_TO_HLS_PR_NORTH_arsize(M_AXI_MM_TO_HLS_PR_NORTH_arsize),
        .M_AXI_MM_TO_HLS_PR_NORTH_arvalid(M_AXI_MM_TO_HLS_PR_NORTH_arvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_awaddr(M_AXI_MM_TO_HLS_PR_NORTH_awaddr),
        .M_AXI_MM_TO_HLS_PR_NORTH_awburst(M_AXI_MM_TO_HLS_PR_NORTH_awburst),
        .M_AXI_MM_TO_HLS_PR_NORTH_awcache(M_AXI_MM_TO_HLS_PR_NORTH_awcache),
        .M_AXI_MM_TO_HLS_PR_NORTH_awid(M_AXI_MM_TO_HLS_PR_NORTH_awid),
        .M_AXI_MM_TO_HLS_PR_NORTH_awlen(M_AXI_MM_TO_HLS_PR_NORTH_awlen),
        .M_AXI_MM_TO_HLS_PR_NORTH_awlock(M_AXI_MM_TO_HLS_PR_NORTH_awlock),
        .M_AXI_MM_TO_HLS_PR_NORTH_awprot(M_AXI_MM_TO_HLS_PR_NORTH_awprot),
        .M_AXI_MM_TO_HLS_PR_NORTH_awqos(M_AXI_MM_TO_HLS_PR_NORTH_awqos),
        .M_AXI_MM_TO_HLS_PR_NORTH_awready(M_AXI_MM_TO_HLS_PR_NORTH_awready),
        .M_AXI_MM_TO_HLS_PR_NORTH_awregion(M_AXI_MM_TO_HLS_PR_NORTH_awregion),
        .M_AXI_MM_TO_HLS_PR_NORTH_awsize(M_AXI_MM_TO_HLS_PR_NORTH_awsize),
        .M_AXI_MM_TO_HLS_PR_NORTH_awvalid(M_AXI_MM_TO_HLS_PR_NORTH_awvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_bid(M_AXI_MM_TO_HLS_PR_NORTH_bid),
        .M_AXI_MM_TO_HLS_PR_NORTH_bready(M_AXI_MM_TO_HLS_PR_NORTH_bready),
        .M_AXI_MM_TO_HLS_PR_NORTH_bresp(M_AXI_MM_TO_HLS_PR_NORTH_bresp),
        .M_AXI_MM_TO_HLS_PR_NORTH_bvalid(M_AXI_MM_TO_HLS_PR_NORTH_bvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_rdata(M_AXI_MM_TO_HLS_PR_NORTH_rdata),
        .M_AXI_MM_TO_HLS_PR_NORTH_rid(M_AXI_MM_TO_HLS_PR_NORTH_rid),
        .M_AXI_MM_TO_HLS_PR_NORTH_rlast(M_AXI_MM_TO_HLS_PR_NORTH_rlast),
        .M_AXI_MM_TO_HLS_PR_NORTH_rready(M_AXI_MM_TO_HLS_PR_NORTH_rready),
        .M_AXI_MM_TO_HLS_PR_NORTH_rresp(M_AXI_MM_TO_HLS_PR_NORTH_rresp),
        .M_AXI_MM_TO_HLS_PR_NORTH_rvalid(M_AXI_MM_TO_HLS_PR_NORTH_rvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_wdata(M_AXI_MM_TO_HLS_PR_NORTH_wdata),
        .M_AXI_MM_TO_HLS_PR_NORTH_wlast(M_AXI_MM_TO_HLS_PR_NORTH_wlast),
        .M_AXI_MM_TO_HLS_PR_NORTH_wready(M_AXI_MM_TO_HLS_PR_NORTH_wready),
        .M_AXI_MM_TO_HLS_PR_NORTH_wstrb(M_AXI_MM_TO_HLS_PR_NORTH_wstrb),
        .M_AXI_MM_TO_HLS_PR_NORTH_wvalid(M_AXI_MM_TO_HLS_PR_NORTH_wvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_araddr(S_AXI_MM_FROM_HLS_PR_NORTH_araddr),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arburst(S_AXI_MM_FROM_HLS_PR_NORTH_arburst),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arcache(S_AXI_MM_FROM_HLS_PR_NORTH_arcache),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arid(S_AXI_MM_FROM_HLS_PR_NORTH_arid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arlen(S_AXI_MM_FROM_HLS_PR_NORTH_arlen),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arlock(S_AXI_MM_FROM_HLS_PR_NORTH_arlock),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arprot(S_AXI_MM_FROM_HLS_PR_NORTH_arprot),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arqos(S_AXI_MM_FROM_HLS_PR_NORTH_arqos),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arready(S_AXI_MM_FROM_HLS_PR_NORTH_arready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arregion(S_AXI_MM_FROM_HLS_PR_NORTH_arregion),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arsize(S_AXI_MM_FROM_HLS_PR_NORTH_arsize),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arvalid(S_AXI_MM_FROM_HLS_PR_NORTH_arvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awaddr(S_AXI_MM_FROM_HLS_PR_NORTH_awaddr),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awburst(S_AXI_MM_FROM_HLS_PR_NORTH_awburst),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awcache(S_AXI_MM_FROM_HLS_PR_NORTH_awcache),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awid(S_AXI_MM_FROM_HLS_PR_NORTH_awid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awlen(S_AXI_MM_FROM_HLS_PR_NORTH_awlen),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awlock(S_AXI_MM_FROM_HLS_PR_NORTH_awlock),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awprot(S_AXI_MM_FROM_HLS_PR_NORTH_awprot),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awqos(S_AXI_MM_FROM_HLS_PR_NORTH_awqos),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awready(S_AXI_MM_FROM_HLS_PR_NORTH_awready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awregion(S_AXI_MM_FROM_HLS_PR_NORTH_awregion),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awsize(S_AXI_MM_FROM_HLS_PR_NORTH_awsize),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awvalid(S_AXI_MM_FROM_HLS_PR_NORTH_awvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bid(S_AXI_MM_FROM_HLS_PR_NORTH_bid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bready(S_AXI_MM_FROM_HLS_PR_NORTH_bready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bresp(S_AXI_MM_FROM_HLS_PR_NORTH_bresp),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bvalid(S_AXI_MM_FROM_HLS_PR_NORTH_bvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rdata(S_AXI_MM_FROM_HLS_PR_NORTH_rdata),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rid(S_AXI_MM_FROM_HLS_PR_NORTH_rid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rlast(S_AXI_MM_FROM_HLS_PR_NORTH_rlast),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rready(S_AXI_MM_FROM_HLS_PR_NORTH_rready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rresp(S_AXI_MM_FROM_HLS_PR_NORTH_rresp),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rvalid(S_AXI_MM_FROM_HLS_PR_NORTH_rvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wdata(S_AXI_MM_FROM_HLS_PR_NORTH_wdata),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wlast(S_AXI_MM_FROM_HLS_PR_NORTH_wlast),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wready(S_AXI_MM_FROM_HLS_PR_NORTH_wready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wstrb(S_AXI_MM_FROM_HLS_PR_NORTH_wstrb),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wvalid(S_AXI_MM_FROM_HLS_PR_NORTH_wvalid),
        .axi_reset_n_out(axi_reset_n_out),
        .c1_ddr4_act_n(c1_ddr4_act_n),
        .c1_ddr4_adr(c1_ddr4_adr),
        .c1_ddr4_ba(c1_ddr4_ba),
        .c1_ddr4_bg(c1_ddr4_bg),
        .c1_ddr4_ck_c(c1_ddr4_ck_c),
        .c1_ddr4_ck_t(c1_ddr4_ck_t),
        .c1_ddr4_cke(c1_ddr4_cke),
        .c1_ddr4_cs_n(c1_ddr4_cs_n),
        .c1_ddr4_dq(c1_ddr4_dq),
        .c1_ddr4_dqs_c(c1_ddr4_dqs_c),
        .c1_ddr4_dqs_t(c1_ddr4_dqs_t),
        .c1_ddr4_odt(c1_ddr4_odt),
        .c1_ddr4_par(c1_ddr4_par),
        .c1_ddr4_reset_n(c1_ddr4_reset_n),
        .clk_out_125M(clk_out_125M),
        .clk_out_250M(clk_out_250M),
        .clk_out_PROG(clk_out_PROG),
        .pcie_mgt_rxn(pcie_mgt_rxn),
        .pcie_mgt_rxp(pcie_mgt_rxp),
        .pcie_mgt_txn(pcie_mgt_txn),
        .pcie_mgt_txp(pcie_mgt_txp),
        .sys_clk(sys_clk),
        .sys_clk_gt(sys_clk_gt),
        .sys_rst_n(sys_rst_n));
endmodule
