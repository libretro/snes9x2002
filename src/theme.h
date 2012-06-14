#ifndef __THEME_H__
#define __THEME_H__

#include "graphics.h"

#ifdef __cplusplus
extern "C" {
#endif

extern gBITMAP *tBmpBackground;
extern gBITMAP *tBmpBar;
extern gBITMAP *tBmpLoading;
extern gBITMAP *tBmpInGame;

extern unsigned short tTextColorTitle;
extern unsigned short tTextColorFocus;
extern unsigned short tTextColorItem;
extern unsigned short tTextColorVersion;
extern unsigned short tTextColorLoading;
extern unsigned short tBackgroundColor;


int initTheme();
int loadTheme(char *name);
void destroyTheme();
int isThemeActive();

#ifdef __cplusplus
}
#endif

#endif
