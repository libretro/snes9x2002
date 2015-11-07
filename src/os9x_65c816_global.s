/*	.DATA*/
   .text
	.align	4
	.include	"os9x_65c816_common.s"

.globl asmS9xGetByte
.globl asmS9xGetWord
.globl asmS9xSetByte
.globl asmS9xSetWord
.globl asmS9xSetPCBase
@ input: r0 : address
@ return: rpc, regpcbase
@ uint8 asmS9xSetPCBase(uint32 address);
asmS9xSetPCBase:
	@ MEMMAP_SHIFT is 12, Address is 0xFFFFFFFF at max, so
	@ R1 is maxed by 0x000FFFFF, MEMMAP_MASK is 0x1000-1=0xFFF
	@ so AND MEMMAP_MASK is BIC 0xFF000
	mov	r1, r0, lsr #MEMMAP_SHIFT


	@ R2 <= Map[block] (GetAddress)
	ldr	r2, [reg_cpu_var, #Map_ofs]
	bic	r1, r1, #0xFF000

	ldr	regpcbase, [r2, r1, lsl #2]
	bic	r0, r0, #0xff0000	@ Address & 0xffff

	cmp	regpcbase, #MAP_LAST
	blo	SPCBSpecial

	ldr	r2, [reg_cpu_var, #MemorySpeed_ofs]
	bic	rstatus, rstatus, #MEMSPEED_MASK
	ldr	r1, [r2, r1, lsl #2]
	add	rpc, regpcbase, r0
	str	r1, [reg_cpu_var, #MemSpeed_ofs]
	orr	rstatus, rstatus, r1, lsl #MEMSPEED_SHIFT		

	bx	r3
	

SPCBSpecial:

	ldr	pc, [pc, regpcbase, lsl #2]
	mov	r0, r0 		@ nop, for align
	.long	SPCB_PPU
	.long	SPCB_CPU
	.long	SPCB_DSP
	.long	SPCB_LOROM_SRAM
	.long	SPCB_HIROM_SRAM
	.long	SPCB_LOROM_SRAM
	.long	SPCB_LOROM_SRAM
	.long	SPCB_C4
	.long	SPCB_BWRAM
	.long	SPCB_LOROM_SRAM
	.long	SPCB_LOROM_SRAM
	.long	SPCB_LOROM_SRAM
/*
	MAP_PPU 	0
	MAP_CPU 	1
	MAP_DSP 	2
	MAP_LOROM_SRAM	3
	MAP_HIROM_SRAM	4
	MAP_NONE	5
	MAP_DEBUG	6	
	MAP_C4		7
	MAP_BWRAM	8
	MAP_BWRAM_BITMAP	9
	MAP_BWRAM_BITMAP2	10
	MAP_SA1RAM	11
	MAP_LAST	12
*/

vMemory:
	.word	Memory

SPCB_PPU:
	@CPU.PCBase = Memory.FillRAM - 0x2000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);

	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_fillram]
	
	sub	regpcbase, regpcbase, #0x2000
	add	rpc, regpcbase, r0

	mov	r0, #ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				

	@return;
	bx 	r3
	@-------------------

SPCB_CPU:
	@CPU.PCBase = Memory.FillRAM - 0x4000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);

	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_fillram]
	
	sub	regpcbase, regpcbase, #0x4000
	add	rpc, regpcbase, r0
		
	mov	r0, #ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				

	@return;
	bx 	r3
	@-------------------

SPCB_DSP:
	@CPU.PCBase = Memory.FillRAM - 0x6000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);

	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_fillram]
	
	sub	regpcbase, regpcbase, #0x6000
	add	rpc, regpcbase, r0

	mov	r0, #SLOW_ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]		
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				
		
	@return;
	bx 	r3
	@-------------------

SPCB_LOROM_SRAM:
	@CPU.PCBase = Memory.SRAM;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);

	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_sram]

	add	rpc, regpcbase, r0
	
	mov	r0, #SLOW_ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]		
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				

	@return;
	bx 	r3
	@-------------------

SPCB_HIROM_SRAM:
	@CPU.PCBase = Memory.SRAM - 0x6000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);

	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_sram]
	
	sub	regpcbase, regpcbase, #0x6000
	add	rpc, regpcbase, r0

	mov	r0, #SLOW_ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]		
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				

	@return;
	bx 	r3
	@-------------------

SPCB_C4:
	@CPU.PCBase = Memory.C4RAM - 0x6000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);
	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_c4ram]
	
	sub	regpcbase, regpcbase, #0x6000
	add	rpc, regpcbase, r0

	mov	r0, #SLOW_ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]		
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				

	@return;
	bx 	r3
	@-------------------

