/*
	Simple theming handling library
	Under GPL v2 License
	2011 by bitrider
*/

#include "string.h"
#include "stdio.h"

#include "minIni.h"
#include "graphics.h"
#include "config.h"
#include "png.h"

gBITMAP *tBmpBackground = NULL;
gBITMAP *tBmpBar = NULL;
gBITMAP *tBmpLoading = NULL;
gBITMAP *tBmpInGame = NULL;

unsigned short tTextColorTitle = RGB16(255, 0, 0);
unsigned short tTextColorFocus = RGB16(0, 0, 0);
unsigned short tTextColorItem = RGB16(255, 255, 255);
unsigned short tTextColorVersion = RGB16(0, 0, 255);
unsigned short tTextColorInfo = RGB16(255, 127, 40);
unsigned short tTextColorLoading = RGB16(255, 255,255);
unsigned short tBackgroundColor = RGB16(0,0,0);

static gBITMAP *_loadBitmapFromIni(char *ini_file, char *ini_entry, char *dir) {
 	char f[1024];
	char def[] = "none";
	int len;
	gBITMAP *bmp;	

	strcpy(f, dir);
	len = strlen(f);
  	ini_gets("bitmaps", ini_entry, def, f + len, sizeof(f) - len, ini_file);
	if (strcmp(f + len, def) == 0) {
		printf("- No \"%s\" image specified\n", ini_entry);
		return NULL;	
		}
	printf("- Loading bitmap: %s", f);
	bmp = load_png(f, NULL);
	if (!bmp) {
		printf(" - ERROR loading file !!\n", f);
		return NULL;
		}
	printf(" - OK\n");
	
	return bmp;
}

static int _loadColorFromIni(char *ini_file, char *ini_entry) {
 	char f[1024];
	char def[] = "none";
	int r = -1;
	int g = -1; 
	int b = -1;

  	ini_gets("colors", ini_entry, def, f, sizeof(f), ini_file);
	if (strcmp(f, def) == 0) {
		printf("- No \"%s\" color specified\n", ini_entry);
		return -1;	
		}
	printf("- Parsing color : %s", ini_entry);
	sscanf(f, "RGB(%d, %d, %d)", &r, &g, &b);
	if ((r < 0) || (r > 255) ||
	    (g < 0) || (g > 255) ||
	    (b < 0) || (b > 255)) {
		printf(" - ERROR parsing color !!\n", f);
		return -1;
		}
	printf(" - OK: RGB(%d,%d,%d)\n", r, g, b);
	
	return RGB16(r, g, b);
}

int loadTheme(char *name) {
	char themes_dir[] = "themes";
	char ini[1024]; 
	char dir[1024];
	gBITMAP *bgnd, *bar, *loading, *ingame;
	int cTitle, cFocus, cItem, cVersion, cInfo, cLoading, cBackground;

	sprintf(ini, "%s/%s.ini", themes_dir, name);
	printf("Loading theme file from: %s\n", ini);

	// Load colors
	cTitle = _loadColorFromIni(ini, "text_title");
	cFocus = _loadColorFromIni(ini, "text_focus");
	cItem = _loadColorFromIni(ini, "text_item");
	cVersion = _loadColorFromIni(ini, "text_version");
	cInfo = _loadColorFromIni(ini, "text_info");
	cLoading = _loadColorFromIni(ini, "text_loading");
	cBackground = _loadColorFromIni(ini, "background");

	// Load bitmaps
	sprintf(dir, "%s/%s/", themes_dir, name);  // build bitmaps directory

	bgnd = _loadBitmapFromIni(ini, "background", dir);
	if (!bgnd) return -1;

	bar = _loadBitmapFromIni(ini, "bar", dir);
	if (!bar) {
		gDestroyBitmap(bgnd); 
		return -1;
		}

	// Not required: can be null
	loading = _loadBitmapFromIni(ini, "loading", dir);
	ingame = _loadBitmapFromIni(ini, "ingame", dir);  
	
	// Everything went OK, so replace current theme values with just loaded ones
	gDestroyBitmap(tBmpBackground);
	tBmpBackground = bgnd;
	gDestroyBitmap(tBmpBar);
	tBmpBar = bar;
	gDestroyBitmap(tBmpInGame);
	tBmpInGame = ingame;
	gDestroyBitmap(tBmpLoading);
	tBmpLoading = loading;

	if (cTitle >= 0) tTextColorTitle = cTitle;
	if (cFocus >= 0) tTextColorFocus = cFocus;
	if (cItem >= 0) tTextColorItem = cItem;
	if (cVersion >= 0) tTextColorVersion = cVersion;
	if (cInfo >= 0) tTextColorInfo = cInfo;
	if (cLoading >= 0) tTextColorLoading = cLoading;
	if (cBackground >= 0) tBackgroundColor = cBackground;

	return 0;
}

int initTheme() {
	char theme[256];
	getConfigValue(CONFIG_THEME, theme, sizeof(theme));	
	return loadTheme(theme);
}

void destroyTheme() {

	// Destroy bitmaps
	gDestroyBitmap(tBmpBackground);
	tBmpBackground = NULL;
	gDestroyBitmap(tBmpBar);
	tBmpBar = NULL;
	gDestroyBitmap(tBmpLoading);
	tBmpLoading = NULL;
	gDestroyBitmap(tBmpInGame);
	tBmpInGame = NULL;

	// Restore text colors
	tTextColorTitle = RGB16(255, 0, 0);
	tTextColorFocus = RGB16(0, 0, 0);
	tTextColorItem = RGB16(255, 255, 255);
	tTextColorVersion = RGB16(0, 0, 255);
	tTextColorInfo = RGB16(255, 127, 40);
	tTextColorLoading = RGB16(255, 255,255);
	tBackgroundColor = RGB16(0,0,0);
}

int isThemeActive() {
	if (tBmpBackground != NULL) return 1;
	else return 0;
}

