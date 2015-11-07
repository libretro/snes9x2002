@  notaz's SPC700 Emulator v0.12 - Assembler Output

@ (c) Copyright 2006 notaz, All rights reserved.

@ Modified by bitrider 2010

@ this is a rewrite of spc700.cpp in ARM asm, inspired by other asm CPU cores like
@ Cyclone and DrZ80. It is meant to be used in Snes9x emulator ports for ARM platforms.

@ the code is released under Snes9x license. See spcgen.c or any other source file
@ from Snes9x source tree.


  .extern IAPU
  .extern CPU @ for STOP and SLEEP
  .extern S9xAPUGetByte
  .extern S9xAPUSetByte
  .extern S9xAPUGetByteZ
  .extern S9xAPUSetByteZ

   .extern S9xGetAPUDSP
   .extern S9xSetAPUDSP
   .extern S9xSetAPUControl
   .extern S9xAPUSetByteFFC0
   .extern S9xAPUSetByteFFtoF0
  .global spc700_execute @ int cycles
  .global Spc700JumpTab_13
  .global Spc700JumpTab_14
  .global Spc700JumpTab_15
  .global Spc700JumpTab_21

  opcode  .req r3
  cycles  .req r4
  context .req r5
  opcodes .req r6
  spc_pc  .req r7
  spc_ya  .req r8
  spc_p   .req r9
  spc_x   .req r10
  spc_s   .req r11
  spc_ram .req r12

  .equ iapu_directpage,    0x00
  .equ iapu_ram,           0x44
  .equ iapu_extraram,      0x48
  .equ iapu_allregs_load,  0x30
  .equ iapu_allregs_save,  0x34

  .equ flag_c,             0x01
  .equ flag_z,             0x02
  .equ flag_i,             0x04
  .equ flag_h,             0x08
  .equ flag_b,             0x10
  .equ flag_d,             0x20
  .equ flag_o,             0x40
  .equ flag_n,             0x80

  .equ cpu_apu_executing,		124 

@ --------------------------- Framework --------------------------
	.align 	4
   .text
spc700_execute: @ int cycles
  stmfd sp!,{r4-r11,lr}
  ldr   context,=IAPU               @ Pointer to SIAPU struct
  mov   cycles,r0                   @ Cycles
  add   r0,context,#iapu_allregs_load
  ldmia r0,{opcodes,spc_pc,spc_ya,spc_p,spc_x,spc_ram}
  ldrb  opcode,[spc_pc],#1          @ Fetch first opcode
  mov   spc_s,spc_x,lsr #8
  and   spc_x,spc_x,#0xff

  ldr   pc,[opcodes,opcode,lsl #2]  @ Jump to opcode handler


@ We come back here after execution
spc700End:
  orr   spc_x,spc_x,spc_s,lsl #8
  add   r0,context,#iapu_allregs_save
  stmia r0,{spc_pc,spc_ya,spc_p,spc_x}
  mov   r0,cycles
  ldmfd sp!,{r4-r11,pc}

  .ltorg

GetAPUDSP:		
	ldrb	r1, [spc_ram, #0xf2]		
	mov	r0, #0
	and	r2, r1, #0X0f	
	cmp	r2, #0x08
	bxeq	lr
	cmp	r2, #0x09
	ldrne	r2, .APU_DSP
	and	r1, r1, #0X7f	
	ldrneb	r0, [r2, r1]		
	bxne	lr		
	ldr	r2, .SOUNDDATA_CHANNELS
	mov	r1, r1, lsr #4		
	ldr	r0, [r2, r1, asl #8]	
	add	r1, r2, r1, asl #8
	cmp	r0, #0		
	ldrneh	r1, [r1, #0x48]		
	bxeq	lr		
	and	r0, r1, #0xff
	orr	r0, r0, r1, lsr #8
	bx	lr		
.APU_DSP:
	.long	APU + 0x0b
.SOUNDDATA_CHANNELS:
	.long	SoundData + 0x30
	.align 	4


Apu00_13:
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu01_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1e]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu02_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu03_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu04_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu05_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu06_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu07_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu08_13:
  ldrb  r0,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu09_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
   orr  r0, r0, r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0A_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0B_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0C_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0D_13:
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orreq r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,r0,lsl #24
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0E_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  orr   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0F_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orrne r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  orr   spc_p,spc_p,#flag_b
  bic   spc_p,spc_p,#flag_i
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x20]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu10_13:
  tst   spc_p,#0x80000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu11_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1c]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu12_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu13_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu14_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu15_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu16_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu17_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu18_13:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  orr   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu19_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0, r3, r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1A_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  sub   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1B_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
  mov r3, r0
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1C_13:
  tst   spc_ya,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   r0,spc_ya,#0x7f
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1D_13:
  sub   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1E_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1F_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
  sub   sp,sp,#8
  str   r0,[sp,#4]
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  str   r0,[sp]
  ldr   r0,[sp,#4]
  add   r0,r0,#1
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  ldr   r1,[sp],#8
  orr   r0,r1,r0,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu20_13:
  bic   spc_p,spc_p,#flag_d
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  str   spc_ram,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu21_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1a]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu22_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu23_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu24_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu25_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu26_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu27_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu28_13:
  ldrb  r0,[spc_pc],#1
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu29_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2A_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orreq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2B_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2C_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2D_13:
  add   r1,spc_ram,spc_s
  strb  spc_ya,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2E_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2F_13:
  ldrsb r0,[spc_pc],#1
  add   spc_pc,spc_pc,r0
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu30_13:
  tst   spc_p,#0x80000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu31_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x18]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu32_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu33_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu34_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu35_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu36_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu37_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu38_13:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  and   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu39_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3A_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3B_13:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3C_13:
  and   r0,spc_ya,#0xff
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3D_13:
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3E_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3F_13:
  ldrb  r2,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r2,r2,r14,lsl #8
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu40_13:
  orr   spc_p,spc_p,#flag_d
  add   r0,spc_ram,#0x100
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu41_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x16]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu42_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu43_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu44_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu45_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu46_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu47_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu48_13:
  ldrb  r0,[spc_pc],#1
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu49_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4A_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4B_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4C_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4D_13:
  add   r1,spc_ram,spc_s
  strb  spc_x,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4E_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  bic   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4F_13:
  ldrb  r2,[spc_pc],#1
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  add   spc_pc,spc_pc,#0xff00
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu50_13:
  tst   spc_p,#0x00000040
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu51_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x14]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu52_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu53_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu54_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu55_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu56_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu57_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu58_13:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu59_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5A_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5B_13:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5C_13:
  and   r0,spc_ya,#0xff
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5D_13:
  and   spc_x,spc_ya,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5E_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5F_13:
  ldrb  r0, [spc_pc], #1
  ldrb  r14, [spc_pc], #1
  add   spc_pc, r0, spc_ram
  add   spc_pc, spc_pc, r14, lsl #8
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu60_13:
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu61_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x12]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu62_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu63_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu64_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu65_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu66_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu67_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu68_13:
  ldrb  r0,[spc_pc],#1
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu69_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6A_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  bicne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6B_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6C_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6D_13:
  mov   r0,spc_ya,lsr #8
  add   r1,spc_ram,spc_s
  strb  r0,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6E_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  sub   r0,r0,#1
  tst   r0,r0
  addeq spc_pc,spc_pc,#1
  ldrnesb r2,[spc_pc],#1
  addne spc_pc,spc_pc,r2
  subne cycles,cycles,#26
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6F_13:
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu70_13:
  tst   spc_p,#0x00000040
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu71_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x10]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu72_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu73_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu74_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu75_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu76_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu77_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu78_13:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu79_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7A_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,spc_ya,r1
  movs  r2,r0,lsr #16
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  bic   r2,r0,#0x00ff0000
  eor   r3,r1,r2
  eor   r14,spc_ya,r1
  mvn   r14,r14
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7B_13:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7C_13:
  and   r0,spc_ya,#0xff
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7D_13:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_x
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7E_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7F_13:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  str   r0,[context,#iapu_directpage]
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu80_13:
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu81_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xe]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu82_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu83_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu84_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu85_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu86_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu87_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu88_13:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu89_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8A_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  eorne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8B_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8C_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8D_13:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8E_13:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8F_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu90_13:
  tst   spc_p,#0x00000001
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu91_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xc]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu92_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu93_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu94_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu95_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu96_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu97_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu98_13:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r2,r0,r1
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r1
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r1
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu99_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9A_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  mov   r2,r0,lsl #16
  mov   r2,r2,lsr #16
  eor   r3,spc_ya,r2
  eor   r14,spc_ya,r1
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r1
  tst   r14,#0x10
  bicne spc_p,spc_p,#flag_h
  orreq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9B_13:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9C_13:
  and   r0,spc_ya,#0xff
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9D_13:
  mov   spc_x,spc_s
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9E_13:
  tst   spc_x,spc_x @ div by 0?
  orreq spc_ya,spc_ya,#0xff00
  orreq spc_ya,spc_ya,#0x00ff
  orreq spc_p,spc_p,#flag_o
  beq   1002f
  bic   spc_p,spc_p,#flag_o
@ Divide spc_ya by spc_x
  mov r3,#0
  mov r1,spc_x

@ Shift up divisor till it's just less than numerator
cmp   spc_ya,r1,lsl #8
movge r1,r1,lsl #8
cmp   spc_ya,r1,lsl #4
movge r1,r1,lsl #4
cmp   spc_ya,r1,lsl #2
movge r1,r1,lsl #2
cmp   spc_ya,r1,lsl #1
movge r1,r1,lsl #1
1001:
  cmp spc_ya,r1
  adc r3,r3,r3 ;@ Double r3 and add 1 if carry set
  subcs spc_ya,spc_ya,r1
  teq r1,spc_x
  movne r1,r1,lsr #1
  bne 1001b

  and   spc_ya,spc_ya,#0xff
  and   r3,r3,#0xff
  orr   spc_ya,r3,spc_ya,lsl #8
