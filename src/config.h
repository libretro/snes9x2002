#ifndef __CONFIG_H__
#define __CONFIG_H__

#ifdef __cplusplus
extern "C" {
#endif

#define CONFIG_LASTLOADED	0
#define CONFIG_THEME		1

void getConfigValue(unsigned int value, char *buffer, int bfsz);
void setConfigValue(unsigned int value, char *ll);

#ifdef __cplusplus
}
#endif

#endif
