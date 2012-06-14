
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/soundcard.h>
#include <linux/fb.h>
#include <linux/fb.h>
#include <pthread.h>
#include "menu.h"
#include "wiz_sdk.h"
#include <stdint.h>
#include "polluxregs.h"
#include <time.h>
#include "asmmemfuncs.h"
#include "pollux_set.h"
#include "warm.h"

#define SYS_CLK_FREQ 27
#define BUFFERS	4

static int fb_size=(320*240*2); //+(16*2);

//unsigned long gp2x_ticks_per_second=7372800/1000;
unsigned long   wiz_dev[3]={0,0,0};
unsigned long wiz_physvram[BUFFERS]={0,0,0,0};

unsigned short *framebuffer16[BUFFERS]={0,0,0,0};
static unsigned short *framebuffer_mmap[BUFFERS]={0,0,0,0};
unsigned short gp2x_sound_buffer[4+((44100*2)*8)]; //*2=stereo, *4=max buffers

volatile short *pOutput[8];
int InitFramebuffer=0;
int Timer=0;
volatile int SoundThreadFlag=0;
volatile int CurrentSoundBank=0;
int CurrentFrameBuffer=0;
int CurrentFrag=0;

// 1024x8   8x8 font, i love it :)
const unsigned int font8x8[]= {0x0,0x0,0xc3663c18,0x3c2424e7,0xe724243c,0x183c66c3,0xc16f3818,0x18386fc1,0x83f61c18,0x181cf683,0xe7c3993c,0x3c99c3,0x3f7fffff,0xe7cf9f,0x3c99c3e7,0xe7c399,0x3160c080,0x40e1b,0xcbcbc37e,0x7ec3c3db,0x3c3c3c18,0x81c087e,0x8683818,0x60f0e08,0x81422418,0x18244281,0xbd5a2418,0x18245abd,0x818181ff,0xff8181,0xa1c181ff,0xff8995,0x63633e,0x3e6363,0x606060,0x606060,0x3e60603e,0x3e0303,0x3e60603e,0x3e6060,0x3e636363,0x606060,0x3e03033e,0x3e6060,0x3e03033e,0x3e6363,0x60603e,0x606060,0x3e63633e,0x3e6363,0x3e63633e,0x3e6060,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x18181818,0x180018,0x666666,0x0,0x367f3600,0x367f36,0x3c067c18,0x183e60,0x18366600,0x62660c,0xe1c361c,0x6e337b,0x181818,0x0,0x18183870,0x703818,0x18181c0e,0xe1c18,0xff3c6600,0x663c,0x7e181800,0x1818,0x0,0x60c0c00,0x7e000000,0x0,0x0,0x181800,0x18306040,0x2060c,0x6e76663c,0x3c6666,0x18181c18,0x7e1818,0x3060663c,0x7e0c18,0x3018307e,0x3c6660,0x363c3830,0x30307e,0x603e067e,0x3c6660,0x3e06063c,0x3c6666,0x1830607e,0xc0c0c,0x3c66663c,0x3c6666,0x7c66663c,0x1c3060,0x181800,0x1818,0x181800,0xc1818,0xc183060,0x603018,0x7e0000,0x7e00,0x30180c06,0x60c18,0x3060663c,0x180018,0x5676663c,0x7c0676,0x66663c18,0x66667e,0x3e66663e,0x3e6666,0x606663c,0x3c6606,0x6666361e,0x1e3666,0x3e06067e,0x7e0606,0x3e06067e,0x60606,0x7606067c,0x7c6666,0x7e666666,0x666666,0x1818183c,0x3c1818,0x60606060,0x3c6660,0xe1e3666,0x66361e,0x6060606,0x7e0606,0x6b7f7763,0x636363,0x7e7e6e66,0x666676,0x6666663c,0x3c6666,0x3e66663e,0x60606,0x6666663c,0x6c366e,0x3e66663e,0x666636,0x3c06663c,0x3c6660,0x1818187e,0x181818,0x66666666,0x7c6666,0x66666666,0x183c66,0x6b636363,0x63777f,0x183c6666,0x66663c,0x3c666666,0x181818,0x1830607e,0x7e060c,0x18181878,0x781818,0x180c0602,0x406030,0x1818181e,0x1e1818,0x63361c08,0x0,0x0,0x7f0000,0xc060300,0x0,0x603c0000,0x7c667c,0x663e0606,0x3e6666,0x63c0000,0x3c0606,0x667c6060,0x7c6666,0x663c0000,0x3c067e,0xc3e0c38,0xc0c0c,0x667c0000,0x3e607c66,0x663e0606,0x666666,0x181c0018,0x3c1818,0x18180018,0xe181818,0x36660606,0x66361e,0x1818181c,0x3c1818,0x7f370000,0x63636b,0x663e0000,0x666666,0x663c0000,0x3c6666,0x663e0000,0x63e6666,0x667c0000,0x607c6666,0x663e0000,0x60606,0x67c0000,0x3e603c,0x187e1800,0x701818,0x66660000,0x7c6666,0x66660000,0x183c66,0x63630000,0x363e6b,0x3c660000,0x663c18,0x66660000,0x3e607c66,0x307e0000,0x7e0c18,0xc181870,0x701818,0x18181818,0x18181818,0x3018180e,0xe1818,0x794f0600,0x30};

