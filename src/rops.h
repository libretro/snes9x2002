#ifndef __ROPS_H__
#define __ROPS_H__

#include <boolean.h>

/*
   Raster Operations macros
*/

// -------------
// RGB_565
// a.red = a.red - b.red
// a.blue = a.blue - b.blue
// a.green = a.green - b.green
/*
#define ROP_SUB(a, b) \
         "  bics  " #b ", " #b ", #0b00000100000100000   \n"\
         "  orr   " #a ", " #a ", #0b00000100000100000   \n"\
         "  orr   " #a ", " #a ", #0b10000000000000000   \n"\
         "  sub   " #a ", " #a ", " #b "        \n"\
         "  tst   " #a ", #0b00000000000100000  \n"\
         "  biceq " #a ", " #a ", #0b00000000000011111   \n"\
         "  tst   " #a ", #0b00000100000000000  \n"\
         "  biceq " #a ", " #a ", #0b00000011111100000   \n"\
         "  tst   " #a ", #0b10000000000000000  \n"\
         "  biceq " #a ", " #a ", #0b01111100000000000   \n"
*/
#define ROP_SUB(a, b) \
         "	bics	" #b ", " #b ", #0b00000100000100000	\n"\
         "	beq	999f	\n"\
         "	orr	" #a ", " #a ", #0b00000100000100000	\n"\
         "	orr	" #a ", " #a ", #(1 << 31)	\n"\
         "	subs	" #a ", " #a ", " #b " 			\n"\
         "	bicpl	" #a ", " #a ", #0b01111100000000000	\n"\
         "	tst	" #a ", #0b00000000000100000	\n"\
         "	biceq	" #a ", " #a ", #0b00000000000011111	\n"\
         "	tst	" #a ", #0b00000100000000000	\n"\
         "	biceq	" #a ", " #a ", #0b00000011111100000	\n"\
         "999:\n"


// -------------
// RGB_565
// if ZF set do ROP_SUB, else:
// a.red = (a.red - b.red) / 2
// a.blue = (a.blue - b.blue) / 2
// a.green = (a.green - b.green) / 2
/*
#define ROP_SUB1_2(a, b) \
         "  movne " #a ", " #a ", lsr #1        \n"\
         "  bicne " #a ", " #a ", #0b00000010000010000   \n"\
         "  movne " #b ", " #b ", lsr #1        \n"\
         "  bicne " #b ", " #b ", #0b00000010000010000   \n"\
                              \
         "  bic   " #b ", " #b ", #0b00000100000100000   \n"\
         "  orr   " #a ", " #a ", #0b00000100000100000   \n"\
         "  orr   " #a ", " #a ", #0b10000000000000000   \n"\
         "  sub   " #a ", " #a ", " #b "        \n"\
         "  tst   " #a ", #0b00000000000100000  \n"\
         "  biceq " #a ", " #a ", #0b00000000000011111   \n"\
         "  tst   " #a ", #0b00000100000000000  \n"\
         "  biceq " #a ", " #a ", #0b00000011111100000   \n"\
         "  tst   " #a ", #0b10000000000000000  \n"\
         "  biceq " #a ", " #a ", #0b01111100000000000   \n"
*/

#define ROP_SUB1_2(a, b) \
         "	movne	" #a ", " #a ", lsr #1			\n"\
         "	bicne	" #a ", " #a ", #0b00000010000010000	\n"\
         "	movne	" #b ", " #b ", lsr #1			\n"\
         "	bicne	" #b ", " #b ", #0b00000010000010000	\n"\
                              \
         "	bics	" #b ", " #b ", #0b00000100000100000	\n"\
         "	beq	999f \n"\
         "	orr	" #a ", " #a ", #0b00000100000100000	\n"\
         "	orr	" #a ", " #a ", #(1 << 31)	\n"\
         "	subs	" #a ", " #a ", " #b " 			\n"\
         "	bicpl	" #a ", " #a ", #0b01111100000000000	\n"\
         "	tst	" #a ", #0b00000000000100000	\n"\
         "	biceq	" #a ", " #a ", #0b00000000000011111	\n"\
         "	tst	" #a ", #0b00000100000000000	\n"\
         "	biceq	" #a ", " #a ", #0b00000011111100000	\n"\
         "999:\n"


