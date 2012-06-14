#ifndef _WIZ_SDK_H_
#define _WIZ_SDK_H_

#ifdef __cplusplus
extern "C" {
#endif

#define UPPERMEM_START  0x3000000
//0x2A00000
#define UPPERMEM_SIZE  (0x4000000-UPPERMEM_START)

#define SOUND_THREAD_SOUND_ON			1
#define SOUND_THREAD_SOUND_OFF		2
#define SOUND_THREAD_PAUSE				3

#define INP_BUTTON_UP				(18)
#define INP_BUTTON_LEFT				(16)
#define INP_BUTTON_DOWN				(19)
#define INP_BUTTON_RIGHT			(17)
#define INP_BUTTON_START			(9)
#define INP_BUTTON_SELECT			(8)
#define INP_BUTTON_L				(7)
#define INP_BUTTON_R				(6)
#define INP_BUTTON_A				(20)
#define INP_BUTTON_B				(21)
#define INP_BUTTON_X				(22)
#define INP_BUTTON_Y				(23)
#define INP_BUTTON_VOL_UP			(10)
#define INP_BUTTON_VOL_DOWN			(11)

void gp_setClipping(int x1, int y1, int x2, int y2);
void gp_drawString (int x,int y,int len,char *buffer,unsigned short color,void *framebuffer);
void gp_clearFramebuffer16(unsigned short *framebuffer, unsigned short pal);
void gp_setCpuspeed(unsigned int cpuspeed);
void gp_initGraphics(unsigned short bpp, int flip, int applyMmuHack);
void gp_setFramebuffer(int flip, int sync);
int gp_initSound(int rate, int bits, int stereo, int Hz, int frag);
void gp_stopSound(void);
void gp_Reset(void);
void gp_sound_volume(int l, int r);
//unsigned long gp_timer_read(void);
#define gp_timer_read	clock

unsigned int gp_getButton(unsigned char enable_diagnals);
void gp_video_RGB_setscaling(int W, int H);
void gp_video_RGB_setHZscaling(int W, int H);
void set_gamma(int g100);
void set_RAM_Timings(int tRC, int tRAS, int tWR, int tMRD, int tRFC, int tRP, int tRCD);

extern volatile int SoundThreadFlag;
extern volatile int CurrentSoundBank;
extern int CurrentFrameBuffer;
extern volatile short *pOutput[];
extern unsigned short *framebuffer16[];
extern unsigned long wiz_physvram[];
extern volatile unsigned short *wiz_memregs;
extern void *uppermem;
 
#ifdef __cplusplus
}
#endif

#endif

