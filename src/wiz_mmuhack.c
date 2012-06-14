#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <fcntl.h>
#include <sys/mman.h>
#include <linux/fb.h>
#include <unistd.h>
#include <stropts.h>
#include <string.h>
#include <errno.h>

void wiz_mmuhack(int mem_fd)
{
	int mmufd = open("/dev/mmuhack", O_RDWR);
  
  
	if(mmufd < 0) {
		printf ("Installing NK's kernel module for Squidge MMU Hack...\n");
		system("/sbin/insmod mmuhack.ko");
		mmufd = open("/dev/mmuhack", O_RDWR);
	}
	if(mmufd < 0) return 0;
	 
	close(mmufd);
	return 1;
}