1002:
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#156
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9F_13:
  and   r0,spc_ya,#0xff
  mov   r1,r0,lsl #28
  orr   r0,r1,r0,lsl #20
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsr #24
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA0_13:
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA1_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xa]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA2_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA3_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA4_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA5_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA6_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA7_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA8_13:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA9_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAA_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAB_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAC_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAD_13:
  ldrb  r0,[spc_pc],#1
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAE_13:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff00
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAF_13:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  add   spc_x,spc_x,#1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB0_13:
  tst   spc_p,#0x00000001
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB1_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x8]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB2_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB3_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB4_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB5_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB6_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB7_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB8_13:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r1
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB9_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBA_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1, [spc_pc],#1
  mov   spc_ya, r0
  add   r0, r1, #1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBB_13:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBC_13:
  and   r0,spc_ya,#0xff
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBD_13:
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  mov   spc_s,spc_x
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBE_13:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  subhi r0,r0,#6
  tstls spc_p,#flag_h
  subeq r0,r0,#6
  cmp   r0,#0x9f
  bhi   2001f
  tst   spc_p,#flag_c
  beq   2001f
  orr   spc_p,spc_p,#flag_c
  b     2002f
2001:
  sub   r0,r0,#0x60
  bic   spc_p,spc_p,#flag_c
2002:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBF_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC0_13:
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC1_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x6]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC2_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC3_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC4_13:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC5_13:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC6_13:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC7_13:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r1,r1,spc_x
  and   r1,r1,#0xff
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  orr   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#91
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC8_13:
  ldrb  r0,[spc_pc],#1
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC9_13:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_x
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCA_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  tst   spc_p,#flag_c
  orrne r0,r0,r2
  biceq r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCB_13:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCC_13:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya,lsr #8
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCD_13:
  ldrb  spc_x,[spc_pc],#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCE_13:
  add   spc_x,spc_ram,spc_s
  ldrb  spc_x,[spc_x,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCF_13:
  mov   r0,spc_ya,lsr #8
  and   spc_ya,spc_ya,#0xff
  mul   spc_ya,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#117
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD0_13:
  tst   spc_p,#0xFF000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD1_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x4]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD2_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD3_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD4_13:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD5_13:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_x
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD6_13:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_ya, lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD7_13:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  add   r1,r1,spc_ya,lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#91
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD8_13:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD9_13:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
  add   r1,r1,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDA_13:
  ldrb  r1,[spc_pc]
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDB_13:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDC_13:
  mov   r0,spc_ya,lsr #8
  sub   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDD_13:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_ya,lsr #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDE_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#26
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDF_13:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  addhi r0,r0,#6
  bls   3001f
  cmphi r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
  b     3002f
3001:
  tst   spc_p,#flag_h
  addne r0,r0,#6
  beq   3002f
  cmp   r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
3002:
  tst   spc_p,#flag_c
  addne r0,r0,#0x60
  bne   3003f
  cmp   r0,#0x9f
  addhi r0,r0,#0x60
  orrhi spc_p,spc_p,#flag_c
  bicls spc_p,spc_p,#flag_c
3003:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE0_13:
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#(flag_o|flag_h)
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE1_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x2]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE2_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE3_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#26
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE4_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE5_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE6_13:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE7_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE8_13:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE9_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEA_13:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  eor   r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEB_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEC_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuED_13:
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  eor   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEE_13:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEF_13:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF0_13:
  tst   spc_p,#0xFF000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF1_13:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x0]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#104
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF2_13:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF3_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#26
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF4_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF5_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF6_13:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF7_13:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#78
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF8_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF9_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFA_13:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#65
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFB_13:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFC_13:
  mov   r0,spc_ya,lsr #8
  add   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFD_13:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,spc_ya,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#26
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFE_13:
  sub   spc_ya,spc_ya,#0x100
  mov   spc_ya,spc_ya,lsl #16
  mov   spc_ya,spc_ya,lsr #16
  movs  r0,spc_ya,lsr #8
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#26
  subs   cycles,cycles,#52
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFF_13:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#39
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


@ -------------------------- Jump Table 13 --------------------------
Spc700JumpTab_13:
  .long Apu00_13, Apu01_13, Apu02_13, Apu03_13, Apu04_13, Apu05_13, Apu06_13, Apu07_13 @ 00
  .long Apu08_13, Apu09_13, Apu0A_13, Apu0B_13, Apu0C_13, Apu0D_13, Apu0E_13, Apu0F_13 @ 08
  .long Apu10_13, Apu11_13, Apu12_13, Apu13_13, Apu14_13, Apu15_13, Apu16_13, Apu17_13 @ 10
  .long Apu18_13, Apu19_13, Apu1A_13, Apu1B_13, Apu1C_13, Apu1D_13, Apu1E_13, Apu1F_13 @ 18
  .long Apu20_13, Apu21_13, Apu22_13, Apu23_13, Apu24_13, Apu25_13, Apu26_13, Apu27_13 @ 20
  .long Apu28_13, Apu29_13, Apu2A_13, Apu2B_13, Apu2C_13, Apu2D_13, Apu2E_13, Apu2F_13 @ 28
  .long Apu30_13, Apu31_13, Apu32_13, Apu33_13, Apu34_13, Apu35_13, Apu36_13, Apu37_13 @ 30
  .long Apu38_13, Apu39_13, Apu3A_13, Apu3B_13, Apu3C_13, Apu3D_13, Apu3E_13, Apu3F_13 @ 38
  .long Apu40_13, Apu41_13, Apu42_13, Apu43_13, Apu44_13, Apu45_13, Apu46_13, Apu47_13 @ 40
  .long Apu48_13, Apu49_13, Apu4A_13, Apu4B_13, Apu4C_13, Apu4D_13, Apu4E_13, Apu4F_13 @ 48
  .long Apu50_13, Apu51_13, Apu52_13, Apu53_13, Apu54_13, Apu55_13, Apu56_13, Apu57_13 @ 50
  .long Apu58_13, Apu59_13, Apu5A_13, Apu5B_13, Apu5C_13, Apu5D_13, Apu5E_13, Apu5F_13 @ 58
  .long Apu60_13, Apu61_13, Apu62_13, Apu63_13, Apu64_13, Apu65_13, Apu66_13, Apu67_13 @ 60
  .long Apu68_13, Apu69_13, Apu6A_13, Apu6B_13, Apu6C_13, Apu6D_13, Apu6E_13, Apu6F_13 @ 68
  .long Apu70_13, Apu71_13, Apu72_13, Apu73_13, Apu74_13, Apu75_13, Apu76_13, Apu77_13 @ 70
  .long Apu78_13, Apu79_13, Apu7A_13, Apu7B_13, Apu7C_13, Apu7D_13, Apu7E_13, Apu7F_13 @ 78
  .long Apu80_13, Apu81_13, Apu82_13, Apu83_13, Apu84_13, Apu85_13, Apu86_13, Apu87_13 @ 80
  .long Apu88_13, Apu89_13, Apu8A_13, Apu8B_13, Apu8C_13, Apu8D_13, Apu8E_13, Apu8F_13 @ 88
  .long Apu90_13, Apu91_13, Apu92_13, Apu93_13, Apu94_13, Apu95_13, Apu96_13, Apu97_13 @ 90
  .long Apu98_13, Apu99_13, Apu9A_13, Apu9B_13, Apu9C_13, Apu9D_13, Apu9E_13, Apu9F_13 @ 98
  .long ApuA0_13, ApuA1_13, ApuA2_13, ApuA3_13, ApuA4_13, ApuA5_13, ApuA6_13, ApuA7_13 @ a0
  .long ApuA8_13, ApuA9_13, ApuAA_13, ApuAB_13, ApuAC_13, ApuAD_13, ApuAE_13, ApuAF_13 @ a8
  .long ApuB0_13, ApuB1_13, ApuB2_13, ApuB3_13, ApuB4_13, ApuB5_13, ApuB6_13, ApuB7_13 @ b0
  .long ApuB8_13, ApuB9_13, ApuBA_13, ApuBB_13, ApuBC_13, ApuBD_13, ApuBE_13, ApuBF_13 @ b8
  .long ApuC0_13, ApuC1_13, ApuC2_13, ApuC3_13, ApuC4_13, ApuC5_13, ApuC6_13, ApuC7_13 @ c0
  .long ApuC8_13, ApuC9_13, ApuCA_13, ApuCB_13, ApuCC_13, ApuCD_13, ApuCE_13, ApuCF_13 @ c8
  .long ApuD0_13, ApuD1_13, ApuD2_13, ApuD3_13, ApuD4_13, ApuD5_13, ApuD6_13, ApuD7_13 @ d0
  .long ApuD8_13, ApuD9_13, ApuDA_13, ApuDB_13, ApuDC_13, ApuDD_13, ApuDE_13, ApuDF_13 @ d8
  .long ApuE0_13, ApuE1_13, ApuE2_13, ApuE3_13, ApuE4_13, ApuE5_13, ApuE6_13, ApuE7_13 @ e0
  .long ApuE8_13, ApuE9_13, ApuEA_13, ApuEB_13, ApuEC_13, ApuED_13, ApuEE_13, ApuEF_13 @ e8
  .long ApuF0_13, ApuF1_13, ApuF2_13, ApuF3_13, ApuF4_13, ApuF5_13, ApuF6_13, ApuF7_13 @ f0
  .long ApuF8_13, ApuF9_13, ApuFA_13, ApuFB_13, ApuFC_13, ApuFD_13, ApuFE_13, ApuFF_13 @ f8


