# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl
create_project project_X project_X -part [DEVICE_TYPE] 

add_files -fileset sources_1 -norecurse {
./shell/PCIe_Bridge_ICAP_complex/PCIe_Bridge_ICAP_complex.bd
./role/debug_bridge_PR/debug_bridge_PR.xci
}

