/* Sanjay Rai - Routine to access PCIe via  dev.mem mmap  */
#ifndef SRAI_ACCEL_UTILS_H_
#define SRAI_ACCEL_UTILS_H_

#define PAGE_SIZE (1*1024UL*1024UL)

/* Address Ranges as defined in VIvado IPI Address map */
/* NOTE: Be aware on any PCIe-AXI Address translation setup on the xDMA/PCIEBridge*/ 
/*       These address translations affect the address shown . THese address are  */
/*       exactly waht is populated on the IPI Address tab                         */
/* AXI MM Register interfaces */
#define AXI_MM_DDR4_BASE_NORTH_in_C0      0x000000000ULL
#define AXI_MM_DDR4_BASE_NORTH_in_C2      0x100000000ULL
#define AXI_MM_DDR4_BASE_NORTH_results_C0 0x080000000ULL
#define AXI_MM_DDR4_BASE_NORTH_results_C2 0x140000000ULL


/* AXI LITE Register interfaces */
#define AXI_LITE_GPIO_BASE             0x00010000UL
#define AXI_LITE_PROG_CLOCK_BASE       0x00020000UL
#define AXI_LITE_ICAP_BASE             0x00030000UL
#define AXI_LITE_PR_HLS_NORTH_BASE     0x00040000UL
#define AXI_LITE_SCRATCH_PAD_BRAM      0x000F0000UL

/* Address Offset of various Peripheral Registers */ 
#define ICAP_CNTRL_REG              AXI_LITE_ICAP_BASE + 0x10CUL
#define ICAP_STATUS_REG             AXI_LITE_ICAP_BASE + 0x110UL
#define ICAP_WR_FIFO_REG            AXI_LITE_ICAP_BASE + 0x100UL
#define ICAP_WR_FIFO_VACANCY_REG    AXI_LITE_ICAP_BASE + 0x114UL
#define PR_HLS_NORTH_CONTROL_REG          AXI_LITE_PR_HLS_NORTH_BASE + 0x0UL
#define PR_HLS_NORTH_IN0_ADDR_OFFSET      AXI_LITE_PR_HLS_NORTH_BASE + 0x10UL
#define PR_HLS_NORTH_OUT0_ADDR_OFFSET     AXI_LITE_PR_HLS_NORTH_BASE + 0x1CUL
#define PR_HLS_NORTH_NUMBER_OF_DATA_SETS  AXI_LITE_PR_HLS_NORTH_BASE + 0x28UL
#define PROG_CLOCK_STATUS_REGISTER        AXI_LITE_PROG_CLOCK_BASE + 0x004UL
#define PROG_CLOCK_DIVIDE_REGISTER        AXI_LITE_PROG_CLOCK_BASE + 0x208UL
#define PROG_CLOCK_CONTROL_REGISTER       AXI_LITE_PROG_CLOCK_BASE + 0x25CUL

#define ISOLATE_NORTH_PR     0x00000000UL
#define DEISOLATE_NORTH_PR   0xFFFFFFFFUL


int fpga_clean (fpga_xDMA *my_fpga_xDMA_ptr, fpga_mmio *fpga_AXI_Lite_ptr);
void fpga_PCIE_BANDWIDTH_test (fpga_xDMA *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS,  char *A_IN, uint32_t xfer_size);
void fpga_PCIE_BANDWIDTH_test64 (fpga_xDMA *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS,  char *A_IN, uint32_t xfer_size);
void fpga_PROGRAM_NORTH_PR (fpga_mmio *fpga_AXI_Lite_ptr, string PR_binFile_name);
int fpga_xfer_data_to_card_NORTH(fpga_xDMA *my_fpga_xDMA_ptr, fpga_mmio *fpga_AXI_Lite_ptr, uint32_t AXI_ADDRESS, char *data_buf_ptr, uint32_t XFER_SIZE);
int fpga_xfer_data_to_card_NORTH64(fpga_xDMA *my_fpga_xDMA_ptr, fpga_mmio *fpga_AXI_Lite_ptr, uint64_t AXI_ADDRESS, char *data_buf_ptr, uint32_t XFER_SIZE);
int fpga_xfer_data_from_card(fpga_xDMA *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS_RESULTS, char *data_buf_ptr, uint32_t XFER_SIZE);
int fpga_xfer_data_from_card64(fpga_xDMA *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS_RESULTS, char *data_buf_ptr, uint32_t XFER_SIZE);
void fpga_run_NORTH_PR(fpga_mmio *fpga_AXI_Lite_ptr, uint32_t AXI_ADDRESS_in0, uint32_t AXI_ADDRESS_RESULTS, uint32_t NUM_OF_DATA_SETS);
void fpga_run_NORTH_PR64(fpga_mmio *fpga_AXI_Lite_ptr, uint64_t AXI_ADDRESS_in0, uint64_t AXI_ADDRESS_RESULTS, uint32_t NUM_OF_DATA_SETS);
int  fpga_check_compute_done_NORTH_PR (fpga_mmio *fpga_AXI_Lite_ptr);
void fpga_test_AXIL_LITE_8KSCRATCHPAD_BRAM (fpga_mmio *fpga_AXI_Lite_ptr);
int ICAP_prog_PR_binfile (fpga_mmio *fpga_AXI_Lite_ptr, string PR_binFile_name);
int xDMA_througput_h2c (fpga_xDMA *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS,  char *data_buffer, uint32_t xfer_size);
int xDMA_througput_h2c64 (fpga_xDMA *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS, char *data_buffer, uint32_t xfer_size);
int xDMA_througput_c2h (fpga_xDMA *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS, char *data_buffer, uint32_t xfer_size);
int xDMA_througput_c2h64 (fpga_xDMA *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS, char *data_buffer, uint32_t xfer_size);
void fpga_PROGRAM_PR_CLOCK (fpga_mmio *fpga_AXI_Lite_ptr, float PR_Frequency);
#endif // SRAI_ACCEL_UTILS_H_
