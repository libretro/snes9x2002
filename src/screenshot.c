#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include "screenshot.h"
#include "png.h"
#include "menu.h"
#include "config.h"

static gBITMAP *screenShot = NULL;

#define SS_WIDTH	256
#define	SS_HEIGHT	240

// Copy screen into screenshot buffer
void getScreenShot(unsigned short *screen) {
	unsigned int x, y;
	screen += 32;

	if (!screenShot) {
		screenShot = 0;//gCreateBitmap(SS_WIDTH, SS_HEIGHT, 32);
		if (!screenShot) return;
		}

	for (y = 0; y < SS_HEIGHT; y++)
		for(x = 0; x < SS_WIDTH; x++) {
			unsigned short pixel = screen[y * SCREEN_WIDTH + x];
			screenShot->data[(y * SS_WIDTH + x) * 4 + 0] = PIXEL16_R(pixel);
			screenShot->data[(y * SS_WIDTH + x) * 4 + 1] = PIXEL16_G(pixel);	
			screenShot->data[(y * SS_WIDTH + x) * 4 + 2] = PIXEL16_B(pixel);	
			screenShot->data[(y * SS_WIDTH + x) * 4 + 3] = 0xff;
			}
}

int saveScreenShot() {
	char fn[1024];
	char png_fn[1024];
	char *ext;
	int ret;

	if (!screenShot) return -1;
	
	// get filename of last loaded ROM (the running one)	
	//getConfigValue(CONFIG_LASTLOADED, fn, sizeof(fn));
	// set file ext to .png
	ext = strrchr(fn, '.');
	if (!ext) ext = &fn[strlen(fn)];
	strcpy(ext, ".png");
	// compose screenshot file's full path
	sprintf(png_fn, "%s%s", getScreenShotsDir(), strrchr(fn, '/'));

	ret = 0;//save_png(screenShot, png_fn);
	sync();
	
	return ret;
}

static char screenShotsDir[1024] = "\0";
static int getScreenShotsDirFirstTime = 1;
const char *getScreenShotsDir() {
	if (screenShotsDir[0] == '\0') sprintf(screenShotsDir, "%s/%s", currentWorkingDir, "screenshots");
	if (getScreenShotsDirFirstTime) {
		mkdir(screenShotsDir, 0777);
		getScreenShotsDirFirstTime = 0;
		}
	return screenShotsDir;
}

void destroyScreenShot() {
	//gDestroyBitmap(screenShot);
	screenShot = NULL;
}
