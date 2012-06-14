#ifndef __GRAPHICS_H__
#define __GRAPHICS_H__

#ifdef __cplusplus
extern "C" {
#endif

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 240

#define PIXEL32_A(p)	(p >> 24)
#define PIXEL32_B(p)	((p >> 16) & 0xff)
#define PIXEL32_G(p)	((p >>  8) & 0xff)
#define PIXEL32_R(p)	(p & 0xff)
#define RGB32(r, g, b, a) ((a << 24) | (b << 16) | (g << 8) | r)

#define RGB16(r, g, b)	(((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3))
#define PIXEL16_R(p)	((p >> 11) << 3)
#define PIXEL16_G(p)	(((p >> 5) & 63) << 2)
#define PIXEL16_B(p)	((p & 31) << 3)
//#define BLEND(c1, a, c2) (((((unsigned int)c1) * ((unsigned int)a)) + (((unsigned int)c2) * (0x100 - ((unsigned char)a)))) >> 8)
#define BLEND(c1, a, c2) ((((int)a * ((int)c1 - (int)c2)) + ((int)c2 << 8)) >> 8)
#ifndef MIN
	#define MIN(a, b) (((a) < (b))? (a) : (b)) 
#endif
#ifndef MIN
	#define MAX(a, b) (((a) > (b))? (a) : (b)) 
#endif


typedef struct {
	unsigned int w;
	unsigned int h;
	unsigned int bpp;
	unsigned char *data;
	} gBITMAP; 

void gSetClipping(int x1, int y1, int x2, int y2);
void gClearClipping();

void gClearScreen(unsigned short *screen, unsigned short color);

void gBlendPixel16(unsigned short *screen, int x, int y, unsigned char r, unsigned char g, unsigned char b, unsigned char a);
void gDrawPixel16(unsigned short *screen, int x, int y, unsigned char r, unsigned char g, unsigned char b); 
void gBlendBitmap16(unsigned short *screen, int sx, int sy, gBITMAP *img, unsigned int ix, unsigned int iy, unsigned int iw, unsigned int ih);
void gDrawBitmap16(unsigned short *screen, int sx, int sy, gBITMAP *img, unsigned int ix, unsigned int iy, unsigned int iw, unsigned int ih);
void gDrawScaledBitmap16(unsigned short *screen, int sx, int sy, gBITMAP *img, unsigned int iw, unsigned int ih);

void gDestroyBitmap(gBITMAP *img);
gBITMAP *gCreateBitmap(unsigned int width, unsigned int height, unsigned char bpp); 
gBITMAP *gStretchBitmap(gBITMAP *img, unsigned int iw, unsigned int ih);

#ifdef __cplusplus
}
#endif

#endif