Apu00_14:
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu01_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1e]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu02_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu03_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu04_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu05_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu06_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu07_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu08_14:
  ldrb  r0,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu09_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
   orr  r0, r0, r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0A_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0B_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0C_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0D_14:
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orreq r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,r0,lsl #24
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0E_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  orr   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0F_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orrne r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  orr   spc_p,spc_p,#flag_b
  bic   spc_p,spc_p,#flag_i
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x20]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu10_14:
  tst   spc_p,#0x80000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu11_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1c]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu12_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu13_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu14_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu15_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu16_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu17_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu18_14:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  orr   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu19_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0, r3, r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1A_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  sub   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1B_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
  mov r3, r0
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1C_14:
  tst   spc_ya,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   r0,spc_ya,#0x7f
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1D_14:
  sub   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1E_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1F_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
  sub   sp,sp,#8
  str   r0,[sp,#4]
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  str   r0,[sp]
  ldr   r0,[sp,#4]
  add   r0,r0,#1
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  ldr   r1,[sp],#8
  orr   r0,r1,r0,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu20_14:
  bic   spc_p,spc_p,#flag_d
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  str   spc_ram,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu21_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1a]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu22_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu23_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu24_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu25_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu26_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu27_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu28_14:
  ldrb  r0,[spc_pc],#1
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu29_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2A_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orreq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2B_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2C_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2D_14:
  add   r1,spc_ram,spc_s
  strb  spc_ya,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2E_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2F_14:
  ldrsb r0,[spc_pc],#1
  add   spc_pc,spc_pc,r0
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu30_14:
  tst   spc_p,#0x80000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu31_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x18]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu32_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu33_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu34_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu35_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu36_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu37_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu38_14:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  and   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu39_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3A_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3B_14:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3C_14:
  and   r0,spc_ya,#0xff
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3D_14:
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3E_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3F_14:
  ldrb  r2,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r2,r2,r14,lsl #8
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu40_14:
  orr   spc_p,spc_p,#flag_d
  add   r0,spc_ram,#0x100
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu41_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x16]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu42_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu43_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu44_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu45_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu46_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu47_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu48_14:
  ldrb  r0,[spc_pc],#1
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu49_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4A_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4B_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4C_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4D_14:
  add   r1,spc_ram,spc_s
  strb  spc_x,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4E_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  bic   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4F_14:
  ldrb  r2,[spc_pc],#1
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  add   spc_pc,spc_pc,#0xff00
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu50_14:
  tst   spc_p,#0x00000040
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu51_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x14]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu52_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu53_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu54_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu55_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu56_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu57_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu58_14:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu59_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5A_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5B_14:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5C_14:
  and   r0,spc_ya,#0xff
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5D_14:
  and   spc_x,spc_ya,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5E_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5F_14:
  ldrb  r0, [spc_pc], #1
  ldrb  r14, [spc_pc], #1
  add   spc_pc, r0, spc_ram
  add   spc_pc, spc_pc, r14, lsl #8
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu60_14:
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu61_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x12]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu62_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu63_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu64_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu65_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu66_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu67_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu68_14:
  ldrb  r0,[spc_pc],#1
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu69_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6A_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  bicne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6B_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6C_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6D_14:
  mov   r0,spc_ya,lsr #8
  add   r1,spc_ram,spc_s
  strb  r0,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6E_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  sub   r0,r0,#1
  tst   r0,r0
  addeq spc_pc,spc_pc,#1
  ldrnesb r2,[spc_pc],#1
  addne spc_pc,spc_pc,r2
  subne cycles,cycles,#28
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6F_14:
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu70_14:
  tst   spc_p,#0x00000040
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu71_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x10]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu72_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu73_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu74_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu75_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu76_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu77_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu78_14:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu79_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7A_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,spc_ya,r1
  movs  r2,r0,lsr #16
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  bic   r2,r0,#0x00ff0000
  eor   r3,r1,r2
  eor   r14,spc_ya,r1
  mvn   r14,r14
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7B_14:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7C_14:
  and   r0,spc_ya,#0xff
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7D_14:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_x
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7E_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7F_14:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  str   r0,[context,#iapu_directpage]
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu80_14:
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu81_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xe]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu82_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu83_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu84_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu85_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu86_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu87_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu88_14:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu89_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8A_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  eorne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8B_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8C_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8D_14:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8E_14:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8F_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu90_14:
  tst   spc_p,#0x00000001
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu91_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xc]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu92_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu93_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu94_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu95_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu96_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu97_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu98_14:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r2,r0,r1
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r1
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r1
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu99_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9A_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  mov   r2,r0,lsl #16
  mov   r2,r2,lsr #16
  eor   r3,spc_ya,r2
  eor   r14,spc_ya,r1
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r1
  tst   r14,#0x10
  bicne spc_p,spc_p,#flag_h
  orreq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9B_14:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9C_14:
  and   r0,spc_ya,#0xff
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9D_14:
  mov   spc_x,spc_s
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9E_14:
  tst   spc_x,spc_x @ div by 0?
  orreq spc_ya,spc_ya,#0xff00
  orreq spc_ya,spc_ya,#0x00ff
  orreq spc_p,spc_p,#flag_o
  beq   1002f
  bic   spc_p,spc_p,#flag_o
@ Divide spc_ya by spc_x
  mov r3,#0
  mov r1,spc_x

@ Shift up divisor till it's just less than numerator
cmp   spc_ya,r1,lsl #8
movge r1,r1,lsl #8
cmp   spc_ya,r1,lsl #4
movge r1,r1,lsl #4
cmp   spc_ya,r1,lsl #2
movge r1,r1,lsl #2
cmp   spc_ya,r1,lsl #1
movge r1,r1,lsl #1
1001:
  cmp spc_ya,r1
  adc r3,r3,r3 ;@ Double r3 and add 1 if carry set
  subcs spc_ya,spc_ya,r1
  teq r1,spc_x
  movne r1,r1,lsr #1
  bne 1001b

  and   spc_ya,spc_ya,#0xff
  and   r3,r3,#0xff
  orr   spc_ya,r3,spc_ya,lsl #8
1002:
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9F_14:
  and   r0,spc_ya,#0xff
  mov   r1,r0,lsl #28
  orr   r0,r1,r0,lsl #20
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsr #24
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA0_14:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA1_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xa]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA2_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA3_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA4_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA5_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA6_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA7_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA8_14:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA9_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAA_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAB_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAC_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAD_14:
  ldrb  r0,[spc_pc],#1
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAE_14:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff00
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAF_14:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  add   spc_x,spc_x,#1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB0_14:
  tst   spc_p,#0x00000001
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB1_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x8]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB2_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB3_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB4_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB5_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB6_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB7_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB8_14:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r1
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB9_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBA_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1, [spc_pc],#1
  mov   spc_ya, r0
  add   r0, r1, #1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBB_14:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBC_14:
  and   r0,spc_ya,#0xff
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBD_14:
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  mov   spc_s,spc_x
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBE_14:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  subhi r0,r0,#6
  tstls spc_p,#flag_h
  subeq r0,r0,#6
  cmp   r0,#0x9f
  bhi   2001f
  tst   spc_p,#flag_c
  beq   2001f
  orr   spc_p,spc_p,#flag_c
  b     2002f
2001:
  sub   r0,r0,#0x60
  bic   spc_p,spc_p,#flag_c
2002:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBF_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC0_14:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC1_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x6]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC2_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC3_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC4_14:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC5_14:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC6_14:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC7_14:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r1,r1,spc_x
  and   r1,r1,#0xff
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  orr   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#98
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC8_14:
  ldrb  r0,[spc_pc],#1
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC9_14:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_x
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCA_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  tst   spc_p,#flag_c
  orrne r0,r0,r2
  biceq r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCB_14:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCC_14:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya,lsr #8
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCD_14:
  ldrb  spc_x,[spc_pc],#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCE_14:
  add   spc_x,spc_ram,spc_s
  ldrb  spc_x,[spc_x,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCF_14:
  mov   r0,spc_ya,lsr #8
  and   spc_ya,spc_ya,#0xff
  mul   spc_ya,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD0_14:
  tst   spc_p,#0xFF000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD1_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x4]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD2_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD3_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD4_14:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD5_14:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_x
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD6_14:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_ya, lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD7_14:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  add   r1,r1,spc_ya,lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#98
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD8_14:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD9_14:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
  add   r1,r1,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDA_14:
  ldrb  r1,[spc_pc]
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDB_14:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDC_14:
  mov   r0,spc_ya,lsr #8
  sub   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDD_14:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_ya,lsr #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDE_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#28
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDF_14:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  addhi r0,r0,#6
  bls   3001f
  cmphi r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
  b     3002f
3001:
  tst   spc_p,#flag_h
  addne r0,r0,#6
  beq   3002f
  cmp   r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
3002:
  tst   spc_p,#flag_c
  addne r0,r0,#0x60
  bne   3003f
  cmp   r0,#0x9f
  addhi r0,r0,#0x60
  orrhi spc_p,spc_p,#flag_c
  bicls spc_p,spc_p,#flag_c
3003:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE0_14:
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#(flag_o|flag_h)
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE1_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x2]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE2_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE3_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#28
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE4_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE5_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE6_14:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE7_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE8_14:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE9_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEA_14:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  eor   r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEB_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEC_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuED_14:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  eor   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEE_14:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEF_14:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF0_14:
  tst   spc_p,#0xFF000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF1_14:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x0]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#112
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF2_14:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF3_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#28
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF4_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF5_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF6_14:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF7_14:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF8_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF9_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFA_14:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#70
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFB_14:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFC_14:
  mov   r0,spc_ya,lsr #8
  add   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFD_14:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,spc_ya,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#28
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFE_14:
  sub   spc_ya,spc_ya,#0x100
  mov   spc_ya,spc_ya,lsl #16
  mov   spc_ya,spc_ya,lsr #16
  movs  r0,spc_ya,lsr #8
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#28
  subs   cycles,cycles,#56
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFF_14:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