pthread_t       gp2x_sound_thread=0, gp2x_sound_thread_exit=0;

uint32_t bkregs32[15];	/* backing up values */
int layer_width[2];
volatile uint32_t *memregs32;
volatile uint16_t *memregs16;
volatile uint8_t  *memregs8;

extern unsigned short * pOutputScreen;

/* Sets the dirty flag for the MLC */
static void lc_dirtymlc(void)
{
	MLCCONTROLT |= BIT(3);
}

#define FBIO_MAGIC			'D'
#define	FBIO_LCD_CHANGE_CONTROL		_IOW(FBIO_MAGIC, 90, unsigned int[2])
#define	LCD_DIRECTION_ON_CMD		5	/* 320x240 */
#define	LCD_DIRECTION_OFF_CMD		6	/* 240x320 */

void lc_screensize(int w, int h) {
	unsigned int send[2];
	int fb_fd = open("/dev/fb0", O_RDWR);
	send[1] = 0;
	/* alter MLC to rotate the display */
	if(w == 320 && h == 240) {
		send[0] = LCD_DIRECTION_ON_CMD;
	} else if(w == 240 && h == 320) {
		send[0] = LCD_DIRECTION_OFF_CMD;
	}
	
	/* send command to display controller */
	ioctl(fb_fd, FBIO_LCD_CHANGE_CONTROL, &send);
	close(fb_fd);
	/* apply the MLC changes */
	MLCSCREENSIZE = ((h-1)<<16) | (w-1);
	lc_dirtymlc();
}

/* Sets the dirty flag for the layer */
static void lc_dirtylayer(int layer)
{
	if(layer == 0) {
		MLCCONTROL0 |= BIT(4);
	} else {
		MLCCONTROL1 |= BIT(4);
	}
}

/* Sets layer position */
static void lc_layerpos(int layer, int x1, int y1, int x2, int y2)
{
	unsigned int temp_lr, temp_tb;
	temp_lr = (x1 << 16) | x2;
	temp_tb = (y1 << 16) | y2;

	if(layer == 0) {
		MLCLEFTRIGHT0 = temp_lr;
		MLCTOPBOTTOM0 = temp_tb;
	} else {
		MLCLEFTRIGHT1 = temp_lr;
		MLCTOPBOTTOM1 = temp_tb;
	}
	lc_dirtylayer(layer);

	layer_width[layer] = (x2-x1)+1;
}

/* Sets stride registers */
static void lc_setstride(int layer, int hs, int vs)
{
	/* set how many bytes the MLC is supposed to read */
	if(layer == 0) {
		MLCHSTRIDE0 = hs;
		MLCVSTRIDE0 = vs;
	} else {
		MLCHSTRIDE1 = hs;
		MLCVSTRIDE1 = vs;
	}
	lc_dirtylayer(layer);
}

