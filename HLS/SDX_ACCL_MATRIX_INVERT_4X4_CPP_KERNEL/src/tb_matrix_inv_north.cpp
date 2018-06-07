#include<stdio.h>
#include<math.h>
#include <errno.h>

#include <fstream>
#include <string>
#include <chrono>
#include <cmath>
#include "pcie_memio.h" 
//#include "pcie_memio_winx.h"
#include "srai_accel_utils.h" 
#include "cycle.h"

//#include "sdaccel_utils.h" 
#include "sdx_cppKernel_top.h" 
#define ZERO_f 1.0e-4
#define PRINT_SAMPLE_OUT false
using namespace std;



int check_if_Indentity_Matrix (data_t matrix_A[DIM][DIM]){
int id_error_count;
    id_error_count = 0;
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
            if (row == col) {
                if (fabs(matrix_A[row][col] -1.0f) > 0.1e-4){
                    cout << "ERROR DBG :: " << fabs(matrix_A[row][col] -1.0f) << endl;
                    id_error_count++;
                } 
            } else if (fabs(matrix_A[row][col]) > 0.1e-4){
                    id_error_count++;
            }
        }
    }
    return id_error_count;
}

void matrix_mult (data_t matrix_A[DIM][DIM], data_t matrix_B[DIM][DIM], data_t mult[DIM][DIM]) {
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
            mult[row][col] = 0.0f;
        }
    }
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
          for (int k = 0; k < DIM;k++) {
            mult[row][col] += matrix_A[row][k]* matrix_B[k][col];
          }
        }
    }
}

void print_matrix (data_t matrix_val[DIM][DIM]) {
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
            if (fabs(matrix_val[row][col]) < 1.0e-4) {
                matrix_val[row][col] = 0.0f;
            }
            cout << matrix_val[row][col] << " "; 
        }
        cout << endl;
    }
        cout << "------------------------------------"<< endl;

}

void gen_test_matrix(srai_mem_conv_IN0 *a) {
//   static data_t temp[DIM][DIM] = {{1.0f, 2.0f, 3.0f, 4.0f},
//                                   {5.0f, 6.0f, 7.0f, 8.0f},
//                                   {2.0f, 6.0f, 4.0f, 8.0f},
//                                   {3.0f, 1.0f, 1.0f, 2.0f}};
//   static data_t temp[DIM][DIM] = {{1.0f, ZERO_f, ZERO_f, ZERO_f},
//                                   {ZERO_f, 1.0f, ZERO_f, ZERO_f},
//                                   {ZERO_f, ZERO_f, 1.0f, ZERO_f},
//                                   {ZERO_f, ZERO_f, ZERO_f, 1.0f}};
   static data_t temp[DIM][DIM] = {{1.0f, 2.0f, 3.0f, 4.0f},
                                   {5.0f, 6.0f, 7.0f, 8.0f},
                                   {2.0f, 6.0f, 4.0f, 8.0f},
                                   {3.0f, 1.0f, 1.0f, 2.0f}};
 
//   static data_t temp[DIM][DIM] = {{1.0f, 2.0f, 3.0f, 4.0f},
//                                   {5.0f, 6.0f, 7.0f, 8.0f},
//                                   {9.0f, 10.0f, 11.0f, 12.0f},
//                                   {13.0f, 14.0f, 15.0f, 16.0f}};

  data_t random_scale;

    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
        for (int i = 0 ; i < SDX_CU_LOCAL_IN_SIZE; i++) {
            //random_scale = (data_t)(rand() % (int)32768.0)/321.01;
            random_scale = (data_t)(1.0f + ((rand() % (int)32768.0)/321.01));
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    a->my_data_t[row][col] = (temp[row][col])*random_scale; 
                }
            }
            a++;
        }
    }
}

