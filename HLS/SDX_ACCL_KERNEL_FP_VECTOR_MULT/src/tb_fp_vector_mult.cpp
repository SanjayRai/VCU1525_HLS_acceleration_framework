#include<stdio.h>
#include<math.h>
#include <errno.h>

#include <fstream>
#include <string>
#include <chrono>
#include <cmath>
#include "pcie_memio.h" 
#include "srai_accel_utils.h" 
#include "cycle.h"

#include "sdx_cppKernel_top.h" 
#define ZERO_f 1.0e-4
using namespace std;



double getCPUTime();


void gen_test_data(srai_mem_conv_IN0 *a) {

    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
        for (int i = 0 ; i < SDX_CU_LOCAL_SIZE; i++) {
            for (int x = 0 ; x < NUM_INPUT_KERNEL_FUNCTION_ARGUMENTS; x++) {
                // First Arg set
                for (unsigned int index = 0; index < NUM_ELEMENTS_PER_SDX_DATA_BEAT;index++) {
                    a->my_data_t[index] = (float((rand() % 32768))/327.0f); 
                }
                a++;
            }
        }
    }
}

void print_test_data(srai_mem_conv_IN0 *a) {

printf("\n Input Test Data Set : \n");
for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
    for (int i = 0 ; i < SDX_CU_LOCAL_IN_SIZE; i++) {
        for (unsigned int index = 0; index < NUM_ELEMENTS_PER_SDX_DATA_BEAT;index++) {
            printf ("\t%f|  \n", a->my_data_t[index]);
        }
        a++;
    }
}
printf ("\n");
printf ("-----------------------------------------------------\n");
}

