/*
	Simple PNG handling library
	Under GPL v2 License
	2011 by bitrider
*/

#include <stdlib.h>
#include "lodepng.h"
#include "png.h"

#define ERROR(err) {if (error) (*error) = PNG_ERROR_OPENING; return NULL;}
gBITMAP *load_png(char *filename, int *error)  /* We need to open the file */
{
	gBITMAP *img = NULL;
	unsigned int e;
	
	// allocate memory
	img = malloc(sizeof(gBITMAP));
	if (!img) ERROR(PNG_ERROR_MEMORY);
	
	img->data = NULL;
	
	e = LodePNG_decode32_file(&img->data, &img->w, &img->h, filename);
	if (e) {
		gDestroyBitmap(img);
		ERROR(e);
	}

	img->bpp = 32;
	if (error) (*error) = PNG_OK;
	return img;	
}	

int save_png(gBITMAP *img, char *filename) {
	if ((!img) || (!img->data) || (img->bpp != 32)) return PNG_ERROR_INVALID_INPUT;

	return LodePNG_encode32_file(filename, img->data, img->w, img->h);
}