@ -------------------------- Jump Table 14 --------------------------
Spc700JumpTab_14:
  .long Apu00_14, Apu01_14, Apu02_14, Apu03_14, Apu04_14, Apu05_14, Apu06_14, Apu07_14 @ 00
  .long Apu08_14, Apu09_14, Apu0A_14, Apu0B_14, Apu0C_14, Apu0D_14, Apu0E_14, Apu0F_14 @ 08
  .long Apu10_14, Apu11_14, Apu12_14, Apu13_14, Apu14_14, Apu15_14, Apu16_14, Apu17_14 @ 10
  .long Apu18_14, Apu19_14, Apu1A_14, Apu1B_14, Apu1C_14, Apu1D_14, Apu1E_14, Apu1F_14 @ 18
  .long Apu20_14, Apu21_14, Apu22_14, Apu23_14, Apu24_14, Apu25_14, Apu26_14, Apu27_14 @ 20
  .long Apu28_14, Apu29_14, Apu2A_14, Apu2B_14, Apu2C_14, Apu2D_14, Apu2E_14, Apu2F_14 @ 28
  .long Apu30_14, Apu31_14, Apu32_14, Apu33_14, Apu34_14, Apu35_14, Apu36_14, Apu37_14 @ 30
  .long Apu38_14, Apu39_14, Apu3A_14, Apu3B_14, Apu3C_14, Apu3D_14, Apu3E_14, Apu3F_14 @ 38
  .long Apu40_14, Apu41_14, Apu42_14, Apu43_14, Apu44_14, Apu45_14, Apu46_14, Apu47_14 @ 40
  .long Apu48_14, Apu49_14, Apu4A_14, Apu4B_14, Apu4C_14, Apu4D_14, Apu4E_14, Apu4F_14 @ 48
  .long Apu50_14, Apu51_14, Apu52_14, Apu53_14, Apu54_14, Apu55_14, Apu56_14, Apu57_14 @ 50
  .long Apu58_14, Apu59_14, Apu5A_14, Apu5B_14, Apu5C_14, Apu5D_14, Apu5E_14, Apu5F_14 @ 58
  .long Apu60_14, Apu61_14, Apu62_14, Apu63_14, Apu64_14, Apu65_14, Apu66_14, Apu67_14 @ 60
  .long Apu68_14, Apu69_14, Apu6A_14, Apu6B_14, Apu6C_14, Apu6D_14, Apu6E_14, Apu6F_14 @ 68
  .long Apu70_14, Apu71_14, Apu72_14, Apu73_14, Apu74_14, Apu75_14, Apu76_14, Apu77_14 @ 70
  .long Apu78_14, Apu79_14, Apu7A_14, Apu7B_14, Apu7C_14, Apu7D_14, Apu7E_14, Apu7F_14 @ 78
  .long Apu80_14, Apu81_14, Apu82_14, Apu83_14, Apu84_14, Apu85_14, Apu86_14, Apu87_14 @ 80
  .long Apu88_14, Apu89_14, Apu8A_14, Apu8B_14, Apu8C_14, Apu8D_14, Apu8E_14, Apu8F_14 @ 88
  .long Apu90_14, Apu91_14, Apu92_14, Apu93_14, Apu94_14, Apu95_14, Apu96_14, Apu97_14 @ 90
  .long Apu98_14, Apu99_14, Apu9A_14, Apu9B_14, Apu9C_14, Apu9D_14, Apu9E_14, Apu9F_14 @ 98
  .long ApuA0_14, ApuA1_14, ApuA2_14, ApuA3_14, ApuA4_14, ApuA5_14, ApuA6_14, ApuA7_14 @ a0
  .long ApuA8_14, ApuA9_14, ApuAA_14, ApuAB_14, ApuAC_14, ApuAD_14, ApuAE_14, ApuAF_14 @ a8
  .long ApuB0_14, ApuB1_14, ApuB2_14, ApuB3_14, ApuB4_14, ApuB5_14, ApuB6_14, ApuB7_14 @ b0
  .long ApuB8_14, ApuB9_14, ApuBA_14, ApuBB_14, ApuBC_14, ApuBD_14, ApuBE_14, ApuBF_14 @ b8
  .long ApuC0_14, ApuC1_14, ApuC2_14, ApuC3_14, ApuC4_14, ApuC5_14, ApuC6_14, ApuC7_14 @ c0
  .long ApuC8_14, ApuC9_14, ApuCA_14, ApuCB_14, ApuCC_14, ApuCD_14, ApuCE_14, ApuCF_14 @ c8
  .long ApuD0_14, ApuD1_14, ApuD2_14, ApuD3_14, ApuD4_14, ApuD5_14, ApuD6_14, ApuD7_14 @ d0
  .long ApuD8_14, ApuD9_14, ApuDA_14, ApuDB_14, ApuDC_14, ApuDD_14, ApuDE_14, ApuDF_14 @ d8
  .long ApuE0_14, ApuE1_14, ApuE2_14, ApuE3_14, ApuE4_14, ApuE5_14, ApuE6_14, ApuE7_14 @ e0
  .long ApuE8_14, ApuE9_14, ApuEA_14, ApuEB_14, ApuEC_14, ApuED_14, ApuEE_14, ApuEF_14 @ e8
  .long ApuF0_14, ApuF1_14, ApuF2_14, ApuF3_14, ApuF4_14, ApuF5_14, ApuF6_14, ApuF7_14 @ f0
  .long ApuF8_14, ApuF9_14, ApuFA_14, ApuFB_14, ApuFC_14, ApuFD_14, ApuFE_14, ApuFF_14 @ f8


Apu00_15:
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu01_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1e]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu02_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu03_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu04_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu05_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu06_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu07_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu08_15:
  ldrb  r0,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu09_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
   orr  r0, r0, r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0A_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0B_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0C_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0D_15:
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orreq r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,r0,lsl #24
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0E_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  orr   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0F_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orrne r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  orr   spc_p,spc_p,#flag_b
  bic   spc_p,spc_p,#flag_i
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x20]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu10_15:
  tst   spc_p,#0x80000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu11_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1c]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu12_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu13_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu14_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu15_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu16_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu17_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu18_15:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  orr   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu19_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0, r3, r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1A_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  sub   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1B_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
  mov r3, r0
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1C_15:
  tst   spc_ya,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   r0,spc_ya,#0x7f
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1D_15:
  sub   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1E_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1F_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
  sub   sp,sp,#8
  str   r0,[sp,#4]
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  str   r0,[sp]
  ldr   r0,[sp,#4]
  add   r0,r0,#1
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  ldr   r1,[sp],#8
  orr   r0,r1,r0,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu20_15:
  bic   spc_p,spc_p,#flag_d
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  str   spc_ram,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu21_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1a]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu22_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu23_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu24_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu25_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu26_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu27_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu28_15:
  ldrb  r0,[spc_pc],#1
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu29_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2A_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orreq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2B_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2C_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2D_15:
  add   r1,spc_ram,spc_s
  strb  spc_ya,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2E_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2F_15:
  ldrsb r0,[spc_pc],#1
  add   spc_pc,spc_pc,r0
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu30_15:
  tst   spc_p,#0x80000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu31_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x18]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu32_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu33_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu34_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu35_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu36_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu37_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu38_15:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  and   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu39_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3A_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3B_15:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3C_15:
  and   r0,spc_ya,#0xff
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3D_15:
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3E_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3F_15:
  ldrb  r2,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r2,r2,r14,lsl #8
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu40_15:
  orr   spc_p,spc_p,#flag_d
  add   r0,spc_ram,#0x100
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu41_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x16]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu42_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu43_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu44_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu45_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu46_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu47_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu48_15:
  ldrb  r0,[spc_pc],#1
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu49_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4A_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4B_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4C_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4D_15:
  add   r1,spc_ram,spc_s
  strb  spc_x,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4E_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  bic   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4F_15:
  ldrb  r2,[spc_pc],#1
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  add   spc_pc,spc_pc,#0xff00
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu50_15:
  tst   spc_p,#0x00000040
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu51_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x14]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu52_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu53_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu54_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu55_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu56_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu57_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu58_15:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu59_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5A_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5B_15:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5C_15:
  and   r0,spc_ya,#0xff
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5D_15:
  and   spc_x,spc_ya,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5E_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5F_15:
  ldrb  r0, [spc_pc], #1
  ldrb  r14, [spc_pc], #1
  add   spc_pc, r0, spc_ram
  add   spc_pc, spc_pc, r14, lsl #8
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu60_15:
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu61_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x12]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu62_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu63_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu64_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu65_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu66_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu67_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu68_15:
  ldrb  r0,[spc_pc],#1
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu69_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6A_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  bicne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6B_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6C_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6D_15:
  mov   r0,spc_ya,lsr #8
  add   r1,spc_ram,spc_s
  strb  r0,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6E_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  sub   r0,r0,#1
  tst   r0,r0
  addeq spc_pc,spc_pc,#1
  ldrnesb r2,[spc_pc],#1
  addne spc_pc,spc_pc,r2
  subne cycles,cycles,#30
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6F_15:
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu70_15:
  tst   spc_p,#0x00000040
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu71_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x10]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu72_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu73_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu74_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu75_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu76_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu77_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu78_15:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu79_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7A_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,spc_ya,r1
  movs  r2,r0,lsr #16
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  bic   r2,r0,#0x00ff0000
  eor   r3,r1,r2
  eor   r14,spc_ya,r1
  mvn   r14,r14
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7B_15:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7C_15:
  and   r0,spc_ya,#0xff
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7D_15:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_x
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7E_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7F_15:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  str   r0,[context,#iapu_directpage]
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu80_15:
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu81_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xe]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu82_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu83_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu84_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu85_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu86_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu87_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu88_15:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu89_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8A_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  eorne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8B_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8C_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8D_15:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8E_15:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8F_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu90_15:
  tst   spc_p,#0x00000001
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu91_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xc]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu92_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu93_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu94_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu95_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu96_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu97_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu98_15:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r2,r0,r1
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r1
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r1
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu99_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9A_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  mov   r2,r0,lsl #16
  mov   r2,r2,lsr #16
  eor   r3,spc_ya,r2
  eor   r14,spc_ya,r1
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r1
  tst   r14,#0x10
  bicne spc_p,spc_p,#flag_h
  orreq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9B_15:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9C_15:
  and   r0,spc_ya,#0xff
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9D_15:
  mov   spc_x,spc_s
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9E_15:
  tst   spc_x,spc_x @ div by 0?
  orreq spc_ya,spc_ya,#0xff00
  orreq spc_ya,spc_ya,#0x00ff
  orreq spc_p,spc_p,#flag_o
  beq   1002f
  bic   spc_p,spc_p,#flag_o