// -------------
// RGB_565
// a.red = a.red + b.red
// a.blue = a.blue + b.blue
// a.green = a.green + b.green
#define ROP_ADD(a, b) \
         "	bics	" #b ", " #b ", #0b00000100000100000	\n"\
         "	beq	999f \n"\
         "	bic	" #a ", " #a ", #0b00000100000100000	\n"\
         "	add	" #a ", " #a ", " #b " 			\n"\
         "	tst	" #a ", #0b00000000000100000	\n"\
         "	orrne	" #a ", " #a ", #0b00000000000011111	\n"\
         "	tst	" #a ", #0b00000100000000000	\n"\
         "	orrne	" #a ", " #a ", #0b00000011111100000	\n"\
         "	tst	" #a ", #0b10000000000000000	\n"\
         "	orrne	" #a ", " #a ", #0b01111100000000000	\n"\
         "999:\n"

// -------------
// RGB_565
// if ZF set do ROP_ADD, else:
// a.red = (a.red + b.red) / 2
// a.blue = (a.blue + b.blue) / 2
// a.green = (a.green + b.green) / 2
#define ROP_ADD1_2(a, b) \
         "	bic	" #a ", " #a ", #0b00000100000100000	\n"\
         "	bicne	" #a ", " #a ", #0b00001000001000000	\n"\
         "	bic	" #b ", " #b ", #0b00000100000100000	\n"\
         "	bicne	" #b ", " #b ", #0b00001000001000000	\n"\
         "	add	" #a ", " #a ", " #b "			\n"\
         "	movne	" #a ", " #a ", lsr #1			\n"\
         "	tst	" #a ", #0b00000000000100000	\n"\
         "	orrne	" #a ", " #a ", #0b00000000000011111	\n"\
         "	tst	" #a ", #0b00000100000000000	\n"\
         "	orrne	" #a ", " #a ", #0b00000011111100000	\n"\
         "	tst	" #a ", #0b10000000000000000	\n"\
         "	orrne	" #a ", " #a ", #0b01111100000000000	\n"


typedef struct
{
   unsigned char line;
   unsigned char rop;
   unsigned int value;
} ROPSTRUCT;

#define MAX_ROPS  0x10000
extern ROPSTRUCT rops[MAX_ROPS];
extern unsigned int ROpCount;

#define ROP_NOP         0
#define ROP_FIXEDCOLOUR    1
#define ROP_PALETTE     2
#define ROP_SCREEN_MODE    3
#define ROP_BRIGHTNESS     4
#define ROP_FORCE_BLANKING 5
#define ROP_TILE_ADDRESS   6
#define ROP_MOSAIC      7
#define ROP_BG_SCSIZE_SCBASE  8
#define ROP_BG_NAMEBASE    9
#define ROP_MODE7_ROTATION 10
#define ROP_BG_WINDOW_ENABLE  11
#define ROP_WINDOW1_LEFT   12
#define ROP_WINDOW1_RIGHT  13
#define ROP_WINDOW2_LEFT   14
#define ROP_WINDOW2_RIGHT  15
#define ROP_BG_WINDOW_LOGIC   16
#define ROP_OBJS_WINDOW_LOGIC 17
#define ROP_MAIN_SCREEN_DESIG 18
#define ROP_SUB_SCREEN_DESIG  19
#define ROP_MAIN_SCREEN_WMASK 20
#define ROP_SUB_SCREEN_WMASK  21
#define ROP_FIXEDCOL_OR_SCREEN   22
#define ROP_ADD_OR_SUB_COLOR  23

#define ADD_ROP(drop, dval)   {rops[ROpCount].line = IPPU.CurrentLine; rops[ROpCount].rop = drop; rops[ROpCount].value = dval; ROpCount++;}
#define RESET_ROPS(from)   \
   { \
   unsigned int c;\
   for (c = from; c < ROpCount; c++) doRaster(&rops[c]);\
   ROpCount = 0;\
   }

void doRaster(ROPSTRUCT* rop);
bool wouldRasterAlterStatus(ROPSTRUCT* rop);

#endif