void print_gen_test_matrix(srai_mem_conv_IN0 *a) {

    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
        for (int i = 0 ; i < SDX_CU_LOCAL_IN_SIZE; i++) {
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    cout << a->my_data_t[row][col] << " ";
                }
                cout << endl;
            }
                cout << endl;
                cout << "------------------------------------"<< endl;
                a++;
        }
    }
}


int main(int argc, char **argv) {

  int compute_itn_count;
  double startTime;
  time_t t;
  srand((unsigned) time(&t));
  double high_res_elapsed_time;
  double high_res_elapsed_time_HW = 0.0f;
  double high_res_elapsed_time_SW = 0.0f;
  chrono::high_resolution_clock::time_point start_t;
  chrono::high_resolution_clock::time_point stop_t;
  chrono::duration<double> elapsed_hi_res;


  sdx_data_t *a_in_ptr;
  char *a_in_ptr_c_POSIX = NULL;
  char *y_out_ptr_c_POSIX = NULL;
  srai_mem_conv_IN0 *a_in_ptr_c;
  srai_mem_conv_OUT0 *y_out_ptr_c;
  srai_mem_conv_IN0 *a_in_head_c;
  srai_mem_conv_OUT0 *y_out_head_c;
  sdx_data_t *y_out_ptr;

  SysMon_temp_struct sys_temprature;

  cout << "Srai_ DBG NUMBER_OF_DATA_SETS  =  " << NUMBER_OF_DATA_SETS << endl;
  cout << "Srai_ DBG GLOBAL_DATA_IN_SIZE  =  " << GLOBAL_DATA_IN_SIZE << endl;
  cout << "Srai_ DBG GLOBAL_DATA_OUT_SIZE =  " << GLOBAL_DATA_OUT_SIZE << endl;

  posix_memalign((void **)&a_in_ptr_c_POSIX, 4096/*alignment*/, GLOBAL_DATA_IN_SIZE_BYTES + 4096);
  assert(a_in_ptr_c_POSIX);
  a_in_ptr_c = (srai_mem_conv_IN0 *)a_in_ptr_c_POSIX;
  
  //a_in_ptr_c = new srai_mem_conv_IN0[NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE];
  a_in_head_c = a_in_ptr_c;

  posix_memalign((void **)&y_out_ptr_c_POSIX, 4096/*alignment*/, GLOBAL_DATA_OUT_SIZE_BYTES + 4096);
  assert(y_out_ptr_c_POSIX);
  y_out_ptr_c = (srai_mem_conv_OUT0 *)y_out_ptr_c_POSIX;
  //y_out_ptr_c = new srai_mem_conv_OUT0[NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_OUT_SIZE];
  y_out_head_c = y_out_ptr_c;

  printf("-------------------------------------------------------------\n");
  printf("Create Test Data Set\n");
  printf("Note DATA_IN_SIZE (Input Memory size in bytes  ) = %d (%x)\n",(GLOBAL_DATA_IN_SIZE_BYTES),(GLOBAL_DATA_IN_SIZE_BYTES));
  printf("Note DATA_OUT_SIZE(Input Memory size in bytes  ) = %d (%x)\n",(GLOBAL_DATA_OUT_SIZE_BYTES),(GLOBAL_DATA_OUT_SIZE_BYTES));
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
    gen_test_matrix(a_in_ptr_c);
    a_in_ptr = (sdx_data_t *)a_in_head_c;
    y_out_ptr = (sdx_data_t *)y_out_head_c;

    //print_gen_test_matrix(a_in_ptr_c);
    a_in_ptr_c = a_in_head_c;
    cout << "Memory Initialized with test Data\n";

#ifdef GPP_ONLY_FLOW  
    sdx_cppKernel_top(a_in_ptr, y_out_ptr, (unsigned int)NUMBER_OF_DATA_SETS);

#elif SRAI__HLS_ACCEL
// Compile for SRAI custom HLS accelerator platform 
    string PR_binFile_name;
    unsigned int xfer_count ;

    if (argc != 2) {
        printf("usage: %s fpga_bin_file\n", argv[0]);
        return -1;
    }

    PR_binFile_name = argv[1];


    cout << "Initializing FPGA\n";
    fpga_xDMA_linux *my_fpga_xDMA_ptr = new fpga_xDMA_linux;
    //fpga_xDMA_winx *my_fpga_xDMA_ptr = new fpga_xDMA_winx;
    my_fpga_xDMA_ptr->fpga_xDMA_init();

    fpga_test_AXIL_LITE_8KSCRATCHPAD_BRAM (my_fpga_xDMA_ptr);
    //
    //DeIsolate before doing anyting on AXI Buses
    cout << "DeIsolate PR region \n";
    my_fpga_xDMA_ptr->fpga_poke(AXI_LITE_GPIO_BASE, DEISOLATE_NORTH_PR); 

    fpga_read_temprature(my_fpga_xDMA_ptr, &sys_temprature, 10);
    cout << "Current FPGA Die Temprature (deg C) =  " << sys_temprature.current_temp << endl;
    cout << "Current FPGA Max Die Temprature (deg C) =  " << sys_temprature.maximum_temp << endl;
    cout << "Current FPGA Min Die Temprature (deg C) =  " << sys_temprature.minimum_temp << endl;


    /* xDMA Throughput testing */
    cout << "xDMA BandWidth test C0  : \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C0, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   cout << "xDMA BandWidth test C1  : \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C1, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   cout << "xDMA BandWidth test C2  : \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C2, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   cout << "xDMA BandWidth test C3: \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C3, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   
   

   
    cout << "Start HLS execution " << endl;
    cout << " ............... Programing PR clock ------------------ " << endl;
    fpga_PROGRAM_PR_CLOCK (my_fpga_xDMA_ptr, HW_Kernel_frequency);
    cout << " ....DONE ...... Programing PR clock ------------------ " << endl;

    /* Program Partial Bit file */
    fpga_PROGRAM_NORTH_PR(my_fpga_xDMA_ptr, PR_binFile_name);


    //auto start_t = chrono::high_resolution_clock::now();
    //cin >> DBG__SRAI_tempvar_1; 
    /* Read the PR_HLS Control register to poll the Idle bit (bit 1) */ 
    xfer_count = fpga_xfer_data_to_card64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C1, (char*)a_in_ptr, (GLOBAL_DATA_IN_SIZE_BYTES));
    //cout << "Waiting for input\n";
    //cin >> DBG__SRAI_tempvar_1; 
    /* Write to PR_HLS Address offset registers to set the location in Memory where Input Data and Output results are stored */
    start_t = chrono::high_resolution_clock::now();
    fpga_run_NORTH_PR(my_fpga_xDMA_ptr, AXI_MM_DDR4_C1, AXI_MM_DDR4_results_C1, (NUMBER_OF_DATA_SETS));
    compute_itn_count = fpga_check_compute_done_NORTH_PR(my_fpga_xDMA_ptr);
    stop_t = chrono::high_resolution_clock::now();
    cout << "compute_itn_count = " << compute_itn_count << endl;

    /* Read Results from DDR4 output (results) area */
    xfer_count = fpga_xfer_data_from_card64(my_fpga_xDMA_ptr, AXI_MM_DDR4_results_C1, (char*)y_out_ptr, (GLOBAL_DATA_OUT_SIZE_BYTES));

    //stop_t = chrono::high_resolution_clock::now();
    elapsed_hi_res = stop_t - start_t ;
    high_res_elapsed_time = elapsed_hi_res.count();
    high_res_elapsed_time_HW = high_res_elapsed_time;
    cout << "HLS Execution time =  " <<  high_res_elapsed_time << "s\n";
    cout << "HLS THroughput =  " <<  (GLOBAL_DATA_OUT_SIZE_BYTES/high_res_elapsed_time) << " Bytes/s\n";
    fpga_clean(my_fpga_xDMA_ptr);