@ Divide spc_ya by spc_x
  mov r3,#0
  mov r1,spc_x

@ Shift up divisor till it's just less than numerator
cmp   spc_ya,r1,lsl #8
movge r1,r1,lsl #8
cmp   spc_ya,r1,lsl #4
movge r1,r1,lsl #4
cmp   spc_ya,r1,lsl #2
movge r1,r1,lsl #2
cmp   spc_ya,r1,lsl #1
movge r1,r1,lsl #1
1001:
  cmp spc_ya,r1
  adc r3,r3,r3 ;@ Double r3 and add 1 if carry set
  subcs spc_ya,spc_ya,r1
  teq r1,spc_x
  movne r1,r1,lsr #1
  bne 1001b

  and   spc_ya,spc_ya,#0xff
  and   r3,r3,#0xff
  orr   spc_ya,r3,spc_ya,lsl #8
1002:
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#180
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9F_15:
  and   r0,spc_ya,#0xff
  mov   r1,r0,lsl #28
  orr   r0,r1,r0,lsl #20
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsr #24
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA0_15:
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA1_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xa]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA2_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA3_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA4_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA5_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA6_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA7_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA8_15:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA9_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAA_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAB_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAC_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAD_15:
  ldrb  r0,[spc_pc],#1
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAE_15:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff00
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAF_15:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  add   spc_x,spc_x,#1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB0_15:
  tst   spc_p,#0x00000001
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB1_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x8]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB2_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB3_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB4_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB5_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB6_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB7_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB8_15:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r1
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB9_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBA_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1, [spc_pc],#1
  mov   spc_ya, r0
  add   r0, r1, #1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBB_15:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBC_15:
  and   r0,spc_ya,#0xff
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBD_15:
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  mov   spc_s,spc_x
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBE_15:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  subhi r0,r0,#6
  tstls spc_p,#flag_h
  subeq r0,r0,#6
  cmp   r0,#0x9f
  bhi   2001f
  tst   spc_p,#flag_c
  beq   2001f
  orr   spc_p,spc_p,#flag_c
  b     2002f
2001:
  sub   r0,r0,#0x60
  bic   spc_p,spc_p,#flag_c
2002:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBF_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC0_15:
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC1_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x6]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC2_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC3_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC4_15:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC5_15:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC6_15:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC7_15:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r1,r1,spc_x
  and   r1,r1,#0xff
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  orr   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC8_15:
  ldrb  r0,[spc_pc],#1
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC9_15:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_x
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCA_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  tst   spc_p,#flag_c
  orrne r0,r0,r2
  biceq r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCB_15:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCC_15:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya,lsr #8
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCD_15:
  ldrb  spc_x,[spc_pc],#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCE_15:
  add   spc_x,spc_ram,spc_s
  ldrb  spc_x,[spc_x,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCF_15:
  mov   r0,spc_ya,lsr #8
  and   spc_ya,spc_ya,#0xff
  mul   spc_ya,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#135
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD0_15:
  tst   spc_p,#0xFF000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD1_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x4]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD2_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD3_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD4_15:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD5_15:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_x
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD6_15:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_ya, lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD7_15:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  add   r1,r1,spc_ya,lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD8_15:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD9_15:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
  add   r1,r1,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDA_15:
  ldrb  r1,[spc_pc]
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDB_15:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDC_15:
  mov   r0,spc_ya,lsr #8
  sub   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDD_15:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_ya,lsr #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDE_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#30
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDF_15:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  addhi r0,r0,#6
  bls   3001f
  cmphi r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
  b     3002f
3001:
  tst   spc_p,#flag_h
  addne r0,r0,#6
  beq   3002f
  cmp   r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
3002:
  tst   spc_p,#flag_c
  addne r0,r0,#0x60
  bne   3003f
  cmp   r0,#0x9f
  addhi r0,r0,#0x60
  orrhi spc_p,spc_p,#flag_c
  bicls spc_p,spc_p,#flag_c
3003:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE0_15:
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#(flag_o|flag_h)
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE1_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x2]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE2_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE3_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#30
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE4_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE5_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE6_15:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE7_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE8_15:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE9_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEA_15:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  eor   r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEB_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEC_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuED_15:
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  eor   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEE_15:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEF_15:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF0_15:
  tst   spc_p,#0xFF000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF1_15:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x0]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#120
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF2_15:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF3_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#30
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF4_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF5_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF6_15:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF7_15:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#90
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF8_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF9_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFA_15:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#75
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFB_15:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFC_15:
  mov   r0,spc_ya,lsr #8
  add   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFD_15:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,spc_ya,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#30
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFE_15:
  sub   spc_ya,spc_ya,#0x100
  mov   spc_ya,spc_ya,lsl #16
  mov   spc_ya,spc_ya,lsr #16
  movs  r0,spc_ya,lsr #8
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#30
  subs   cycles,cycles,#60
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFF_15:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#45
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


@ -------------------------- Jump Table 15 --------------------------
Spc700JumpTab_15:
  .long Apu00_15, Apu01_15, Apu02_15, Apu03_15, Apu04_15, Apu05_15, Apu06_15, Apu07_15 @ 00
  .long Apu08_15, Apu09_15, Apu0A_15, Apu0B_15, Apu0C_15, Apu0D_15, Apu0E_15, Apu0F_15 @ 08
  .long Apu10_15, Apu11_15, Apu12_15, Apu13_15, Apu14_15, Apu15_15, Apu16_15, Apu17_15 @ 10
  .long Apu18_15, Apu19_15, Apu1A_15, Apu1B_15, Apu1C_15, Apu1D_15, Apu1E_15, Apu1F_15 @ 18
  .long Apu20_15, Apu21_15, Apu22_15, Apu23_15, Apu24_15, Apu25_15, Apu26_15, Apu27_15 @ 20
  .long Apu28_15, Apu29_15, Apu2A_15, Apu2B_15, Apu2C_15, Apu2D_15, Apu2E_15, Apu2F_15 @ 28
  .long Apu30_15, Apu31_15, Apu32_15, Apu33_15, Apu34_15, Apu35_15, Apu36_15, Apu37_15 @ 30
  .long Apu38_15, Apu39_15, Apu3A_15, Apu3B_15, Apu3C_15, Apu3D_15, Apu3E_15, Apu3F_15 @ 38
  .long Apu40_15, Apu41_15, Apu42_15, Apu43_15, Apu44_15, Apu45_15, Apu46_15, Apu47_15 @ 40
  .long Apu48_15, Apu49_15, Apu4A_15, Apu4B_15, Apu4C_15, Apu4D_15, Apu4E_15, Apu4F_15 @ 48
  .long Apu50_15, Apu51_15, Apu52_15, Apu53_15, Apu54_15, Apu55_15, Apu56_15, Apu57_15 @ 50
  .long Apu58_15, Apu59_15, Apu5A_15, Apu5B_15, Apu5C_15, Apu5D_15, Apu5E_15, Apu5F_15 @ 58
  .long Apu60_15, Apu61_15, Apu62_15, Apu63_15, Apu64_15, Apu65_15, Apu66_15, Apu67_15 @ 60
  .long Apu68_15, Apu69_15, Apu6A_15, Apu6B_15, Apu6C_15, Apu6D_15, Apu6E_15, Apu6F_15 @ 68
  .long Apu70_15, Apu71_15, Apu72_15, Apu73_15, Apu74_15, Apu75_15, Apu76_15, Apu77_15 @ 70
  .long Apu78_15, Apu79_15, Apu7A_15, Apu7B_15, Apu7C_15, Apu7D_15, Apu7E_15, Apu7F_15 @ 78
  .long Apu80_15, Apu81_15, Apu82_15, Apu83_15, Apu84_15, Apu85_15, Apu86_15, Apu87_15 @ 80
  .long Apu88_15, Apu89_15, Apu8A_15, Apu8B_15, Apu8C_15, Apu8D_15, Apu8E_15, Apu8F_15 @ 88
  .long Apu90_15, Apu91_15, Apu92_15, Apu93_15, Apu94_15, Apu95_15, Apu96_15, Apu97_15 @ 90
  .long Apu98_15, Apu99_15, Apu9A_15, Apu9B_15, Apu9C_15, Apu9D_15, Apu9E_15, Apu9F_15 @ 98
  .long ApuA0_15, ApuA1_15, ApuA2_15, ApuA3_15, ApuA4_15, ApuA5_15, ApuA6_15, ApuA7_15 @ a0
  .long ApuA8_15, ApuA9_15, ApuAA_15, ApuAB_15, ApuAC_15, ApuAD_15, ApuAE_15, ApuAF_15 @ a8
  .long ApuB0_15, ApuB1_15, ApuB2_15, ApuB3_15, ApuB4_15, ApuB5_15, ApuB6_15, ApuB7_15 @ b0
  .long ApuB8_15, ApuB9_15, ApuBA_15, ApuBB_15, ApuBC_15, ApuBD_15, ApuBE_15, ApuBF_15 @ b8
  .long ApuC0_15, ApuC1_15, ApuC2_15, ApuC3_15, ApuC4_15, ApuC5_15, ApuC6_15, ApuC7_15 @ c0
  .long ApuC8_15, ApuC9_15, ApuCA_15, ApuCB_15, ApuCC_15, ApuCD_15, ApuCE_15, ApuCF_15 @ c8
  .long ApuD0_15, ApuD1_15, ApuD2_15, ApuD3_15, ApuD4_15, ApuD5_15, ApuD6_15, ApuD7_15 @ d0
  .long ApuD8_15, ApuD9_15, ApuDA_15, ApuDB_15, ApuDC_15, ApuDD_15, ApuDE_15, ApuDF_15 @ d8
  .long ApuE0_15, ApuE1_15, ApuE2_15, ApuE3_15, ApuE4_15, ApuE5_15, ApuE6_15, ApuE7_15 @ e0
  .long ApuE8_15, ApuE9_15, ApuEA_15, ApuEB_15, ApuEC_15, ApuED_15, ApuEE_15, ApuEF_15 @ e8
  .long ApuF0_15, ApuF1_15, ApuF2_15, ApuF3_15, ApuF4_15, ApuF5_15, ApuF6_15, ApuF7_15 @ f0
  .long ApuF8_15, ApuF9_15, ApuFA_15, ApuFB_15, ApuFC_15, ApuFD_15, ApuFE_15, ApuFF_15 @ f8


