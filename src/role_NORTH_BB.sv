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

endmodule
