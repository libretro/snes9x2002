asm_S9xSetPCBase:
	.file 1 "os9x_asm_cpu.cpp"
	.loc 1 16 0
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0


	MOV		R1,R0,LSR #MEMMAP_SHIFT
	@ MEMMAP_SHIFT is 12, Address is 0xFFFFFFFF at max, so
	@ R1 is maxed by 0x000FFFFF, MEMMAP_MASK is 0x1000-1=0xFFF
	@ so AND MEMMAP_MASK is BIC 0xFF000
	BIC		R1,R1,#0xFF000
	bic	r0, r0, #0xff0000

	@ R2 <= Map[block] (GetAddress)
	LDR		R2,[reg_cpu_var,#Map_ofs]

	LDR		R2,[R2,R1,LSL #2]
	CMP		R2,#MAP_LAST
	BLO		SPCSpecial  @ special

	mov	regpcbase, r2
	add	rpc, r2, r0
	str	rpc, [reg_cpu_var, #PC_ofs]
	str	regpcbase, [reg_cpu_var, #PCBase_ofs]

	bx	r3
	

SPCSpecial:

	LDR		PC,[PC,R2,LSL #2]
	MOV		R0,R0 		@ nop, for align

	.long	SPC_PPU
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
	.long	SPCDefault
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
.equ	_fillram, 20

SPC_PPU:
	@CPU.PCBase = Memory.FillRAM - 0x2000;
	@CPU.PC = CPU.PCBase + (Address & 0xffff);

	ldr	r1, vMemory
	ldr	r2, [r1, #_fillram]
	sub	r2, r2, #0x2000

	mov	regpcbase, r2
	add	rpc, r2, r0
	str	rpc, [reg_cpu_var, #PC_ofs]
	str	regpcbase, [reg_cpu_var, #PCBase_ofs]
	
	@return;
	bx 	r3
	@-------------------

SPCDefault:
	bx	r3
