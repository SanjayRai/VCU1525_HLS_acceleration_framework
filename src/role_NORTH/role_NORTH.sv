// Sanjay Rai (sanjay.d.rai@gmail.com)
//
`timescale 1 ps / 1 ps

module role_NORTH (
  input AXI_RESET_N,
  input CLK_IN_125M,
  input CLK_IN_250,
  input CLK_IN_PROG,
  srai_accel_AXI_MM_intfc.master M_AXI_NORTH_TO_STATIC,
  srai_accel_AXI_LITE_intfc.slave S_AXI_LITE_FROM_STATIC);


  HLS_PR_SDX_SRAI HLS_PR_0_i_NORTH
       (.AXI_RESET_N(AXI_RESET_N),
        .CLK_IN_125M(CLK_IN_125M),
        .CLK_IN_250(CLK_IN_250),
        .CLK_IN_PROG(CLK_IN_PROG),
        .M_AXI_TO_STATIC_araddr(M_AXI_NORTH_TO_STATIC.AXI_araddr),
        .M_AXI_TO_STATIC_arburst(M_AXI_NORTH_TO_STATIC.AXI_arburst),
        .M_AXI_TO_STATIC_arcache(M_AXI_NORTH_TO_STATIC.AXI_arcache),
        .M_AXI_TO_STATIC_arlen(M_AXI_NORTH_TO_STATIC.AXI_arlen),
        .M_AXI_TO_STATIC_arlock(M_AXI_NORTH_TO_STATIC.AXI_arlock),
        .M_AXI_TO_STATIC_arprot(M_AXI_NORTH_TO_STATIC.AXI_arprot),
        .M_AXI_TO_STATIC_arqos(M_AXI_NORTH_TO_STATIC.AXI_arqos),
        .M_AXI_TO_STATIC_arready(M_AXI_NORTH_TO_STATIC.AXI_arready),
        .M_AXI_TO_STATIC_arregion(M_AXI_NORTH_TO_STATIC.AXI_arregion),
        .M_AXI_TO_STATIC_arsize(M_AXI_NORTH_TO_STATIC.AXI_arsize),
        .M_AXI_TO_STATIC_arvalid(M_AXI_NORTH_TO_STATIC.AXI_arvalid),
        .M_AXI_TO_STATIC_awaddr(M_AXI_NORTH_TO_STATIC.AXI_awaddr),
        .M_AXI_TO_STATIC_awburst(M_AXI_NORTH_TO_STATIC.AXI_awburst),
        .M_AXI_TO_STATIC_awcache(M_AXI_NORTH_TO_STATIC.AXI_awcache),
        .M_AXI_TO_STATIC_awlen(M_AXI_NORTH_TO_STATIC.AXI_awlen),
        .M_AXI_TO_STATIC_awlock(M_AXI_NORTH_TO_STATIC.AXI_awlock),
        .M_AXI_TO_STATIC_awprot(M_AXI_NORTH_TO_STATIC.AXI_awprot),
        .M_AXI_TO_STATIC_awqos(M_AXI_NORTH_TO_STATIC.AXI_awqos),
        .M_AXI_TO_STATIC_awready(M_AXI_NORTH_TO_STATIC.AXI_awready),
        .M_AXI_TO_STATIC_awregion(M_AXI_NORTH_TO_STATIC.AXI_awregion),
        .M_AXI_TO_STATIC_awsize(M_AXI_NORTH_TO_STATIC.AXI_awsize),
        .M_AXI_TO_STATIC_awvalid(M_AXI_NORTH_TO_STATIC.AXI_awvalid),
        .M_AXI_TO_STATIC_bready(M_AXI_NORTH_TO_STATIC.AXI_bready),
        .M_AXI_TO_STATIC_bresp(M_AXI_NORTH_TO_STATIC.AXI_bresp),
        .M_AXI_TO_STATIC_bvalid(M_AXI_NORTH_TO_STATIC.AXI_bvalid),
        .M_AXI_TO_STATIC_rdata(M_AXI_NORTH_TO_STATIC.AXI_rdata),
        .M_AXI_TO_STATIC_rlast(M_AXI_NORTH_TO_STATIC.AXI_rlast),
        .M_AXI_TO_STATIC_rready(M_AXI_NORTH_TO_STATIC.AXI_rready),
        .M_AXI_TO_STATIC_rresp(M_AXI_NORTH_TO_STATIC.AXI_rresp),
        .M_AXI_TO_STATIC_rvalid(M_AXI_NORTH_TO_STATIC.AXI_rvalid),
        .M_AXI_TO_STATIC_wdata(M_AXI_NORTH_TO_STATIC.AXI_wdata),
        .M_AXI_TO_STATIC_wlast(M_AXI_NORTH_TO_STATIC.AXI_wlast),
        .M_AXI_TO_STATIC_wready(M_AXI_NORTH_TO_STATIC.AXI_wready),
        .M_AXI_TO_STATIC_wstrb(M_AXI_NORTH_TO_STATIC.AXI_wstrb),
        .M_AXI_TO_STATIC_wvalid(M_AXI_NORTH_TO_STATIC.AXI_wvalid),
        .S_AXI_LITE_FROM_STATIC_araddr(S_AXI_LITE_FROM_STATIC.AXI_LITE_araddr),
        .S_AXI_LITE_FROM_STATIC_arprot(S_AXI_LITE_FROM_STATIC.AXI_LITE_arprot),
        .S_AXI_LITE_FROM_STATIC_arready(S_AXI_LITE_FROM_STATIC.AXI_LITE_arready),
        .S_AXI_LITE_FROM_STATIC_arvalid(S_AXI_LITE_FROM_STATIC.AXI_LITE_arvalid),
        .S_AXI_LITE_FROM_STATIC_awaddr(S_AXI_LITE_FROM_STATIC.AXI_LITE_awaddr),
        .S_AXI_LITE_FROM_STATIC_awprot(S_AXI_LITE_FROM_STATIC.AXI_LITE_awprot),
        .S_AXI_LITE_FROM_STATIC_awready(S_AXI_LITE_FROM_STATIC.AXI_LITE_awready),
        .S_AXI_LITE_FROM_STATIC_awvalid(S_AXI_LITE_FROM_STATIC.AXI_LITE_awvalid),
        .S_AXI_LITE_FROM_STATIC_bready(S_AXI_LITE_FROM_STATIC.AXI_LITE_bready),
        .S_AXI_LITE_FROM_STATIC_bresp(S_AXI_LITE_FROM_STATIC.AXI_LITE_bresp),
        .S_AXI_LITE_FROM_STATIC_bvalid(S_AXI_LITE_FROM_STATIC.AXI_LITE_bvalid),
        .S_AXI_LITE_FROM_STATIC_rdata(S_AXI_LITE_FROM_STATIC.AXI_LITE_rdata),
        .S_AXI_LITE_FROM_STATIC_rready(S_AXI_LITE_FROM_STATIC.AXI_LITE_rready),
        .S_AXI_LITE_FROM_STATIC_rresp(S_AXI_LITE_FROM_STATIC.AXI_LITE_rresp),
        .S_AXI_LITE_FROM_STATIC_rvalid(S_AXI_LITE_FROM_STATIC.AXI_LITE_rvalid),
        .S_AXI_LITE_FROM_STATIC_wdata(S_AXI_LITE_FROM_STATIC.AXI_LITE_wdata),
        .S_AXI_LITE_FROM_STATIC_wready(S_AXI_LITE_FROM_STATIC.AXI_LITE_wready),
        .S_AXI_LITE_FROM_STATIC_wstrb(S_AXI_LITE_FROM_STATIC.AXI_LITE_wstrb),
        .S_AXI_LITE_FROM_STATIC_wvalid(S_AXI_LITE_FROM_STATIC.AXI_LITE_wvalid));
endmodule