/* Sets layer properties */
static void lc_setlayer(int layer, unsigned int onoff, unsigned int alpha, unsigned int invert, unsigned int trans, unsigned int mode)
{
	/* set layer properties register */
	unsigned int temp;
	temp = 0;
	if(onoff)	temp |= BIT(5);
	if(alpha)	temp |= BIT(2);
	if(invert)	temp |= BIT(1);
	if(trans)	temp |= BIT(0);
	temp |= BIT(12);
	temp |= BIT(14);
	temp |= BIT(15);
	temp |= (mode<<16);

	if(layer == 0) {
		MLCCONTROL0 = temp;
	} else {
		MLCCONTROL1= temp;
	}
	lc_dirtylayer(layer);

	int pixel_width = 0;
	/* set stride based on pixel width*/
	switch(mode) {
		case RGB565:
		case BGR565:
		case XRGB1555:
		case XBGR1555:
		case XRGB4444:
		case XBGR4444:
		case XRGB8332:
		case XBGR8332:
		case ARGB1555:
		case ABGR1555:
		case ARGB4444:
		case ABGR4444:
		case ARGB8332:
		case ABGR8332:
			pixel_width = 2;
			break;
		case RGB888:
		case BGR888:
			pixel_width = 3;
			break;
		case ARGB8888:
		case ABGR8888:
			pixel_width = 4;
			break;
		case PTRGB565:
			pixel_width = 1;
			break;
		default:
			break;
	}
	lc_setstride(layer, pixel_width, pixel_width*layer_width[layer]);
}

/* Sets the background colour */
static void lc_setbgcol(unsigned int colour)
{
	/* colour to be displayed where no layers cover */
	MLCBGCOLOR = colour;
	lc_dirtymlc();
}

/* 
########################
Graphics functions
########################
 */

static void debug(char *text, int pause)
{
	gp_clearFramebuffer16(framebuffer16[currFB],0);
	gp_drawString(0,0,strlen(text),text,(unsigned short)MENU_RGB(31,31,31),framebuffer16[currFB]);
	MenuFlip();
	if(pause)	MenuPause();

}

static int clipping_x1 = 0; 
static int clipping_x2 = 319;
static int clipping_y1 = 0;
static int clipping_y2 = 239;

void gp_setClipping(int x1, int y1, int x2, int y2) {
	if (x1 < 0) x1 = 0;
	if (x1 > 319) x1 = 319;
	if (x2 < 0) x2 = 0;
	if (x2 > 319) x2 = 319;
	if (y1 < 0) y1 = 0;
	if (y1 > 239) y1 = 239;
	if (y2 < 0) y2 = 0;
	if (y2 > 239) y2 = 239;

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

static __inline__
void gp_drawPixel16 ( int x, int y, unsigned short c, unsigned short *framebuffer ) 
{
	if ((x < clipping_x1) || (x > clipping_x2) || (y < clipping_y1) || (y > clipping_y2)) return;
	*(framebuffer +(320*y)+x ) = c;
}
static
void set_char8x8_16bpp (int xx,int yy,int offset,unsigned short mode,unsigned short *framebuffer) 
{
	unsigned int y, pixel;
	offset *= 2;
	pixel = font8x8[0 + offset];
	for (y = 0; y < 4; y++) 
	{
		if (pixel&(1<<(0+(y<<3)))) gp_drawPixel16(xx+0, yy+y, mode, framebuffer);
		if (pixel&(1<<(1+(y<<3)))) gp_drawPixel16(xx+1, yy+y, mode, framebuffer);
		if (pixel&(1<<(2+(y<<3)))) gp_drawPixel16(xx+2, yy+y, mode, framebuffer);
		if (pixel&(1<<(3+(y<<3)))) gp_drawPixel16(xx+3, yy+y, mode, framebuffer);
		if (pixel&(1<<(4+(y<<3)))) gp_drawPixel16(xx+4, yy+y, mode, framebuffer);
		if (pixel&(1<<(5+(y<<3)))) gp_drawPixel16(xx+5, yy+y, mode, framebuffer);
		if (pixel&(1<<(6+(y<<3)))) gp_drawPixel16(xx+6, yy+y, mode, framebuffer);
		if (pixel&(1<<(7+(y<<3)))) gp_drawPixel16(xx+7, yy+y, mode, framebuffer);
	}
	pixel = font8x8[1 + offset];
	for (y = 0; y < 4; y++) 
	{
		if (pixel&(1<<(0+(y<<3)))) gp_drawPixel16(xx+0, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(1+(y<<3)))) gp_drawPixel16(xx+1, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(2+(y<<3)))) gp_drawPixel16(xx+2, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(3+(y<<3)))) gp_drawPixel16(xx+3, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(4+(y<<3)))) gp_drawPixel16(xx+4, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(5+(y<<3)))) gp_drawPixel16(xx+5, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(6+(y<<3)))) gp_drawPixel16(xx+6, yy+y+4, mode, framebuffer);
		if (pixel&(1<<(7+(y<<3)))) gp_drawPixel16(xx+7, yy+y+4, mode, framebuffer);

	}
}

