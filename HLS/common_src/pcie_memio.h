/* Sanjay Rai - Routine to access PCIe via  dev.mem mmap  */
#ifndef FPGA_MMIO_UTILS_H_
#define  FPGA_MMIO_UTILS_H_

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>
#include <inttypes.h>
#include <iostream>
#include <iomanip>

using namespace std;

#define FAUT_CONDITION do { fprintf(stderr, "Error at line %d, file %s (%d) [%s]\n", __LINE__, __FILE__, errno, strerror(errno)); exit(1); } while(0)

#define PAGE_SIZE (32*1024UL*1024UL)


class fpga_xDMA_linux {
	private :
            void *virt_page_base;
            int fpga_fp_user;
            int fpga_fd_c2h;
            int fpga_fd_h2c;

	public :
		fpga_xDMA_linux (void) {}

		int fpga_xDMA_init() {
                        if((fpga_fp_user = open("/dev/xdma/card0/user", O_RDWR | O_SYNC)) == -1) FAUT_CONDITION;
                        fflush(stdout);
                        virt_page_base = mmap(0, (uint32_t)PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fpga_fp_user, 0);
                        //cout << " Virtual Base Address = " << hex << virt_page_base << endl;
                        if(virt_page_base == (void *) -1) FAUT_CONDITION;

			if((fpga_fd_c2h = open("/dev/xdma0_c2h_0", O_RDWR | O_NONBLOCK)) == -1) FAUT_CONDITION;
			if((fpga_fd_h2c = open("/dev/xdma0_h2c_0", O_RDWR | O_NONBLOCK)) == -1) FAUT_CONDITION;
			return 0;
		}

                int fpga_poke (uint32_t register_offset, uint32_t val) {
                    volatile uint32_t *tmp_addr;
                    tmp_addr = (uint32_t *)((uint8_t *)virt_page_base + register_offset);

                    *((uint32_t *)tmp_addr) = val;
                    return 0;
                }

                uint32_t fpga_peek (uint32_t register_offset) {
                    volatile uint32_t *tmp_addr;
                    volatile uint32_t ret_val;
                    tmp_addr = (uint32_t *)((uint8_t *)virt_page_base + register_offset);
                    ret_val = *((uint32_t *)tmp_addr);
                    return(ret_val);
                }


		int fpga_xDMA_read(uint32_t AXI_addr, char *buffer, uint32_t size ) {
                        off_t lseek_rc;
                        int count;
			lseek_rc = lseek(fpga_fd_c2h, AXI_addr, SEEK_SET);
			count = read(fpga_fd_c2h, buffer, size);
			return count;
		}

		int fpga_xDMA_read64(uint64_t AXI_addr, char *buffer, uint32_t size ) {
                        off64_t lseek_rc;
                        int count;
			lseek_rc = lseek64(fpga_fd_c2h, AXI_addr, SEEK_SET);
			count = read(fpga_fd_c2h, buffer, size);
			return count;
		}

		int fpga_xDMA_write(uint32_t AXI_addr, char *buffer, uint32_t size ) {
                        off_t lseek_rc;
                        int count;
			lseek_rc = lseek(fpga_fd_h2c, AXI_addr, SEEK_SET);
			count = write(fpga_fd_h2c, buffer, size);
			return count;
		}

		int fpga_xDMA_write64(uint64_t AXI_addr, char *buffer, uint32_t size ) {
                        off64_t lseek_rc;
                        int count;
			lseek_rc = lseek64(fpga_fd_h2c, AXI_addr, SEEK_SET);
			count = write(fpga_fd_h2c, buffer, size);
			return count;
		}

		int fpga_xDMA_clean() {
                        if(munmap(virt_page_base, PAGE_SIZE) == -1) FAUT_CONDITION;
                        close(fpga_fp_user);
			close(fpga_fd_c2h);
			close(fpga_fd_h2c);
			return 0;
		}
}; 
#endif
