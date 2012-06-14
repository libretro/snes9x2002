#include <stdio.h>
#include "minIni.h"
#include "menu.h"
#include "port.h"
#include "config.h"

static char *cfgEntry_lastLoaded = "last_loaded";
static char *cfgEntry_theme = "theme";
static char *cfgFile = "config.ini";
static char *cfgSection_general = "general";

void getConfigValue(unsigned int value, char *buffer, int bfsz) {
	char fp_cfgFile[_MAX_PATH];
	sprintf(fp_cfgFile, "%s/%s", snesOptionsDir, cfgFile);

	switch(value) {
		case CONFIG_LASTLOADED:
  			ini_gets(cfgSection_general, cfgEntry_lastLoaded, "\0", buffer, bfsz, fp_cfgFile);
			break;
		case CONFIG_THEME:
  			ini_gets(cfgSection_general, cfgEntry_theme, "default", buffer, bfsz, fp_cfgFile);
			break;
	}
}

void setConfigValue(unsigned int value, char *ll) {
	char fp_cfgFile[_MAX_PATH];
	sprintf(fp_cfgFile, "%s/%s", snesOptionsDir, cfgFile);
	
	switch(value) {
		case CONFIG_LASTLOADED:
			ini_puts(cfgSection_general, cfgEntry_lastLoaded, ll, fp_cfgFile);
			break;
		case CONFIG_THEME:
			ini_puts(cfgSection_general, cfgEntry_theme, ll, fp_cfgFile);
			break;
		}
}