void gp_drawString (int x,int y,int len,char *buffer,unsigned short color,void *framebuffer) 
{
	int l,base=0;

	for (l=0;l<len;l++) 
	{
		set_char8x8_16bpp (x+base,y,buffer[l],color,framebuffer);
		base+=8;
	}
}

void gp_clearFramebuffer16(unsigned short *framebuffer, unsigned short pal)
{
	int x,y;
	for (y=0;y<240;y++)
	{
		for (x=0;x<320;x++)
		{
			*framebuffer++ = pal;
		}
	}
}

unsigned int gp_getButton(unsigned char enable_diagnals)
{
	return ~((GPIOCPAD << 16) | GPIOBPAD);
}

void gp_initGraphics(unsigned short bpp, int flip, int applyMmuHack)
{
	
	int x = 0;
	unsigned int key = 0;
	unsigned int offset = 0;
	char buf[256];

	struct fb_fix_screeninfo info;
	int fb_fd;
	int f;

	gp_setClipping(0, 0, 319, 239);

#ifdef DEBUG
    printf("Entering gp_initGraphics....\r\n");
#endif    
	/*
	First check that frame buffer memory has not already been setup
	*/
	if (!InitFramebuffer)
	{
#ifdef DEBUG
		sprintf(buf, "Initing buffer\r\n");
		printf(buf);
#endif 
		wiz_dev[0] = open("/dev/mem", O_RDWR);
		if(wiz_dev[0] < 0) {
			printf("Could not open /dev/mem\n");
			return;
		}
		
#ifdef DEBUG
		sprintf(buf, "Devices opened\r\n");
		printf(buf);
		sprintf(buf, "/dev/mem: %x \r\n", wiz_dev[0]);
		printf(buf);
#endif 		

		memregs32 = (volatile unsigned int *)mmap(0, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, wiz_dev[0], 0xC0000000);
		if(memregs32 == (volatile unsigned int *)0xFFFFFFFF) {
			printf("Could not mmap hardware registers\n");
			return;
		}
  
		memregs16 = (volatile unsigned short *)memregs32;
		memregs8 = (volatile unsigned char *)memregs32;
		
		/* backup old register values to restore upon exit */
		bkregs32[0] = MLCADDRESS0; bkregs32[1] = MLCADDRESS1; bkregs32[2] = MLCCONTROL0; bkregs32[3] = MLCCONTROL1; bkregs32[4] = MLCLEFTRIGHT0;
		bkregs32[5] = MLCTOPBOTTOM0; bkregs32[6] = MLCLEFTRIGHT1; bkregs32[7] = MLCTOPBOTTOM1; bkregs32[8] = MLCBGCOLOR; bkregs32[9] = MLCHSTRIDE0;
		bkregs32[10] = MLCVSTRIDE0; bkregs32[11] = MLCHSTRIDE1; bkregs32[12] = MLCVSTRIDE1; bkregs32[13] = DPCCTRL1; bkregs32[14] = MLCSCREENSIZE;
		bkregs32[15] = PLLSETREG0;

		// Get frame buffer address, do not hardcode them, for tv-out compatibility
		fb_fd = open("/dev/fb0", O_RDWR);
		if ((!fb_fd) || (ioctl(fb_fd, FBIOGET_FSCREENINFO, &info) < 0)) return;

		wiz_physvram[0] = info.smem_start;		
		framebuffer_mmap[0] = (void *)mmap(0, fb_size * BUFFERS, PROT_READ|PROT_WRITE, MAP_SHARED, wiz_dev[0], wiz_physvram[0]); 		

		for (f = 1; f < BUFFERS; f++) {
			framebuffer_mmap[f] = framebuffer_mmap[f-1] + (fb_size / sizeof(unsigned short));
			wiz_physvram[f] = wiz_physvram[f-1] + fb_size; 
			}

		close(fb_fd);

		if (applyMmuHack) 
		{
			warm_init();
			warm_change_cb_upper(WCB_C_BIT|WCB_B_BIT, 1);
		}
		
		// Init and clear the frame buffers
		for (f = 0; f < BUFFERS; f++) {
			memset(framebuffer_mmap[f], 0, fb_size);
			framebuffer16[f] = framebuffer_mmap[f];
			}

/* Not working well with TV-Out
		// offset externally visible buffers by 8
		// this allows DrMD to not worry about clipping
		framebuffer16[0]=framebuffer_mmap[0]+8;
		framebuffer16[1]=framebuffer_mmap[1]+8;
		framebuffer16[2]=framebuffer_mmap[2]+8;
		framebuffer16[3]=framebuffer_mmap[3]+8;
		//ofset physical buffer as well
		wiz_physvram[0]+=16;
		wiz_physvram[1]+=16;
		wiz_physvram[2]+=16;
		wiz_physvram[3]+=16;
*/
		InitFramebuffer=1;		
		
	}
	
	
	// Set graphics mode
	lc_screensize(320, 240); 
	lc_setbgcol(0x000000); /* set default background colour */
	lc_layerpos(0, 0, 0, 319, 239);	/* set default layer positions */
	lc_layerpos(1, 0, 0, 319, 239);
    lc_setlayer(0, 0, 0, 0, 0, RGB565); /* set default layer settings */
    lc_setlayer(1, 1, 0, 0, 0, RGB565);
	
	gp_setFramebuffer(flip,1);
	usleep(100000);

    pollux_set(memregs16, "lcd_timings=397,1,37,277,341,0,17,337;dpc_clkdiv0=9");
    pollux_set(memregs16, "ram_timings=2,9,4,1,1,1,1");
#ifdef DEBUG
    printf("Leaving gp_initGraphics....\r\n");
#endif 
}