#endif



    printf (" ------------   Results  ------------------------------\n");
    printf (" ------------------------------------------------------\n");
    data_t in_arg_0[DIM*DIM];
    data_t out_arg_0[DIM*DIM];
    data_t temp_A[DIM][DIM];
    data_t temp_Y[DIM][DIM];
    data_t result_sw[DIM][DIM];
    data_t mult[DIM][DIM];
    int total_id_error;
    int curr_test_error;
    total_id_error = 0;
    uint32_t random_index[4];

    for (int i = 0; i < 4; i++) {
        random_index[i]  = (uint32_t)(rand() % NUMBER_OF_DATA_SETS); 
    }
    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
    curr_test_error = 0;
        for (int i = 0 ; i < SDX_CU_LOCAL_SIZE; i++) {
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    temp_A[row][col] = a_in_ptr_c->my_data_t[row][col];
                    temp_Y[row][col] = y_out_ptr_c->my_data_t[row][col];
                }
            }
            a_in_ptr_c++;
            y_out_ptr_c++;
            matrix_mult (temp_A, temp_Y, mult);
            auto start_t = chrono::high_resolution_clock::now();
            matrix_operation_wrapper(temp_A, result_sw);
            auto stop_t = chrono::high_resolution_clock::now();
            chrono::duration<double> elapsed_hi_res = stop_t - start_t ;
            high_res_elapsed_time += elapsed_hi_res.count();
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    if (fabs(result_sw[row][col]- temp_Y[row][col]) > 0.1e-4) {
                        curr_test_error++;
                        //cout << "Error !! Expected :" << mult_sw[row][col] << "  but got : " << temp_Y[row][col] << endl;
                    }
                }
            }
            if (curr_test_error != 0) {
                total_id_error++;
//                 cout << " -------- Expected-------\n";
//                 print_matrix(mult_sw);
//                 cout << " -------- Got from HW ---\n";
//                 print_matrix(temp_Y);
            }

            if ( ((j == random_index[0]) | (j == random_index[1]) | (j == random_index[2]) | (j == random_index[3])) & PRINT_SAMPLE_OUT ) {
                cout << "Input Matrix .........\n";
                print_matrix(temp_A);
                cout << "Output  Matrix .........\n";
                print_matrix(temp_Y);
                cout << "Identity  Matrix .........\n";
                print_matrix(mult);
            }
        }
    }

    high_res_elapsed_time_SW = high_res_elapsed_time;
    printf ("\n");
    cout << ".....................................................\n";
    cout << "SW Execution time =  " <<  high_res_elapsed_time << "s\n";
    cout << "SW THroughput =  " <<  (GLOBAL_DATA_OUT_SIZE_BYTES/high_res_elapsed_time) << " Bytes/s\n";
    if (total_id_error) {
        cout << "TEST UnSucessful! : Total Errors  =  " << total_id_error << endl; 
    } else {
        cout << "TEST Sucessful : Total Errors  =  " << total_id_error << endl; 
    }
    cout << "Gain (SW_time/HW_time)  =  " << (high_res_elapsed_time_SW/high_res_elapsed_time_HW) << endl;
    cout << "Highres  (SW_time)  =  " << (high_res_elapsed_time_SW) << endl;
    printf ("%d :: Software Number of %dx%d floating point Matrix Multiplies per sec = %f \n",(NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE), DIM, DIM, (NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE)/high_res_elapsed_time_SW);
    printf ("%d :: Hawdware Number of %dx%d floating point Matrix Multiplies per sec = %f \n",(NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE), DIM, DIM, (NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE)/high_res_elapsed_time_HW);

    printf ("-----------------------------------------------------\n");

    cout << "Results verifcation complete " << endl;
    cout << "Total Error = " << total_id_error << endl;

    // ------------ Clean -----------------------
    //delete [] a_in_head_c;
    free(a_in_ptr_c_POSIX);
    //delete [] y_out_head_c;
    free(y_out_ptr_c_POSIX);
    return 0;
}
