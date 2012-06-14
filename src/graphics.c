/*
	Simple graphic handling library
	Under GPL v2 License
	2011 by bitrider
*/
#include <stdlib.h>
#include <stdio.h>

#include "graphics.h"

static int clipping_x1 = 0; 
static int clipping_x2 = SCREEN_WIDTH - 1;
static int clipping_y1 = 0;
static int clipping_y2 = SCREEN_HEIGHT - 1;

void gSetClipping(int x1, int y1, int x2, int y2) {
	if (x1 < 0) x1 = 0;
	if (x1 > (SCREEN_WIDTH -1)) x1 = (SCREEN_WIDTH -1);
	if (x2 < 0) x2 = 0;
	if (x2 > (SCREEN_WIDTH -1)) x2 = (SCREEN_WIDTH -1);
	if (y1 < 0) y1 = 0;
	if (y1 > (SCREEN_HEIGHT - 1)) y1 = (SCREEN_HEIGHT - 1);
	if (y2 < 0) y2 = 0;
	if (y2 > (SCREEN_HEIGHT - 1)) y2 = (SCREEN_HEIGHT - 1);

	if (x1 < x2) {
		clipping_x1 = x1;
		clipping_x2 = x2;
	} else {
		clipping_x2 = x1;
		clipping_x1 = x2;
	}

	if (y1 < y2) {
		clipping_y1 = y1;
		clipping_y2 = y2;
	} else {
		clipping_y2 = y1;
		clipping_y1 = y2;
	}
}

void gClearClipping() {
	clipping_x1 = 0;
	clipping_y1 = 0;
	clipping_x2 = SCREEN_WIDTH - 1;
	clipping_y2 = SCREEN_HEIGHT - 1;
}

void gDestroyBitmap(gBITMAP *img) {
   if (img) {
	free(img->data);
	free(img);
	}
}

gBITMAP *gCreateBitmap(unsigned int width, unsigned int height, unsigned char bpp) {
   gBITMAP *img;

   if (bpp != 32) return NULL; // supported BPPs
   if ((!width) || (!height)) return NULL; 

   img = malloc(sizeof(gBITMAP));
   if (!img) return NULL;
   img->bpp = bpp;
   img->w = width;
   img->h = height;
   img->data = malloc(width * height * (bpp >> 3));
   if (!img->data) {
 	free(img);
	return NULL;
	}
   return img;
}

void gDrawPixel16(unsigned short *screen, int x, int y, unsigned char r, unsigned char g, unsigned char b) {
	unsigned int sr, sg, sb;
	unsigned short pixel;

	if ((x < clipping_x1) || (x > clipping_x2) || (y < clipping_y1) || (y > clipping_y2)) return;
	
	// blend 
	screen[y * SCREEN_WIDTH + x] = RGB16(r, g, b);
}

void gBlendPixel16(unsigned short *screen, int x, int y, unsigned char r, unsigned char g, unsigned char b, unsigned char a) {
	unsigned int sr, sg, sb;
	unsigned short pixel;

	if ((x < clipping_x1) || (x > clipping_x2) || (y < clipping_y1) || (y > clipping_y2)) return;
	
	// get screen pixel
	pixel = screen[y * SCREEN_WIDTH + x];
	sr = PIXEL16_R(pixel); //((pixel >> 11) << 3);
	sg = PIXEL16_G(pixel); //((pixel >> 5) & 63) << 2;
	sb = PIXEL16_B(pixel); //(pixel & 31) << 3;
	// blend 
	screen[y * SCREEN_WIDTH + x] = RGB16(BLEND(r, a, sr), BLEND(g, a, sg), BLEND(b, a, sb));
}