int main(int argc, char** argv)
{

  int compute_itn_count;
  double startTime;
  double endTime;
  clock_t elspsed_time;
  time_t t;
  srand((unsigned) time(&t));
  double high_res_elapsed_time;
  double high_res_elapsed_time_HW = 0.0f;
  double high_res_elapsed_time_SW = 0.0f;
  ticks t0, t1;
  double tick_elsped_time_HW = 0.0f; 
  double tick_elsped_time_SW = 0.0f; 

  elspsed_time = clock();

  sdx_data_t *a_in_ptr;
  char *a_in_ptr_c_POSIX = NULL;
  srai_mem_conv_IN0 *a_in_ptr_c;
  srai_mem_conv_OUT0 *y_out_ptr_c;
  srai_mem_conv_IN0 *a_in_head_c;
  srai_mem_conv_OUT0 *y_out_head_c;
  sdx_data_t *y_out_ptr;

  bool RESULT_SUCESSFULL;

  cout << "Srai_ DBG NUMBER_OF_DATA_SETS  =  " << NUMBER_OF_DATA_SETS << endl;
  cout << "Srai_ DBG GLOBAL_DATA_IN_SIZE  =  " << GLOBAL_DATA_IN_SIZE << endl;
  cout << "Srai_ DBG GLOBAL_DATA_OUT_SIZE =  " << GLOBAL_DATA_OUT_SIZE << endl;

  //posix_memalign((void **)&a_in_ptr_c_POSIX, 4096/*alignment*/, GLOBAL_DATA_IN_SIZE_BYTES + 4096);
  //assert(a_in_ptr_c_POSIX);
  //a_in_ptr_c = (srai_mem_conv_IN0 *)a_in_ptr_c_POSIX;
  
  a_in_ptr_c = new srai_mem_conv_IN0[NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE];
  a_in_head_c = a_in_ptr_c;
  y_out_ptr_c = new srai_mem_conv_OUT0[NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_OUT_SIZE];
  y_out_head_c = y_out_ptr_c;

  printf("-------------------------------------------------------------\n");
  printf("Create Test Data Set\n");
  printf("Note GLOBAL_DATA_IN_SIZE (Number of test loops run) = %d\n", GLOBAL_DATA_IN_SIZE);
  printf("Note GLOBAL_DATA_OUT_SIZE (Number of test loops run) = %d\n", GLOBAL_DATA_OUT_SIZE);
  cout << "Size of data_t = " << sizeof(data_t) << endl;
  cout << "Number of Input Operands =  " << NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE*NUM_ELEMENTS_PER_SDX_DATA_BEAT<< endl;
  cout << "Number of Output Operands = " << NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_OUT_SIZE*NUM_ELEMENTS_PER_SDX_DATA_BEAT<< endl;
  cout << "Size of srai_mem_conv_IN0 = " << sizeof(srai_mem_conv_IN0) << endl;
  cout << "True Size (in Bytes) of Input Data  = " << sizeof(data_t)*NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE*NUM_ELEMENTS_PER_SDX_DATA_BEAT<< endl;
  cout << "Allocated Size (in Bytes) of a_in_ptr = " <<  GLOBAL_DATA_IN_SIZE_BYTES  << " | 0x"<< hex <<  GLOBAL_DATA_IN_SIZE_BYTES << endl;
  cout << dec;
  cout << "Allocated Size (in Bytes) of a_in_ptr_c = " << sizeof(srai_mem_conv_IN0)*NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE << " | 0x" << hex << sizeof(srai_mem_conv_IN0)*NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE << endl;
  cout << dec;
  printf("-------------------------------------------------------------\n\n\n");

    //Fill ddr4_Memory wr_data_buffer
    cout << "Initializing Memory with InputA args\n";
    gen_test_data(a_in_ptr_c);
    a_in_ptr = (sdx_data_t *)a_in_head_c;
    y_out_ptr = (sdx_data_t *)y_out_head_c;
 
    //print_gen_test_matrix(a_in_ptr_c);
    a_in_ptr_c = a_in_head_c;
    cout << "Memory Initialized with test Data\n";

#ifdef GPP_ONLY_FLOW  
    startTime = getCPUTime();
    sdx_cppKernel_top(a_in_ptr, y_out_ptr, (unsigned int)NUMBER_OF_DATA_SETS);
    endTime = getCPUTime();

#elif SRAI__HLS_ACCEL
// Compile for SRAI custom HLS accelerator platform 
    startTime = getCPUTime();
    string PR_binFile_name;
    unsigned int xfer_count ;

    if (argc != 2) {
        printf("usage: %s base_addr fpga_bin_file\n", argv[0]);
        return -1;
    }

    PR_binFile_name = argv[1];


    cout << "Initializing FPGA\n";
    fpga_mmio *my_fpga_ptr = new fpga_mmio;
    fpga_xDMA *my_fpga_xDMA_ptr = new fpga_xDMA;
    my_fpga_ptr->fpga_mmio_init<uint32_t>(PAGE_SIZE);
    my_fpga_xDMA_ptr->fpga_xDMA_init();

    fpga_test_AXIL_LITE_8KSCRATCHPAD_BRAM (my_fpga_ptr);

    /* xDMA Throughput testing */
    fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_BASE_NORTH_in_C0,  (char*)a_in_ptr, GLOBAL_DATA_IN_SIZE_BYTES);

   
    /* Program Partial Bit file */
    fpga_PROGRAM_NORTH_PR(my_fpga_ptr, PR_binFile_name);

    cout << "Start HLS execution " << endl;
    cout << " ............... Programing PR clock ------------------ " << endl;
    fpga_PROGRAM_PR_CLOCK (my_fpga_ptr, HW_Kernel_frequency);
    cout << " ....DONE ...... Programing PR clock ------------------ " << endl;


    //auto start_t = chrono::high_resolution_clock::now();
    //cin >> DBG__SRAI_tempvar_1; 
    /* Read the PR_HLS Control register to poll the Idle bit (bit 1) */ 
    xfer_count = fpga_xfer_data_to_card_NORTH64(my_fpga_xDMA_ptr, my_fpga_ptr, AXI_MM_DDR4_BASE_NORTH_in_C0, (char*)a_in_ptr, (GLOBAL_DATA_IN_SIZE_BYTES));
    //cout << "Waiting for input\n";
    //cin >> DBG__SRAI_tempvar_1; 
    /* Write to PR_HLS Address offset registers to set the location in Memory where Input Data and Output results are stored */
    auto start_t = chrono::high_resolution_clock::now();
    t0 = getticks();
    fpga_run_NORTH_PR64(my_fpga_ptr, AXI_MM_DDR4_BASE_NORTH_in_C0, AXI_MM_DDR4_BASE_NORTH_results_C0, (NUMBER_OF_DATA_SETS));
    compute_itn_count = fpga_check_compute_done_NORTH_PR(my_fpga_ptr);
    t1 = getticks();
    tick_elsped_time_HW = elapsed(t1,t0); 
    auto stop_t = chrono::high_resolution_clock::now();
    //cout << "compute_itn_count = " << compute_itn_count << endl;

    /* Read Results from DDR4 output (results) area */
    xfer_count = fpga_xfer_data_from_card64(my_fpga_xDMA_ptr, AXI_MM_DDR4_BASE_NORTH_results_C0, (char*)y_out_ptr, (GLOBAL_DATA_OUT_SIZE_BYTES));


    //auto stop_t = chrono::high_resolution_clock::now();
    chrono::duration<double> elapsed_hi_res = stop_t - start_t ;
    high_res_elapsed_time = elapsed_hi_res.count();
    high_res_elapsed_time_HW = high_res_elapsed_time;
    cout << "HLS Execution time =  " <<  high_res_elapsed_time << "s\n";
    cout << "HLS THroughput =  " <<  (GLOBAL_DATA_OUT_SIZE_BYTES/high_res_elapsed_time) << " Bytes/s\n";
    endTime = getCPUTime();
    fpga_clean(my_fpga_xDMA_ptr, my_fpga_ptr);

