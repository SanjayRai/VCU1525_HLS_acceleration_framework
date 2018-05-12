// Sanjay Rai (sanjay.d.rai@gmail.com)
//
`timescale 1 ps / 1 ps

module VU9P_AXI_ICAP_PR_DESIGN_top (
  input c1_sys_clk_n,
  input c1_sys_clk_p,
  output c1_ddr4_act_n,
  output [16:0]c1_ddr4_adr,
  output [1:0]c1_ddr4_ba,
  output [1:0]c1_ddr4_bg,
  output [0:0]c1_ddr4_ck_c,
  output [0:0]c1_ddr4_ck_t,
  output [0:0]c1_ddr4_cke,
  output [0:0]c1_ddr4_cs_n,
  inout [71:0]c1_ddr4_dq,
  inout [17:0]c1_ddr4_dqs_c,
  inout [17:0]c1_ddr4_dqs_t,
  output [0:0]c1_ddr4_odt,
  output c1_ddr4_par,
  output c1_ddr4_reset_n,
  input [15:0]pcie_mgt_rxn,
  input [15:0]pcie_mgt_rxp,
  output [15:0]pcie_mgt_txn,
  output [15:0]pcie_mgt_txp,
  input         sys_clk_p,
  input         sys_clk_n,
  input         sys_rst_n );

  wire sys_rst_n_c;
  wire sys_clk;
  wire sys_clk_gt;
  wire clk_out_125M;
  wire clk_out_250M;
  wire clk_out_PROG;
  wire axi_reset_n_out;



  IBUF   sys_reset_n_ibuf (.O(sys_rst_n_c), .I(sys_rst_n));
  IBUFDS_GTE4 refclk_ibuf (.O(sys_clk_gt), .ODIV2(sys_clk), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));

  srai_accel_AXI_MM_intfc AXI_MM_FROM_HLS_PR ();
  srai_accel_AXI_LITE_intfc M_AXI_LITE_TO_HLS_PR();

  shell_top U_shell_top (
        .C1_SYS_CLK_clk_n(c1_sys_clk_n),
        .C1_SYS_CLK_clk_p(c1_sys_clk_p),
        .DDR4_sys_rst(1'b0),
        .M_AXI_LITE_TO_HLS_PR_NORTH(M_AXI_LITE_TO_HLS_PR.master),
        .S_AXI_MM_FROM_HLS_PR_NORTH(AXI_MM_FROM_HLS_PR.slave),
        .axi_reset_n_out(axi_reset_n_out),
        .c1_ddr4_act_n(c1_ddr4_act_n),
        .c1_ddr4_adr(c1_ddr4_adr),
        .c1_ddr4_ba(c1_ddr4_ba),
        .c1_ddr4_bg(c1_ddr4_bg),
        .c1_ddr4_ck_c(c1_ddr4_ck_c),
        .c1_ddr4_ck_t(c1_ddr4_ck_t),
        .c1_ddr4_cke(c1_ddr4_cke),
        .c1_ddr4_cs_n(c1_ddr4_cs_n),
        .c1_ddr4_par(c1_ddr4_par),
        .c1_ddr4_dq(c1_ddr4_dq),
        .c1_ddr4_dqs_c(c1_ddr4_dqs_c),
        .c1_ddr4_dqs_t(c1_ddr4_dqs_t),
        .c1_ddr4_odt(c1_ddr4_odt),
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
        .sys_rst_n(sys_rst_n_c));


  role_NORTH U_role_NORTH (
        .AXI_RESET_N(axi_reset_n_out),
        .CLK_IN_250(clk_out_250M),
        .CLK_IN_125M(clk_out_125M),
        .CLK_IN_PROG(clk_out_PROG),
        .M_AXI_NORTH_TO_STATIC(AXI_MM_FROM_HLS_PR.master),
        .S_AXI_LITE_FROM_STATIC(M_AXI_LITE_TO_HLS_PR.slave));


endmodule