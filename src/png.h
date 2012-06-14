#ifndef __PNG_H__
#define __PNG_H__

#include "graphics.h"

#ifdef __cplusplus
extern "C" {
#endif

#define PNG_OK			0
#define PNG_ERROR_OPENING	1
#define PNG_ERROR_READING	2
#define PNG_ERROR_NOT_PNG	3
#define PNG_ERROR_PNG_STRUCTS	4
#define PNG_ERROR_MEMORY	5
#define PNG_ERROR		6
#define PNG_ERROR_INVALID_INPUT 7

gBITMAP *load_png(char *filename, int *error);
int save_png(gBITMAP *img, char *filename);

#ifdef __cplusplus
}
#endif

#endif
