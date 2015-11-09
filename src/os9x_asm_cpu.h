#ifndef __os9x_asm_cpu__
#define __os9x_asm_cpu__

#include "snes9x.h"

START_EXTERN_C

void test_opcode(SCPUState* cpuptr);

void asmMainLoop_spcC(SCPUState* cpuptr);
void asmMainLoop_spcAsm(SCPUState* cpuptr);
void asmMainLoop(SCPUState* cpuptr);

void asm_S9xMainLoop(void);

END_EXTERN_C

#endif
