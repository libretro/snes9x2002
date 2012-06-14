#include "stdio.h"
#include "stdlib.h"
#include "tslib.h"

struct tsdev *ts = NULL;

int InitTouchScreen(void) {
	// Taken directly from tslib test sources, slightly modifed
	char *tsdevice = NULL;

	if( (tsdevice = getenv("TSLIB_TSDEVICE")) != NULL ) {
		ts = ts_open(tsdevice, 1);
	} else {
		ts = ts_open("/dev/input/event0", 1);
	}

	if (!ts) {
		perror("ts_open");
		return 0;
	}
	if (ts_config(ts)) {
		perror("ts_config");
		return 0;
	}	

	return 1;
}

void DeInitTouchScreen(void) {
	// Nothing to do	
}


// return -1 on error, else pressure value

int getTouchScreen(int *x, int *y) {
	struct ts_sample tsdata;

	if (ts == NULL) return -1;

	if (ts_read(ts, &tsdata, 1) != 1) return -1;

	*x = tsdata.x;
	*y = tsdata.y;
	return tsdata.pressure;
} 

