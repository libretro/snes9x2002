#ifndef __SCREENSHOT_H__
#define __SCREENSHOT_H__

#include "graphics.h"

#ifdef __cplusplus
extern "C" {
#endif

int saveScreenShot();
void destroyScreenShot();
void getScreenShot(unsigned short *screen);
const char *getScreenShotsDir();

#ifdef __cplusplus
}
#endif

#endif