#endif
    int MAX_ITERATION_to_print = 1;
    uint32_t random_index[4];
    uint32_t random_NUMBER_OF_DATA_SETS;
    data_t sw_result;

    for (int i = 0; i < 4; i++) {
        random_index[i]  = (uint32_t)(rand() % NUM_ELEMENTS_PER_SDX_DATA_BEAT); 
    }
    random_NUMBER_OF_DATA_SETS = (uint32_t)(rand() % NUMBER_OF_DATA_SETS); 

    RESULT_SUCESSFULL = 1;
    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
    data_t fn_in_arg0[NUM_ELEMENTS_PER_SDX_DATA_BEAT][NUM_INPUT_KERNEL_FUNCTION_ARGUMENTS];
    data_t fn_out_arg0[NUM_ELEMENTS_PER_SDX_DATA_BEAT][NUM_OUTPUT_KERNEL_FUNCTION_ARGUMENTS];
        for (int i = 0 ; i < SDX_CU_LOCAL_SIZE; i++) {
            for (int x = 0 ; x < NUM_INPUT_KERNEL_FUNCTION_ARGUMENTS; x++) {
                for (unsigned int k = 0 ; k < (NUM_ELEMENTS_PER_SDX_DATA_BEAT); k++) {
                    fn_in_arg0[k][x] = a_in_ptr_c->my_data_t[k];
                }
                a_in_ptr_c++;
            }
            for (int x = 0 ; x < NUM_OUTPUT_KERNEL_FUNCTION_ARGUMENTS; x++) {
                for (unsigned int k = 0 ; k < (NUM_ELEMENTS_PER_SDX_DATA_BEAT); k++) {
                    fn_out_arg0[k][x] = y_out_ptr_c->my_data_t[k];
                }
                y_out_ptr_c++;
            }
            for (unsigned int index = 0; index < (NUM_ELEMENTS_PER_SDX_DATA_BEAT);index++) {
                if (j == random_NUMBER_OF_DATA_SETS & ( (index == random_index[0]) | (index == random_index[1]) | (index == random_index[2]) | (index == random_index[3]) )) {
                    //printf ("Input A = %f Inout_B = %f Output Y = %f \n", (fn_in_arg0[index][0]),(fn_in_arg0[index][1]),(fn_out_arg0[index][0]));
                }
                auto start_t = chrono::high_resolution_clock::now();
                t0 = getticks();
                sw_result = ((fn_in_arg0[index][0])*(fn_in_arg0[index][1]));
                t1 = getticks();
                auto stop_t = chrono::high_resolution_clock::now();
                chrono::duration<double> elapsed_hi_res = stop_t - start_t ;
                high_res_elapsed_time += elapsed_hi_res.count();
                tick_elsped_time_SW += elapsed(t1,t0); 
                if (fabs(sw_result - fn_out_arg0[index][0]) < ZERO_f){
                    RESULT_SUCESSFULL &= 1;
                } else {
                    RESULT_SUCESSFULL &= 0;
                }
            }
        }
    }

    high_res_elapsed_time_SW = high_res_elapsed_time;

    if (!RESULT_SUCESSFULL) {
        printf (" ------------   Results did not Verify - Test Failed !!!!!! -------------------------------------------------\n");
    } else {
        printf (" ------------   Results Verified  ---------------------------------------------------------------------------\n");
    }

    cout << "Gain (SW_time/HW_time)  =  " << (high_res_elapsed_time_SW/high_res_elapsed_time_HW) << endl;
    cout << "Tick  (SW_time)  =  " << (tick_elsped_time_SW) << endl;
    cout << "Tick  (HW_time)  =  " << (tick_elsped_time_HW) << endl;
    cout << "RDTSC based Gain (tick_elsped_time_SW/tick_elsped_time_HW)  =  " << (tick_elsped_time_SW/tick_elsped_time_HW) << endl;
    cout << "Highres  (SW_time)  =  " << (high_res_elapsed_time_SW) << endl;
    printf ("%d :: Software Number of operations per sec = %f \n",(NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE), (NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE)/high_res_elapsed_time_SW);
    printf ("%d :: Hawdware Number of operations per sec = %f \n",(NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE), (NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE)/high_res_elapsed_time_HW);

    printf ("-----------------------------------------------------\n");

    cout << "Results verifcation complete " << endl;

    // ------------ Clean -----------------------
    elspsed_time = (clock() - elspsed_time);
    delete [] a_in_head_c;
    //free(a_in_ptr_c_POSIX);
    delete [] y_out_head_c;
    printf (" Total elapsed Time for algorithm = %1f sec\n", elspsed_time);
    return 0;
}