void gBlendBitmap16(unsigned short *screen, int sx, int sy, gBITMAP *img, unsigned int ix, unsigned int iy, unsigned int iw, unsigned int ih) {
	int ssx;
	unsigned int sw, ijmp, sjmp;
	unsigned char *iaddr;
	unsigned int pixel;

	if ((!img) || (!img->data)) return; // sanity check
	if (img->bpp != 32) return; // supported BPPs
	if ((sx > clipping_x2) || (sy > clipping_y2) || 
	    ((sx + iw - 1) < clipping_x1) || ((sy + ih - 1) < clipping_y1)) return; // Out of screen	

	// Image dimensions
	if ((iw + ix) > img->w) iw = img->w - ix;
	if ((ih + iy) > img->h) ih = img->h - iy;

	// Clipping 
	if (sx < clipping_x1) {
		iw -= clipping_x1 - sx;
		sx = clipping_x1;
	}
	if (sy < clipping_y1) {
		ih -= clipping_y1 - sy;
		sy = clipping_y1;
	}
	if ((sx + iw - 1) > clipping_x2) iw -=  (sx + iw - 1) - clipping_x2; 
	if ((sy + ih - 1) > clipping_y2) ih -=  (sy + ih - 1) - clipping_y2; 

	ssx = sx;
	sw = iw;

	ijmp = (img->w - iw) * (img->bpp >> 3);
	iaddr = &img->data[(iy * img->w + ix) * 4 + 0];
	sjmp = SCREEN_WIDTH - iw;
	screen = &screen[sy * SCREEN_WIDTH + sx];

	for (; (ih > 0); ih--, iaddr += ijmp, screen += sjmp) { 
		for (iw = sw; (iw > 0); iw--, iaddr += 4, screen++) {
			// blend
			pixel = *((unsigned int *)iaddr);
			/* 
			*screen = RGB16(BLEND(iaddr[0], iaddr[3], PIXEL16_R(*screen)), 
					BLEND(iaddr[1], iaddr[3], PIXEL16_G(*screen)), 
					BLEND(iaddr[2], iaddr[3], PIXEL16_B(*screen)));
			*/
			*screen = RGB16(BLEND(PIXEL32_R(pixel), PIXEL32_A(pixel), PIXEL16_R(*screen)), 
					BLEND(PIXEL32_G(pixel), PIXEL32_A(pixel), PIXEL16_G(*screen)), 
					BLEND(PIXEL32_B(pixel), PIXEL32_A(pixel), PIXEL16_B(*screen)));
		}
	}
}

void gDrawBitmap16(unsigned short *screen, int sx, int sy, gBITMAP *img, unsigned int ix, unsigned int iy, unsigned int iw, unsigned int ih) {
	int ssx;
	unsigned int sw, ijmp, sjmp;
	unsigned char *iaddr;
	unsigned short pixel;

	if ((!img) || (!img->data)) return; // sanity check
	if ((img->bpp != 32) || (img->bpp != 32)) return; // supported BPPs
	if ((sx > clipping_x2) || (sy > clipping_y2) || 
	    ((sx + iw - 1) < clipping_x1) || ((sy + ih - 1) < clipping_y1)) return; // Out of screen	

	// Image dimensions
	if ((iw + ix) > img->w) iw = img->w - ix;
	if ((ih + iy) > img->h) ih = img->h - iy;

	// Clipping 
	if (sx < clipping_x1) {
		iw -= clipping_x1 - sx;
		sx = clipping_x1;
	}
	if (sy < clipping_y1) {
		ih -= clipping_y1 - sy;
		sy = clipping_y1;
	}
	if ((sx + iw - 1) > clipping_x2) iw -=  (sx + iw - 1) - clipping_x2; 
	if ((sy + ih - 1) > clipping_y2) ih -=  (sy + ih - 1) - clipping_y2; 

	ssx = sx;
	sw = iw;

	ijmp = (img->w - iw) * (img->bpp >> 3);
	iaddr = &img->data[(iy * img->w + ix) * (img->bpp >> 3) + 0];
	sjmp = SCREEN_WIDTH - iw;
	screen = &screen[sy * SCREEN_WIDTH + sx];

	switch (img->bpp) {
		case 32:
			for (; (ih > 0); ih--, iaddr += ijmp, screen += sjmp) { 
				for (iw = sw; (iw > 0); iw--, iaddr += 4, screen++) {
					*screen = RGB16(iaddr[0], iaddr[1], iaddr[2]); 
				}
			}
			break;
		case 16:
			for (; (ih > 0); ih--, iaddr += ijmp, screen += sjmp) { 
				for (iw = sw; (iw > 0); iw--, iaddr += 2) {
					*screen++ = *(unsigned short *)iaddr; 
				}
			}
			break;
	}
}