SPCB_BWRAM:	
	@CPU.PCBase = Memory.BWRAM - 0x6000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);
	ldr	r1, vMemory
	ldr	regpcbase, [r1, #_bwram]
	
	sub	regpcbase, regpcbase, #0x6000
	add	rpc, regpcbase, r0

	mov	r0, #SLOW_ONE_CYCLE
	bic	rstatus, rstatus, #MEMSPEED_MASK
	str	r0, [reg_cpu_var, #MemSpeed_ofs]		
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT				

	@return;
	bx 	r3
	@-------------------


@ uint8 aaS9xGetByte(uint32 address);
asmS9xGetByte:
	@  in : R0  = 0x00hhmmll
	@  out : R0 = 0x000000ll
	@  DESTROYED : R1,R2,R3
	@  UPDATE : reg_cycles
	@ R1 <= block	
	MOV		R1,R0,LSR #MEMMAP_SHIFT
	@ MEMMAP_SHIFT is 12, Address is 0xFFFFFFFF at max, so
	@ R1 is maxed by 0x000FFFFF, MEMMAP_MASK is 0x1000-1=0xFFF
	@ so AND MEMMAP_MASK is BIC 0xFF000
	BIC		R1,R1,#0xFF000
	@ R2 <= Map[block] (GetAddress)
	LDR		R2,[reg_cpu_var,#Map_ofs]
	LDR		R2,[R2,R1,LSL #2]
	CMP		R2,#MAP_LAST
	BLO		GBSpecial  @ special
	@  Direct ROM/RAM acess
	@ R2 <= GetAddress + Address & 0xFFFF	
	@ R3 <= MemorySpeed[block]			
	LDR		R3,[reg_cpu_var,#MemorySpeed_ofs]
	@MOV		R0,R0,LSL #16
	bic		r0, r0, #0xff0000		
	LDR		R3,[R3,R1, lsl #2]
	@ADD		R2,R2,R0,LSR #16
	add		r2, r2, r0
	@ Update CPU.Cycles
	ADD		reg_cycles,reg_cycles,R3	
	@ R3 = BlockIsRAM[block]
	LDR		R3,[reg_cpu_var,#BlockIsRAM_ofs]
	@ Get value to return
	LDRB		R3,[R3,R1]
	LDRB		R0,[R2]
	MOVS		R3,R3
	@  if BlockIsRAM => update for CPUShutdown
	LDRNE		R1,[reg_cpu_var,#PCAtOpcodeStart_ofs]
	orrne		rstatus, rstatus, #MASK_SHUTDOWN
	STRNE		R1,[reg_cpu_var,#WaitAddress_ofs]


	LDMFD		R13!,{PC} @ Return
GBSpecial:
	
	LDR		PC,[PC,R2,LSL #2]
	MOV		R0,R0 		@ nop, for align
	.long GBPPU
	.long GBCPU
	.long GBDSP
	.long GBLSRAM
	.long GBHSRAM
	.long GBNONE
	.long GBDEBUG
	.long GBC4
	.long GBBWRAM
	.long GBNONE
	.long GBNONE
	.long GBNONE
	/*.long GB7ROM
	.long GB7RAM
	.long GB7SRM*/
GBPPU:
	@ InDMA ?
	LDRB		R1,[reg_cpu_var,#InDMA_ofs]
	@MOV		R0,R0,LSL #16	@ S9xGetPPU(Address&0xFFFF);
	bic		r0, r0, #0xff0000		
	MOVS		R1,R1	
	ADDEQ		reg_cycles,reg_cycles,#ONE_CYCLE		@ No -> update Cycles
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs]	@ Save Cycles
	@MOV		R0,R0,LSR #16	
	
	str		rstatus, [reg_cpu_var, #rstatus_ofs]
		PREPARE_C_CALL
	BL		S9xGetPPU
		RESTORE_C_CALL
	ldr		rstatus, [reg_cpu_var, #rstatus_ofs]

	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
GBCPU:	
	ADD		reg_cycles,reg_cycles,#ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16 @ S9xGetCPU(Address&0xFFFF);	
	bic		r0, r0, #0xff0000			
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16
		PREPARE_C_CALL
	BL		S9xGetCPU
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
	
GBDSP:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16 @ S9xGetCPU(Address&0xFFFF);	
	bic		r0, r0, #0x0ff0000	
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16

	ldr		reg_cycles, [reg_cpu_var, #DSPGet_ofs]
		PREPARE_C_CALL
	blx		reg_cycles	
	@BL		S9xGetDSP		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
GBLSRAM:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles		
	LDR		R2,[reg_cpu_var,#SRAMMask]
	LDR		R1,[reg_cpu_var,#SRAM]	
	AND		R0,R2,R0		@ Address&SRAMMask
	LDRB		R0,[R1,R0]		@ *Memory.SRAM + Address&SRAMMask
	LDMFD		R13!,{PC}
GB7SRM:	
GBHSRAM:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles		
	
	MOV		R1,R0,LSL #17  
	AND		R2,R0,#0xF0000
	MOV		R1,R1,LSR #17	@ Address&0x7FFF	
	MOV		R2,R2,LSR #3 @ (Address&0xF0000 >> 3)
	ADD		R0,R2,R1
	LDR		R2,[reg_cpu_var,#SRAMMask]
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000 + ((Address & 0xf0000) >> 3))
	LDR		R1,[reg_cpu_var,#SRAM]	
	AND		R0,R2,R0		@ Address&SRAMMask	
	LDRB		R0,[R1,R0]		@ *Memory.SRAM + Address&SRAMMask
	LDMFD		R13!,{PC}		@ return
GB7ROM:
GB7RAM:	
GBNONE:
	MOV		R0,R0,LSR #8
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles
	AND		R0,R0,#0xFF
	LDMFD		R13!,{PC}
@ GBDEBUG:
	/*ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles
	MOV		R0,#0
	LDMFD		R13!,{PC}*/
GBC4:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16 @ S9xGetC4(Address&0xFFFF);	
	bic		r0, r0, #0xff0000			
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16
		PREPARE_C_CALL
	BL		S9xGetC4
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles		
	LDMFD		R13!,{PC} @ Return
GBDEBUG:	
GBBWRAM:
	MOV		R0,R0,LSL #17  
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles	
	MOV		R0,R0,LSR #17	@ Address&0x7FFF			
	LDR		R1,[reg_cpu_var,#BWRAM]	
	SUB		R0,R0,#0x6000   @ ((Address & 0x7fff) - 0x6000)	
	LDRB		R0,[R0,R1]		@ *Memory.BWRAM + ((Address & 0x7fff) - 0x6000)	
	LDMFD		R13!,{PC}


@ uint16 aaS9xGetWord(uint32 address);
asmS9xGetWord:
	@  in : R0  = 0x00hhmmll
	@  out : R0 = 0x000000ll
	@  DESTROYED : R1,R2,R3
	@  UPDATE : reg_cycles
	
	
	MOV		R1,R0,LSL #19	
	ADDS		R1,R1,#0x80000
	@ if = 0x1FFF => 0
	BNE		GW_NotBoundary
	
	STMFD		R13!,{R0}
		STMFD		R13!,{PC}
	B		asmS9xGetByte
		MOV		R0,R0
	LDMFD		R13!,{R1}
	STMFD		R13!,{R0}
	ADD		R0,R1,#1
		STMFD		R13!,{PC}
	B		asmS9xGetByte
		MOV		R0,R0
	LDMFD		R13!,{R1}
	ORR		R0,R1,R0,LSL #8
	LDMFD		R13!,{PC}
	
GW_NotBoundary:	
	
	@ R1 <= block	
	MOV		R1,R0,LSR #MEMMAP_SHIFT
	@ MEMMAP_SHIFT is 12, Address is 0xFFFFFFFF at max, so
	@ R1 is maxed by 0x000FFFFF, MEMMAP_MASK is 0x1000-1=0xFFF
	@ so AND MEMMAP_MASK is BIC 0xFF000
	BIC		R1,R1,#0xFF000
	@ R2 <= Map[block] (GetAddress)
	LDR		R2,[reg_cpu_var,#Map_ofs]
	LDR		R2,[R2,R1,LSL #2]
	CMP		R2,#MAP_LAST
	BLO		GWSpecial  @ special
	@  Direct ROM/RAM acess
	
	TST		R0,#1	
	BNE		GW_Not_Aligned1
	@ R2 <= GetAddress + Address & 0xFFFF	
	@ R3 <= MemorySpeed[block]			
	LDR		R3,[reg_cpu_var,#MemorySpeed_ofs]
	@MOV		R0,R0,LSL #16
	bic		r0, r0, #0xff0000		
	LDR		R3,[R3,R1, lsl #2]	
	@MOV		R0,R0,LSR #16
	@ Update CPU.Cycles
	ADD		reg_cycles,reg_cycles,R3, LSL #1
	@ R3 = BlockIsRAM[block]
	LDR		R3,[reg_cpu_var,#BlockIsRAM_ofs]
	@ Get value to return
	LDRH		R0,[R2,R0]
	LDRB		R3,[R3,R1]
	MOVS		R3,R3
	@  if BlockIsRAM => update for CPUShutdown
	LDRNE		R1,[reg_cpu_var,#PCAtOpcodeStart_ofs]
	orrne		rstatus, rstatus, #MASK_SHUTDOWN	
	STRNE		R1,[reg_cpu_var,#WaitAddress_ofs]
	
	LDMFD		R13!,{PC} @ Return
GW_Not_Aligned1:			

	MOV		R0,R0,LSL #16		
	ADD		R3,R0,#0x10000
	LDRB		R3,[R2,R3,LSR #16]	@ GetAddress+ (Address+1)&0xFFFF
	LDRB		R0,[R2,R0,LSR #16]	@ GetAddress+ Address&0xFFFF	
	ORR		R0,R0,R3,LSL #8	

	@  if BlockIsRAM => update for CPUShutdown
	LDR		R3,[reg_cpu_var,#BlockIsRAM_ofs]	
	LDR		R2,[reg_cpu_var,#MemorySpeed_ofs]
	LDRB		R3,[R3,R1]   @ R3 = BlockIsRAM[block]
	LDR		R2,[R2,R1, lsl #2]   @ R2 <= MemorySpeed[block]
	MOVS		R3,R3 	    @ IsRAM ? CPUShutdown stuff
	LDRNE		R1,[reg_cpu_var,#PCAtOpcodeStart_ofs]
	orrne		rstatus, rstatus, #MASK_SHUTDOWN	
	STRNE		R1,[reg_cpu_var,#WaitAddress_ofs]			
	ADD		reg_cycles,reg_cycles,R2, LSL #1 @ Update CPU.Cycles				
	LDMFD		R13!,{PC}  @ Return
GWSpecial:
	LDR		PC,[PC,R2,LSL #2]
	MOV		R0,R0 		@ nop, for align
	.long GWPPU
	.long GWCPU
	.long GWDSP
	.long GWLSRAM
	.long GWHSRAM
	.long GWNONE
	.long GWDEBUG
	.long GWC4
	.long GWBWRAM
	.long GWNONE
	.long GWNONE
	.long GWNONE
	/*.long GW7ROM
	.long GW7RAM
	.long GW7SRM*/
/*	MAP_PPU, MAP_CPU, MAP_DSP, MAP_LOROM_SRAM, MAP_HIROM_SRAM,
	MAP_NONE, MAP_DEBUG, MAP_C4, MAP_BWRAM, MAP_BWRAM_BITMAP,
	MAP_BWRAM_BITMAP2, MAP_SA1RAM, MAP_LAST*/
	
GWPPU:
	@ InDMA ?
	LDRB		R1,[reg_cpu_var,#InDMA_ofs]
	@MOV		R0,R0,LSL #16	@ S9xGetPPU(Address&0xFFFF);
	bic		r0, r0, #0xff0000			
	MOVS		R1,R1	
	ADDEQ		reg_cycles,reg_cycles,#(ONE_CYCLE*2)		@ No -> update Cycles
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs]	@ Save Cycles
	@MOV		R0,R0,LSR #16

	str		rstatus, [reg_cpu_var, #rstatus_ofs]
		PREPARE_C_CALL_R0
	BL		S9xGetPPU
	LDMFD		R13!,{R1}
	STMFD		R13!,{R0}
	ADD		R0,R1,#1
	@ BIC		R0,R0,#0x10000
	BL		S9xGetPPU
		RESTORE_C_CALL_R1
	ldr		rstatus, [reg_cpu_var, #rstatus_ofs]

	ORR		R0,R1,R0,LSL #8
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
GWCPU:	
	ADD		reg_cycles,reg_cycles,#(ONE_CYCLE*2)	@ update Cycles	
	@MOV		R0,R0,LSL #16 @ S9xGetCPU(Address&0xFFFF);	
	bic		r0, r0, #0xff0000			
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16
		PREPARE_C_CALL_R0
	BL		S9xGetCPU
	LDMFD		R13!,{R1}
	STMFD		R13!,{R0}
	ADD		R0,R1,#1
	@ BIC		R0,R0,#0x10000
	BL		S9xGetCPU			
		RESTORE_C_CALL_R1
	ORR		R0,R1,R0,LSL #8
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
GWDSP:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles	
	@MOV		R0,R0,LSL #16 @ S9xGetCPU(Address&0xFFFF);	
	bic		r0, r0, #0x0ff0000		
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16
	
	ldr		reg_cycles, [reg_cpu_var, #DSPGet_ofs]	
		PREPARE_C_CALL_R0
	blx		reg_cycles
	@BL		S9xGetDSP
	LDMFD		R13!,{R1}
	STMFD		R13!,{R0}
	ADD		R0,R1,#1
	@ BIC		R0,R0,#0x10000
	@BL		S9xGetDSP
	blx		reg_cycles	
		RESTORE_C_CALL_R1
	ORR		R0,R1,R0,LSL #8
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
GWLSRAM:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles		
	
	TST		R0,#1
	BNE		GW_Not_Aligned2
	LDR		R2,[reg_cpu_var,#SRAMMask]
	LDR		R1,[reg_cpu_var,#SRAM]
	AND		R3,R2,R0		@ Address&SRAMMask
	LDRH		R0,[R3,R1]		@ *Memory.SRAM + Address&SRAMMask		
	LDMFD		R13!,{PC}	@ return
GW_Not_Aligned2:	
	LDR		R2,[reg_cpu_var,#SRAMMask]
	LDR		R1,[reg_cpu_var,#SRAM]	
	AND		R3,R2,R0		@ Address&SRAMMask
	ADD		R0,R0,#1
	AND		R2,R0,R2		@ Address&SRAMMask
	LDRB		R3,[R1,R3]		@ *Memory.SRAM + Address&SRAMMask
	LDRB		R2,[R1,R2]		@ *Memory.SRAM + Address&SRAMMask
	ORR		R0,R3,R2,LSL #8
	LDMFD		R13!,{PC}	@ return
GW7SRM:	
GWHSRAM:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles		
	
	TST		R0,#1
	BNE		GW_Not_Aligned3
	
	MOV		R1,R0,LSL #17  
	AND		R2,R0,#0xF0000
	MOV		R1,R1,LSR #17	@ Address&0x7FFF	
	MOV		R2,R2,LSR #3 @ (Address&0xF0000 >> 3)
	ADD		R0,R2,R1
	LDR		R2,[reg_cpu_var,#SRAMMask]
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000 + ((Address & 0xf0000) >> 3))

	LDR		R1,[reg_cpu_var,#SRAM]	
	AND		R0,R2,R0		@ Address&SRAMMask	
	LDRH		R0,[R1,R0]		@ *Memory.SRAM + Address&SRAMMask
	LDMFD		R13!,{PC}		@ return
	
GW_Not_Aligned3:	
	MOV		R3,R0,LSL #17  
	AND		R2,R0,#0xF0000
	MOV		R3,R3,LSR #17	@ Address&0x7FFF	
	MOV		R2,R2,LSR #3 @ (Address&0xF0000 >> 3)	
	ADD		R2,R2,R3						
	ADD		R0,R0,#1	
	SUB		R2,R2,#0x6000 @ ((Address & 0x7fff) - 0x6000 + ((Address & 0xf0000) >> 3))
	MOV		R3,R0,LSL #17  
	AND		R0,R0,#0xF0000
	MOV		R3,R3,LSR #17	@ (Address+1)&0x7FFF	
	MOV		R0,R0,LSR #3 @ ((Address+1)&0xF0000 >> 3)	
	ADD		R0,R0,R3	
	LDR		R3,[reg_cpu_var,#SRAMMask]	@ reload mask	
	SUB		R0,R0,#0x6000 @ (((Address+1) & 0x7fff) - 0x6000 + (((Address+1) & 0xf0000) >> 3))		
	AND		R2,R3,R2		@ Address...&SRAMMask	
	AND		R0,R3,R0		@ (Address+1...)&SRAMMask	

	LDR		R3,[reg_cpu_var,#SRAM]
	LDRB		R0,[R0,R3]		@ *Memory.SRAM + (Address...)&SRAMMask	
	LDRB		R2,[R2,R3]		@ *Memory.SRAM + (Address+1...)&SRAMMask
	ORR		R0,R2,R0,LSL #8
			
	LDMFD		R13!,{PC}		@ return
GW7ROM:
GW7RAM:	
GWNONE:		
	MOV		R0,R0,LSL #16
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles
	MOV		R0,R0,LSR #24
	ORR		R0,R0,R0,LSL #8
	LDMFD		R13!,{PC}
GWDEBUG:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles
	MOV		R0,#0
	LDMFD		R13!,{PC}
GWC4:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles	
	@MOV		R0,R0,LSL #16 @ S9xGetC4(Address&0xFFFF);	
	bic		r0, r0, #0xff0000		
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16
		PREPARE_C_CALL_R0
	BL		S9xGetC4
	LDMFD		R13!,{R1}
	STMFD		R13!,{R0}
	ADD		R0,R1,#1
	@ BIC		R0,R0,#0x10000
	BL		S9xGetC4
		RESTORE_C_CALL_R1
	ORR		R0,R1,R0,LSL #8
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
GWBWRAM:
	TST		R0,#1
	BNE		GW_Not_Aligned4
	MOV		R0,R0,LSL #17  
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles
	MOV		R0,R0,LSR #17	@ Address&0x7FFF
	LDR		R1,[reg_cpu_var,#BWRAM]		
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000)		
	LDRH		R0,[R1,R0]		@ *Memory.BWRAM + ((Address & 0x7fff) - 0x6000)	
	LDMFD		R13!,{PC}		@ return
GW_Not_Aligned4:
	MOV		R0,R0,LSL #17  	
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles
	ADD		R3,R0,#0x20000
	MOV		R0,R0,LSR #17	@ Address&0x7FFF
	MOV		R3,R3,LSR #17	@ (Address+1)&0x7FFF
	LDR		R1,[reg_cpu_var,#BWRAM]		
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000)	
	SUB		R3,R3,#0x6000 @ (((Address+1) & 0x7fff) - 0x6000)	
	LDRB		R0,[R1,R0]		@ *Memory.BWRAM + ((Address & 0x7fff) - 0x6000)		
	LDRB		R3,[R1,R3]		@ *Memory.BWRAM + (((Address+1) & 0x7fff) - 0x6000)	
	ORR		R0,R0,R3,LSL #8
	LDMFD		R13!,{PC}		@ return




@ void aaS9xSetByte(uint32 address,uint8 val);
asmS9xSetByte:
	@  in : R0=0x00hhmmll  R1=0x000000ll	
	@  DESTROYED : R0,R1,R2,R3
	@  UPDATE : reg_cycles	
	@ cpu shutdown
	@MOV		R2,#0
	@STR		R2,[reg_cpu_var,#WaitAddress_ofs]
	bic		rstatus, rstatus, #MASK_SHUTDOWN

	@ 
	
	@ R3 <= block				
	MOV		R3,R0,LSR #MEMMAP_SHIFT
	@ MEMMAP_SHIFT is 12, Address is 0xFFFFFFFF at max, so
	@ R0 is maxed by 0x000FFFFF, MEMMAP_MASK is 0x1000-1=0xFFF
	@ so AND MEMMAP_MASK is BIC 0xFF000
	BIC		R3,R3,#0xFF000
	@ R2 <= Map[block] (SetAddress)
	LDR		R2,[reg_cpu_var,#WriteMap_ofs]
	LDR		R2,[R2,R3,LSL #2]
	CMP		R2,#MAP_LAST
	BLO		SBSpecial  @ special
	@  Direct ROM/RAM acess
	
	@ R2 <= SetAddress + Address & 0xFFFF	
	@MOV		R0,R0,LSL #16
	bic		r0, r0, #0xff0000			
	@ADD		R2,R2,R0,LSR #16
	add		r2, r2, r0
	LDR		R0,[reg_cpu_var,#MemorySpeed_ofs]
	@ Set byte
	STRB		R1,[R2]		
	@ R0 <= MemorySpeed[block]
	LDR		R0,[R0,R3, lsl #2]	
	@ Update CPU.Cycles
	ADD		reg_cycles,reg_cycles,R0
	@ CPUShutdown
	@ only SA1 here : TODO	
	@ Return
	LDMFD		R13!,{PC}
SBSpecial:
	LDR		PC,[PC,R2,LSL #2]
	MOV		R0,R0 		@ nop, for align
	.long SBPPU
	.long SBCPU
	.long SBDSP
	.long SBLSRAM
	.long SBHSRAM
	.long SBNONE
	.long SBDEBUG
	.long SBC4
	.long SBBWRAM
	.long SBNONE
	.long SBNONE
	.long SBNONE
	/*.long SB7ROM
	.long SB7RAM
	.long SB7SRM*/
SBPPU:
	@ InDMA ?
	LDRB		R2,[reg_cpu_var,#InDMA_ofs]
	@MOV		R0,R0,LSL #16
	bic		r0, r0, #0xff0000			
	MOVS		R2,R2	
	ADDEQ		reg_cycles,reg_cycles,#ONE_CYCLE		@ No -> update Cycles
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs]	@ Save Cycles
	@MOV		R0,R0,LSR #16
		PREPARE_C_CALL
	MOV		R12,R0
	MOV		R0,R1
	MOV		R1,R12		
	BL		S9xSetPPU		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SBCPU:	
	ADD		reg_cycles,reg_cycles,#ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16 
	bic		r0, r0, #0xff0000		
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16	@ Address&0xFFFF
		PREPARE_C_CALL
	MOV		R12,R0
	MOV		R0,R1
	MOV		R1,R12		
	BL		S9xSetCPU		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SBDSP:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16
	bic		r0, r0, #0x0ff0000 
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16	@ Address&0xFFFF
		PREPARE_C_CALL	
	MOV		R12,R0
	MOV		R0,R1
	ldr		reg_cycles, [reg_cpu_var, #DSPSet_ofs]
	MOV		R1,R12	
	blx		reg_cycles
	@BL		S9xSetDSP		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SBLSRAM:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles		
	LDR		R2,[reg_cpu_var,#SRAMMask]
	MOVS		R2,R2
	LDMEQFD		R13!,{PC} @ return if SRAMMask=0
	LDR		R3,[reg_cpu_var,#SRAM]	
	AND		R0,R2,R0		@ Address&SRAMMask	
	STRB		R1,[R0,R3]		@ *Memory.SRAM + Address&SRAMMask	
	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	LDMFD		R13!,{PC}  @ return
SB7SRM:	
SBHSRAM:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles		
	
	MOV		R3,R0,LSL #17  
	AND		R2,R0,#0xF0000
	MOV		R3,R3,LSR #17	@ Address&0x7FFF	
	MOV		R2,R2,LSR #3 @ (Address&0xF0000 >> 3)	
	ADD		R0,R2,R3	
	
	LDR		R2,[reg_cpu_var,#SRAMMask]
	MOVS		R2,R2
	LDMEQFD		R13!,{PC} @ return if SRAMMask=0
	
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000 + ((Address & 0xf0000) >> 3))
	LDR		R3,[reg_cpu_var,#SRAM]	
	AND		R0,R2,R0		@ Address&SRAMMask	
	STRB		R1,[R0,R3]		@ *Memory.SRAM + Address&SRAMMask
	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	LDMFD		R13!,{PC}	@ return
SB7ROM:
SB7RAM:	
SBNONE:	
SBDEBUG:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles
	LDMFD		R13!,{PC}
SBC4:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16 
	bic		r0, r0, #0xff0000			
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16	@ Address&0xFFFF	
		PREPARE_C_CALL
	MOV		R12,R0
	MOV		R0,R1
	MOV		R1,R12		
	BL		S9xSetC4		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SBBWRAM:
	MOV		R0,R0,LSL #17  
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles
	MOV		R0,R0,LSR #17	@ Address&0x7FFF			
	LDR		R2,[reg_cpu_var,#BWRAM]	
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000)	
	STRB		R1,[R0,R2]		@ *Memory.BWRAM + ((Address & 0x7fff) - 0x6000)
	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	
	LDMFD		R13!,{PC}



@ void aaS9xSetWord(uint32 address,uint16 val);
asmS9xSetWord:
	@  in : R0  = 0x00hhmmll R1=0x0000hhll
	@  DESTROYED : R0,R1,R2,R3
	@  UPDATE : reg_cycles
	@ R1 <= block	
	
	MOV		R2,R0,LSL #19	
	ADDS		R2,R2,#0x80000
	@ if = 0x1FFF => 0
	BNE		SW_NotBoundary
	
	STMFD		R13!,{R0,R1}
		STMFD		R13!,{PC}
	B		asmS9xSetByte
		MOV		R0,R0
	LDMFD		R13!,{R0,R1}	
	ADD		R0,R0,#1
	MOV		R1,R1,LSR #8
		STMFD		R13!,{PC}
	B		asmS9xSetByte
		MOV		R0,R0
	
	LDMFD		R13!,{PC}
	
SW_NotBoundary:	
	
	@MOV		R2,#0
	@STR		R2,[reg_cpu_var,#WaitAddress_ofs]
	bic		rstatus, rstatus, #MASK_SHUTDOWN

	@ 	
	@ R3 <= block				
	MOV		R3,R0,LSR #MEMMAP_SHIFT
	@ MEMMAP_SHIFT is 12, Address is 0xFFFFFFFF at max, so
	@ R1 is maxed by 0x000FFFFF, MEMMAP_MASK is 0x1000-1=0xFFF
	@ so AND MEMMAP_MASK is BIC 0xFF000
	BIC		R3,R3,#0xFF000
	@ R2 <= Map[block] (SetAddress)
	LDR		R2,[reg_cpu_var,#WriteMap_ofs]
	LDR		R2,[R2,R3,LSL #2]
	CMP		R2,#MAP_LAST
	BLO		SWSpecial  @ special
	@  Direct ROM/RAM acess		
	
	
	@ check if address is 16bits aligned or not
	TST		R0,#1
	BNE		SW_not_aligned1
	@ aligned
	@MOV		R0,R0,LSL #16
	bic		r0, r0, #0xff0000		
	@ADD		R2,R2,R0,LSR #16	@ address & 0xFFFF + SetAddress
	add		r2, r2, r0	
	LDR		R0,[reg_cpu_var,#MemorySpeed_ofs]
	@ Set word
	STRH		R1,[R2]		
	@ R1 <= MemorySpeed[block]
	LDR		R0,[R0,R3, lsl #2]
	@ Update CPU.Cycles
	ADD		reg_cycles,reg_cycles,R0, LSL #1
	@ CPUShutdown
	@ only SA1 here : TODO	
	@ Return
	LDMFD		R13!,{PC}
	
SW_not_aligned1:	
	@ R1 = (Address&0xFFFF)<<16
	MOV		R0,R0,LSL #16		
	@ First write @address
	STRB		R1,[R2,R0,LSR #16]
	ADD		R0,R0,#0x10000
	MOV		R1,R1,LSR #8
	@ Second write @address+1
	STRB		R1,[R2,R0,LSR #16]	
	@ R1 <= MemorySpeed[block]
	LDR		R0,[reg_cpu_var,#MemorySpeed_ofs]
	LDR		R0,[R0,R3, lsl #2]	
	@ Update CPU.Cycles
	ADD		reg_cycles,reg_cycles,R0,LSL #1
	@ CPUShutdown
	@ only SA1 here : TODO	
	@ Return
	LDMFD		R13!,{PC}
SWSpecial:
	LDR		PC,[PC,R2,LSL #2]
	MOV		R0,R0 		@ nop, for align
	.long SWPPU
	.long SWCPU
	.long SWDSP
	.long SWLSRAM
	.long SWHSRAM
	.long SWNONE
	.long SWDEBUG
	.long SWC4
	.long SWBWRAM
	.long SWNONE
	.long SWNONE
	.long SWNONE
	/*.long SW7ROM
	.long SW7RAM
	.long SW7SRM*/
SWPPU:
	@ InDMA ?
	LDRB		R2,[reg_cpu_var,#InDMA_ofs]
	@MOV		R0,R0,LSL #16	
	bic		r0, r0, #0xff0000			
	MOVS		R2,R2	
	ADDEQ		reg_cycles,reg_cycles,#(ONE_CYCLE*2)		@ No -> update Cycles
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs]	@ Save Cycles
	@MOV		R0,R0,LSR #16
	MOV		R2,R1
	MOV		R1,R0
	MOV		R0,R2
		PREPARE_C_CALL_R0R1
	BL		S9xSetPPU		
	LDMFD		R13!,{R0,R1}
	ADD		R1,R1,#1
	MOV		R0,R0,LSR #8	
	BIC		R1,R1,#0x10000		
	BL		S9xSetPPU		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SWCPU:	
	ADD		reg_cycles,reg_cycles,#(ONE_CYCLE*2)	@ update Cycles	
	@MOV		R0,R0,LSL #16 
	bic		r0, r0, #0xff0000			
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16	@ Address&0xFFFF
	MOV		R2,R1
	MOV		R1,R0
	MOV		R0,R2	
		PREPARE_C_CALL_R0R1
	BL		S9xSetCPU		
	LDMFD		R13!,{R0,R1}
	ADD		R1,R1,#1
	MOV		R0,R0,LSR #8	
	BIC		R1,R1,#0x10000		
	BL		S9xSetCPU		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SWDSP:
	ADD		reg_cycles,reg_cycles,#SLOW_ONE_CYCLE	@ update Cycles	
	@MOV		R0,R0,LSL #16 
	bic		r0, r0, #0x0ff0000		
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16	@ Address&0xFFFF
	MOV		R2,R1
	MOV		R1,R0
	MOV		R0,R2
	ldr		reg_cycles, [reg_cpu_var, #DSPSet_ofs]
		PREPARE_C_CALL_R0R1
	blx		reg_cycles
	@BL		S9xSetDSP	
	LDMFD		R13!,{R0,R1}
	ADD		R1,R1,#1
	MOV		R0,R0,LSR #8	
	BIC		R1,R1,#0x10000
	blx		reg_cycles	
	@BL		S9xSetDSP		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SWLSRAM:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles		
	LDR		R2,[reg_cpu_var,#SRAMMask]
	MOVS		R2,R2
	LDMEQFD		R13!,{PC} @ return if SRAMMask=0
			
	AND		R3,R2,R0		@ Address&SRAMMask
	TST		R0,#1
	BNE		SW_not_aligned2
	@ aligned	
	LDR		R0,[reg_cpu_var,#SRAM]	
	STRH		R1,[R0,R3]		@ *Memory.SRAM + Address&SRAMMask		
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	LDMFD		R13!,{PC}  @ return	
SW_not_aligned2:	

	ADD		R0,R0,#1
	AND		R2,R2,R0		@ (Address+1)&SRAMMask		
	LDR		R0,[reg_cpu_var,#SRAM]	
	STRB		R1,[R0,R3]		@ *Memory.SRAM + Address&SRAMMask
	MOV		R1,R1,LSR #8
	STRB		R1,[R0,R2]		@ *Memory.SRAM + (Address+1)&SRAMMask	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	LDMFD		R13!,{PC}  @ return
SW7SRM:	
SWHSRAM:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles		
	
	LDR		R2,[reg_cpu_var,#SRAMMask]
	MOVS		R2,R2
	LDMEQFD		R13!,{PC} @ return if SRAMMask=0
	
	TST		R0,#1
	BNE		SW_not_aligned3	
	@ aligned
	MOV		R3,R0,LSL #17  
	AND		R2,R0,#0xF0000
	MOV		R3,R3,LSR #17	@ Address&0x7FFF	
	MOV		R2,R2,LSR #3 @ (Address&0xF0000 >> 3)	
	ADD		R0,R2,R3				
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000 + ((Address & 0xf0000) >> 3))
	LDR		R2,[reg_cpu_var,#SRAMMask]
	LDR		R3,[reg_cpu_var,#SRAM]	
	AND		R0,R2,R0		@ Address&SRAMMask	
	STRH		R1,[R0,R3]		@ *Memory.SRAM + Address&SRAMMask	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	LDMFD		R13!,{PC}	@ return		
SW_not_aligned3:	
	MOV		R3,R0,LSL #17  
	AND		R2,R0,#0xF0000
	MOV		R3,R3,LSR #17	@ Address&0x7FFF	
	MOV		R2,R2,LSR #3 @ (Address&0xF0000 >> 3)	
	ADD		R2,R2,R3				
	SUB		R2,R2,#0x6000 @ ((Address & 0x7fff) - 0x6000 + ((Address & 0xf0000) >> 3))
	
	ADD		R0,R0,#1	
	MOV		R3,R0,LSL #17  
	AND		R0,R0,#0xF0000
	MOV		R3,R3,LSR #17	@ (Address+1)&0x7FFF	
	MOV		R0,R0,LSR #3 @ ((Address+1)&0xF0000 >> 3)	
	ADD		R0,R0,R3	
	LDR		R3,[reg_cpu_var,#SRAMMask]	@ reload mask	
	SUB		R0,R0,#0x6000 @ (((Address+1) & 0x7fff) - 0x6000 + (((Address+1) & 0xf0000) >> 3))		
	AND		R2,R3,R2		@ Address...&SRAMMask	
	AND		R0,R3,R0		@ (Address+1...)&SRAMMask	
	
	LDR		R3,[reg_cpu_var,#SRAM]
	STRB		R1,[R2,R3]		@ *Memory.SRAM + (Address...)&SRAMMask
	MOV		R1,R1,LSR #8
	STRB		R1,[R0,R3]		@ *Memory.SRAM + (Address+1...)&SRAMMask
	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]		
	LDMFD		R13!,{PC}	@ return	
SW7ROM:
SW7RAM:	
SWNONE:	
SWDEBUG:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles
	LDMFD		R13!,{PC}	@ return
SWC4:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles	
	@MOV		R0,R0,LSL #16 
	bic		r0, r0, #0xff0000			
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Save Cycles
	@MOV		R0,R0,LSR #16	@ Address&0xFFFF	
	MOV		R2,R1
	MOV		R1,R0
	MOV		R0,R2
		PREPARE_C_CALL_R0R1
	BL		S9xSetC4		
	LDMFD		R13!,{R0,R1}	
	ADD		R1,R1,#1
	MOV		R0,R0,LSR #8	
	BIC		R1,R1,#0x10000		
	BL		S9xSetC4		
		RESTORE_C_CALL
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs] @ Load Cycles	
	LDMFD		R13!,{PC} @ Return
SWBWRAM:
	ADD		reg_cycles,reg_cycles,#(SLOW_ONE_CYCLE*2)	@ update Cycles
	TST		R0,#1
	BNE		SW_not_aligned4
	@ aligned
	MOV		R0,R0,LSL #17		
	LDR		R2,[reg_cpu_var,#BWRAM]
	MOV		R0,R0,LSR #17	@ Address&0x7FFF			
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000)	
	MOV		R3,#1
	STRH		R1,[R0,R2]		@ *Memory.BWRAM + ((Address & 0x7fff) - 0x6000)			
	STRB		R3,[reg_cpu_var,#SRAMModified_ofs]			
	LDMFD		R13!,{PC}	@ return
SW_not_aligned4:
	MOV		R0,R0,LSL #17	
	ADD		R3,R0,#0x20000
	MOV		R0,R0,LSR #17	@ Address&0x7FFF
	MOV		R3,R3,LSR #17	@ (Address+1)&0x7FFF
	LDR		R2,[reg_cpu_var,#BWRAM]	
	SUB		R0,R0,#0x6000 @ ((Address & 0x7fff) - 0x6000)
	SUB		R3,R3,#0x6000 @ (((Address+1) & 0x7fff) - 0x6000)
	STRB		R1,[R2,R0]		@ *Memory.BWRAM + ((Address & 0x7fff) - 0x6000)
	MOV		R1,R1,LSR #8
	STRB		R1,[R2,R3]		@ *Memory.BWRAM + (((Address+1) & 0x7fff) - 0x6000)	
	MOV		R0,#1
	STRB		R0,[reg_cpu_var,#SRAMModified_ofs]			
	LDMFD		R13!,{PC}		@ return
	