void gp_setFramebuffer(int flip, int sync)
{
	CurrentFrameBuffer=flip;
	unsigned int address=(unsigned int)wiz_physvram[flip];
	unsigned short x=0;

	// Wait for VSync if required
	if (sync) {
		while((DPCCTRL0 & 0x400) == 0); 
		DPCCTRL0 |= 0x400;
		}

	/* set absolute address for framebuffers */
	MLCADDRESS1 = address;
	lc_dirtylayer(1);
}
	
/* 
########################
Sound functions
########################
 */
static
void *gp2x_sound_play(void *x)
{
	//struct timespec ts; ts.tv_sec=0, ts.tv_nsec=1000;
	while(! gp2x_sound_thread_exit)
	{
		Timer++;
		//CurrentSoundBank++;
		//if (CurrentSoundBank >= 8) CurrentSoundBank = 0;
		
		//if (SoundThreadFlag==SOUND_THREAD_SOUND_ON)
		//{
		write(wiz_dev[1], (void *)pOutput[CurrentSoundBank], gp2x_sound_buffer[1]);
		CurrentSoundBank = (CurrentSoundBank  + 1) & 7;
		ioctl(wiz_dev[1], SOUND_PCM_SYNC, 0); 
			//ts.tv_sec=0, ts.tv_nsec=(gp2x_sound_buffer[3]<<16)|gp2x_sound_buffer[2];
			//nanosleep(&ts, NULL);
/*
		}
		else
		{
			write(wiz_dev[1], (void *)&gp2x_sound_buffer[4], gp2x_sound_buffer[1]);
			//ioctl(wiz_dev[1], SOUND_PCM_SYNC, 0); 
			//ts.tv_sec=0, ts.tv_nsec=(gp2x_sound_buffer[3]<<16)|gp2x_sound_buffer[2];
			//nanosleep(&ts, NULL);
		}
*/
	}
 
	return NULL;
}

void gp_sound_volume(int l, int r) 
{ 
	if(!wiz_dev[2])
	{
		wiz_dev[2] = open("/dev/mixer", O_WRONLY); 
	}

	l=((l<<8)|r);
	ioctl(wiz_dev[2], SOUND_MIXER_WRITE_PCM, &l);
} 

/*
unsigned long gp_timer_read(void)
{
  // Once again another peice of direct hardware access bites the dust
  // the code below is broken in firmware 2.1.1 so I've replaced it with a
  // to a linux function which seems to work
  //return gp2x_memregl[0x0A00>>2]/gp2x_ticks_per_second;
  struct timeval tval; // timing
  
  gettimeofday(&tval, 0);
  //tval.tv_usec
  //tval.tv_sec
  return (tval.tv_sec*1000000)+tval.tv_usec;
}
*/

