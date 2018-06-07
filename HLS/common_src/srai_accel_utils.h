/* Sanjay Rai - Routine to access PCIe via  dev.mem mmap  */
#ifndef SRAI_ACCEL_UTILS_H_
#define SRAI_ACCEL_UTILS_H_

#define PAGE_SIZE (32*1024UL*1024UL)

/* Address Ranges as defined in VIvado IPI Address map */
/* NOTE: Be aware on any PCIe-AXI Address translation setup on the xDMA/PCIEBridge*/ 
/*       These address translations affect the address shown . THese address are  */
/*       exactly waht is populated on the IPI Address tab                         */
/* AXI MM Register interfaces */
#define AXI_MM_DDR4_C0         0x1000000000ULL
#define AXI_MM_DDR4_results_C0 0x1080000000ULL
#define AXI_MM_DDR4_C1         0x0000000000ULL
#define AXI_MM_DDR4_results_C1 0x0080000000ULL
#define AXI_MM_DDR4_C2         0x1400000000ULL
#define AXI_MM_DDR4_results_C2 0x1480000000ULL
#define AXI_MM_DDR4_C3         0x1800000000ULL
#define AXI_MM_DDR4_results_C3 0x1880000000ULL


/* AXI LITE Register interfaces */
#define AXI_LITE_GPIO_BASE             0x00010000UL
#define AXI_LITE_PROG_CLOCK_BASE       0x00020000UL
#define AXI_LITE_ICAP_BASE             0x00030000UL
#define AXI_LITE_PR_HLS_NORTH_BASE     0x00100000UL
#define AXI_LITE_AXI_SYSMON_BASE       0x00050000UL
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
#define SYSMON_Temptature_register        AXI_LITE_AXI_SYSMON_BASE + 0x400UL 
#define SYSMON_MAX_Temptature_register    AXI_LITE_AXI_SYSMON_BASE + 0x1c80L 
#define SYSMON_MIN_Temptature_register    AXI_LITE_AXI_SYSMON_BASE + 0x1c90L 

#define ISOLATE_NORTH_PR     0x00000000UL
#define DEISOLATE_NORTH_PR   0xFFFFFFFFUL

typedef struct {
    double current_temp;
    double maximum_temp;
    double minimum_temp;
} SysMon_temp_struct;




int fpga_clean (fpga_xDMA_linux *my_fpga_xDMA_ptr);
void fpga_PCIE_BANDWIDTH_test (fpga_xDMA_linux *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS,  char *A_IN, uint32_t xfer_size);
void fpga_PCIE_BANDWIDTH_test64 (fpga_xDMA_linux *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS,  char *A_IN, uint32_t xfer_size);
void fpga_PROGRAM_NORTH_PR (fpga_xDMA_linux *fpga_AXI_Lite_ptr, string PR_binFile_name);
int fpga_xfer_data_to_card_NORTH(fpga_xDMA_linux *my_fpga_xDMA_ptr, fpga_xDMA_linux *fpga_AXI_Lite_ptr, uint32_t AXI_ADDRESS, char *data_buf_ptr, uint32_t XFER_SIZE);
int fpga_xfer_data_to_card64(fpga_xDMA_linux *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS, char *data_buf_ptr, uint32_t XFER_SIZE);
int fpga_xfer_data_from_card(fpga_xDMA_linux *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS_RESULTS, char *data_buf_ptr, uint32_t XFER_SIZE);
int fpga_xfer_data_from_card64(fpga_xDMA_linux *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS_RESULTS, char *data_buf_ptr, uint32_t XFER_SIZE);
void fpga_run_NORTH_PR(fpga_xDMA_linux *fpga_AXI_Lite_ptr, uint32_t AXI_ADDRESS_in0, uint32_t AXI_ADDRESS_RESULTS, uint32_t NUM_OF_DATA_SETS);
void fpga_run_NORTH_PR64(fpga_xDMA_linux *fpga_AXI_Lite_ptr, uint64_t AXI_ADDRESS_in0, uint64_t AXI_ADDRESS_RESULTS, uint32_t NUM_OF_DATA_SETS);
int  fpga_check_compute_done_NORTH_PR (fpga_xDMA_linux *fpga_AXI_Lite_ptr);
void fpga_test_AXIL_LITE_8KSCRATCHPAD_BRAM (fpga_xDMA_linux *fpga_AXI_Lite_ptr);
int ICAP_prog_PR_binfile (fpga_xDMA_linux *fpga_AXI_Lite_ptr, string PR_binFile_name);
int xDMA_througput_h2c (fpga_xDMA_linux *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS,  char *data_buffer, uint32_t xfer_size);
int xDMA_througput_h2c64 (fpga_xDMA_linux *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS, char *data_buffer, uint32_t xfer_size);
int xDMA_througput_c2h (fpga_xDMA_linux *my_fpga_xDMA_ptr, uint32_t AXI_ADDRESS, char *data_buffer, uint32_t xfer_size);
int xDMA_througput_c2h64 (fpga_xDMA_linux *my_fpga_xDMA_ptr, uint64_t AXI_ADDRESS, char *data_buffer, uint32_t xfer_size);
void fpga_PROGRAM_PR_CLOCK (fpga_xDMA_linux *fpga_AXI_Lite_ptr, float PR_Frequency);
void  fpga_read_temprature (fpga_xDMA_linux *fpga_AXI_Lite_ptr, SysMon_temp_struct *sys_temp, int average_num);
#endif // SRAI_ACCEL_UTILS_H_
