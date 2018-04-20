/****************************************************************
	DEFINES
****************************************************************/

.equ MAP_LAST,	12

rstatus 	.req R4  @ format : 0xff800000
reg_d_bank	.req R4  @ format : 0x000000ll
reg_a		.req R5  @ format : 0xhhll0000 or 0xll000000
reg_d		.req R6  @ format : 0xhhll0000
reg_p_bank	.req R6  @ format : 0x000000ll
reg_x		.req R7  @ format : 0xhhll0000 or 0xll000000
reg_s		.req R8  @ format : 0x0000hhll
reg_y		.req R9  @ format : 0xhhll0000 or 0xll000000

rpc	    	.req R10 @ 32bits address
reg_cycles	.req R11 @ 32bits counter
regpcbase	.req R12 @ 32bits address

rscratch	.req R0  @ format : 0xhhll0000 if data and calculation or return of S9XREADBYTE	or WORD
regopcode	.req R0  @ format : 0x000000ll
rscratch2	.req R1  @ format : 0xhhll for calculation and value
rscratch3	.req R2  @ 
rscratch4	.req R3  @ ??????

@ used for SBC opcode
rscratch9	.req R10 @ ??????

reg_cpu_var .req R14



@ not used
@ R13	@ Pointer 32 bit on a struct.

@ R15 = pc (sic!)


/*
.equ Carry       1
.equ Zero        2
.equ IRQ         4
.equ Decimal     8
.equ IndexFlag  16
.equ MemoryFlag 32
.equ Overflow   64
.equ Negative  128
.equ Emulation 256*/

.equ STATUS_SHIFTER,		24
.equ MASK_APU_EXECUTING,(1<<(STATUS_SHIFTER-4))
.equ MASK_SHUTDOWN,	(1<<(STATUS_SHIFTER-3))
.equ MASK_BRANCHSKIP,	(1<<(STATUS_SHIFTER-2))
.equ MASK_EMUL,		(1<<(STATUS_SHIFTER-1))
.equ MASK_SHIFTER_CARRY,	(STATUS_SHIFTER+1)
.equ	MASK_CARRY,		(1<<(STATUS_SHIFTER))  @ 0
.equ	MASK_ZERO,		(2<<(STATUS_SHIFTER))  @ 1
.equ MASK_IRQ,		(4<<(STATUS_SHIFTER))  @ 2
.equ MASK_DECIMAL,		(8<<(STATUS_SHIFTER))  @ 3
.equ	MASK_INDEX,		(16<<(STATUS_SHIFTER)) @ 4  @ 1
.equ	MASK_MEM,		(32<<(STATUS_SHIFTER)) @ 5  @ 2
.equ	MASK_OVERFLOW,		(64<<(STATUS_SHIFTER)) @ 6  @ 4
.equ	MASK_NEG,		(128<<(STATUS_SHIFTER))@ 7  @ 8

.equ ONE_CYCLE, 6
.equ SLOW_ONE_CYCLE, 8
.equ NOSA1, 1

.equ	NMI_FLAG,	    (1 << 7)
.equ IRQ_PENDING_FLAG,    (1 << 11)
.equ SCAN_KEYS_FLAG,	    (1 << 4)


.equ MEMMAP_BLOCK_SIZE, (0x1000)
.equ MEMMAP_SHIFT, 12
.equ MEMMAP_MASK, (0xFFF)

.equ MEMSPEED_MASK, (0xF0000)
.equ MEMSPEED_SHIFT, 16

/****************************************************************
	MACROS
****************************************************************/

@ #include "os9x_65c816_mac_gen.h"
/*****************************************************************/
/*     Offset in SCPUState structure				 */
/*****************************************************************/
.equ Flags_ofs,		    0    
.equ BranchSkip_ofs,	4
.equ NMIActive_ofs,		5
.equ IRQActive_ofs,		6
.equ WaitingForInterrupt_ofs,	7

.equ	RPB_ofs,		8
.equ	RDB_ofs,		9
.equ	RP_ofs,		    10
.equ	RA_ofs,		    12
.equ    RAH_ofs,	    13
.equ	RD_ofs,		    14
.equ	RX_ofs,		    16
.equ	RS_ofs,		    18
.equ	RY_ofs,		    20
@.equ	RPC_ofs,		22
   
.equ PC_ofs,			24
.equ Cycles_ofs,		28
.equ PCBase_ofs,		32

.equ PCAtOpcodeStart_ofs,	36
.equ WaitAddress_ofs,		40
.equ WaitCounter_ofs,		44
.equ NextEvent_ofs,		    48
.equ V_Counter_ofs,		    52
.equ MemSpeed_ofs,		    56
.equ MemSpeedx2_ofs,		60
.equ FastROMSpeed_ofs,	    64
.equ AutoSaveTimer_ofs,	    68
.equ NMITriggerPoint_ofs,	72
.equ NMICycleCount_ofs,	    76
.equ IRQCycleCount_ofs,	    80