Apu00_21:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu01_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1e]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu02_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu03_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu04_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu05_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu06_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu07_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu08_21:
  ldrb  r0,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu09_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
   orr  r0, r0, r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0A_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0B_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0C_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0D_21:
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orreq r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,r0,lsl #24
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0E_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  orr   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu0F_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  mov   r0,spc_p,lsr #24
  and   r1,r0,#0x80
  tst   r0,r0
  orrne r1,r1,#flag_z
  and   spc_p,spc_p,#0x7d @ clear N & Z
  orr   spc_p,spc_p,r1
  add   r1,spc_ram,spc_s
  strb  spc_p,[r1,#0x100]
  sub   spc_s,spc_s,#1
  orr   spc_p,spc_p,#flag_b
  bic   spc_p,spc_p,#flag_i
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x20]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu10_21:
  tst   spc_p,#0x80000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu11_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1c]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu12_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x01
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu13_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu14_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu15_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu16_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu17_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu18_21:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  orr   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu19_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0, r3, r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1A_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  sub   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1B_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
  mov r3, r0
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1C_21:
  tst   spc_ya,#0x80
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   r0,spc_ya,#0x7f
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsl #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1D_21:
  sub   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1E_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu1F_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
  sub   sp,sp,#8
  str   r0,[sp,#4]
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  str   r0,[sp]
  ldr   r0,[sp,#4]
  add   r0,r0,#1
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  ldr   r1,[sp],#8
  orr   r0,r1,r0,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu20_21:
  bic   spc_p,spc_p,#flag_d
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  str   spc_ram,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu21_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x1a]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu22_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu23_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu24_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu25_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu26_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu27_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu28_21:
  ldrb  r0,[spc_pc],#1
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu29_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2A_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orreq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2B_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2C_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2D_21:
  add   r1,spc_ram,spc_s
  strb  spc_ya,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2E_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu2F_21:
  ldrsb r0,[spc_pc],#1
  add   spc_pc,spc_pc,r0
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu30_21:
  tst   spc_p,#0x80000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu31_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x18]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu32_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x02
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu33_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x02
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu34_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu35_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu36_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu37_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  orr   r0,r0,#0xff00
  and   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu38_21:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  and   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu39_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3A_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,r1,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  stmfd sp!,{r0}
  ldrb  r1,[spc_pc]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldmfd sp!,{r0}
  mov   r0,r0,lsr #8
  ldrb  r1,[spc_pc],#1
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3B_21:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3C_21:
  and   r0,spc_ya,#0xff
  mov   r0,r0,lsl #1
  tst   spc_p,#flag_c
  orrne r0,r0,#1
  tst   r0,#0x100
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3D_21:
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3E_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu3F_21:
  ldrb  r2,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r2,r2,r14,lsl #8
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu40_21:
  orr   spc_p,spc_p,#flag_d
  add   r0,spc_ram,#0x100
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu41_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x16]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu42_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu43_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu44_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu45_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu46_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu47_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu48_21:
  ldrb  r0,[spc_pc],#1
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu49_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4A_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4B_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4C_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4D_21:
  add   r1,spc_ram,spc_s
  strb  spc_x,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4E_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r2,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r2,lsl #24
  bic   r0,r0,spc_ya
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu4F_21:
  ldrb  r2,[spc_pc],#1
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  add   spc_pc,spc_ram,r2
  add   spc_pc,spc_pc,#0xff00
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu50_21:
  tst   spc_p,#0x00000040
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu51_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x14]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu52_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x04
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu53_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x04
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu54_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu55_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu56_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu57_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  eor   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu58_21:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r0,r0,r1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu59_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r0,r0,r3
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5A_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #16
  tst   r0,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5B_21:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5C_21:
  and   r0,spc_ya,#0xff
  tst   r0,#0x01
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  mov   r0,r0,lsr #1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5D_21:
  and   spc_x,spc_ya,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5E_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu5F_21:
  ldrb  r0, [spc_pc], #1
  ldrb  r14, [spc_pc], #1
  add   spc_pc, r0, spc_ram
  add   spc_pc, spc_pc, r14, lsl #8
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu60_21:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu61_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x12]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu62_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu63_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu64_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu65_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu66_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu67_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu68_21:
  ldrb  r0,[spc_pc],#1
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu69_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6A_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  bicne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6B_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6C_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6D_21:
  mov   r0,spc_ya,lsr #8
  add   r1,spc_ram,spc_s
  strb  r0,[r1,#0x100]
  sub   spc_s,spc_s,#1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6E_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
  sub   r0,r0,#1
  tst   r0,r0
  addeq spc_pc,spc_pc,#1
  ldrnesb r2,[spc_pc],#1
  addne spc_pc,spc_pc,r2
  subne cycles,cycles,#42
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu6F_21:
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu70_21:
  tst   spc_p,#0x00000040
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu71_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x10]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu72_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x08
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu73_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x08
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu74_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu75_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu76_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu77_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r14,spc_ya,#0xff
  subs  r14,r14,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu78_21:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  subs  r14,r0,r1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu79_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_x,spc_x,r0,lsl #24
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_x,lsr #24
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7A_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  add   r0,spc_ya,r1
  movs  r2,r0,lsr #16
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  bic   r2,r0,#0x00ff0000
  eor   r3,r1,r2
  eor   r14,spc_ya,r1
  mvn   r14,r14
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7B_21:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7C_21:
  and   r0,spc_ya,#0xff
  tst   spc_p,#flag_c
  orrne r0,r0,#0x100
  movs  r0,r0,lsr #1
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7D_21:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_x
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7E_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu7F_21:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  str   r0,[context,#iapu_directpage]
  add   r1,spc_ram,spc_s
  ldrb  r0,[r1,#(0xff + 2)]
  ldrb  r1,[r1,#(0x100 + 2)]
  add   spc_s,spc_s,#2
  orr   r0,r0,r1,lsl #8
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu80_21:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu81_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xe]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu82_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu83_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu84_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu85_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu86_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu87_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu88_21:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu89_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8A_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  eorne spc_p,spc_p,#flag_c
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8B_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8C_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8D_21:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8E_21:
  add   spc_p,spc_ram,spc_s
  ldrb  spc_p,[spc_p,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   r0,spc_p,#(flag_z|flag_n)
  eor   r0,r0,#flag_z
  orr   spc_p,spc_p,r0,lsl #24
  tst   spc_p,#flag_d
  addne r0,spc_ram,#0x100
  moveq r0,spc_ram
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  str   r0,[context,#iapu_directpage]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu8F_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu90_21:
  tst   spc_p,#0x00000001
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu91_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xc]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu92_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x10
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu93_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x10
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu94_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu95_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu96_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu97_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  eor   r2,spc_ya,r0
  movs  r14, spc_p, lsr #1
  adc   spc_ya, spc_ya, r0
  movs  r14,spc_ya,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r0
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,spc_ya
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu98_21:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  eor   r2,r0,r1
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r1
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r1
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu99_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  eor   r2,r0,r3
  movs  r14, spc_p, lsr #1
  adc   r0, r0, r3
  movs  r14,r0,lsr #8
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  eor   r14,r0,r3
  bic   r14,r14,r2
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r2,r0
  tst   r14,#0x10
  orrne spc_p,spc_p,#flag_h
  biceq spc_p,spc_p,#flag_h
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9A_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   r3, r0
  ldrb  r0,[spc_pc],#1
  add   r0,r0,#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r1,r3,r0,lsl #8
  subs  r0,spc_ya,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  mov   r2,r0,lsl #16
  mov   r2,r2,lsr #16
  eor   r3,spc_ya,r2
  eor   r14,spc_ya,r1
  and   r14,r14,r3
  tst   r14,#0x8000
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r1
  tst   r14,#0x10
  bicne spc_p,spc_p,#flag_h
  orreq spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9B_21:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9C_21:
  and   r0,spc_ya,#0xff
  sub   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9D_21:
  mov   spc_x,spc_s
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9E_21:
  tst   spc_x,spc_x @ div by 0?
  orreq spc_ya,spc_ya,#0xff00
  orreq spc_ya,spc_ya,#0x00ff
  orreq spc_p,spc_p,#flag_o
  beq   1002f
  bic   spc_p,spc_p,#flag_o
@ Divide spc_ya by spc_x
  mov r3,#0
  mov r1,spc_x

@ Shift up divisor till it's just less than numerator
cmp   spc_ya,r1,lsl #8
movge r1,r1,lsl #8
cmp   spc_ya,r1,lsl #4
movge r1,r1,lsl #4
cmp   spc_ya,r1,lsl #2
movge r1,r1,lsl #2
cmp   spc_ya,r1,lsl #1
movge r1,r1,lsl #1
1001:
  cmp spc_ya,r1
  adc r3,r3,r3 ;@ Double r3 and add 1 if carry set
  subcs spc_ya,spc_ya,r1
  teq r1,spc_x
  movne r1,r1,lsr #1
  bne 1001b

  and   spc_ya,spc_ya,#0xff
  and   r3,r3,#0xff
  orr   spc_ya,r3,spc_ya,lsl #8
1002:
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#252
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


Apu9F_21:
  and   r0,spc_ya,#0xff
  mov   r1,r0,lsl #28
  orr   r0,r1,r0,lsl #20
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0,lsr #24
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA0_21:
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  orr   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA1_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0xa]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA2_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA3_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA4_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA5_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA6_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA7_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA8_21:
  ldrb  r0,[spc_pc],#1
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuA9_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAA_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r0,r0,lsr r1
  tst   r0,#1
  orrne spc_p,spc_p,#flag_c
  biceq spc_p,spc_p,#flag_c
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAB_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAC_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
  mov   r3, r0
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1, r3
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAD_21:
  ldrb  r0,[spc_pc],#1
  mov   r1,spc_ya,lsr #8
  subs  r14,r1,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAE_21:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff00
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuAF_21:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  add   spc_x,spc_x,#1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  and   spc_x,spc_x,#0xff
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB0_21:
  tst   spc_p,#0x00000001
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB1_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x8]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB2_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x20
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB3_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x20
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB4_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB5_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB6_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB7_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   r1,spc_ya,#0xff00
  and   spc_ya,spc_ya,#0xff
  movs  r14,spc_p,lsr #1
  sbcs  r2,spc_ya,r0
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,spc_ya,r2
  eor   r3,spc_ya,r0
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   spc_ya,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r1
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB8_21:
  ldrb  r0,[spc_pc,#1]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#2
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r1
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r1
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc,#-1]
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuB9_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov r3, r0
  mov   r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  movs  r14,spc_p,lsr #1
  sbcs  r2,r0,r3
  orrge spc_p,spc_p,#flag_c
  biclt spc_p,spc_p,#flag_c
  eor   r14,r0,r2
  eor   r3,r0,r3
  and   r14,r14,r3
  tst   r14,#0x80
  orrne spc_p,spc_p,#flag_o
  biceq spc_p,spc_p,#flag_o
  eor   r14,r3,r2
  tst   r14,#0x10
  orreq spc_p,spc_p,#flag_h
  bicne spc_p,spc_p,#flag_h
  mov   r0,r2
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBA_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1, [spc_pc],#1
  mov   spc_ya, r0
  add   r0, r1, #1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBB_21:
  ldrb  r0,[spc_pc]
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  ldrb  r1,[spc_pc],#1
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBC_21:
  and   r0,spc_ya,#0xff
  add   r0,r0,#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   r0,r0,#0xff
  mov   spc_ya,spc_ya,lsr #8
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,r0,spc_ya,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBD_21:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  mov   spc_s,spc_x
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBE_21:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  subhi r0,r0,#6
  tstls spc_p,#flag_h
  subeq r0,r0,#6
  cmp   r0,#0x9f
  bhi   2001f
  tst   spc_p,#flag_c
  beq   2001f
  orr   spc_p,spc_p,#flag_c
  b     2002f
2001:
  sub   r0,r0,#0x60
  bic   spc_p,spc_p,#flag_c
2002:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuBF_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  add   spc_x,spc_x,#1
  and   spc_x,spc_x,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC0_21:
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#flag_i
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC1_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x6]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC2_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC3_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC4_21:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC5_21:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC6_21:
  mov   r0,spc_ya
  mov   r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC7_21:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r1,r1,spc_x
  and   r1,r1,#0xff
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  orr   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#147
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC8_21:
  ldrb  r0,[spc_pc],#1
  subs  r14,spc_x,r0
  orrcs spc_p,spc_p,#flag_c
  biccc spc_p,spc_p,#flag_c
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r14,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuC9_21:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_x
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCA_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  tst   spc_p,#flag_c
  orrne r0,r0,r2
  biceq r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCB_21:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCC_21:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya,lsr #8
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCD_21:
  ldrb  spc_x,[spc_pc],#1
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCE_21:
  add   spc_x,spc_ram,spc_s
  ldrb  spc_x,[spc_x,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuCF_21:
  mov   r0,spc_ya,lsr #8
  and   spc_ya,spc_ya,#0xff
  mul   spc_ya,r0,spc_ya
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #16
  tst   spc_ya,#0xff
  orrne spc_p,spc_p,#0x01000000
  subs   cycles,cycles,#189
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD0_21:
  tst   spc_p,#0xFF000000
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD1_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x4]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD2_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x40
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD3_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x40
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD4_21:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD5_21:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_x
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD6_21:
  ldrb  r1,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r1,r1,spc_ya, lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD7_21:
  ldrb  r1,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r1,[r14,r1]!
  ldrb  r14,[r14,#1]
  add   r1,r1,spc_ya,lsr #8
  add   r1,r1,r14,lsl #8
  mov   r0,spc_ya
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#147
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD8_21:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuD9_21:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_x
  add   r1,r1,spc_ya,lsr #8
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDA_21:
  ldrb  r1,[spc_pc]
  mov   r0,spc_ya
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
2:						
	strb	r0, [r2, r1]			
1:						
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDB_21:
  ldrb  r1,[spc_pc],#1
  mov   r0,spc_ya,lsr #8
  add   r1,r1,spc_x
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDC_21:
  mov   r0,spc_ya,lsr #8
  sub   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDD_21:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,spc_ya,lsr #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDE_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   r1,spc_ya,#0xff
  cmp   r0,r1
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#42
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuDF_21:
  and   r0,spc_ya,#0xff
  and   r1,spc_ya,#0x0f
  cmp   r1,#9
  addhi r0,r0,#6
  bls   3001f
  cmphi r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
  b     3002f
3001:
  tst   spc_p,#flag_h
  addne r0,r0,#6
  beq   3002f
  cmp   r0,#0xf0
  orrhi spc_p,spc_p,#flag_c
3002:
  tst   spc_p,#flag_c
  addne r0,r0,#0x60
  bne   3003f
  cmp   r0,#0x9f
  addhi r0,r0,#0x60
  orrhi spc_p,spc_p,#flag_c
  bicls spc_p,spc_p,#flag_c
3003:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE0_21:
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  bic   spc_p,spc_p,#(flag_o|flag_h)
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE1_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x2]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE2_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  orr   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE3_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  subne cycles,cycles,#42
  addne spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE4_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE5_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE6_21:
  mov   r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE7_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  add   r0,r0,spc_x
  and   r0,r0,#0xff
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  orr   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE8_21:
  ldrb  r0,[spc_pc],#1
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuE9_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEA_21:
  ldrb  r0,[spc_pc], #1
  ldrb  r3,[spc_pc], #1
  add   r3,r0,r3,lsl #8
  bic   r0, r3, #0xe000
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  mov   r1, r3, lsr #13
  mov   r2,#1
  mov   r2,r2,lsl r1
  eor   r0,r0,r2
  bic   r1, r3, #0xe000
	add	r2, r1, #40			
	tst	r2, #0x10000			
	bne	1f				
	bic	r2, r1, #0x0f
	cmp	r2, #0xf0
	strneb	r0, [spc_ram, r1]		
	bne	3f
	add	lr, pc, #20
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
1:						
	bl	S9xAPUSetByteFFC0		
	ldr   	spc_ram, [context, #iapu_ram]	
3:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEB_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEC_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuED_21:
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  eor   spc_p,spc_p,#flag_c
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEE_21:
  add   r0,spc_ram,spc_s
  ldrb  r0,[r0,#(0x100 + 1)]
  add   spc_s,spc_s,#1
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuEF_21:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF0_21:
  tst   spc_p,#0xFF000000
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF1_21:
  sub   r0,spc_pc,spc_ram
  add   r1,spc_ram,spc_s
  sub   spc_s,spc_s,#2
  strb  r0,[r1,#0xff]
  mov   r0,r0,lsr #8
  strb  r0,[r1,#0x100]
  ldr   r0,[context,#iapu_extraram]
  ldrh  r0,[r0,#0x0]
  add   spc_pc,spc_ram,r0
  subs   cycles,cycles,#168
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF2_21:
  ldrb  r0,[spc_pc]
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  bic   r0,r0,#0x80
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF3_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  tst   r0,#0x80
  addne spc_pc,spc_pc,#1
  ldreqsb r0,[spc_pc],#1
  subeq cycles,cycles,#42
  addeq spc_pc,spc_pc,r0
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF4_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF5_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_x
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF6_21:
  ldrb  r0,[spc_pc],#1
  ldrb  r14,[spc_pc],#1
  add   r0,r0,spc_ya, lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF7_21:
  ldrb  r0,[spc_pc],#1
  ldr   r14,[context,#iapu_directpage]
  ldrb  r0,[r14,r0]!
  ldrb  r14,[r14,#1]
  add   r0,r0,spc_ya,lsr #8
  add   r0,r0,r14,lsl #8
	mov	r1, r0
	ldrb	r0, [spc_ram, r1]		
	cmp	r1, #0x0ff
	bhi	1f	
	cmp	r1, #0xf3			
	addeq	lr, pc, #12	
	beq	GetAPUDSP			
	cmp	r1, #0xfd			
	movhs	r2, #0				
	strhsb	r2, [spc_ram, r1]		
1:
  and   spc_ya,spc_ya,#0xff00
  orr   spc_ya,spc_ya,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#126
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF8_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuF9_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_ya,lsr #8
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  mov   spc_x,r0
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_x,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFA_21:
  ldrb  r0,[spc_pc],#1
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  ldrb  r1,[spc_pc],#1
	ldr	r2, [context, #iapu_directpage]	
	cmp	r2, spc_ram			
	bne	2f				
	cmp	r1, #0xf0			
	blo  	2f				
	cmp	r1, #0xfe			
	bhs	1f				
	add	lr, pc, #16
	cmp	r1, #0xf1			
	beq	S9xSetAPUControl		
	cmp	r1, #0xf3			
	beq	S9xSetAPUDSP			
	b	S9xAPUSetByteFFtoF0		
   	ldr   	spc_ram, [context, #iapu_ram]	
	b	1f				
2:						
	strb	r0, [r2, r1]			
1:						
  subs   cycles,cycles,#105
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFB_21:
  ldrb  r0,[spc_pc],#1
  add   r0,r0,spc_x
	mov	r1, r0
	cmp	r1, #0xf3			
	addeq	lr, pc, #20	
	beq	GetAPUDSP			
	ldr	r14, [context, #iapu_directpage]
	cmp	r1, #0xfd			
	ldrb	r0, [r14, r1]			
	movhs	r2, #0				
	strhsb	r2, [r14, r1]			
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,r0,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFC_21:
  mov   r0,spc_ya,lsr #8
  add   r0,r0,#1
  and   r0,r0,#0xff
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,r0,lsl #24
  and   spc_ya,spc_ya,#0xff
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  orr   spc_ya,spc_ya,r0,lsl #8
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFD_21:
  and   spc_ya,spc_ya,#0xff
  orr   spc_ya,spc_ya,spc_ya,lsl #8
  and   spc_p,spc_p,#0xff
  orr   spc_p,spc_p,spc_ya,lsl #24
  subs   cycles,cycles,#42
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFE_21:
  sub   spc_ya,spc_ya,#0x100
  mov   spc_ya,spc_ya,lsl #16
  mov   spc_ya,spc_ya,lsr #16
  movs  r0,spc_ya,lsr #8
  addeq spc_pc,spc_pc,#1
  ldrnesb r0,[spc_pc],#1
  addne spc_pc,spc_pc,r0
  subne cycles,cycles,#42
  subs   cycles,cycles,#84
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


ApuFF_21:
	ldr	r0, 5001f
  mov   r1,#0
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  str  r1,[r0,#cpu_apu_executing]
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End
5001:
	.long	CPU	
  subs   cycles,cycles,#63
  ldrgeb opcode,[spc_pc],#1
  ldrge  pc,[opcodes,opcode,lsl #2]
  b      spc700End


@ -------------------------- Jump Table 21 --------------------------
Spc700JumpTab_21:
  .long Apu00_21, Apu01_21, Apu02_21, Apu03_21, Apu04_21, Apu05_21, Apu06_21, Apu07_21 @ 00
  .long Apu08_21, Apu09_21, Apu0A_21, Apu0B_21, Apu0C_21, Apu0D_21, Apu0E_21, Apu0F_21 @ 08
  .long Apu10_21, Apu11_21, Apu12_21, Apu13_21, Apu14_21, Apu15_21, Apu16_21, Apu17_21 @ 10
  .long Apu18_21, Apu19_21, Apu1A_21, Apu1B_21, Apu1C_21, Apu1D_21, Apu1E_21, Apu1F_21 @ 18
  .long Apu20_21, Apu21_21, Apu22_21, Apu23_21, Apu24_21, Apu25_21, Apu26_21, Apu27_21 @ 20
  .long Apu28_21, Apu29_21, Apu2A_21, Apu2B_21, Apu2C_21, Apu2D_21, Apu2E_21, Apu2F_21 @ 28
  .long Apu30_21, Apu31_21, Apu32_21, Apu33_21, Apu34_21, Apu35_21, Apu36_21, Apu37_21 @ 30
  .long Apu38_21, Apu39_21, Apu3A_21, Apu3B_21, Apu3C_21, Apu3D_21, Apu3E_21, Apu3F_21 @ 38
  .long Apu40_21, Apu41_21, Apu42_21, Apu43_21, Apu44_21, Apu45_21, Apu46_21, Apu47_21 @ 40
  .long Apu48_21, Apu49_21, Apu4A_21, Apu4B_21, Apu4C_21, Apu4D_21, Apu4E_21, Apu4F_21 @ 48
  .long Apu50_21, Apu51_21, Apu52_21, Apu53_21, Apu54_21, Apu55_21, Apu56_21, Apu57_21 @ 50
  .long Apu58_21, Apu59_21, Apu5A_21, Apu5B_21, Apu5C_21, Apu5D_21, Apu5E_21, Apu5F_21 @ 58
  .long Apu60_21, Apu61_21, Apu62_21, Apu63_21, Apu64_21, Apu65_21, Apu66_21, Apu67_21 @ 60
  .long Apu68_21, Apu69_21, Apu6A_21, Apu6B_21, Apu6C_21, Apu6D_21, Apu6E_21, Apu6F_21 @ 68
  .long Apu70_21, Apu71_21, Apu72_21, Apu73_21, Apu74_21, Apu75_21, Apu76_21, Apu77_21 @ 70
  .long Apu78_21, Apu79_21, Apu7A_21, Apu7B_21, Apu7C_21, Apu7D_21, Apu7E_21, Apu7F_21 @ 78
  .long Apu80_21, Apu81_21, Apu82_21, Apu83_21, Apu84_21, Apu85_21, Apu86_21, Apu87_21 @ 80
  .long Apu88_21, Apu89_21, Apu8A_21, Apu8B_21, Apu8C_21, Apu8D_21, Apu8E_21, Apu8F_21 @ 88
  .long Apu90_21, Apu91_21, Apu92_21, Apu93_21, Apu94_21, Apu95_21, Apu96_21, Apu97_21 @ 90
  .long Apu98_21, Apu99_21, Apu9A_21, Apu9B_21, Apu9C_21, Apu9D_21, Apu9E_21, Apu9F_21 @ 98
  .long ApuA0_21, ApuA1_21, ApuA2_21, ApuA3_21, ApuA4_21, ApuA5_21, ApuA6_21, ApuA7_21 @ a0
  .long ApuA8_21, ApuA9_21, ApuAA_21, ApuAB_21, ApuAC_21, ApuAD_21, ApuAE_21, ApuAF_21 @ a8
  .long ApuB0_21, ApuB1_21, ApuB2_21, ApuB3_21, ApuB4_21, ApuB5_21, ApuB6_21, ApuB7_21 @ b0
  .long ApuB8_21, ApuB9_21, ApuBA_21, ApuBB_21, ApuBC_21, ApuBD_21, ApuBE_21, ApuBF_21 @ b8
  .long ApuC0_21, ApuC1_21, ApuC2_21, ApuC3_21, ApuC4_21, ApuC5_21, ApuC6_21, ApuC7_21 @ c0
  .long ApuC8_21, ApuC9_21, ApuCA_21, ApuCB_21, ApuCC_21, ApuCD_21, ApuCE_21, ApuCF_21 @ c8
  .long ApuD0_21, ApuD1_21, ApuD2_21, ApuD3_21, ApuD4_21, ApuD5_21, ApuD6_21, ApuD7_21 @ d0
  .long ApuD8_21, ApuD9_21, ApuDA_21, ApuDB_21, ApuDC_21, ApuDD_21, ApuDE_21, ApuDF_21 @ d8
  .long ApuE0_21, ApuE1_21, ApuE2_21, ApuE3_21, ApuE4_21, ApuE5_21, ApuE6_21, ApuE7_21 @ e0
  .long ApuE8_21, ApuE9_21, ApuEA_21, ApuEB_21, ApuEC_21, ApuED_21, ApuEE_21, ApuEF_21 @ e8
  .long ApuF0_21, ApuF1_21, ApuF2_21, ApuF3_21, ApuF4_21, ApuF5_21, ApuF6_21, ApuF7_21 @ f0
  .long ApuF8_21, ApuF9_21, ApuFA_21, ApuFB_21, ApuFC_21, ApuFD_21, ApuFE_21, ApuFF_21 @ f8