int gp_initSound(int rate, int bits, int stereo, int Hz, int frag)
{
	int status;
	int i=0;
	int nonblocking=1;
	unsigned int bufferStart=0;
	int result;
	char text[256];
	
	//int frag=0x00020010;   // double buffer - frag size = 1<<0xf = 32768

	//8 = 256				= 2 fps loss			= good sound
	//9 = 512				= 1 fps loss			= good sound
	//A = 1024				= 
	//f = 32768				= 0 fps loss			= bad sound
	/*	
	if ((frag!= CurrentFrag)&&(wiz_dev[1]!=0))
	{
		// Different frag config required
		// close device in order to re-adjust
		close(wiz_dev[1]);
		wiz_dev[1]=0;
	}
	*/

	if (wiz_dev[1]==0)
	{
		wiz_dev[1] = open("/dev/dsp", O_WRONLY);
		printf("Opening sound device: %x\r\n",wiz_dev[1]);
		//ioctl(wiz_dev[1], SNDCTL_DSP_SETFRAGMENT, &frag);
		//CurrentFrag=frag; // save frag config
	}

	//ioctl(wiz_dev[3], SNDCTL_DSP_RESET, 0);
	result=ioctl(wiz_dev[1], SNDCTL_DSP_SPEED,  &rate);
	if(result==-1)
	{
		debug("Error setting DSP Speed",1);
		return(-1);
	}
	
	result=ioctl(wiz_dev[1], SNDCTL_DSP_SETFMT,  &bits);
	if(result==-1)
	{
		debug("Error setting DSP format",1);
		return(-1);
	}

	result=ioctl(wiz_dev[1], SNDCTL_DSP_STEREO,  &stereo);
	if(result==-1)
	{
		debug("Error setting DSP format",1);
		return(-1);
	}
	//printf("Disable Blocking: %x\r\n",ioctl(wiz_dev[3], 0x5421, &nonblocking));
	
	gp2x_sound_buffer[1]=(gp2x_sound_buffer[0]=(rate/Hz)) << (stereo + (bits==16));
	gp2x_sound_buffer[2]=(1000000000/Hz)&0xFFFF;
	gp2x_sound_buffer[3]=(1000000000/Hz)>>16;
 
	bufferStart= (unsigned int)&gp2x_sound_buffer[4];
	pOutput[0] = (short*)bufferStart+(0*gp2x_sound_buffer[1]);
	pOutput[1] = (short*)bufferStart+(1*gp2x_sound_buffer[1]);
	pOutput[2] = (short*)bufferStart+(2*gp2x_sound_buffer[1]);
	pOutput[3] = (short*)bufferStart+(3*gp2x_sound_buffer[1]);
	pOutput[4] = (short*)bufferStart+(4*gp2x_sound_buffer[1]);
	pOutput[5] = (short*)bufferStart+(5*gp2x_sound_buffer[1]);
	pOutput[6] = (short*)bufferStart+(6*gp2x_sound_buffer[1]);
	pOutput[7] = (short*)bufferStart+(7*gp2x_sound_buffer[1]);
	
	if(!gp2x_sound_thread) 
	{ 
		pthread_create( &gp2x_sound_thread, NULL, gp2x_sound_play, NULL);
		//atexit(gp_Reset); 
	}
	
	for(i=0;i<(gp2x_sound_buffer[1]*8);i++)
	{
		gp2x_sound_buffer[4+i] = 0;
	}
	
	return(0);
}

void gp_stopSound(void)
{
	unsigned int i=0;
	gp2x_sound_thread_exit=1;
	printf("Killing Thread\r\n");
	for(i=0;i<(gp2x_sound_buffer[1]*8);i++)
	{
		gp2x_sound_buffer[4+i] = 0;
	}
	usleep(100000); 
	printf("Thread is dead\r\n");
	gp2x_sound_thread=0;
	gp2x_sound_thread_exit=0;
	CurrentSoundBank=0;
}


/* 
########################
System functions
########################
 */