.equ InDMA_ofs,		        84
.equ WhichEvent,		    85
.equ SRAMModified_ofs,	    86
.equ BRKTriggered_ofs,	    87
.equ	asm_OPTABLE_ofs,		88
.equ TriedInterleavedMode2_ofs,	92

.equ Map_ofs,		    96
.equ WriteMap_ofs,      100
.equ MemorySpeed_ofs,   104
.equ BlockIsRAM_ofs,    108
.equ SRAM, 		        112
.equ BWRAM,             116
.equ SRAMMask,          120

.equ	APUExecuting_ofs,   124

.equ	PALMOS_R9_ofs, 	    132
.equ	PALMOS_R10_ofs, 	136

@ notaz
.equ	APU_Cycles, 	    140

.equ	DSPGet_ofs,	144
.equ	DSPSet_ofs, 148
.equ	rstatus_ofs, 152

/*****************************************************************/
/*     Offset in CMemory structure				 */
/*****************************************************************/
.equ	_sram, 		12
.equ	_bwram,		16
.equ	_fillram, 	20
.equ	_c4ram,		24

/*****************************************************************/

/* prepare */
.macro		PREPARE_C_CALL
	STMFD	R13!,{R12,R14}	
.endm
.macro		PREPARE_C_CALL_R0
	STMFD	R13!,{R0,R12,R14}	
.endm
.macro		PREPARE_C_CALL_R0R1
	STMFD	R13!,{R0,R1,R12,R14}		
.endm
.macro		PREPARE_C_CALL_LIGHT
	STMFD	R13!,{R14}
.endm
.macro		PREPARE_C_CALL_LIGHTR12
	STMFD	R13!,{R12,R14}
.endm
/* restore */
.macro		RESTORE_C_CALL
	LDMFD	R13!,{R12,R14}
.endm
.macro		RESTORE_C_CALL_R0
	LDMFD	R13!,{R0,R12,R14}
.endm
.macro		RESTORE_C_CALL_R1
	LDMFD	R13!,{R1,R12,R14}
.endm
.macro		RESTORE_C_CALL_LIGHT
	LDMFD	R13!,{R14}
.endm
.macro		RESTORE_C_CALL_LIGHTR12
	LDMFD	R13!,{R12,R14}
.endm


@ --------------