void gDrawScaledBitmap16(unsigned short *screen, int sx, int sy, gBITMAP *img, unsigned int iw, unsigned int ih) {
	int dx, dy;
	int x , y, fp_x, w, h;
	unsigned int *addr;
	unsigned int pixel;

	if ((!img) || (!img->data)) return; // sanity check
	if ((img->bpp != 32) || (img->bpp != 32)) return; // supported BPPs

	#define FP	10
	dx = (img->w << FP) / iw;
	dy = (img->h << FP) / ih;

	w = SCREEN_WIDTH;
	if (w > iw) w = iw;
	h = SCREEN_HEIGHT;
	if (h > ih) h = ih;

	for (y = 0; y < h; y++) {
		addr = &((unsigned int *)img->data)[img->w * ((y * dy) >> FP)]; 
		for (x = 0, fp_x = 0; x < w ; x++, fp_x += dx) {
			pixel = addr[fp_x >> FP];
			gDrawPixel16(screen, sx+x, sy+y, PIXEL32_R(pixel), PIXEL32_G(pixel), PIXEL32_B(pixel));
		}
	}
}

gBITMAP *gStretchBitmap(gBITMAP *img, unsigned int iw, unsigned int ih) {
	int dx, dy;
	int x , y, fp_x, fx, w, h;
	unsigned int *srcCurLineAddr, *srcPrevLineAddr, *srcNextLineAddr;
	unsigned int *dstAddr;
	unsigned int pixel, r, g, b, a, div;
	gBITMAP *toBmp;

	if ((!img) || (!img->data)) return NULL; // sanity check
	if ((img->bpp != 32) || (img->bpp != 32)) return NULL; // supported BPPs
	
	toBmp = gCreateBitmap(iw, ih, img->bpp);
	if (!toBmp) return NULL;

	#define FP	10
	dx = (img->w << FP) / iw;
	dy = (img->h << FP) / ih;

	w = img->w;
	if (w > iw) w = iw;
	h = img->h;
	if (h > ih) h = ih;

	for (y = 0; y < ih; y++) {
		// Current line
		srcCurLineAddr = &((unsigned int *)img->data)[img->w * ((y * dy) >> FP)];
		// Previous line
		if (y == 0) srcPrevLineAddr = NULL;
		else srcPrevLineAddr = &((unsigned int *)img->data)[img->w * (((y * dy) - 1) >> FP)];
		// Next line
		if ((((y * dy) + 1) >> FP) >= img->h) srcNextLineAddr = NULL;
		else srcNextLineAddr = &((unsigned int *)img->data)[img->w * (((y * dy) + 1) >> FP)];
		// Destination
		dstAddr = &((unsigned int*)toBmp->data)[toBmp->w * y]; 
		for (x = 0, fp_x = 0; x < iw ; x++, fp_x += dx) {
			// Current line
			div = 4;
			fx = fp_x >> FP;
			pixel = srcCurLineAddr[fx];
			r = PIXEL32_R(pixel) * 4;
			g = PIXEL32_G(pixel) * 4;
			b = PIXEL32_B(pixel) * 4;
			a = PIXEL32_A(pixel) * 4;
#define INCLUDE_PIXEL(p) \
		{\
		pixel = p;\
		r += PIXEL32_R(pixel);\
		g += PIXEL32_G(pixel);\
		b += PIXEL32_B(pixel);\
		a += PIXEL32_A(pixel);\
		div++;\
		}

			if (fx > 0) INCLUDE_PIXEL(srcCurLineAddr[fx - 1]);
			if ((fx + 1) < img->w) INCLUDE_PIXEL(srcCurLineAddr[fx + 1]);
			// Previous line
			if (srcPrevLineAddr) {
				INCLUDE_PIXEL(srcPrevLineAddr[fx]);
				if (fx > 0) INCLUDE_PIXEL(srcPrevLineAddr[fx - 1]);
				if ((fx + 1) < img->w) INCLUDE_PIXEL(srcPrevLineAddr[fx + 1]);
			}
			// Next line
			if (srcNextLineAddr) {
				INCLUDE_PIXEL(srcNextLineAddr[fx]);
				if (fx > 0) INCLUDE_PIXEL(srcNextLineAddr[fx - 1]);
				if ((fx + 1) < img->w) INCLUDE_PIXEL(srcNextLineAddr[fx + 1]);
			}
#undef INCLUDE_PIXEL
			dstAddr[x] = RGB32(r/div, g/div, b/div, a/div);
		}
	}

	return toBmp;
}



void gClearScreen(unsigned short *screen, unsigned short color) {
	int x, y;
   
	for (y = 0; y < SCREEN_HEIGHT; y++)
	    for (x = 0; x < SCREEN_WIDTH; x++) {
		screen[y * SCREEN_WIDTH + x] = color;
		}
}