void gp_Reset(void)
{
	unsigned int i=0;
	
	gp_setCpuspeed(533);

	if( gp2x_sound_thread) 
	{ 
		gp2x_sound_thread_exit=1; 
		usleep(500); 
	}
 
	MLCADDRESS0 = bkregs32[0]; MLCADDRESS1 = bkregs32[1]; MLCCONTROL0 = bkregs32[2]; MLCCONTROL1 = bkregs32[3]; MLCLEFTRIGHT0 = bkregs32[4];
	MLCTOPBOTTOM0 = bkregs32[5]; MLCLEFTRIGHT1 = bkregs32[6]; MLCTOPBOTTOM1 = bkregs32[7]; MLCBGCOLOR = bkregs32[8]; MLCHSTRIDE0 = bkregs32[9];
	MLCVSTRIDE0 = bkregs32[10]; MLCHSTRIDE1 = bkregs32[11]; MLCVSTRIDE1 = bkregs32[12]; DPCCTRL1 = bkregs32[13]; MLCSCREENSIZE = bkregs32[14];

	lc_dirtylayer(0);
	lc_dirtylayer(1);
	lc_dirtymlc();

   	munmap((void *)memregs32, 0x20000);
	
	munmap(framebuffer_mmap[0], fb_size * BUFFERS);

	if (wiz_dev[0]) close(wiz_dev[0]);
	if (wiz_dev[1]) close(wiz_dev[1]);
	if (wiz_dev[2]) close(wiz_dev[2]);
	
	fcloseall();

	chdir("/usr/gp2x");
	execl("gp2xmenu",NULL);
}

void gp_video_RGB_setscaling(int W, int H)
{
	uint16_t * pSource = (uint16_t *)pOutputScreen;
	uint16_t * pTarget = (uint16_t *)framebuffer16[currFB];
	unsigned short y;
	unsigned short x;
	if (H == 239)
	{
		for (y = 240; y != 0; y--)
		{
			pSource+=32;
			for (x = 64; x != 0; x--)
			{
				pTarget[0] = pSource[0];
				pTarget[1] = pSource[1];
				pTarget[2] = pSource[2];
				pTarget[3] = pSource[3];
				pTarget[4] = pSource[3];
				pTarget+=5;
				pSource+=4;		
			}
			pSource+=32;
		}
	}
	else // 224
	{
		pSource += 2560;
		unsigned short pos = 2;
		for (y = 240; y != 0; y--)
		{
			pSource+=32;
			for (x = 64; x != 0; x--)
			{
				pTarget[0] = pSource[0];
				pTarget[1] = pSource[1];
				pTarget[2] = pSource[2];
				pTarget[3] = pSource[3];
				pTarget[4] = pSource[3];
				pTarget+=5;
				pSource+=4;		
			}
			pSource+=32;
			pos--;

			if (pos == 0)
			{
				pSource -= 320;
				pos = 14;
			}
		}
	}
}

#define COLORMIX(a, b) ( ((((a & 0xF81F) + (b & 0xF81F)) >> 1) & 0xF81F) | ((((a & 0x07E0) + (b & 0x07E0)) >> 1) & 0x07E0) )
void gp_video_RGB_setHZscaling(int W, int H)
{
	uint16_t * pSource = (uint16_t *)pOutputScreen;
	uint16_t * pTarget = (uint16_t *)framebuffer16[currFB];
	unsigned short y;
	unsigned short x;

	if (H == 224)
	{
		pSource += 2560;
		pTarget += 2560;
	}
	for (y = H; y != 0; y--)
	{
		pSource+=32;
		for (x = 64; x != 0; x--)
		{
			pTarget[0] = pSource[0];
			pTarget[1] = pSource[1];
			pTarget[2] = pSource[2];
			pTarget[3] = COLORMIX(pSource[2],pSource[3]);
			pTarget[4] = pSource[3];
			pTarget+=5;
			pSource+=4;		
		}
		pSource+=32;
	}
}

void gp_setCpuspeed(unsigned int MHZ)
{
	unsigned  long v;
	unsigned mdiv, pdiv=9, sdiv=0;

	mdiv= (MHZ * pdiv) / SYS_CLK_FREQ;
	mdiv &= 0x3FF;
	v= pdiv<<18 | mdiv<<8 | sdiv;

	PLLSETREG0 = v;
	PWRMODE |= 0x8000;
}

// craigix: --trc 6 --tras 4 --twr 1 --tmrd 1 --trfc 1 --trp 2 --trcd 2
// set_RAM_Timings(6, 4, 1, 1, 1, 2, 2);
void set_RAM_Timings(int tRC, int tRAS, int tWR, int tMRD, int tRFC, int tRP, int tRCD)
{
}

void set_gamma(int g100)
{
}





