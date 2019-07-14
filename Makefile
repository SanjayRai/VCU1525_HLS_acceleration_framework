# Created : 16:59:35, Fri May 20, 2017 : Sanjay Rai

.PHONY: all

all: help

help:
	@echo "		make build_complete | build_all | clean | clean_all"

build_complete:
	cd HLS; make HLS_IP  
	cd IP/role; make create_all_ip 
	cd vivado_batch_shell;vivado -mode batch -source vivado_batch.tcl;cp *_partial*.bin; cp *.bi* ../bitfiles/shell; cp *.ltx ../bitfiles/shell; cp *.mcs ../bitfiles/shell; cp *.prm ../bitfiles/shell  
	cd vivado_batch_shell;cp *_partial*.bin; cp *.bi* ../bitfiles/shell; cp *.ltx ../bitfiles/shell; cp *.mcs ../bitfiles/shell; cp *.prm ../bitfiles/shell  
	cd vivado_batch_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_MATRIX_MULT_6X6;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_MATRIX_MULT_8X8;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_KERNEL_PASSTHRU;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_KERNEL_FP_VECTOR_MULT;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd bitfiles; tar -zcvf VU9P_AXI_ICAP_PR_DESIGN_bitfiles.tar.gz shell/ role/ 
build_all:
	cd IP/role; make create_all_ip 
	cd vivado_batch_shell;vivado -mode batch -source vivado_batch.tcl;cp *_partial*.bin; cp *.bi* ../bitfiles/shell; cp *.ltx ../bitfiles/shell; cp *.mcs ../bitfiles/shell; cp *.prm ../bitfiles/shell  
	cd vivado_batch_shell;cp *_partial*.bin; cp *.bi* ../bitfiles/shell; cp *.ltx ../bitfiles/shell; cp *.mcs ../bitfiles/shell; cp *.prm ../bitfiles/shell  
	cd vivado_batch_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_MATRIX_MULT_6X6;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_MATRIX_MULT_8X8;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_KERNEL_PASSTHRU;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd vivado_batch_SDX_ACCL_KERNEL_FP_VECTOR_MULT;vivado -mode batch -source vivado_batch.tcl; cp *_partial*.bin ../bitfiles/role
	cd bitfiles; tar -zcvf VU9P_AXI_ICAP_PR_DESIGN_bitfiles.tar.gz shell/ role/ 
clean:
	-cd checkpoints; rm *.dcp
	-cd bitfiles; rm VU9P_AXI_ICAP_PR_DESIGN_bitfiles.tar.gz 
	-cd bitfiles/shell; rm VU9P_AXI_ICAP_PR_DESIGN*.*
	-cd bitfiles/role; rm VU9P_AXI_ICAP_PR_DESIGN*.*
	-cd vivado_batch_shell;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_KERNEL_FP_VECTOR_MULT;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_MULT_6X6;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_MULT_8X8;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_KERNEL_PASSTHRU;./mk_clean.bat
clean_all:
	-cd HLS; make clean_all  
	-cd HLS; make HLS_IP_CLEAN 
	-cd IP/shell; ./mk_clean.bat 
	-cd IP/role; make clean_all 
	-cd checkpoints; rm *.dcp
	-cd bitfiles; rm VU9P_AXI_ICAP_PR_DESIGN_bitfiles.tar.gz 
	-cd bitfiles/shell; rm VU9P_AXI_ICAP_PR_DESIGN*.*
	-cd bitfiles/role; rm VU9P_AXI_ICAP_PR_DESIGN*.*
	-cd vivado_batch_shell;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_KERNEL_FP_VECTOR_MULT;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_MULT_6X6;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_MATRIX_MULT_8X8;./mk_clean.bat
	-cd vivado_batch_SDX_ACCL_KERNEL_PASSTHRU;./mk_clean.bat