.macro		LOAD_REGS
    @ notaz
    add     r0,reg_cpu_var,#8
    ldmia   r0,{r1,reg_a,reg_x,reg_y,rpc,reg_cycles,regpcbase}
    @ rstatus (P) & reg_d_bank
    mov     reg_d_bank,r1,lsl #16
    mov     reg_d_bank,reg_d_bank,lsr #24
    mov     r0,r1,lsr #16
	orrs	rstatus, rstatus, r0,lsl #STATUS_SHIFTER @ 24
	@ if Carry set, then EMULATION bit was set
	orrcs	rstatus,rstatus,#MASK_EMUL	
    @ reg_d & reg_p_bank
    mov     reg_d,reg_a,lsr #16
    mov     reg_d,reg_d,lsl #8
    orr     reg_d,reg_d,r1,lsl #24
    mov     reg_d,reg_d,ror #24    @ 0xdddd00pb
    @ reg_x, reg_s
    mov     reg_s,reg_x,lsr #16
	@ Shift X,Y & A according to the current mode (INDEX, MEMORY bits)
	tst		rstatus,#MASK_INDEX
	movne	reg_x,reg_x,lsl #24
	movne	reg_y,reg_y,lsl #24
	moveq	reg_x,reg_x,lsl #16
	moveq	reg_y,reg_y,lsl #16
	tst		rstatus,#MASK_MEM
	movne	reg_a,reg_a,lsl #24
	moveq	reg_a,reg_a,lsl #16
	
	@-- load MemSpeed into rstatus
	ldr	r0, [reg_cpu_var, #MemSpeed_ofs]	
	bic	rstatus, rstatus, #MEMSPEED_MASK
	orr	rstatus, rstatus, r0, lsl #MEMSPEED_SHIFT
	
	@-- load BranchSpkip into rstatus
	ldrb	r0, [reg_cpu_var, #BranchSkip_ofs]
	movs	r0, r0
	biceq	rstatus, rstatus, #MASK_BRANCHSKIP
	orrne	rstatus, rstatus, #MASK_BRANCHSKIP
	
	@-- load Shutdown
	ldr	r0, [reg_cpu_var, #WaitAddress_ofs]
	movs	r0, r0
	biceq	rstatus, rstatus, #MASK_SHUTDOWN
	orrne	rstatus, rstatus, #MASK_SHUTDOWN
		

/*
    @ reg_d & reg_p_bank share the same register
	LDRB		reg_p_bank,[reg_cpu_var,#RPB_ofs]
	LDRH		rscratch,[reg_cpu_var,#RD_ofs]
	ORR		reg_d,reg_d,rscratch, LSL #16	
	@ rstatus & reg_d_bank share the same register
	LDRB		reg_d_bank,[reg_cpu_var,#RDB_ofs]
	LDRH		rscratch,[reg_cpu_var,#RP_ofs]	
	ORRS		rstatus, rstatus, rscratch,LSL #STATUS_SHIFTER @ 24
	@ if Carry set, then EMULATION bit was set
	ORRCS		rstatus,rstatus,#MASK_EMUL	
	@ 
	LDRH		reg_a,[reg_cpu_var,#RA_ofs]		
	LDRH		reg_x,[reg_cpu_var,#RX_ofs]
	LDRH		reg_y,[reg_cpu_var,#RY_ofs]
	LDRH		reg_s,[reg_cpu_var,#RS_ofs]
	@ Shift X,Y & A according to the current mode (INDEX, MEMORY bits)
	TST		rstatus,#MASK_INDEX
	MOVNE		reg_x,reg_x,LSL #24
	MOVNE		reg_y,reg_y,LSL #24
	MOVEQ		reg_x,reg_x,LSL #16
	MOVEQ		reg_y,reg_y,LSL #16
	TST		rstatus,#MASK_MEM
	MOVNE		reg_a,reg_a,LSL #24
	MOVEQ		reg_a,reg_a,LSL #16
	
	LDR		regpcbase,[reg_cpu_var,#PCBase_ofs]
	LDR		rpc,[reg_cpu_var,#PC_ofs]	
	LDR		reg_cycles,[reg_cpu_var,#Cycles_ofs]
*/
.endm


.macro		SAVE_REGS
    @-- Save Shutdown flag
	tst	rstatus, #MASK_BRANCHSKIP
	moveq	r0, #0
	movne	r0, #1
	str	r0, [reg_cpu_var, #WaitAddress_ofs]

    @-- Save BranchSkip flag
	tst	rstatus, #MASK_BRANCHSKIP
	moveq	r0, #0
	movne	r0, #1
	strb	r0, [reg_cpu_var, #BranchSkip_ofs]
	
    @-- Save MemSpeed2x for compatibility with other cores
	ldr	r0, [reg_cpu_var, #MemSpeed_ofs]
	mov	r0, r0, lsl #1
	str	r0, [reg_cpu_var, #MemSpeedx2_ofs]

    @ notaz
    @ reg_p_bank, reg_d_bank and rstatus
    mov 	r1, rstatus, lsr #16
    orr     r1, r1, reg_p_bank, lsl #24
	movs	r1, r1, lsr #8
	orrcs	r1, r1, #0x100 @ EMULATION bit
    orr     r1, r1, reg_d_bank, lsl #24
    mov     r1, r1, ror #16
    @ reg_a, reg_d
	tst		rstatus,#MASK_MEM
	ldrneh	r0, [reg_cpu_var,#RA_ofs]
	bicne	r0, r0,#0xFF
	orrne	reg_a, r0, reg_a,lsr #24	
	moveq	reg_a, reg_a, lsr #16
    mov     reg_d, reg_d, lsr #16
	orr  	reg_a, reg_a, reg_d, lsl #16
	@ Shift X&Y according to the current mode (INDEX, MEMORY bits)
	tst		rstatus,#MASK_INDEX
	movne	reg_x,reg_x,LSR #24
	movne	reg_y,reg_y,LSR #24
	moveq	reg_x,reg_x,LSR #16
	moveq	reg_y,reg_y,LSR #16
    @ reg_x, reg_s
	orr  	reg_x, reg_x, reg_s, lsl #16
    @ store
    add     r0,reg_cpu_var,#8
    stmia   r0,{r1,reg_a,reg_x,reg_y,rpc,reg_cycles,regpcbase}

/*
    @ reg_d & reg_p_bank is same register
	STRB		reg_p_bank,[reg_cpu_var,#RPB_ofs]
	MOV		rscratch,reg_d, LSR #16
	STRH		rscratch,[reg_cpu_var,#RD_ofs]
	@ rstatus & reg_d_bank is same register
	STRB		reg_d_bank,[reg_cpu_var,#RDB_ofs]
	MOVS		rscratch, rstatus, LSR #STATUS_SHIFTER  
	ORRCS		rscratch,rscratch,#0x100 @ EMULATION bit
	STRH		rscratch,[reg_cpu_var,#RP_ofs]
	@ 
	@ Shift X,Y & A according to the current mode (INDEX, MEMORY bits)
	TST		rstatus,#MASK_INDEX
	MOVNE		rscratch,reg_x,LSR #24
	MOVNE		rscratch2,reg_y,LSR #24
	MOVEQ		rscratch,reg_x,LSR #16
	MOVEQ		rscratch2,reg_y,LSR #16
	STRH		rscratch,[reg_cpu_var,#RX_ofs]
	STRH		rscratch2,[reg_cpu_var,#RY_ofs]
	TST		rstatus,#MASK_MEM
	LDRNEH		rscratch,[reg_cpu_var,#RA_ofs]
	BICNE		rscratch,rscratch,#0xFF
	ORRNE		rscratch,rscratch,reg_a,LSR #24	
	MOVEQ		rscratch,reg_a,LSR #16
	STRH		rscratch,[reg_cpu_var,#RA_ofs]
	
	STRH		reg_s,[reg_cpu_var,#RS_ofs]	
	STR		regpcbase,[reg_cpu_var,#PCBase_ofs]
	STR		rpc,[reg_cpu_var,#PC_ofs]
	
	STR		reg_cycles,[reg_cpu_var,#Cycles_ofs]
*/
.endm

/*****************************************************************/
.macro		ADD1CYCLE		
		add	reg_cycles,reg_cycles, #ONE_CYCLE		
.endm
.macro		ADD1CYCLENE
		addne	reg_cycles,reg_cycles, #ONE_CYCLE		
.endm		
.macro		ADD1CYCLEEQ
		addeq	reg_cycles,reg_cycles, #ONE_CYCLE		
.endm		

.macro		ADD2CYCLE
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*2)
.endm
.macro		ADD2CYCLENE
		addne	reg_cycles,reg_cycles, #(ONE_CYCLE*2)
.endm
.macro		ADD2CYCLE2MEM		
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*2)
		@add	reg_cycles, reg_cycles, rscratch, LSL #1
		add	reg_cycles, reg_cycles, rscratch, LSR #(MEMSPEED_SHIFT - 1)		
.endm
.macro		ADD2CYCLE1MEM
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*2)
		@add	reg_cycles, reg_cycles, rscratch
		add	reg_cycles, reg_cycles, rscratch, LSR #MEMSPEED_SHIFT		
.endm

.macro		ADD3CYCLE
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*3)
.endm

.macro		ADD1CYCLE1MEM
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #ONE_CYCLE
		@add	reg_cycles, reg_cycles, rscratch
		add	reg_cycles, reg_cycles, rscratch, LSR #MEMSPEED_SHIFT		
.endm

.macro		ADD1CYCLE2MEM
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #ONE_CYCLE
		@add	reg_cycles, reg_cycles, rscratch, LSL #1
		add	reg_cycles, reg_cycles, rscratch, LSR #(MEMSPEED_SHIFT - 1)		
.endm

.macro		ADD1MEM
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		@add	reg_cycles, reg_cycles, rscratch
		add	reg_cycles, reg_cycles, rscratch, LSR #MEMSPEED_SHIFT		
.endm
			
.macro		ADD2MEM
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		@add	reg_cycles, reg_cycles, rscratch, LSL #1
		add	reg_cycles, reg_cycles, rscratch, LSR #(MEMSPEED_SHIFT - 1)		
.endm
			
.macro		ADD3MEM
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		@add	reg_cycles, reg_cycles, rscratch
		add	reg_cycles, reg_cycles, rscratch, LSR #MEMSPEED_SHIFT		
		@add	reg_cycles, reg_cycles, rscratch, LSL #1
		add	reg_cycles, reg_cycles, rscratch, LSR #(MEMSPEED_SHIFT - 1)		
.endm

/**************/
/*****************************************************************/
.macro		ADD1CYCLENEX x
		addne	reg_cycles,reg_cycles, #(ONE_CYCLE+(NOSA1*\x))		
.endm		
.macro		ADD1CYCLEEQX x
		addeq	reg_cycles,reg_cycles, #(ONE_CYCLE+(NOSA1*\x))		
.endm		
.macro		ADD2CYCLENEX x
		addne	reg_cycles,reg_cycles, #(ONE_CYCLE*2+(NOSA1*\x))
.endm

.macro		ADD1CYCLEX x		
		add	reg_cycles,reg_cycles, #(ONE_CYCLE+(NOSA1*\x))		
.endm
.macro		ADD2CYCLEX x
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*2+(NOSA1*\x))
.endm
.macro		ADD2CYCLE2MEMX x		
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*2+(NOSA1*\x))
		@add	reg_cycles, reg_cycles, rscratch, LSL #1
		add	reg_cycles, reg_cycles, rscratch, LSR #(MEMSPEED_SHIFT - 1)		
.endm
.macro		ADD2CYCLE1MEMX x
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*2+(NOSA1*\x))
		@add	reg_cycles, reg_cycles, rscratch
		add	reg_cycles, reg_cycles, rscratch, LSR #MEMSPEED_SHIFT		
.endm

.macro		ADD3CYCLEX x
		add	reg_cycles,reg_cycles, #(ONE_CYCLE*3+(NOSA1*\x))
.endm

.macro		ADD1CYCLE1MEMX x
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #(ONE_CYCLE+(NOSA1*\x))
		@add	reg_cycles, reg_cycles, rscratch
		add	reg_cycles, reg_cycles, rscratch, LSR #MEMSPEED_SHIFT		
.endm

.macro		ADD1CYCLE2MEMX x
		@ldr	rscratch,[reg_cpu_var,#MemSpeed_ofs]
		and	rscratch, rstatus, #MEMSPEED_MASK
		add	reg_cycles,reg_cycles, #(ONE_CYCLE+(NOSA1*\x))
		@add	reg_cycles, reg_cycles, rscratch, LSL #1
		add	reg_cycles, reg_cycles, rscratch, LSR #(MEMSPEED_SHIFT - 1)		
.endm

/**************/

.macro		ClearDecimal
		BIC	rstatus,rstatus,#MASK_DECIMAL	
.endm			
.macro		SetDecimal
		ORR	rstatus,rstatus,#MASK_DECIMAL	
.endm
.macro		SetIRQ
		ORR	rstatus,rstatus,#MASK_IRQ
.endm						
.macro		ClearIRQ
		BIC	rstatus,rstatus,#MASK_IRQ
.endm

.macro		CPUShutdown
@ if (Settings.Shutdown && CPU.PC == CPU.WaitAddress)
		tst	rstatus, #MASK_SHUTDOWN
		beq	5431f		
		LDR		rscratch,[reg_cpu_var,#WaitAddress_ofs]
		CMP		rpc,rscratch
		BNE		5431f
@ if (CPU.WaitCounter == 0 && !(CPU.Flags & (IRQ_PENDING_FLAG | NMI_FLAG)))		
		LDR		rscratch,[reg_cpu_var,#Flags_ofs]
		LDR		rscratch2,[reg_cpu_var,#WaitCounter_ofs]
		TST		rscratch,#(IRQ_PENDING_FLAG|NMI_FLAG)
		@BNE		5432f		
		@MOVS		rscratch2,rscratch2
		MOVEQS		rscratch2,rscratch2
		BNE		5432f
@ CPU.WaitAddress = NULL;		
		@MOV		rscratch,#0
		@STR		rscratch,[reg_cpu_var,#WaitAddress_ofs]
		bic		rstatus, rstatus, #MASK_SHUTDOWN
@ if (Settings.SA1)
@ 		S9xSA1ExecuteDuringSleep ();		: TODO
		
@ 	    CPU.Cycles = CPU.NextEvent;
		LDR		reg_cycles,[reg_cpu_var,#NextEvent_ofs]
		@LDR		r0,[reg_cpu_var,#APUExecuting_ofs]
		@MOVS		r0,r0
		@BEQ		5431f
@ 	    if (IAPU.APUExecuting)
/*	    {
		ICPU.CPUExecuting = FALSE;
		do
		{
		    APU_EXECUTE1();
		} while (APU.Cycles < CPU.NextEvent);
		ICPU.CPUExecuting = TRUE;
	    }
	*/					
		asmAPU_EXECUTE2
		B		5431f
@.pool		
5432:
/*	else
	if (CPU.WaitCounter >= 2)
	    CPU.WaitCounter = 1;
	else
	    CPU.WaitCounter--;
*/
		CMP		rscratch2,#1
		MOVHI		rscratch2,#1
		@SUBLS		rscratch2,rscratch2,#1
		MOVLS		rscratch2,#0
		STR		rscratch2,[reg_cpu_var,#WaitCounter_ofs]
5431:		

.endm						
.macro		BranchCheck0	
		/*in rsctach : OpAddress
		/*destroy rscratch2*/
		tst	rstatus, #MASK_BRANCHSKIP
		@beq	1110f
		bicne	rstatus, rstatus, #MASK_BRANCHSKIP
		subne	rscratch2, rpc, regpcbase
		cmpne	rscratch2, rscratch 
		bhi	1111f	
		
		@LDRB	rscratch2,[reg_cpu_var,#BranchSkip_ofs]
		@MOVS	rscratch2,rscratch2	
		@BEQ	1110f
		@MOV	rscratch2,#0		
		@STRB	rscratch2,[reg_cpu_var,#BranchSkip_ofs]
		@SUB	rscratch2,rpc,regpcbase
		@ if( CPU.PC - CPU.PCBase > OpAddress) return;
		@CMP	rscratch2,rscratch
		@BHI	1111f
1110:		
.endm									
.macro		BranchCheck1		
		/*in rsctach : OpAddress
		/*destroy rscratch2*/
		tst	rstatus, #MASK_BRANCHSKIP
		@beq	1110f
		bicne	rstatus, rstatus, #MASK_BRANCHSKIP
		subne	rscratch2, rpc, regpcbase
		cmpne	rscratch2, rscratch 
		bhi	1111f	

		@LDRB	rscratch2,[reg_cpu_var,#BranchSkip_ofs]
		@MOVS	rscratch2,rscratch2	
		@BEQ	1110f
		@MOV	rscratch2,#0		
		@STRB	rscratch2,[reg_cpu_var,#BranchSkip_ofs]
		@SUB	rscratch2,rpc,regpcbase
		@ if( CPU.PC - CPU.PCBase > OpAddress) return;
		@CMP	rscratch2,rscratch
		@BHI	1111f
1110:
.endm												
.macro		BranchCheck2
		/*in rsctach : OpAddress
		/*destroy rscratch2*/
		tst	rstatus, #MASK_BRANCHSKIP
		@beq	1110f
		bicne	rstatus, rstatus, #MASK_BRANCHSKIP
		subne	rscratch2, rpc, regpcbase
		cmpne	rscratch2, rscratch 
		bhi	1111f	

		@LDRB	rscratch2,[reg_cpu_var,#BranchSkip_ofs]
		@MOVS	rscratch2,rscratch2	
		@BEQ	1110f
		@MOV	rscratch2,#0		
		@STRB	rscratch2,[reg_cpu_var,#BranchSkip_ofs]
		@SUB	rscratch2,rpc,regpcbase
		@ if( CPU.PC - CPU.PCBase > OpAddress) return;
		@CMP	rscratch2,rscratch
		@BHI	1111f
	1110:		
.endm
			
.macro		S9xSetPCBase
		@  in  : rscratch (0x00hhmmll)				
		@PREPARE_C_CALL			
		@BL	asm_S9xSetPCBase		
		@RESTORE_C_CALL
		@LDR	rpc,[reg_cpu_var,#PC_ofs]
		@LDR	regpcbase,[reg_cpu_var,#PCBase_ofs]
		mov	r3, pc		@ r3 = return address
		b	asmS9xSetPCBase
		@return address
.endm		

.macro		S9xFixCycles
		TST		rstatus,#MASK_EMUL
		LDRNE		rscratch, = jumptable1	   @ Mode 0 : M=1,X=1
		BNE		991111f
		@ EMULATION=0
		TST		rstatus,#MASK_MEM
		BEQ		991112f
		@ MEMORY=1
		TST		rstatus,#MASK_INDEX
		@ INDEX=1  @ Mode 0 : M=1,X=1
		LDRNE		rscratch, = jumptable1		
		@ INDEX=0  @ Mode 1 : M=1,X=0
		LDREQ		rscratch, = jumptable2
		B		991111f
991112:		@ MEMORY=0		
		TST		rstatus,#MASK_INDEX
		@ INDEX=1   @ Mode 3 : M=0,X=1
		LDRNE		rscratch, = jumptable4
		@ INDEX=0   @ Mode 2 : M=0,X=0
		LDREQ		rscratch, = jumptable3		
991111:
		STR		rscratch,[reg_cpu_var,#asm_OPTABLE_ofs]
.endm		
/*
.macro		S9xOpcode_NMI
		SAVE_REGS
		PREPARE_C_CALL_LIGHT
		BL	asm_S9xOpcode_NMI
		RESTORE_C_CALL_LIGHT
		LOAD_REGS		
.endm
.macro		S9xOpcode_IRQ
		SAVE_REGS
		PREPARE_C_CALL_LIGHT
		BL	asm_S9xOpcode_IRQ
		RESTORE_C_CALL_LIGHT
		LOAD_REGS		
.endm
*/
@-->
.macro		S9xDoHBlankProcessing
		SAVE_REGS
		PREPARE_C_CALL_LIGHT
@		BL	asm_S9xDoHBlankProcessing
		BL	S9xDoHBlankProcessing @ let's go straight to number one
		RESTORE_C_CALL_LIGHT
		LOAD_REGS		
.endm

/********************************/
.macro		EXEC_OP					
		LDR		R1,[reg_cpu_var,#asm_OPTABLE_ofs]
		STR		rpc,[reg_cpu_var,#PCAtOpcodeStart_ofs]
		@ADD1MEM
		@ldr		r3, [reg_cpu_var, #MemSpeed_ofs]
		ldrb		r0, [rpc], #1		
		@add		reg_cycles, reg_cycles, r3
		and		r3, rstatus, #MEMSPEED_MASK			
		add		reg_cycles, reg_cycles, r3, lsr #MEMSPEED_SHIFT

		@LDRB		R0, [rpc], #1		
		
		LDR		PC, [R1,R0, LSL #2]
.endm
.macro		NEXTOPCODE
		LDR			rscratch,[reg_cpu_var,#NextEvent_ofs]
		CMP			reg_cycles,rscratch
		BLT			mainLoop
  		S9xDoHBlankProcessing
		B			mainLoop
		.pool
.endm

@ #include "os9x_65c816_mac_mem.h"
.macro		S9xGetWord	
		@  in  : rscratch (0x00hhmmll)
		@  out : rscratch (0xhhll0000)
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetWord
		MOV	R0,R0
		MOV	R0, R0, LSL #16
.endm
.macro		S9xGetWordLow	
		@  in  : rscratch (0x00hhmmll)
		@  out : rscratch (0x0000hhll)		
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetWord
		MOV	R0,R0		
.endm
.macro		S9xGetWordRegStatus	reg
		@  in  : rscratch (0x00hhmmll) 
		@  out : reg      (0xhhll0000)
		@  flags have to be updated with read value
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetWord
		MOV	R0,R0
		MOVS	\reg, R0, LSL #16
.endm
.macro		S9xGetWordRegNS	reg
		@  in  : rscratch (0x00hhmmll) 
		@  out : reg (0xhhll0000)
		@  DOES NOT DESTROY rscratch (R0)
		STMFD	R13!,{R0}
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetWord
		MOV	R0,R0
		MOV	\reg, R0, LSL #16
		LDMFD	R13!,{R0}
.endm			
.macro		S9xGetWordLowRegNS	reg
		@  in  : rscratch (0x00hhmmll) 
		@  out : reg (0xhhll0000)
		@  DOES NOT DESTROY rscratch (R0)
		STMFD	R13!,{R0}
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetWord
		MOV	R0,R0
		MOV	\reg, R0
		LDMFD	R13!,{R0}
.endm			

.macro		S9xGetByte 	
		@  in  : rscratch (0x00hhmmll)
		@  out : rscratch (0xll000000)
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetByte
		MOV	R0,R0
		MOV	R0, R0, LSL #24
.endm
.macro		S9xGetByteLow
		@  in  : rscratch (0x00hhmmll) 
		@  out : rscratch (0x000000ll)		
		STMFD	R13!,{PC}		
		B	asmS9xGetByte
		MOV	R0,R0
.endm
.macro		S9xGetByteRegStatus	reg
		@  in  : rscratch (0x00hhmmll)
		@  out : reg      (0xll000000)
		@  flags have to be updated with read value
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetByte
		MOV	R0,R0
		MOVS	\reg, R0, LSL #24
.endm
.macro		S9xGetByteRegNS	reg
		@  in  : rscratch (0x00hhmmll) 
		@  out : reg      (0xll000000)
		@  DOES NOT DESTROY rscratch (R0)
		STMFD	R13!,{R0}
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetByte
		MOV	R0,R0
		MOVS	\reg, R0, LSL #24
		LDMFD	R13!,{R0}
.endm
.macro		S9xGetByteLowRegNS	reg
		@  in  : rscratch (0x00hhmmll) 
		@  out : reg      (0x000000ll)
		@  DOES NOT DESTROY rscratch (R0)
		STMFD	R13!,{R0}
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xGetByte
		MOV	R0,R0
		MOVS	\reg, R0
		LDMFD	R13!,{R0}
.endm

.macro		S9xSetWord	regValue		
		@  in  : regValue  (0xhhll0000)
		@  in  : rscratch=address   (0x00hhmmll)
		MOV	R1,\regValue, LSR #16
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xSetWord
		MOV	R0,R0		
.endm
.macro		S9xSetWordZero	
		@  in  : rscratch=address   (0x00hhmmll)
		MOV	R1,#0
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xSetWord
		MOV	R0,R0		
.endm
.macro		S9xSetWordLow	regValue		
		@  in  : regValue  (0x0000hhll)
		@  in  : rscratch=address   (0x00hhmmll)
		MOV	R1,\regValue
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xSetWord
		MOV	R0,R0		
.endm
.macro		S9xSetByte	regValue
		@  in  : regValue  (0xll000000)
		@  in  : rscratch=address   (0x00hhmmll)
		MOV	R1,\regValue, LSR #24
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xSetByte
		MOV	R0,R0		
.endm
.macro		S9xSetByteZero			
		@  in  : rscratch=address   (0x00hhmmll)
		MOV	R1,#0
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xSetByte
		MOV	R0,R0		
.endm
.macro		S9xSetByteLow	regValue
		@  in  : regValue  (0x000000ll)
		@  in  : rscratch=address   (0x00hhmmll)
		MOV	R1,\regValue
		STMFD	R13!,{PC} @ Push return address
		B	asmS9xSetByte
		MOV	R0,R0
.endm

.macro		doMainLoop
	@ save registers
	STMFD		R13!,{R4-R11,LR}
	@ init pointer to CPUvar structure
	MOV		reg_cpu_var,R0
	@ init registers
	LOAD_REGS
	@ get cpu mode from flag and init jump table
	S9xFixCycles

mainLoop:
	@ APU Execute
	asmAPU_EXECUTE

	@ Test Flags
	LDR		rscratch,[reg_cpu_var,#Flags_ofs]
	MOVS		rscratch,rscratch
	BNE		CPUFlags_set	@ If flags => check for irq/nmi/scan_keys...	
	
	EXEC_OP						@ Execute next opcode
	
CPUFlags_set:	@ Check flags (!=0)
		TST	rscratch,#NMI_FLAG		@ Check NMI
		BEQ	CPUFlagsNMI_FLAG_cleared	
		LDR	rscratch2,[reg_cpu_var,#NMICycleCount_ofs]
		SUBS	rscratch2,rscratch2,#1
		STR	rscratch2,[reg_cpu_var,#NMICycleCount_ofs]		
		BNE	CPUFlagsNMI_FLAG_cleared	
		BIC	rscratch,rscratch,#NMI_FLAG
		STR	rscratch,[reg_cpu_var,#Flags_ofs]		
		LDRB	rscratch2,[reg_cpu_var,#WaitingForInterrupt_ofs]
		MOVS	rscratch2,rscratch2
		BEQ	NotCPUaitingForInterruptNMI
		MOV	rscratch2,#0
		ADD	rpc,rpc,#1
		STRB	rscratch2,[reg_cpu_var,#WaitingForInterrupt_ofs]		
NotCPUaitingForInterruptNMI:
		S9xOpcode_NMI
		LDR	rscratch,[reg_cpu_var,#Flags_ofs]	
CPUFlagsNMI_FLAG_cleared:
		TST	rscratch,#IRQ_PENDING_FLAG   @ Check IRQ_PENDING_FLAG
		BEQ	CPUFlagsIRQ_PENDING_FLAG_cleared		
		LDR	rscratch2,[reg_cpu_var,#IRQCycleCount_ofs]
		MOVS	rscratch2,rscratch2
		BNE	CPUIRQCycleCount_NotZero		
	 	LDRB	rscratch2,[reg_cpu_var,#WaitingForInterrupt_ofs]
		MOVS	rscratch2,rscratch2
		BEQ	NotCPUaitingForInterruptIRQ
		MOV	rscratch2,#0
		ADD	rpc,rpc,#1
		STRB	rscratch2,[reg_cpu_var,#WaitingForInterrupt_ofs]
NotCPUaitingForInterruptIRQ:
		LDRB	rscratch2,[reg_cpu_var,#IRQActive_ofs]
		MOVS	rscratch2,rscratch2
		BEQ	CPUIRQActive_cleared
		TST	rstatus,#MASK_IRQ
		BNE	CPUFlagsIRQ_PENDING_FLAG_cleared
		S9xOpcode_IRQ
		LDR	rscratch,[reg_cpu_var,#Flags_ofs]	
		B	CPUFlagsIRQ_PENDING_FLAG_cleared
CPUIRQActive_cleared:		
		BIC	rscratch,rscratch,#IRQ_PENDING_FLAG
		STR	rscratch,[reg_cpu_var,#Flags_ofs]	
		B	CPUFlagsIRQ_PENDING_FLAG_cleared
CPUIRQCycleCount_NotZero:
		SUB	rscratch2,rscratch2,#1
		STR	rscratch2,[reg_cpu_var,#IRQCycleCount_ofs]
CPUFlagsIRQ_PENDING_FLAG_cleared:

		TST	rscratch,#SCAN_KEYS_FLAG   @ Check SCAN_KEYS_FLAG
		BNE	endmainLoop		

	EXEC_OP	@ Execute next opcode

endmainLoop:

    /*Registers.PC = CPU.PC - CPU.PCBase;
    S9xPackStatus ();
    APURegisters.PC = IAPU.PC - IAPU.RAM;
    S9xAPUPackStatus ();
    
    if (CPU.Flags & SCAN_KEYS_FLAG)
    {
	    S9xSyncSpeed ();
	CPU.Flags &= ~SCAN_KEYS_FLAG;
    }	*/
/********end*/
	SAVE_REGS
	LDMFD		R13!,{R4-R11,pc}
	/*MOV		PC,LR*/
	/*bx		lr*/

.endm

.macro		doTestOpcode
	@ save registers
	STMFD		R13!,{R4-R11,LR}
	@ init pointer to CPUvar structure
	MOV		reg_cpu_var,R0
	@ init registers
	LOAD_REGS
	@ get cpu mode from flag and init jump table
	S9xFixCycles
	
	EXEC_OP
.endm
