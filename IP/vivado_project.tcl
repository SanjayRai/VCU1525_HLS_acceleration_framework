# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl
create_project project_X project_X -part [DEVICE_TYPE] 

set_property  ip_repo_paths  ../HLS/SDX_ACCL_KERNEL_FP_VECTOR_MULT/vivado_hls_prj/vhls_prj/solution1/impl/ip [current_project]
update_ip_catalog

add_files -fileset sources_1 -norecurse {
./shell/PCIe_Bridge_ICAP_complex/PCIe_Bridge_ICAP_complex.bd
./role/IP_SDX_ACCL_KERNEL_FP_VECTOR_MULT/HLS_PR_SDX_SRAI/HLS_PR_SDX_SRAI.bd
}

