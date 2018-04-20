/*	.DATA*/
   .text
/****************************************************************	
****************************************************************/
	.align 4
	.include	"os9x_65c816_common.s"

.equ	IAPU_PC_offs, 	52

.macro		asmAPU_EXECUTE
		ldr		r0, [reg_cpu_var, #APUExecuting_ofs]
		ldr		r1, [reg_cpu_var, #APU_Cycles]
		cmp 		r0, #1   @ spc700 enabled, hack mode off
		bne	    	43210f

        	cmp	    	r1, reg_cycles
        	bge        	43210f


		stmfd		r13!, {r4, r12, r14}
		mov		r4, reg_cpu_var
55555:
		ldr		r0, =IAPU
		ldr		r2, =S9xAPUCycles
		ldr		r0, [r0, #IAPU_PC_offs]		@ r0 = IAPU.PC
		ldr		r3, =S9xApuOpcodes
		ldrb		r0, [r0]			@ r0 = APU Opcode		

		add		lr, pc, #(3*4)			@ set return point

		ldr		r2, [r2, r0, lsl #2]		
		add		r1, r1, r2			
		str		r1, [r4, #APU_Cycles]		@ CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC]

		ldr		pc, [r3, r0, lsl #2]		@ (*S9xApuOpcodes[*IAPU.PC]) ();		
		@ return point		

		ldr		r1, [r4, #APU_Cycles]
        	cmp	    	r1, reg_cycles
        	blt        	55555b

		ldmfd		r13!, {r4, r12, r14}

43210:
.endm

.macro		asmAPU_EXECUTE2
		ldr		r0, [reg_cpu_var, #APUExecuting_ofs]
		ldr		r1, [reg_cpu_var, #APU_Cycles]
		cmp 		r0, #1   @ spc700 enabled, hack mode off
		bne	    	43211f

        	cmp	    	r1, reg_cycles
        	bge        	43211f


		stmfd		r13!, {r4, r12, r14}
		mov		r4, reg_cpu_var
55555:
		ldr		r0, =IAPU
		ldr		r2, =S9xAPUCycles
		ldr		r0, [r0, #IAPU_PC_offs]		@ r0 = IAPU.PC
		ldr		r3, =S9xApuOpcodes
		ldrb		r0, [r0]			@ r0 = APU Opcode		

		add		lr, pc, #(3*4)			@ set return point

		ldr		r2, [r2, r0, lsl #2]		
		add		r1, r1, r2			
		str		r1, [r4, #APU_Cycles]		@ CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC]

		ldr		pc, [r3, r0, lsl #2]		@ (*S9xApuOpcodes[*IAPU.PC]) ();		
		@ return point		

		ldr		r1, [r4, #APU_Cycles]
        	cmp	    	r1, reg_cycles
        	blt        	55555b

		ldmfd		r13!, {r4, r12, r14}

43211:
.endm 
/*
.macro		asmAPU_EXECUTE2
		LDR		R0,[reg_cpu_var,#APUExecuting_ofs]
		CMP 		R0, #1   @ spc700 enabled, hack mode off
		BNE		    43211f
		PREPARE_C_CALL_LIGHTR12
		mov		r0, reg_cycles
		bl		APU_EXECUTE4ASM
		RESTORE_C_CALL_LIGHTR12
43211:
.endm
*/
		
		.include	"os9x_65c816_opcodes.s"


/*


CLI_OPE_REC_Nos_Layer0 
  	nos.nos_ope_treasury_date = convert(DATETIME, @treasuryDate, 103)
    	nos.nos_ope_accounting_date = convert(DATETIME, @accountingDate, 103)

CLI_OPE_Nos_Ope_Layer0
	n.nos_ope_treasury_date = convert(DATETIME, @LARD, 103)
	n.nos_ope_accounting_date = convert(DATETIME, @LARD, 103)
    	
CLI_OPE_Nos_Layer0    	
	nos.nos_ope_treasury_date = convert(DATETIME, @LARD, 103)
	nos.nos_ope_accounting_date = convert(DATETIME, @LARD, 103)    	
	
Ecrans:
------


[GNV] : utilisation de la lard (laccdate) pour afficher les openings.
   +nécessité d'avoir des valeurs dans l'opening pour date tréso=date compta=laccdate
	
[Accounting rec] : si laccdate pas bonne (pas = BD-1) -> message warning et pas de donnée
sinon : 
  +données nécessaires : opening date tréso=date compta=laccdate=BD-1
  +données nécessaires : opening date tréso=date compta=laccdate-1
  +données nécessaires : opening date tréso=laccdate-1 et date compta=laccdate
   */


	
/****************************************************************
	GLOBAL
****************************************************************/
	@.globl   test_opcode
	.globl	 asmMainLoop_spcC


@ void asmMainLoop(asm_cpu_var_t *asmcpuPtr);
asmMainLoop_spcC:
	doMainLoop


.pool

/*
@ void test_opcode(struct asm_cpu_var *asm_var);
test_opcode:
	doTestOpcode
.pool

*/

/*****************************************************************
       ASM CODE
*****************************************************************/

	
jumptable1:		.long	Op00mod1
			.long	Op01M1mod1
			.long	Op02mod1
			.long	Op03M1mod1
			.long	Op04M1mod1
			.long	Op05M1mod1
			.long	Op06M1mod1
			.long	Op07M1mod1
			.long	Op08mod1
			.long	Op09M1mod1
			.long	Op0AM1mod1
			.long	Op0Bmod1
			.long	Op0CM1mod1
			.long	Op0DM1mod1
			.long	Op0EM1mod1
			.long	Op0FM1mod1
			.long	Op10mod1
			.long	Op11M1mod1
			.long	Op12M1mod1
			.long	Op13M1mod1
			.long	Op14M1mod1
			.long	Op15M1mod1
			.long	Op16M1mod1
			.long	Op17M1mod1
			.long	Op18mod1
			.long	Op19M1mod1
			.long	Op1AM1mod1
			.long	Op1Bmod1
			.long	Op1CM1mod1
			.long	Op1DM1mod1
			.long	Op1EM1mod1
			.long	Op1FM1mod1
			.long	Op20mod1
			.long	Op21M1mod1
			.long	Op22mod1
			.long	Op23M1mod1
			.long	Op24M1mod1
			.long	Op25M1mod1
			.long	Op26M1mod1
			.long	Op27M1mod1
			.long	Op28mod1
			.long	Op29M1mod1
			.long	Op2AM1mod1
			.long	Op2Bmod1
			.long	Op2CM1mod1
			.long	Op2DM1mod1
			.long	Op2EM1mod1
			.long	Op2FM1mod1
			.long	Op30mod1
			.long	Op31M1mod1
			.long	Op32M1mod1
			.long	Op33M1mod1
			.long	Op34M1mod1
			.long	Op35M1mod1
			.long	Op36M1mod1
			.long	Op37M1mod1
			.long	Op38mod1
			.long	Op39M1mod1
			.long	Op3AM1mod1
			.long	Op3Bmod1
			.long	Op3CM1mod1
			.long	Op3DM1mod1
			.long	Op3EM1mod1
			.long	Op3FM1mod1
			.long	Op40mod1
			.long	Op41M1mod1
			.long	Op42mod1
			.long	Op43M1mod1
			.long	Op44X1mod1
			.long	Op45M1mod1
			.long	Op46M1mod1
			.long	Op47M1mod1
			.long	Op48M1mod1
			.long	Op49M1mod1
			.long	Op4AM1mod1
			.long	Op4Bmod1
			.long	Op4Cmod1
			.long	Op4DM1mod1
			.long	Op4EM1mod1
			.long	Op4FM1mod1
			.long	Op50mod1
			.long	Op51M1mod1
			.long	Op52M1mod1
			.long	Op53M1mod1
			.long	Op54X1mod1
			.long	Op55M1mod1
			.long	Op56M1mod1
			.long	Op57M1mod1
			.long	Op58mod1
			.long	Op59M1mod1
			.long	Op5AX1mod1
			.long	Op5Bmod1
			.long	Op5Cmod1
			.long	Op5DM1mod1
			.long	Op5EM1mod1
			.long	Op5FM1mod1
			.long	Op60mod1
			.long	Op61M1mod1
			.long	Op62mod1
			.long	Op63M1mod1
			.long	Op64M1mod1
			.long	Op65M1mod1
			.long	Op66M1mod1
			.long	Op67M1mod1
			.long	Op68M1mod1
			.long	Op69M1mod1
			.long	Op6AM1mod1
			.long	Op6Bmod1
			.long	Op6Cmod1
			.long	Op6DM1mod1
			.long	Op6EM1mod1
			.long	Op6FM1mod1
			.long	Op70mod1
			.long	Op71M1mod1
			.long	Op72M1mod1
			.long	Op73M1mod1
			.long	Op74M1mod1
			.long	Op75M1mod1
			.long	Op76M1mod1
			.long	Op77M1mod1
			.long	Op78mod1
			.long	Op79M1mod1
			.long	Op7AX1mod1
			.long	Op7Bmod1
			.long	Op7Cmod1
			.long	Op7DM1mod1
			.long	Op7EM1mod1
			.long	Op7FM1mod1
			.long	Op80mod1
			.long	Op81M1mod1
			.long	Op82mod1
			.long	Op83M1mod1
			.long	Op84X1mod1
			.long	Op85M1mod1
			.long	Op86X1mod1
			.long	Op87M1mod1
			.long	Op88X1mod1
			.long	Op89M1mod1
			.long	Op8AM1mod1
			.long	Op8Bmod1
			.long	Op8CX1mod1
			.long	Op8DM1mod1
			.long	Op8EX1mod1
			.long	Op8FM1mod1
			.long	Op90mod1
			.long	Op91M1mod1
			.long	Op92M1mod1
			.long	Op93M1mod1
			.long	Op94X1mod1
			.long	Op95M1mod1
			.long	Op96X1mod1
			.long	Op97M1mod1
			.long	Op98M1mod1
			.long	Op99M1mod1
			.long	Op9Amod1
			.long	Op9BX1mod1

			.long	Op9CM1mod1
			.long	Op9DM1mod1
			.long	Op9EM1mod1
			.long	Op9FM1mod1
			.long	OpA0X1mod1
			.long	OpA1M1mod1
			.long	OpA2X1mod1
			.long	OpA3M1mod1
			.long	OpA4X1mod1
			.long	OpA5M1mod1
			.long	OpA6X1mod1
			.long	OpA7M1mod1
			.long	OpA8X1mod1
			.long	OpA9M1mod1
			.long	OpAAX1mod1
			.long	OpABmod1
			.long	OpACX1mod1
			.long	OpADM1mod1
			.long	OpAEX1mod1
			.long	OpAFM1mod1
			.long	OpB0mod1
			.long	OpB1M1mod1
			.long	OpB2M1mod1
			.long	OpB3M1mod1
			.long	OpB4X1mod1
			.long	OpB5M1mod1
			.long	OpB6X1mod1
			.long	OpB7M1mod1
			.long	OpB8mod1
			.long	OpB9M1mod1
			.long	OpBAX1mod1
			.long	OpBBX1mod1
			.long	OpBCX1mod1
			.long	OpBDM1mod1
			.long	OpBEX1mod1
			.long	OpBFM1mod1
			.long	OpC0X1mod1
			.long	OpC1M1mod1
			.long	OpC2mod1
			.long	OpC3M1mod1
			.long	OpC4X1mod1
			.long	OpC5M1mod1
			.long	OpC6M1mod1
			.long	OpC7M1mod1
			.long	OpC8X1mod1
			.long	OpC9M1mod1
			.long	OpCAX1mod1
			.long	OpCBmod1
			.long	OpCCX1mod1
			.long	OpCDM1mod1
			.long	OpCEM1mod1
			.long	OpCFM1mod1
			.long	OpD0mod1
			.long	OpD1M1mod1
			.long	OpD2M1mod1
			.long	OpD3M1mod1
			.long	OpD4mod1
			.long	OpD5M1mod1
			.long	OpD6M1mod1
			.long	OpD7M1mod1
			.long	OpD8mod1
			.long	OpD9M1mod1
			.long	OpDAX1mod1
			.long	OpDBmod1
			.long	OpDCmod1
			.long	OpDDM1mod1
			.long	OpDEM1mod1
			.long	OpDFM1mod1
			.long	OpE0X1mod1
			.long	OpE1M1mod1
			.long	OpE2mod1
			.long	OpE3M1mod1
			.long	OpE4X1mod1
			.long	OpE5M1mod1
			.long	OpE6M1mod1
			.long	OpE7M1mod1
			.long	OpE8X1mod1
			.long	OpE9M1mod1
			.long	OpEAmod1
			.long	OpEBmod1
			.long	OpECX1mod1
			.long	OpEDM1mod1
			.long	OpEEM1mod1
			.long	OpEFM1mod1
			.long	OpF0mod1
			.long	OpF1M1mod1
			.long	OpF2M1mod1
			.long	OpF3M1mod1
			.long	OpF4mod1
			.long	OpF5M1mod1
			.long	OpF6M1mod1
			.long	OpF7M1mod1
			.long	OpF8mod1
			.long	OpF9M1mod1
			.long	OpFAX1mod1
			.long	OpFBmod1
			.long	OpFCmod1
			.long	OpFDM1mod1
			.long	OpFEM1mod1
			.long	OpFFM1mod1
			
Op00mod1:
lbl00mod1:	Op00
			NEXTOPCODE
Op01M1mod1:
lbl01mod1a:	DirectIndexedIndirect1
lbl01mod1b:	ORA8
			NEXTOPCODE
Op02mod1:
lbl02mod1:	Op02
			NEXTOPCODE
Op03M1mod1:
lbl03mod1a:	StackasmRelative
lbl03mod1b:	ORA8
			NEXTOPCODE
Op04M1mod1:
lbl04mod1a:	Direct
lbl04mod1b:	TSB8
			NEXTOPCODE
Op05M1mod1:
lbl05mod1a:	Direct
lbl05mod1b:	ORA8
			NEXTOPCODE
Op06M1mod1:
lbl06mod1a:	Direct
lbl06mod1b:	ASL8
			NEXTOPCODE
Op07M1mod1:
lbl07mod1a:	DirectIndirectLong
lbl07mod1b:	ORA8
			NEXTOPCODE
Op08mod1:
lbl08mod1:	Op08
			NEXTOPCODE
Op09M1mod1:
lbl09mod1:	Op09M1
			NEXTOPCODE
Op0AM1mod1:
lbl0Amod1a:	A_ASL8
			NEXTOPCODE
Op0Bmod1:
lbl0Bmod1:	Op0B
			NEXTOPCODE
Op0CM1mod1:
lbl0Cmod1a:	Absolute
lbl0Cmod1b:	TSB8
			NEXTOPCODE
Op0DM1mod1:
lbl0Dmod1a:	Absolute
lbl0Dmod1b:	ORA8
			NEXTOPCODE
Op0EM1mod1:
lbl0Emod1a:	Absolute
lbl0Emod1b:	ASL8
			NEXTOPCODE
Op0FM1mod1:
lbl0Fmod1a:	AbsoluteLong
lbl0Fmod1b:	ORA8
			NEXTOPCODE
Op10mod1:
lbl10mod1:	Op10
			NEXTOPCODE
Op11M1mod1:
lbl11mod1a:	DirectIndirectIndexed1
lbl11mod1b:	ORA8
			NEXTOPCODE
Op12M1mod1:
lbl12mod1a:	DirectIndirect
lbl12mod1b:	ORA8
			NEXTOPCODE
Op13M1mod1:

lbl13mod1a:	StackasmRelativeIndirectIndexed1
lbl13mod1b:	ORA8
			NEXTOPCODE
Op14M1mod1:
lbl14mod1a:	Direct
lbl14mod1b:	TRB8
			NEXTOPCODE
Op15M1mod1:
lbl15mod1a:	DirectIndexedX1
lbl15mod1b:	ORA8
			NEXTOPCODE
Op16M1mod1:
lbl16mod1a:	DirectIndexedX1
lbl16mod1b:	ASL8
			NEXTOPCODE
Op17M1mod1:
lbl17mod1a:	DirectIndirectIndexedLong1
lbl17mod1b:	ORA8
			NEXTOPCODE
Op18mod1:
lbl18mod1:	Op18
			NEXTOPCODE
Op19M1mod1:
lbl19mod1a:	AbsoluteIndexedY1
lbl19mod1b:	ORA8
			NEXTOPCODE
Op1AM1mod1:
lbl1Amod1a:	A_INC8
			NEXTOPCODE
Op1Bmod1:
lbl1Bmod1:	Op1BM1
			NEXTOPCODE
Op1CM1mod1:
lbl1Cmod1a:	Absolute
lbl1Cmod1b:	TRB8
			NEXTOPCODE
Op1DM1mod1:
lbl1Dmod1a:	AbsoluteIndexedX1
lbl1Dmod1b:	ORA8
			NEXTOPCODE
Op1EM1mod1:
lbl1Emod1a:	AbsoluteIndexedX1
lbl1Emod1b:	ASL8
			NEXTOPCODE
Op1FM1mod1:
lbl1Fmod1a:	AbsoluteLongIndexedX1
lbl1Fmod1b:	ORA8
			NEXTOPCODE
Op20mod1:
lbl20mod1:	Op20
			NEXTOPCODE
Op21M1mod1:
lbl21mod1a:	DirectIndexedIndirect1
lbl21mod1b:	AND8
			NEXTOPCODE
Op22mod1:
lbl22mod1:	Op22
			NEXTOPCODE
Op23M1mod1:
lbl23mod1a:	StackasmRelative
lbl23mod1b:	AND8
			NEXTOPCODE
Op24M1mod1:
lbl24mod1a:	Direct
lbl24mod1b:	BIT8
			NEXTOPCODE
Op25M1mod1:
lbl25mod1a:	Direct
lbl25mod1b:	AND8
			NEXTOPCODE
Op26M1mod1:
lbl26mod1a:	Direct
lbl26mod1b:	ROL8
			NEXTOPCODE
Op27M1mod1:
lbl27mod1a:	DirectIndirectLong
lbl27mod1b:	AND8
			NEXTOPCODE
Op28mod1:
lbl28mod1:	Op28X1M1
			NEXTOPCODE
.pool			
Op29M1mod1:
lbl29mod1:	Op29M1
			NEXTOPCODE
Op2AM1mod1:
lbl2Amod1a:	A_ROL8
			NEXTOPCODE
Op2Bmod1:
lbl2Bmod1:	Op2B
			NEXTOPCODE
Op2CM1mod1:
lbl2Cmod1a:	Absolute
lbl2Cmod1b:	BIT8
			NEXTOPCODE
Op2DM1mod1:
lbl2Dmod1a:	Absolute
lbl2Dmod1b:	AND8
			NEXTOPCODE
Op2EM1mod1:
lbl2Emod1a:	Absolute
lbl2Emod1b:	ROL8
			NEXTOPCODE
Op2FM1mod1:
lbl2Fmod1a:	AbsoluteLong
lbl2Fmod1b:	AND8
			NEXTOPCODE
Op30mod1:
lbl30mod1:	Op30
			NEXTOPCODE
Op31M1mod1:
lbl31mod1a:	DirectIndirectIndexed1
lbl31mod1b:	AND8
			NEXTOPCODE
Op32M1mod1:
lbl32mod1a:	DirectIndirect
lbl32mod1b:	AND8
			NEXTOPCODE
Op33M1mod1:
lbl33mod1a:	StackasmRelativeIndirectIndexed1
lbl33mod1b:	AND8
			NEXTOPCODE
Op34M1mod1:
lbl34mod1a:	DirectIndexedX1
lbl34mod1b:	BIT8
			NEXTOPCODE
Op35M1mod1:
lbl35mod1a:	DirectIndexedX1
lbl35mod1b:	AND8
			NEXTOPCODE
Op36M1mod1:
lbl36mod1a:	DirectIndexedX1
lbl36mod1b:	ROL8
			NEXTOPCODE
Op37M1mod1:
lbl37mod1a:	DirectIndirectIndexedLong1
lbl37mod1b:	AND8
			NEXTOPCODE
Op38mod1:
lbl38mod1:	Op38
			NEXTOPCODE
Op39M1mod1:
lbl39mod1a:	AbsoluteIndexedY1
lbl39mod1b:	AND8
			NEXTOPCODE
Op3AM1mod1:
lbl3Amod1a:	A_DEC8
			NEXTOPCODE
Op3Bmod1:
lbl3Bmod1:	Op3BM1
			NEXTOPCODE
Op3CM1mod1:
lbl3Cmod1a:	AbsoluteIndexedX1
lbl3Cmod1b:	BIT8
			NEXTOPCODE
Op3DM1mod1:
lbl3Dmod1a:	AbsoluteIndexedX1
lbl3Dmod1b:	AND8
			NEXTOPCODE
Op3EM1mod1:
lbl3Emod1a:	AbsoluteIndexedX1
lbl3Emod1b:	ROL8
			NEXTOPCODE
Op3FM1mod1:
lbl3Fmod1a:	AbsoluteLongIndexedX1
lbl3Fmod1b:	AND8
			NEXTOPCODE
Op40mod1:
lbl40mod1:	Op40X1M1
			NEXTOPCODE
.pool						
Op41M1mod1:
lbl41mod1a:	DirectIndexedIndirect1
lbl41mod1b:	EOR8
			NEXTOPCODE
Op42mod1:
lbl42mod1:	Op42
			NEXTOPCODE
Op43M1mod1:
lbl43mod1a:	StackasmRelative
lbl43mod1b:	EOR8
			NEXTOPCODE
Op44X1mod1:
lbl44mod1:	Op44X1M1
			NEXTOPCODE
Op45M1mod1:
lbl45mod1a:	Direct
lbl45mod1b:	EOR8
			NEXTOPCODE
Op46M1mod1:
lbl46mod1a:	Direct
lbl46mod1b:	LSR8
			NEXTOPCODE
Op47M1mod1:
lbl47mod1a:	DirectIndirectLong
lbl47mod1b:	EOR8
			NEXTOPCODE
Op48M1mod1:
lbl48mod1:	Op48M1
			NEXTOPCODE
Op49M1mod1:
lbl49mod1:	Op49M1
			NEXTOPCODE
Op4AM1mod1:
lbl4Amod1a:	A_LSR8
			NEXTOPCODE
Op4Bmod1:
lbl4Bmod1:	Op4B
			NEXTOPCODE
Op4Cmod1:
lbl4Cmod1:	Op4C
			NEXTOPCODE
Op4DM1mod1:
lbl4Dmod1a:	Absolute
lbl4Dmod1b:	EOR8
			NEXTOPCODE
Op4EM1mod1:
lbl4Emod1a:	Absolute
lbl4Emod1b:	LSR8
			NEXTOPCODE
Op4FM1mod1:
lbl4Fmod1a:	AbsoluteLong
lbl4Fmod1b:	EOR8
			NEXTOPCODE
Op50mod1:
lbl50mod1:	Op50
			NEXTOPCODE
Op51M1mod1:
lbl51mod1a:	DirectIndirectIndexed1
lbl51mod1b:	EOR8
			NEXTOPCODE
Op52M1mod1:
lbl52mod1a:	DirectIndirect
lbl52mod1b:	EOR8
			NEXTOPCODE
Op53M1mod1:
lbl53mod1a:	StackasmRelativeIndirectIndexed1
lbl53mod1b:	EOR8
			NEXTOPCODE
Op54X1mod1:
lbl54mod1:	Op54X1M1
			NEXTOPCODE
Op55M1mod1:
lbl55mod1a:	DirectIndexedX1
lbl55mod1b:	EOR8
			NEXTOPCODE
Op56M1mod1:
lbl56mod1a:	DirectIndexedX1
lbl56mod1b:	LSR8
			NEXTOPCODE
Op57M1mod1:
lbl57mod1a:	DirectIndirectIndexedLong1
lbl57mod1b:	EOR8
			NEXTOPCODE
Op58mod1:
lbl58mod1:	Op58
			NEXTOPCODE
Op59M1mod1:
lbl59mod1a:	AbsoluteIndexedY1
lbl59mod1b:	EOR8
			NEXTOPCODE
Op5AX1mod1:
lbl5Amod1:	Op5AX1
			NEXTOPCODE
Op5Bmod1:
lbl5Bmod1:	Op5BM1
			NEXTOPCODE
Op5Cmod1:
lbl5Cmod1:	Op5C
			NEXTOPCODE
Op5DM1mod1:
lbl5Dmod1a:	AbsoluteIndexedX1
lbl5Dmod1b:	EOR8
			NEXTOPCODE
Op5EM1mod1:
lbl5Emod1a:	AbsoluteIndexedX1
lbl5Emod1b:	LSR8
			NEXTOPCODE
Op5FM1mod1:
lbl5Fmod1a:	AbsoluteLongIndexedX1
lbl5Fmod1b:	EOR8
			NEXTOPCODE
Op60mod1:
lbl60mod1:	Op60
			NEXTOPCODE
Op61M1mod1:
lbl61mod1a:	DirectIndexedIndirect1
lbl61mod1b:	ADC8
			NEXTOPCODE
Op62mod1:
lbl62mod1:	Op62
			NEXTOPCODE
Op63M1mod1:
lbl63mod1a:	StackasmRelative
lbl63mod1b:	ADC8
			NEXTOPCODE
Op64M1mod1:
lbl64mod1a:	Direct
lbl64mod1b:	STZ8
			NEXTOPCODE
Op65M1mod1:
lbl65mod1a:	Direct
lbl65mod1b:	ADC8
			NEXTOPCODE
Op66M1mod1:
lbl66mod1a:	Direct
lbl66mod1b:	ROR8
			NEXTOPCODE
Op67M1mod1:
lbl67mod1a:	DirectIndirectLong
lbl67mod1b:	ADC8

			NEXTOPCODE

Op68M1mod1:
lbl68mod1:	Op68M1
			NEXTOPCODE
Op69M1mod1:
lbl69mod1a:	Immediate8
lbl69mod1b:	ADC8
			NEXTOPCODE
Op6AM1mod1:
lbl6Amod1a:	A_ROR8
			NEXTOPCODE
Op6Bmod1:
lbl6Bmod1:	Op6B
			NEXTOPCODE
Op6Cmod1:
lbl6Cmod1:	Op6C
			NEXTOPCODE
Op6DM1mod1:
lbl6Dmod1a:	Absolute
lbl6Dmod1b:	ADC8
			NEXTOPCODE
Op6EM1mod1:


lbl6Emod1a:	Absolute
lbl6Emod1b:	ROR8
			NEXTOPCODE
Op6FM1mod1:
lbl6Fmod1a:	AbsoluteLong
lbl6Fmod1b:	ADC8
			NEXTOPCODE
Op70mod1:
lbl70mod1:	Op70
			NEXTOPCODE
Op71M1mod1:
lbl71mod1a:	DirectIndirectIndexed1
lbl71mod1b:	ADC8
			NEXTOPCODE
Op72M1mod1:
lbl72mod1a:	DirectIndirect
lbl72mod1b:	ADC8
			NEXTOPCODE
Op73M1mod1:
lbl73mod1a:	StackasmRelativeIndirectIndexed1
lbl73mod1b:	ADC8
			NEXTOPCODE

Op74M1mod1:
lbl74mod1a:	DirectIndexedX1
lbl74mod1b:	STZ8
			NEXTOPCODE
Op75M1mod1:
lbl75mod1a:	DirectIndexedX1
lbl75mod1b:	ADC8
			NEXTOPCODE
Op76M1mod1:
lbl76mod1a:	DirectIndexedX1
lbl76mod1b:	ROR8
			NEXTOPCODE
Op77M1mod1:
lbl77mod1a:	DirectIndirectIndexedLong1
lbl77mod1b:	ADC8
			NEXTOPCODE
Op78mod1:
lbl78mod1:	Op78
			NEXTOPCODE
Op79M1mod1:
lbl79mod1a:	AbsoluteIndexedY1
lbl79mod1b:	ADC8
			NEXTOPCODE
Op7AX1mod1:
lbl7Amod1:	Op7AX1
			NEXTOPCODE
Op7Bmod1:
lbl7Bmod1:	Op7BM1
			NEXTOPCODE
Op7Cmod1:
lbl7Cmod1:	AbsoluteIndexedIndirectX1
		Op7C
			NEXTOPCODE
Op7DM1mod1:
lbl7Dmod1a:	AbsoluteIndexedX1
lbl7Dmod1b:	ADC8
			NEXTOPCODE
Op7EM1mod1:
lbl7Emod1a:	AbsoluteIndexedX1
lbl7Emod1b:	ROR8
			NEXTOPCODE
Op7FM1mod1:
lbl7Fmod1a:	AbsoluteLongIndexedX1
lbl7Fmod1b:	ADC8
			NEXTOPCODE


Op80mod1:
lbl80mod1:	Op80
			NEXTOPCODE
Op81M1mod1:
lbl81mod1a:	DirectIndexedIndirect1
lbl81mod1b:	Op81M1
			NEXTOPCODE
Op82mod1:
lbl82mod1:	Op82
			NEXTOPCODE
Op83M1mod1:
lbl83mod1a:	StackasmRelative
lbl83mod1b:	STA8
			NEXTOPCODE
Op84X1mod1:
lbl84mod1a:	Direct
lbl84mod1b:	STY8
			NEXTOPCODE
Op85M1mod1:
lbl85mod1a:	Direct
lbl85mod1b:	STA8
			NEXTOPCODE
Op86X1mod1:
lbl86mod1a:	Direct
lbl86mod1b:	STX8
			NEXTOPCODE
Op87M1mod1:
lbl87mod1a:	DirectIndirectLong
lbl87mod1b:	STA8
			NEXTOPCODE
Op88X1mod1:
lbl88mod1:	Op88X1
			NEXTOPCODE
Op89M1mod1:
lbl89mod1:	Op89M1
			NEXTOPCODE
Op8AM1mod1:
lbl8Amod1:	Op8AM1X1
			NEXTOPCODE
Op8Bmod1:
lbl8Bmod1:	Op8B
			NEXTOPCODE
Op8CX1mod1:
lbl8Cmod1a:	Absolute
lbl8Cmod1b:	STY8
			NEXTOPCODE
Op8DM1mod1:
lbl8Dmod1a:	Absolute
lbl8Dmod1b:	STA8
			NEXTOPCODE
Op8EX1mod1:
lbl8Emod1a:	Absolute
lbl8Emod1b:	STX8
			NEXTOPCODE
Op8FM1mod1:
lbl8Fmod1a:	AbsoluteLong
lbl8Fmod1b:	STA8
			NEXTOPCODE
Op90mod1:
lbl90mod1:	Op90
			NEXTOPCODE
Op91M1mod1:
lbl91mod1a:	DirectIndirectIndexed1
lbl91mod1b:	STA8
			NEXTOPCODE
Op92M1mod1:
lbl92mod1a:	DirectIndirect
lbl92mod1b:	STA8
			NEXTOPCODE
Op93M1mod1:
lbl93mod1a:	StackasmRelativeIndirectIndexed1
lbl93mod1b:	STA8
			NEXTOPCODE
Op94X1mod1:
lbl94mod1a:	DirectIndexedX1
lbl94mod1b:	STY8
			NEXTOPCODE
Op95M1mod1:
lbl95mod1a:	DirectIndexedX1
lbl95mod1b:	STA8
			NEXTOPCODE
Op96X1mod1:
lbl96mod1a:	DirectIndexedY1
lbl96mod1b:	STX8
			NEXTOPCODE
Op97M1mod1:
lbl97mod1a:	DirectIndirectIndexedLong1
lbl97mod1b:	STA8
			NEXTOPCODE
Op98M1mod1:
lbl98mod1:	Op98M1X1
			NEXTOPCODE
Op99M1mod1:
lbl99mod1a:	AbsoluteIndexedY1
lbl99mod1b:	STA8
			NEXTOPCODE
Op9Amod1:
lbl9Amod1:	Op9AX1
			NEXTOPCODE
Op9BX1mod1:
lbl9Bmod1:	Op9BX1
			NEXTOPCODE
Op9CM1mod1:
lbl9Cmod1a:	Absolute
lbl9Cmod1b:	STZ8
			NEXTOPCODE
Op9DM1mod1:
lbl9Dmod1a:	AbsoluteIndexedX1
lbl9Dmod1b:	STA8
			NEXTOPCODE
Op9EM1mod1:	
lbl9Emod1:	AbsoluteIndexedX1		
		STZ8
			NEXTOPCODE
Op9FM1mod1:
lbl9Fmod1a:	AbsoluteLongIndexedX1
lbl9Fmod1b:	STA8
			NEXTOPCODE
OpA0X1mod1:
lblA0mod1:	OpA0X1
			NEXTOPCODE
OpA1M1mod1:
lblA1mod1a:	DirectIndexedIndirect1
lblA1mod1b:	LDA8
			NEXTOPCODE
OpA2X1mod1:
lblA2mod1:	OpA2X1
			NEXTOPCODE
OpA3M1mod1:
lblA3mod1a:	StackasmRelative
lblA3mod1b:	LDA8
			NEXTOPCODE
OpA4X1mod1:
lblA4mod1a:	Direct
lblA4mod1b:	LDY8
			NEXTOPCODE
OpA5M1mod1:
lblA5mod1a:	Direct
lblA5mod1b:	LDA8
			NEXTOPCODE
OpA6X1mod1:
lblA6mod1a:	Direct
lblA6mod1b:	LDX8
			NEXTOPCODE
OpA7M1mod1:
lblA7mod1a:	DirectIndirectLong
lblA7mod1b:	LDA8
			NEXTOPCODE
OpA8X1mod1:
lblA8mod1:	OpA8X1M1
			NEXTOPCODE
OpA9M1mod1:
lblA9mod1:	OpA9M1
			NEXTOPCODE
OpAAX1mod1:
lblAAmod1:	OpAAX1M1
			NEXTOPCODE
OpABmod1:
lblABmod1:	OpAB
			NEXTOPCODE
OpACX1mod1:
lblACmod1a:	Absolute
lblACmod1b:	LDY8
			NEXTOPCODE
OpADM1mod1:
lblADmod1a:	Absolute
lblADmod1b:	LDA8
			NEXTOPCODE
OpAEX1mod1:
lblAEmod1a:	Absolute
lblAEmod1b:	LDX8
			NEXTOPCODE
OpAFM1mod1:
lblAFmod1a:	AbsoluteLong
lblAFmod1b:	LDA8
			NEXTOPCODE
OpB0mod1:
lblB0mod1:	OpB0
			NEXTOPCODE
OpB1M1mod1:
lblB1mod1a:	DirectIndirectIndexed1
lblB1mod1b:	LDA8
			NEXTOPCODE
OpB2M1mod1:
lblB2mod1a:	DirectIndirect
lblB2mod1b:	LDA8
			NEXTOPCODE
OpB3M1mod1:
lblB3mod1a:	StackasmRelativeIndirectIndexed1
lblB3mod1b:	LDA8
			NEXTOPCODE
OpB4X1mod1:
lblB4mod1a:	DirectIndexedX1
lblB4mod1b:	LDY8
			NEXTOPCODE
OpB5M1mod1:
lblB5mod1a:	DirectIndexedX1
lblB5mod1b:	LDA8
			NEXTOPCODE
OpB6X1mod1:
lblB6mod1a:	DirectIndexedY1
lblB6mod1b:	LDX8
			NEXTOPCODE
OpB7M1mod1:
lblB7mod1a:	DirectIndirectIndexedLong1
lblB7mod1b:	LDA8
			NEXTOPCODE
OpB8mod1:
lblB8mod1:	OpB8
			NEXTOPCODE
OpB9M1mod1:
lblB9mod1a:	AbsoluteIndexedY1
lblB9mod1b:	LDA8
			NEXTOPCODE
OpBAX1mod1:
lblBAmod1:	OpBAX1
			NEXTOPCODE
OpBBX1mod1:
lblBBmod1:	OpBBX1
			NEXTOPCODE
OpBCX1mod1:
lblBCmod1a:	AbsoluteIndexedX1
lblBCmod1b:	LDY8
			NEXTOPCODE
OpBDM1mod1:
lblBDmod1a:	AbsoluteIndexedX1
lblBDmod1b:	LDA8
			NEXTOPCODE
OpBEX1mod1:
lblBEmod1a:	AbsoluteIndexedY1
lblBEmod1b:	LDX8
			NEXTOPCODE
OpBFM1mod1:
lblBFmod1a:	AbsoluteLongIndexedX1
lblBFmod1b:	LDA8
			NEXTOPCODE
OpC0X1mod1:
lblC0mod1:	OpC0X1
			NEXTOPCODE
OpC1M1mod1:
lblC1mod1a:	DirectIndexedIndirect1
lblC1mod1b:	CMP8
			NEXTOPCODE
OpC2mod1:
lblC2mod1:	OpC2
			NEXTOPCODE
.pool
OpC3M1mod1:
lblC3mod1a:	StackasmRelative
lblC3mod1b:	CMP8
			NEXTOPCODE
OpC4X1mod1:
lblC4mod1a:	Direct
lblC4mod1b:	CMY8
			NEXTOPCODE
OpC5M1mod1:
lblC5mod1a:	Direct
lblC5mod1b:	CMP8
			NEXTOPCODE
OpC6M1mod1:
lblC6mod1a:	Direct
lblC6mod1b:	DEC8
			NEXTOPCODE
OpC7M1mod1:
lblC7mod1a:	DirectIndirectLong
lblC7mod1b:	CMP8
			NEXTOPCODE
OpC8X1mod1:
lblC8mod1:	OpC8X1
			NEXTOPCODE
OpC9M1mod1:
lblC9mod1:	OpC9M1
			NEXTOPCODE
OpCAX1mod1:
lblCAmod1:	OpCAX1
			NEXTOPCODE
OpCBmod1:
lblCBmod1:	OpCB
			NEXTOPCODE
OpCCX1mod1:
lblCCmod1a:	Absolute
lblCCmod1b:	CMY8
			NEXTOPCODE
OpCDM1mod1:
lblCDmod1a:	Absolute
lblCDmod1b:	CMP8
			NEXTOPCODE
OpCEM1mod1:
lblCEmod1a:	Absolute
lblCEmod1b:	DEC8
			NEXTOPCODE
OpCFM1mod1:
lblCFmod1a:	AbsoluteLong
lblCFmod1b:	CMP8
			NEXTOPCODE
OpD0mod1:
lblD0mod1:	OpD0
			NEXTOPCODE
OpD1M1mod1:
lblD1mod1a:	DirectIndirectIndexed1
lblD1mod1b:	CMP8
			NEXTOPCODE
OpD2M1mod1:
lblD2mod1a:	DirectIndirect
lblD2mod1b:	CMP8
			NEXTOPCODE
OpD3M1mod1:
lblD3mod1a:	StackasmRelativeIndirectIndexed1
lblD3mod1b:	CMP8

			NEXTOPCODE
OpD4mod1:
lblD4mod1:	OpD4
			NEXTOPCODE
OpD5M1mod1:
lblD5mod1a:	DirectIndexedX1
lblD5mod1b:	CMP8
			NEXTOPCODE
OpD6M1mod1:
lblD6mod1a:	DirectIndexedX1
lblD6mod1b:	DEC8
			NEXTOPCODE
OpD7M1mod1:
lblD7mod1a:	DirectIndirectIndexedLong1
lblD7mod1b:	CMP8
			NEXTOPCODE
OpD8mod1:
lblD8mod1:	OpD8
			NEXTOPCODE
OpD9M1mod1:
lblD9mod1a:	AbsoluteIndexedY1
lblD9mod1b:	CMP8
			NEXTOPCODE
OpDAX1mod1:
lblDAmod1:	OpDAX1
			NEXTOPCODE
OpDBmod1:
lblDBmod1:	OpDB
			NEXTOPCODE
OpDCmod1:
lblDCmod1:	OpDC
			NEXTOPCODE
OpDDM1mod1:
lblDDmod1a:	AbsoluteIndexedX1
lblDDmod1b:	CMP8
			NEXTOPCODE
OpDEM1mod1:
lblDEmod1a:	AbsoluteIndexedX1
lblDEmod1b:	DEC8
			NEXTOPCODE
OpDFM1mod1:
lblDFmod1a:	AbsoluteLongIndexedX1
lblDFmod1b:	CMP8
			NEXTOPCODE
OpE0X1mod1:
lblE0mod1:	OpE0X1
			NEXTOPCODE
OpE1M1mod1:
lblE1mod1a:	DirectIndexedIndirect1
lblE1mod1b:	SBC8
			NEXTOPCODE
OpE2mod1:
lblE2mod1:	OpE2
			NEXTOPCODE
.pool
OpE3M1mod1:
lblE3mod1a:	StackasmRelative
lblE3mod1b:	SBC8
			NEXTOPCODE
OpE4X1mod1:
lblE4mod1a:	Direct
lblE4mod1b:	CMX8
			NEXTOPCODE
OpE5M1mod1:
lblE5mod1a:	Direct
lblE5mod1b:	SBC8
			NEXTOPCODE
OpE6M1mod1:
lblE6mod1a:	Direct
lblE6mod1b:	INC8
			NEXTOPCODE
OpE7M1mod1:
lblE7mod1a:	DirectIndirectLong
lblE7mod1b:	SBC8
			NEXTOPCODE
OpE8X1mod1:
lblE8mod1:	OpE8X1
			NEXTOPCODE
OpE9M1mod1:
lblE9mod1a:	Immediate8
lblE9mod1b:	SBC8
			NEXTOPCODE
OpEAmod1:
lblEAmod1:	OpEA
			NEXTOPCODE
OpEBmod1:
lblEBmod1:	OpEBM1
			NEXTOPCODE
OpECX1mod1:
lblECmod1a:	Absolute
lblECmod1b:	CMX8
			NEXTOPCODE
OpEDM1mod1:
lblEDmod1a:	Absolute
lblEDmod1b:	SBC8
			NEXTOPCODE
OpEEM1mod1:
lblEEmod1a:	Absolute
lblEEmod1b:	INC8
			NEXTOPCODE
OpEFM1mod1:
lblEFmod1a:	AbsoluteLong
lblEFmod1b:	SBC8
			NEXTOPCODE
OpF0mod1:
lblF0mod1:	OpF0
			NEXTOPCODE
OpF1M1mod1:
lblF1mod1a:	DirectIndirectIndexed1
lblF1mod1b:	SBC8
			NEXTOPCODE
OpF2M1mod1:
lblF2mod1a:	DirectIndirect
lblF2mod1b:	SBC8
			NEXTOPCODE
OpF3M1mod1:
lblF3mod1a:	StackasmRelativeIndirectIndexed1
lblF3mod1b:	SBC8
			NEXTOPCODE
OpF4mod1:
lblF4mod1:	OpF4
			NEXTOPCODE
OpF5M1mod1:
lblF5mod1a:	DirectIndexedX1
lblF5mod1b:	SBC8
			NEXTOPCODE
OpF6M1mod1:
lblF6mod1a:	DirectIndexedX1
lblF6mod1b:	INC8
			NEXTOPCODE
OpF7M1mod1:
lblF7mod1a:	DirectIndirectIndexedLong1
lblF7mod1b:	SBC8
			NEXTOPCODE
OpF8mod1:
lblF8mod1:	OpF8
			NEXTOPCODE
OpF9M1mod1:
lblF9mod1a:	AbsoluteIndexedY1
lblF9mod1b:	SBC8
			NEXTOPCODE
OpFAX1mod1:
lblFAmod1:	OpFAX1
			NEXTOPCODE
OpFBmod1:
lblFBmod1:	OpFB
			NEXTOPCODE
OpFCmod1:
lblFCmod1:	OpFCX1
			NEXTOPCODE
OpFDM1mod1:
lblFDmod1a:	AbsoluteIndexedX1
lblFDmod1b:	SBC8
			NEXTOPCODE
OpFEM1mod1:
lblFEmod1a:	AbsoluteIndexedX1
lblFEmod1b:	INC8
			NEXTOPCODE
OpFFM1mod1:
lblFFmod1a:	AbsoluteLongIndexedX1
lblFFmod1b:	SBC8
			NEXTOPCODE
.pool

			
jumptable2:		.long	Op00mod2
			.long	Op01M1mod2
			.long	Op02mod2
			.long	Op03M1mod2
			.long	Op04M1mod2
			.long	Op05M1mod2
			.long	Op06M1mod2
			.long	Op07M1mod2
			.long	Op08mod2
			.long	Op09M1mod2
			.long	Op0AM1mod2
			.long	Op0Bmod2
			.long	Op0CM1mod2
			.long	Op0DM1mod2
			.long	Op0EM1mod2
			.long	Op0FM1mod2
			.long	Op10mod2
			.long	Op11M1mod2
			.long	Op12M1mod2
			.long	Op13M1mod2
			.long	Op14M1mod2
			.long	Op15M1mod2
			.long	Op16M1mod2
			.long	Op17M1mod2
			.long	Op18mod2
			.long	Op19M1mod2
			.long	Op1AM1mod2
			.long	Op1Bmod2
			.long	Op1CM1mod2
			.long	Op1DM1mod2
			.long	Op1EM1mod2
			.long	Op1FM1mod2
			.long	Op20mod2
			.long	Op21M1mod2
			.long	Op22mod2
			.long	Op23M1mod2
			.long	Op24M1mod2
			.long	Op25M1mod2
			.long	Op26M1mod2
			.long	Op27M1mod2
			.long	Op28mod2
			.long	Op29M1mod2
			.long	Op2AM1mod2
			.long	Op2Bmod2
			.long	Op2CM1mod2
			.long	Op2DM1mod2
			.long	Op2EM1mod2
			.long	Op2FM1mod2
			.long	Op30mod2
			.long	Op31M1mod2
			.long	Op32M1mod2
			.long	Op33M1mod2
			.long	Op34M1mod2
			.long	Op35M1mod2
			.long	Op36M1mod2
			.long	Op37M1mod2
			.long	Op38mod2
			.long	Op39M1mod2
			.long	Op3AM1mod2
			.long	Op3Bmod2
			.long	Op3CM1mod2
			.long	Op3DM1mod2
			.long	Op3EM1mod2
			.long	Op3FM1mod2
			.long	Op40mod2
			.long	Op41M1mod2
			.long	Op42mod2
			.long	Op43M1mod2
			.long	Op44X0mod2
			.long	Op45M1mod2
			.long	Op46M1mod2
			.long	Op47M1mod2
			.long	Op48M1mod2
			.long	Op49M1mod2
			.long	Op4AM1mod2
			.long	Op4Bmod2
			.long	Op4Cmod2
			.long	Op4DM1mod2
			.long	Op4EM1mod2
			.long	Op4FM1mod2
			.long	Op50mod2
			.long	Op51M1mod2
			.long	Op52M1mod2
			.long	Op53M1mod2
			.long	Op54X0mod2
			.long	Op55M1mod2
			.long	Op56M1mod2
			.long	Op57M1mod2
			.long	Op58mod2
			.long	Op59M1mod2
			.long	Op5AX0mod2
			.long	Op5Bmod2
			.long	Op5Cmod2
			.long	Op5DM1mod2
			.long	Op5EM1mod2
			.long	Op5FM1mod2
			.long	Op60mod2
			.long	Op61M1mod2
			.long	Op62mod2
			.long	Op63M1mod2
			.long	Op64M1mod2
			.long	Op65M1mod2
			.long	Op66M1mod2
			.long	Op67M1mod2
			.long	Op68M1mod2
			.long	Op69M1mod2
			.long	Op6AM1mod2
			.long	Op6Bmod2
			.long	Op6Cmod2
			.long	Op6DM1mod2
			.long	Op6EM1mod2
			.long	Op6FM1mod2
			.long	Op70mod2
			.long	Op71M1mod2
			.long	Op72M1mod2
			.long	Op73M1mod2
			.long	Op74M1mod2
			.long	Op75M1mod2
			.long	Op76M1mod2
			.long	Op77M1mod2
			.long	Op78mod2
			.long	Op79M1mod2
			.long	Op7AX0mod2
			.long	Op7Bmod2
			.long	Op7Cmod2
			.long	Op7DM1mod2
			.long	Op7EM1mod2
			.long	Op7FM1mod2
			.long	Op80mod2
			.long	Op81M1mod2
			.long	Op82mod2
			.long	Op83M1mod2
			.long	Op84X0mod2
			.long	Op85M1mod2
			.long	Op86X0mod2
			.long	Op87M1mod2
			.long	Op88X0mod2
			.long	Op89M1mod2
			.long	Op8AM1mod2
			.long	Op8Bmod2
			.long	Op8CX0mod2
			.long	Op8DM1mod2
			.long	Op8EX0mod2
			.long	Op8FM1mod2
			.long	Op90mod2
			.long	Op91M1mod2
			.long	Op92M1mod2
			.long	Op93M1mod2
			.long	Op94X0mod2
			.long	Op95M1mod2
			.long	Op96X0mod2
			.long	Op97M1mod2
			.long	Op98M1mod2
			.long	Op99M1mod2
			.long	Op9Amod2
			.long	Op9BX0mod2
			.long	Op9CM1mod2
			.long	Op9DM1mod2
			.long	Op9EM1mod2
			.long	Op9FM1mod2
			.long	OpA0X0mod2
			.long	OpA1M1mod2
			.long	OpA2X0mod2
			.long	OpA3M1mod2
			.long	OpA4X0mod2
			.long	OpA5M1mod2
			.long	OpA6X0mod2
			.long	OpA7M1mod2
			.long	OpA8X0mod2
			.long	OpA9M1mod2
			.long	OpAAX0mod2
			.long	OpABmod2
			.long	OpACX0mod2
			.long	OpADM1mod2
			.long	OpAEX0mod2
			.long	OpAFM1mod2
			.long	OpB0mod2
			.long	OpB1M1mod2
			.long	OpB2M1mod2
			.long	OpB3M1mod2
			.long	OpB4X0mod2
			.long	OpB5M1mod2
			.long	OpB6X0mod2
			.long	OpB7M1mod2
			.long	OpB8mod2
			.long	OpB9M1mod2
			.long	OpBAX0mod2
			.long	OpBBX0mod2
			.long	OpBCX0mod2
			.long	OpBDM1mod2
			.long	OpBEX0mod2
			.long	OpBFM1mod2
			.long	OpC0X0mod2
			.long	OpC1M1mod2
			.long	OpC2mod2
			.long	OpC3M1mod2
			.long	OpC4X0mod2
			.long	OpC5M1mod2
			.long	OpC6M1mod2
			.long	OpC7M1mod2
			.long	OpC8X0mod2
			.long	OpC9M1mod2
			.long	OpCAX0mod2
			.long	OpCBmod2
			.long	OpCCX0mod2
			.long	OpCDM1mod2
			.long	OpCEM1mod2
			.long	OpCFM1mod2
			.long	OpD0mod2
			.long	OpD1M1mod2
			.long	OpD2M1mod2
			.long	OpD3M1mod2
			.long	OpD4mod2
			.long	OpD5M1mod2
			.long	OpD6M1mod2
			.long	OpD7M1mod2
			.long	OpD8mod2
			.long	OpD9M1mod2
			.long	OpDAX0mod2
			.long	OpDBmod2
			.long	OpDCmod2
			.long	OpDDM1mod2
			.long	OpDEM1mod2
			.long	OpDFM1mod2
			.long	OpE0X0mod2
			.long	OpE1M1mod2
			.long	OpE2mod2
			.long	OpE3M1mod2
			.long	OpE4X0mod2
			.long	OpE5M1mod2
			.long	OpE6M1mod2
			.long	OpE7M1mod2
			.long	OpE8X0mod2
			.long	OpE9M1mod2
			.long	OpEAmod2
			.long	OpEBmod2
			.long	OpECX0mod2
			.long	OpEDM1mod2
			.long	OpEEM1mod2
			.long	OpEFM1mod2
			.long	OpF0mod2
			.long	OpF1M1mod2
			.long	OpF2M1mod2
			.long	OpF3M1mod2
			.long	OpF4mod2
			.long	OpF5M1mod2
			.long	OpF6M1mod2
			.long	OpF7M1mod2
			.long	OpF8mod2
			.long	OpF9M1mod2
			.long	OpFAX0mod2
			.long	OpFBmod2
			.long	OpFCmod2
			.long	OpFDM1mod2
			.long	OpFEM1mod2
			.long	OpFFM1mod2
Op00mod2:
lbl00mod2:	Op00
			NEXTOPCODE
Op01M1mod2:
lbl01mod2a:	DirectIndexedIndirect0
lbl01mod2b:	ORA8
			NEXTOPCODE
Op02mod2:
lbl02mod2:	Op02
			NEXTOPCODE
Op03M1mod2:
lbl03mod2a:	StackasmRelative
lbl03mod2b:	ORA8
			NEXTOPCODE
Op04M1mod2:
lbl04mod2a:	Direct
lbl04mod2b:	TSB8
			NEXTOPCODE
Op05M1mod2:
lbl05mod2a:	Direct
lbl05mod2b:	ORA8
			NEXTOPCODE
Op06M1mod2:
lbl06mod2a:	Direct
lbl06mod2b:	ASL8
			NEXTOPCODE
Op07M1mod2:
lbl07mod2a:	DirectIndirectLong
lbl07mod2b:	ORA8
			NEXTOPCODE
Op08mod2:

lbl08mod2:	Op08
			NEXTOPCODE
Op09M1mod2:
lbl09mod2:	Op09M1
			NEXTOPCODE
Op0AM1mod2:
lbl0Amod2a:	A_ASL8
			NEXTOPCODE
Op0Bmod2:
lbl0Bmod2:	Op0B
			NEXTOPCODE
Op0CM1mod2:
lbl0Cmod2a:	Absolute
lbl0Cmod2b:	TSB8
			NEXTOPCODE
Op0DM1mod2:
lbl0Dmod2a:	Absolute
lbl0Dmod2b:	ORA8
			NEXTOPCODE
Op0EM1mod2:
lbl0Emod2a:	Absolute
lbl0Emod2b:	ASL8
			NEXTOPCODE
Op0FM1mod2:
lbl0Fmod2a:	AbsoluteLong
lbl0Fmod2b:	ORA8
			NEXTOPCODE
Op10mod2:
lbl10mod2:	Op10
			NEXTOPCODE
Op11M1mod2:
lbl11mod2a:	DirectIndirectIndexed0
lbl11mod2b:	ORA8
			NEXTOPCODE
Op12M1mod2:
lbl12mod2a:	DirectIndirect
lbl12mod2b:	ORA8
			NEXTOPCODE
Op13M1mod2:
lbl13mod2a:	StackasmRelativeIndirectIndexed0
lbl13mod2b:	ORA8
			NEXTOPCODE
Op14M1mod2:
lbl14mod2a:	Direct
lbl14mod2b:	TRB8
			NEXTOPCODE
Op15M1mod2:
lbl15mod2a:	DirectIndexedX0
lbl15mod2b:	ORA8
			NEXTOPCODE
Op16M1mod2:
lbl16mod2a:	DirectIndexedX0
lbl16mod2b:	ASL8
			NEXTOPCODE
Op17M1mod2:
lbl17mod2a:	DirectIndirectIndexedLong0
lbl17mod2b:	ORA8
			NEXTOPCODE
Op18mod2:
lbl18mod2:	Op18
			NEXTOPCODE
Op19M1mod2:
lbl19mod2a:	AbsoluteIndexedY0
lbl19mod2b:	ORA8
			NEXTOPCODE
Op1AM1mod2:
lbl1Amod2a:	A_INC8
			NEXTOPCODE
Op1Bmod2:
lbl1Bmod2:	Op1BM1
			NEXTOPCODE
Op1CM1mod2:
lbl1Cmod2a:	Absolute
lbl1Cmod2b:	TRB8
			NEXTOPCODE
Op1DM1mod2:
lbl1Dmod2a:	AbsoluteIndexedX0
lbl1Dmod2b:	ORA8
			NEXTOPCODE
Op1EM1mod2:
lbl1Emod2a:	AbsoluteIndexedX0
lbl1Emod2b:	ASL8
			NEXTOPCODE
Op1FM1mod2:
lbl1Fmod2a:	AbsoluteLongIndexedX0
lbl1Fmod2b:	ORA8
			NEXTOPCODE
Op20mod2:
lbl20mod2:	Op20
			NEXTOPCODE
Op21M1mod2:
lbl21mod2a:	DirectIndexedIndirect0
lbl21mod2b:	AND8
			NEXTOPCODE
Op22mod2:
lbl22mod2:	Op22
			NEXTOPCODE
Op23M1mod2:
lbl23mod2a:	StackasmRelative
lbl23mod2b:	AND8
			NEXTOPCODE
Op24M1mod2:
lbl24mod2a:	Direct
lbl24mod2b:	BIT8
			NEXTOPCODE
Op25M1mod2:
lbl25mod2a:	Direct
lbl25mod2b:	AND8
			NEXTOPCODE
Op26M1mod2:
lbl26mod2a:	Direct
lbl26mod2b:	ROL8
			NEXTOPCODE
Op27M1mod2:
lbl27mod2a:	DirectIndirectLong
lbl27mod2b:	AND8
			NEXTOPCODE
Op28mod2:
lbl28mod2:	Op28X0M1
			NEXTOPCODE
.pool
Op29M1mod2:
lbl29mod2:	Op29M1
			NEXTOPCODE
Op2AM1mod2:
lbl2Amod2a:	A_ROL8
			NEXTOPCODE
Op2Bmod2:
lbl2Bmod2:	Op2B
			NEXTOPCODE
Op2CM1mod2:
lbl2Cmod2a:	Absolute
lbl2Cmod2b:	BIT8
			NEXTOPCODE
Op2DM1mod2:
lbl2Dmod2a:	Absolute
lbl2Dmod2b:	AND8
			NEXTOPCODE
Op2EM1mod2:
lbl2Emod2a:	Absolute
lbl2Emod2b:	ROL8
			NEXTOPCODE
Op2FM1mod2:
lbl2Fmod2a:	AbsoluteLong
lbl2Fmod2b:	AND8
			NEXTOPCODE
Op30mod2:
lbl30mod2:	Op30
			NEXTOPCODE
Op31M1mod2:
lbl31mod2a:	DirectIndirectIndexed0
lbl31mod2b:	AND8
			NEXTOPCODE
Op32M1mod2:
lbl32mod2a:	DirectIndirect
lbl32mod2b:	AND8
			NEXTOPCODE
Op33M1mod2:
lbl33mod2a:	StackasmRelativeIndirectIndexed0
lbl33mod2b:	AND8
			NEXTOPCODE
Op34M1mod2:
lbl34mod2a:	DirectIndexedX0
lbl34mod2b:	BIT8
			NEXTOPCODE
Op35M1mod2:
lbl35mod2a:	DirectIndexedX0
lbl35mod2b:	AND8
			NEXTOPCODE
Op36M1mod2:
lbl36mod2a:	DirectIndexedX0
lbl36mod2b:	ROL8
			NEXTOPCODE
Op37M1mod2:
lbl37mod2a:	DirectIndirectIndexedLong0
lbl37mod2b:	AND8
			NEXTOPCODE
Op38mod2:
lbl38mod2:	Op38
			NEXTOPCODE
Op39M1mod2:
lbl39mod2a:	AbsoluteIndexedY0
lbl39mod2b:	AND8
			NEXTOPCODE
Op3AM1mod2:
lbl3Amod2a:	A_DEC8
			NEXTOPCODE
Op3Bmod2:
lbl3Bmod2:	Op3BM1
			NEXTOPCODE
Op3CM1mod2:
lbl3Cmod2a:	AbsoluteIndexedX0
lbl3Cmod2b:	BIT8
			NEXTOPCODE
Op3DM1mod2:
lbl3Dmod2a:	AbsoluteIndexedX0
lbl3Dmod2b:	AND8
			NEXTOPCODE
Op3EM1mod2:
lbl3Emod2a:	AbsoluteIndexedX0
lbl3Emod2b:	ROL8
			NEXTOPCODE
Op3FM1mod2:
lbl3Fmod2a:	AbsoluteLongIndexedX0
lbl3Fmod2b:	AND8
			NEXTOPCODE
Op40mod2:
lbl40mod2:	Op40X0M1
			NEXTOPCODE
.pool						
Op41M1mod2:
lbl41mod2a:	DirectIndexedIndirect0
lbl41mod2b:	EOR8
			NEXTOPCODE
Op42mod2:
lbl42mod2:	Op42
			NEXTOPCODE
Op43M1mod2:
lbl43mod2a:	StackasmRelative
lbl43mod2b:	EOR8
			NEXTOPCODE
Op44X0mod2:
lbl44mod2:	Op44X0M1
			NEXTOPCODE
Op45M1mod2:
lbl45mod2a:	Direct
lbl45mod2b:	EOR8
			NEXTOPCODE
Op46M1mod2:
lbl46mod2a:	Direct
lbl46mod2b:	LSR8
			NEXTOPCODE
Op47M1mod2:
lbl47mod2a:	DirectIndirectLong
lbl47mod2b:	EOR8
			NEXTOPCODE
Op48M1mod2:
lbl48mod2:	Op48M1
			NEXTOPCODE
Op49M1mod2:
lbl49mod2:	Op49M1
			NEXTOPCODE
Op4AM1mod2:
lbl4Amod2a:	A_LSR8
			NEXTOPCODE
Op4Bmod2:
lbl4Bmod2:	Op4B
			NEXTOPCODE
Op4Cmod2:
lbl4Cmod2:	Op4C
			NEXTOPCODE
Op4DM1mod2:
lbl4Dmod2a:	Absolute
lbl4Dmod2b:	EOR8
			NEXTOPCODE
Op4EM1mod2:
lbl4Emod2a:	Absolute
lbl4Emod2b:	LSR8
			NEXTOPCODE
Op4FM1mod2:
lbl4Fmod2a:	AbsoluteLong
lbl4Fmod2b:	EOR8
			NEXTOPCODE
Op50mod2:
lbl50mod2:	Op50
			NEXTOPCODE
Op51M1mod2:
lbl51mod2a:	DirectIndirectIndexed0
lbl51mod2b:	EOR8
			NEXTOPCODE
Op52M1mod2:
lbl52mod2a:	DirectIndirect
lbl52mod2b:	EOR8
			NEXTOPCODE
Op53M1mod2:
lbl53mod2a:	StackasmRelativeIndirectIndexed0
lbl53mod2b:	EOR8
			NEXTOPCODE
Op54X0mod2:
lbl54mod2:	Op54X0M1
			NEXTOPCODE
Op55M1mod2:
lbl55mod2a:	DirectIndexedX0
lbl55mod2b:	EOR8
			NEXTOPCODE
Op56M1mod2:
lbl56mod2a:	DirectIndexedX0
lbl56mod2b:	LSR8
			NEXTOPCODE
Op57M1mod2:
lbl57mod2a:	DirectIndirectIndexedLong0
lbl57mod2b:	EOR8
			NEXTOPCODE
Op58mod2:
lbl58mod2:	Op58
			NEXTOPCODE
Op59M1mod2:
lbl59mod2a:	AbsoluteIndexedY0
lbl59mod2b:	EOR8
			NEXTOPCODE
Op5AX0mod2:
lbl5Amod2:	Op5AX0
			NEXTOPCODE
Op5Bmod2:
lbl5Bmod2:	Op5BM1
			NEXTOPCODE
Op5Cmod2:
lbl5Cmod2:	Op5C
			NEXTOPCODE
Op5DM1mod2:
lbl5Dmod2a:	AbsoluteIndexedX0
lbl5Dmod2b:	EOR8
			NEXTOPCODE
Op5EM1mod2:
lbl5Emod2a:	AbsoluteIndexedX0
lbl5Emod2b:	LSR8
			NEXTOPCODE
Op5FM1mod2:
lbl5Fmod2a:	AbsoluteLongIndexedX0
lbl5Fmod2b:	EOR8
			NEXTOPCODE
Op60mod2:
lbl60mod2:	Op60
			NEXTOPCODE
Op61M1mod2:
lbl61mod2a:	DirectIndexedIndirect0
lbl61mod2b:	ADC8
			NEXTOPCODE
Op62mod2:
lbl62mod2:	Op62
			NEXTOPCODE
Op63M1mod2:
lbl63mod2a:	StackasmRelative
lbl63mod2b:	ADC8
			NEXTOPCODE
Op64M1mod2:
lbl64mod2a:	Direct
lbl64mod2b:	STZ8
			NEXTOPCODE
Op65M1mod2:
lbl65mod2a:	Direct
lbl65mod2b:	ADC8
			NEXTOPCODE
Op66M1mod2:
lbl66mod2a:	Direct
lbl66mod2b:	ROR8
			NEXTOPCODE
Op67M1mod2:
lbl67mod2a:	DirectIndirectLong
lbl67mod2b:	ADC8
			NEXTOPCODE
Op68M1mod2:
lbl68mod2:	Op68M1
			NEXTOPCODE
Op69M1mod2:
lbl69mod2a:	Immediate8
lbl69mod2b:	ADC8
			NEXTOPCODE
Op6AM1mod2:
lbl6Amod2a:	A_ROR8
			NEXTOPCODE
Op6Bmod2:
lbl6Bmod2:	Op6B
			NEXTOPCODE
Op6Cmod2:
lbl6Cmod2:	Op6C
			NEXTOPCODE
Op6DM1mod2:
lbl6Dmod2a:	Absolute
lbl6Dmod2b:	ADC8
			NEXTOPCODE
Op6EM1mod2:
lbl6Emod2a:	Absolute
lbl6Emod2b:	ROR8
			NEXTOPCODE
Op6FM1mod2:
lbl6Fmod2a:	AbsoluteLong
lbl6Fmod2b:	ADC8
			NEXTOPCODE
Op70mod2:
lbl70mod2:	Op70
			NEXTOPCODE
Op71M1mod2:
lbl71mod2a:	DirectIndirectIndexed0
lbl71mod2b:	ADC8
			NEXTOPCODE
Op72M1mod2:
lbl72mod2a:	DirectIndirect
lbl72mod2b:	ADC8
			NEXTOPCODE
Op73M1mod2:
lbl73mod2a:	StackasmRelativeIndirectIndexed0
lbl73mod2b:	ADC8
			NEXTOPCODE
Op74M1mod2:
lbl74mod2a:	DirectIndexedX0
lbl74mod2b:	STZ8
			NEXTOPCODE
Op75M1mod2:
lbl75mod2a:	DirectIndexedX0
lbl75mod2b:	ADC8
			NEXTOPCODE
Op76M1mod2:
lbl76mod2a:	DirectIndexedX0
lbl76mod2b:	ROR8
			NEXTOPCODE
Op77M1mod2:
lbl77mod2a:	DirectIndirectIndexedLong0
lbl77mod2b:	ADC8
			NEXTOPCODE
Op78mod2:
lbl78mod2:	Op78
			NEXTOPCODE
Op79M1mod2:
lbl79mod2a:	AbsoluteIndexedY0
lbl79mod2b:	ADC8
			NEXTOPCODE
Op7AX0mod2:
lbl7Amod2:	Op7AX0
			NEXTOPCODE
Op7Bmod2:
lbl7Bmod2:	Op7BM1
			NEXTOPCODE
Op7Cmod2:
lbl7Cmod2:	AbsoluteIndexedIndirectX0
		Op7C
			NEXTOPCODE
Op7DM1mod2:
lbl7Dmod2a:	AbsoluteIndexedX0
lbl7Dmod2b:	ADC8
			NEXTOPCODE
Op7EM1mod2:
lbl7Emod2a:	AbsoluteIndexedX0
lbl7Emod2b:	ROR8
			NEXTOPCODE
Op7FM1mod2:
lbl7Fmod2a:	AbsoluteLongIndexedX0
lbl7Fmod2b:	ADC8
			NEXTOPCODE


Op80mod2:
lbl80mod2:	Op80
			NEXTOPCODE
Op81M1mod2:
lbl81mod2a:	DirectIndexedIndirect0
lbl81mod2b:	Op81M1
			NEXTOPCODE
Op82mod2:
lbl82mod2:	Op82
			NEXTOPCODE
Op83M1mod2:
lbl83mod2a:	StackasmRelative
lbl83mod2b:	STA8
			NEXTOPCODE
Op84X0mod2:
lbl84mod2a:	Direct
lbl84mod2b:	STY16
			NEXTOPCODE
Op85M1mod2:
lbl85mod2a:	Direct
lbl85mod2b:	STA8
			NEXTOPCODE
Op86X0mod2:
lbl86mod2a:	Direct
lbl86mod2b:	STX16
			NEXTOPCODE
Op87M1mod2:
lbl87mod2a:	DirectIndirectLong
lbl87mod2b:	STA8
			NEXTOPCODE
Op88X0mod2:
lbl88mod2:	Op88X0
			NEXTOPCODE
Op89M1mod2:
lbl89mod2:	Op89M1
			NEXTOPCODE
Op8AM1mod2:
lbl8Amod2:	Op8AM1X0
			NEXTOPCODE
Op8Bmod2:
lbl8Bmod2:	Op8B
			NEXTOPCODE
Op8CX0mod2:
lbl8Cmod2a:	Absolute
lbl8Cmod2b:	STY16
			NEXTOPCODE
Op8DM1mod2:
lbl8Dmod2a:	Absolute
lbl8Dmod2b:	STA8
			NEXTOPCODE
Op8EX0mod2:
lbl8Emod2a:	Absolute
lbl8Emod2b:	STX16
			NEXTOPCODE
Op8FM1mod2:
lbl8Fmod2a:	AbsoluteLong
lbl8Fmod2b:	STA8
			NEXTOPCODE
Op90mod2:
lbl90mod2:	Op90
			NEXTOPCODE
Op91M1mod2:
lbl91mod2a:	DirectIndirectIndexed0
lbl91mod2b:	STA8
			NEXTOPCODE
Op92M1mod2:
lbl92mod2a:	DirectIndirect
lbl92mod2b:	STA8
			NEXTOPCODE
Op93M1mod2:
lbl93mod2a:	StackasmRelativeIndirectIndexed0
lbl93mod2b:	STA8
			NEXTOPCODE
Op94X0mod2:
lbl94mod2a:	DirectIndexedX0
lbl94mod2b:	STY16
			NEXTOPCODE
Op95M1mod2:

lbl95mod2a:	DirectIndexedX0
lbl95mod2b:	STA8
			NEXTOPCODE
Op96X0mod2:
lbl96mod2a:	DirectIndexedY0
lbl96mod2b:	STX16
			NEXTOPCODE
Op97M1mod2:
lbl97mod2a:	DirectIndirectIndexedLong0
lbl97mod2b:	STA8
			NEXTOPCODE
Op98M1mod2:
lbl98mod2:	Op98M1X0
			NEXTOPCODE
Op99M1mod2:
lbl99mod2a:	AbsoluteIndexedY0
lbl99mod2b:	STA8
			NEXTOPCODE
Op9Amod2:
lbl9Amod2:	Op9AX0
			NEXTOPCODE
Op9BX0mod2:
lbl9Bmod2:	Op9BX0
			NEXTOPCODE
Op9CM1mod2:
lbl9Cmod2a:	Absolute
lbl9Cmod2b:	STZ8
			NEXTOPCODE
Op9DM1mod2:
lbl9Dmod2a:	AbsoluteIndexedX0
lbl9Dmod2b:	STA8
			NEXTOPCODE
Op9EM1mod2:	
lbl9Emod2:	AbsoluteIndexedX0		
		STZ8
			NEXTOPCODE
Op9FM1mod2:
lbl9Fmod2a:	AbsoluteLongIndexedX0
lbl9Fmod2b:	STA8
			NEXTOPCODE
OpA0X0mod2:
lblA0mod2:	OpA0X0
			NEXTOPCODE
OpA1M1mod2:
lblA1mod2a:	DirectIndexedIndirect0
lblA1mod2b:	LDA8
			NEXTOPCODE
OpA2X0mod2:
lblA2mod2:	OpA2X0
			NEXTOPCODE
OpA3M1mod2:
lblA3mod2a:	StackasmRelative
lblA3mod2b:	LDA8
			NEXTOPCODE
OpA4X0mod2:
lblA4mod2a:	Direct
lblA4mod2b:	LDY16
			NEXTOPCODE
OpA5M1mod2:
lblA5mod2a:	Direct
lblA5mod2b:	LDA8
			NEXTOPCODE
OpA6X0mod2:
lblA6mod2a:	Direct
lblA6mod2b:	LDX16
			NEXTOPCODE
OpA7M1mod2:
lblA7mod2a:	DirectIndirectLong
lblA7mod2b:	LDA8
			NEXTOPCODE
OpA8X0mod2:
lblA8mod2:	OpA8X0M1
			NEXTOPCODE
OpA9M1mod2:
lblA9mod2:	OpA9M1
			NEXTOPCODE
OpAAX0mod2:
lblAAmod2:	OpAAX0M1
			NEXTOPCODE
OpABmod2:
lblABmod2:	OpAB
			NEXTOPCODE
OpACX0mod2:
lblACmod2a:	Absolute
lblACmod2b:	LDY16
			NEXTOPCODE
OpADM1mod2:
lblADmod2a:	Absolute
lblADmod2b:	LDA8
			NEXTOPCODE
OpAEX0mod2:
lblAEmod2a:	Absolute
lblAEmod2b:	LDX16
			NEXTOPCODE
OpAFM1mod2:
lblAFmod2a:	AbsoluteLong
lblAFmod2b:	LDA8
			NEXTOPCODE
OpB0mod2:
lblB0mod2:	OpB0
			NEXTOPCODE
OpB1M1mod2:
lblB1mod2a:	DirectIndirectIndexed0
lblB1mod2b:	LDA8
			NEXTOPCODE
OpB2M1mod2:
lblB2mod2a:	DirectIndirect
lblB2mod2b:	LDA8
			NEXTOPCODE
OpB3M1mod2:
lblB3mod2a:	StackasmRelativeIndirectIndexed0
lblB3mod2b:	LDA8
			NEXTOPCODE
OpB4X0mod2:
lblB4mod2a:	DirectIndexedX0
lblB4mod2b:	LDY16
			NEXTOPCODE
OpB5M1mod2:
lblB5mod2a:	DirectIndexedX0
lblB5mod2b:	LDA8
			NEXTOPCODE
OpB6X0mod2:
lblB6mod2a:	DirectIndexedY0
lblB6mod2b:	LDX16
			NEXTOPCODE
OpB7M1mod2:
lblB7mod2a:	DirectIndirectIndexedLong0
lblB7mod2b:	LDA8
			NEXTOPCODE
OpB8mod2:
lblB8mod2:	OpB8
			NEXTOPCODE
OpB9M1mod2:
lblB9mod2a:	AbsoluteIndexedY0
lblB9mod2b:	LDA8
			NEXTOPCODE
OpBAX0mod2:
lblBAmod2:	OpBAX0
			NEXTOPCODE
OpBBX0mod2:
lblBBmod2:	OpBBX0
			NEXTOPCODE
OpBCX0mod2:
lblBCmod2a:	AbsoluteIndexedX0
lblBCmod2b:	LDY16
			NEXTOPCODE
OpBDM1mod2:
lblBDmod2a:	AbsoluteIndexedX0
lblBDmod2b:	LDA8
			NEXTOPCODE
OpBEX0mod2:
lblBEmod2a:	AbsoluteIndexedY0
lblBEmod2b:	LDX16
			NEXTOPCODE
OpBFM1mod2:
lblBFmod2a:	AbsoluteLongIndexedX0
lblBFmod2b:	LDA8
			NEXTOPCODE
OpC0X0mod2:
lblC0mod2:	OpC0X0
			NEXTOPCODE
OpC1M1mod2:
lblC1mod2a:	DirectIndexedIndirect0
lblC1mod2b:	CMP8
			NEXTOPCODE
OpC2mod2:
lblC2mod2:	OpC2
			NEXTOPCODE
.pool
OpC3M1mod2:
lblC3mod2a:	StackasmRelative
lblC3mod2b:	CMP8
			NEXTOPCODE
OpC4X0mod2:
lblC4mod2a:	Direct
lblC4mod2b:	CMY16
			NEXTOPCODE
OpC5M1mod2:
lblC5mod2a:	Direct
lblC5mod2b:	CMP8
			NEXTOPCODE
OpC6M1mod2:
lblC6mod2a:	Direct
lblC6mod2b:	DEC8
			NEXTOPCODE
OpC7M1mod2:
lblC7mod2a:	DirectIndirectLong
lblC7mod2b:	CMP8
			NEXTOPCODE
OpC8X0mod2:
lblC8mod2:	OpC8X0
			NEXTOPCODE
OpC9M1mod2:
lblC9mod2:	OpC9M1
			NEXTOPCODE
OpCAX0mod2:
lblCAmod2:	OpCAX0
			NEXTOPCODE
OpCBmod2:
lblCBmod2:	OpCB
			NEXTOPCODE
OpCCX0mod2:
lblCCmod2a:	Absolute
lblCCmod2b:	CMY16
			NEXTOPCODE
OpCDM1mod2:
lblCDmod2a:	Absolute
lblCDmod2b:	CMP8
			NEXTOPCODE
OpCEM1mod2:
lblCEmod2a:	Absolute
lblCEmod2b:	DEC8
			NEXTOPCODE
OpCFM1mod2:
lblCFmod2a:	AbsoluteLong
lblCFmod2b:	CMP8
			NEXTOPCODE
OpD0mod2:
lblD0mod2:	OpD0
			NEXTOPCODE
OpD1M1mod2:
lblD1mod2a:	DirectIndirectIndexed0
lblD1mod2b:	CMP8
			NEXTOPCODE
OpD2M1mod2:
lblD2mod2a:	DirectIndirect
lblD2mod2b:	CMP8
			NEXTOPCODE
OpD3M1mod2:
lblD3mod2a:	StackasmRelativeIndirectIndexed0
lblD3mod2b:	CMP8
			NEXTOPCODE
OpD4mod2:
lblD4mod2:	OpD4
			NEXTOPCODE
OpD5M1mod2:
lblD5mod2a:	DirectIndexedX0
lblD5mod2b:	CMP8
			NEXTOPCODE
OpD6M1mod2:
lblD6mod2a:	DirectIndexedX0
lblD6mod2b:	DEC8
			NEXTOPCODE
OpD7M1mod2:
lblD7mod2a:	DirectIndirectIndexedLong0
lblD7mod2b:	CMP8
			NEXTOPCODE
OpD8mod2:
lblD8mod2:	OpD8
			NEXTOPCODE
OpD9M1mod2:
lblD9mod2a:	AbsoluteIndexedY0
lblD9mod2b:	CMP8
			NEXTOPCODE
OpDAX0mod2:
lblDAmod2:	OpDAX0
			NEXTOPCODE
OpDBmod2:
lblDBmod2:	OpDB
			NEXTOPCODE
OpDCmod2:
lblDCmod2:	OpDC
			NEXTOPCODE
OpDDM1mod2:
lblDDmod2a:	AbsoluteIndexedX0
lblDDmod2b:	CMP8
			NEXTOPCODE
OpDEM1mod2:
lblDEmod2a:	AbsoluteIndexedX0
lblDEmod2b:	DEC8
			NEXTOPCODE
OpDFM1mod2:
lblDFmod2a:	AbsoluteLongIndexedX0
lblDFmod2b:	CMP8
			NEXTOPCODE
OpE0X0mod2:
lblE0mod2:	OpE0X0
			NEXTOPCODE
OpE1M1mod2:
lblE1mod2a:	DirectIndexedIndirect0
lblE1mod2b:	SBC8
			NEXTOPCODE
OpE2mod2:
lblE2mod2:	OpE2
			NEXTOPCODE
.pool
OpE3M1mod2:
lblE3mod2a:	StackasmRelative
lblE3mod2b:	SBC8
			NEXTOPCODE
OpE4X0mod2:
lblE4mod2a:	Direct
lblE4mod2b:	CMX16
			NEXTOPCODE
OpE5M1mod2:
lblE5mod2a:	Direct
lblE5mod2b:	SBC8
			NEXTOPCODE
OpE6M1mod2:
lblE6mod2a:	Direct
lblE6mod2b:	INC8
			NEXTOPCODE
OpE7M1mod2:
lblE7mod2a:	DirectIndirectLong
lblE7mod2b:	SBC8
			NEXTOPCODE
OpE8X0mod2:
lblE8mod2:	OpE8X0
			NEXTOPCODE
OpE9M1mod2:
lblE9mod2a:	Immediate8
lblE9mod2b:	SBC8
			NEXTOPCODE
OpEAmod2:
lblEAmod2:	OpEA
			NEXTOPCODE
OpEBmod2:
lblEBmod2:	OpEBM1
			NEXTOPCODE
OpECX0mod2:
lblECmod2a:	Absolute
lblECmod2b:	CMX16
			NEXTOPCODE
OpEDM1mod2:
lblEDmod2a:	Absolute
lblEDmod2b:	SBC8
			NEXTOPCODE
OpEEM1mod2:
lblEEmod2a:	Absolute
lblEEmod2b:	INC8
			NEXTOPCODE
OpEFM1mod2:
lblEFmod2a:	AbsoluteLong
lblEFmod2b:	SBC8
			NEXTOPCODE
OpF0mod2:
lblF0mod2:	OpF0
			NEXTOPCODE
OpF1M1mod2:
lblF1mod2a:	DirectIndirectIndexed0
lblF1mod2b:	SBC8
			NEXTOPCODE
OpF2M1mod2:
lblF2mod2a:	DirectIndirect
lblF2mod2b:	SBC8
			NEXTOPCODE
OpF3M1mod2:
lblF3mod2a:	StackasmRelativeIndirectIndexed0
lblF3mod2b:	SBC8
			NEXTOPCODE
OpF4mod2:
lblF4mod2:	OpF4
			NEXTOPCODE
OpF5M1mod2:
lblF5mod2a:	DirectIndexedX0
lblF5mod2b:	SBC8
			NEXTOPCODE
OpF6M1mod2:
lblF6mod2a:	DirectIndexedX0
lblF6mod2b:	INC8
			NEXTOPCODE
OpF7M1mod2:
lblF7mod2a:	DirectIndirectIndexedLong0
lblF7mod2b:	SBC8
			NEXTOPCODE
OpF8mod2:
lblF8mod2:	OpF8
			NEXTOPCODE
OpF9M1mod2:
lblF9mod2a:	AbsoluteIndexedY0
lblF9mod2b:	SBC8
			NEXTOPCODE
OpFAX0mod2:
lblFAmod2:	OpFAX0
			NEXTOPCODE
OpFBmod2:
lblFBmod2:	OpFB
			NEXTOPCODE
OpFCmod2:
lblFCmod2:	OpFCX0
			NEXTOPCODE
OpFDM1mod2:
lblFDmod2a:	AbsoluteIndexedX0
lblFDmod2b:	SBC8
			NEXTOPCODE
OpFEM1mod2:
lblFEmod2a:	AbsoluteIndexedX0
lblFEmod2b:	INC8
			NEXTOPCODE
OpFFM1mod2:
lblFFmod2a:	AbsoluteLongIndexedX0
lblFFmod2b:	SBC8
			NEXTOPCODE

.pool


jumptable3:		.long	Op00mod3
			.long	Op01M0mod3
			.long	Op02mod3
			.long	Op03M0mod3
			.long	Op04M0mod3
			.long	Op05M0mod3
			.long	Op06M0mod3
			.long	Op07M0mod3
			.long	Op08mod3
			.long	Op09M0mod3
			.long	Op0AM0mod3
			.long	Op0Bmod3
			.long	Op0CM0mod3
			.long	Op0DM0mod3
			.long	Op0EM0mod3
			.long	Op0FM0mod3
			.long	Op10mod3
			.long	Op11M0mod3
			.long	Op12M0mod3
			.long	Op13M0mod3
			.long	Op14M0mod3
			.long	Op15M0mod3
			.long	Op16M0mod3
			.long	Op17M0mod3
			.long	Op18mod3
			.long	Op19M0mod3
			.long	Op1AM0mod3
			.long	Op1Bmod3
			.long	Op1CM0mod3
			.long	Op1DM0mod3
			.long	Op1EM0mod3
			.long	Op1FM0mod3
			.long	Op20mod3
			.long	Op21M0mod3
			.long	Op22mod3
			.long	Op23M0mod3
			.long	Op24M0mod3
			.long	Op25M0mod3
			.long	Op26M0mod3
			.long	Op27M0mod3
			.long	Op28mod3
			.long	Op29M0mod3
			.long	Op2AM0mod3
			.long	Op2Bmod3
			.long	Op2CM0mod3
			.long	Op2DM0mod3
			.long	Op2EM0mod3
			.long	Op2FM0mod3
			.long	Op30mod3
			.long	Op31M0mod3
			.long	Op32M0mod3
			.long	Op33M0mod3
			.long	Op34M0mod3
			.long	Op35M0mod3
			.long	Op36M0mod3
			.long	Op37M0mod3
			.long	Op38mod3
			.long	Op39M0mod3
			.long	Op3AM0mod3
			.long	Op3Bmod3
			.long	Op3CM0mod3
			.long	Op3DM0mod3
			.long	Op3EM0mod3
			.long	Op3FM0mod3
			.long	Op40mod3
			.long	Op41M0mod3
			.long	Op42mod3
			.long	Op43M0mod3
			.long	Op44X0mod3
			.long	Op45M0mod3
			.long	Op46M0mod3
			.long	Op47M0mod3
			.long	Op48M0mod3
			.long	Op49M0mod3
			.long	Op4AM0mod3
			.long	Op4Bmod3
			.long	Op4Cmod3
			.long	Op4DM0mod3
			.long	Op4EM0mod3
			.long	Op4FM0mod3
			.long	Op50mod3
			.long	Op51M0mod3
			.long	Op52M0mod3
			.long	Op53M0mod3
			.long	Op54X0mod3
			.long	Op55M0mod3
			.long	Op56M0mod3
			.long	Op57M0mod3
			.long	Op58mod3
			.long	Op59M0mod3
			.long	Op5AX0mod3
			.long	Op5Bmod3
			.long	Op5Cmod3
			.long	Op5DM0mod3
			.long	Op5EM0mod3
			.long	Op5FM0mod3
			.long	Op60mod3
			.long	Op61M0mod3
			.long	Op62mod3
			.long	Op63M0mod3
			.long	Op64M0mod3
			.long	Op65M0mod3
			.long	Op66M0mod3
			.long	Op67M0mod3
			.long	Op68M0mod3
			.long	Op69M0mod3
			.long	Op6AM0mod3
			.long	Op6Bmod3
			.long	Op6Cmod3
			.long	Op6DM0mod3
			.long	Op6EM0mod3
			.long	Op6FM0mod3
			.long	Op70mod3
			.long	Op71M0mod3
			.long	Op72M0mod3
			.long	Op73M0mod3
			.long	Op74M0mod3
			.long	Op75M0mod3
			.long	Op76M0mod3
			.long	Op77M0mod3
			.long	Op78mod3
			.long	Op79M0mod3
			.long	Op7AX0mod3
			.long	Op7Bmod3
			.long	Op7Cmod3
			.long	Op7DM0mod3
			.long	Op7EM0mod3
			.long	Op7FM0mod3
			.long	Op80mod3
			.long	Op81M0mod3
			.long	Op82mod3
			.long	Op83M0mod3
			.long	Op84X0mod3
			.long	Op85M0mod3
			.long	Op86X0mod3
			.long	Op87M0mod3
			.long	Op88X0mod3
			.long	Op89M0mod3
			.long	Op8AM0mod3
			.long	Op8Bmod3
			.long	Op8CX0mod3
			.long	Op8DM0mod3
			.long	Op8EX0mod3
			.long	Op8FM0mod3
			.long	Op90mod3
			.long	Op91M0mod3
			.long	Op92M0mod3
			.long	Op93M0mod3
			.long	Op94X0mod3
			.long	Op95M0mod3
			.long	Op96X0mod3
			.long	Op97M0mod3
			.long	Op98M0mod3
			.long	Op99M0mod3
			.long	Op9Amod3
			.long	Op9BX0mod3
			.long	Op9CM0mod3
			.long	Op9DM0mod3
			.long	Op9EM0mod3
			.long	Op9FM0mod3
			.long	OpA0X0mod3
			.long	OpA1M0mod3
			.long	OpA2X0mod3
			.long	OpA3M0mod3
			.long	OpA4X0mod3
			.long	OpA5M0mod3
			.long	OpA6X0mod3
			.long	OpA7M0mod3
			.long	OpA8X0mod3
			.long	OpA9M0mod3
			.long	OpAAX0mod3
			.long	OpABmod3
			.long	OpACX0mod3
			.long	OpADM0mod3
			.long	OpAEX0mod3
			.long	OpAFM0mod3
			.long	OpB0mod3
			.long	OpB1M0mod3
			.long	OpB2M0mod3
			.long	OpB3M0mod3
			.long	OpB4X0mod3
			.long	OpB5M0mod3
			.long	OpB6X0mod3
			.long	OpB7M0mod3
			.long	OpB8mod3
			.long	OpB9M0mod3
			.long	OpBAX0mod3
			.long	OpBBX0mod3
			.long	OpBCX0mod3
			.long	OpBDM0mod3
			.long	OpBEX0mod3
			.long	OpBFM0mod3
			.long	OpC0X0mod3
			.long	OpC1M0mod3
			.long	OpC2mod3
			.long	OpC3M0mod3
			.long	OpC4X0mod3
			.long	OpC5M0mod3
			.long	OpC6M0mod3
			.long	OpC7M0mod3
			.long	OpC8X0mod3
			.long	OpC9M0mod3
			.long	OpCAX0mod3
			.long	OpCBmod3
			.long	OpCCX0mod3
			.long	OpCDM0mod3
			.long	OpCEM0mod3
			.long	OpCFM0mod3
			.long	OpD0mod3
			.long	OpD1M0mod3
			.long	OpD2M0mod3
			.long	OpD3M0mod3
			.long	OpD4mod3
			.long	OpD5M0mod3
			.long	OpD6M0mod3
			.long	OpD7M0mod3
			.long	OpD8mod3
			.long	OpD9M0mod3
			.long	OpDAX0mod3
			.long	OpDBmod3
			.long	OpDCmod3
			.long	OpDDM0mod3
			.long	OpDEM0mod3
			.long	OpDFM0mod3
			.long	OpE0X0mod3
			.long	OpE1M0mod3
			.long	OpE2mod3
			.long	OpE3M0mod3
			.long	OpE4X0mod3
			.long	OpE5M0mod3
			.long	OpE6M0mod3
			.long	OpE7M0mod3
			.long	OpE8X0mod3
			.long	OpE9M0mod3
			.long	OpEAmod3
			.long	OpEBmod3
			.long	OpECX0mod3
			.long	OpEDM0mod3
			.long	OpEEM0mod3
			.long	OpEFM0mod3
			.long	OpF0mod3
			.long	OpF1M0mod3
			.long	OpF2M0mod3
			.long	OpF3M0mod3
			.long	OpF4mod3
			.long	OpF5M0mod3
			.long	OpF6M0mod3
			.long	OpF7M0mod3
			.long	OpF8mod3
			.long	OpF9M0mod3
			.long	OpFAX0mod3
			.long	OpFBmod3
			.long	OpFCmod3
			.long	OpFDM0mod3
			.long	OpFEM0mod3
			.long	OpFFM0mod3
Op00mod3:
lbl00mod3:	Op00
			NEXTOPCODE
Op01M0mod3:
lbl01mod3a:	DirectIndexedIndirect0
lbl01mod3b:	ORA16
			NEXTOPCODE
Op02mod3:
lbl02mod3:	Op02
			NEXTOPCODE
Op03M0mod3:
lbl03mod3a:	StackasmRelative
lbl03mod3b:	ORA16
			NEXTOPCODE
Op04M0mod3:
lbl04mod3a:	Direct
lbl04mod3b:	TSB16
			NEXTOPCODE
Op05M0mod3:
lbl05mod3a:	Direct
lbl05mod3b:	ORA16
			NEXTOPCODE
Op06M0mod3:
lbl06mod3a:	Direct
lbl06mod3b:	ASL16
			NEXTOPCODE
Op07M0mod3:
lbl07mod3a:	DirectIndirectLong
lbl07mod3b:	ORA16
			NEXTOPCODE
Op08mod3:
lbl08mod3:	Op08
			NEXTOPCODE
Op09M0mod3:
lbl09mod3:	Op09M0
			NEXTOPCODE
Op0AM0mod3:
lbl0Amod3a:	A_ASL16
			NEXTOPCODE
Op0Bmod3:
lbl0Bmod3:	Op0B
			NEXTOPCODE
Op0CM0mod3:
lbl0Cmod3a:	Absolute
lbl0Cmod3b:	TSB16
			NEXTOPCODE
Op0DM0mod3:
lbl0Dmod3a:	Absolute
lbl0Dmod3b:	ORA16
			NEXTOPCODE
Op0EM0mod3:
lbl0Emod3a:	Absolute
lbl0Emod3b:	ASL16
			NEXTOPCODE
Op0FM0mod3:
lbl0Fmod3a:	AbsoluteLong
lbl0Fmod3b:	ORA16
			NEXTOPCODE
Op10mod3:
lbl10mod3:	Op10
			NEXTOPCODE
Op11M0mod3:
lbl11mod3a:	DirectIndirectIndexed0
lbl11mod3b:	ORA16
			NEXTOPCODE
Op12M0mod3:
lbl12mod3a:	DirectIndirect
lbl12mod3b:	ORA16
			NEXTOPCODE
Op13M0mod3:
lbl13mod3a:	StackasmRelativeIndirectIndexed0
lbl13mod3b:	ORA16
			NEXTOPCODE
Op14M0mod3:
lbl14mod3a:	Direct
lbl14mod3b:	TRB16
			NEXTOPCODE
Op15M0mod3:
lbl15mod3a:	DirectIndexedX0
lbl15mod3b:	ORA16
			NEXTOPCODE
Op16M0mod3:
lbl16mod3a:	DirectIndexedX0
lbl16mod3b:	ASL16
			NEXTOPCODE
Op17M0mod3:
lbl17mod3a:	DirectIndirectIndexedLong0
lbl17mod3b:	ORA16
			NEXTOPCODE
Op18mod3:
lbl18mod3:	Op18
			NEXTOPCODE
Op19M0mod3:
lbl19mod3a:	AbsoluteIndexedY0
lbl19mod3b:	ORA16
			NEXTOPCODE
Op1AM0mod3:
lbl1Amod3a:	A_INC16
			NEXTOPCODE
Op1Bmod3:
lbl1Bmod3:	Op1BM0
			NEXTOPCODE
Op1CM0mod3:
lbl1Cmod3a:	Absolute
lbl1Cmod3b:	TRB16
			NEXTOPCODE
Op1DM0mod3:
lbl1Dmod3a:	AbsoluteIndexedX0
lbl1Dmod3b:	ORA16
			NEXTOPCODE
Op1EM0mod3:
lbl1Emod3a:	AbsoluteIndexedX0
lbl1Emod3b:	ASL16
			NEXTOPCODE
Op1FM0mod3:
lbl1Fmod3a:	AbsoluteLongIndexedX0
lbl1Fmod3b:	ORA16
			NEXTOPCODE
Op20mod3:
lbl20mod3:	Op20
			NEXTOPCODE
Op21M0mod3:
lbl21mod3a:	DirectIndexedIndirect0
lbl21mod3b:	AND16
			NEXTOPCODE
Op22mod3:
lbl22mod3:	Op22
			NEXTOPCODE
Op23M0mod3:
lbl23mod3a:	StackasmRelative
lbl23mod3b:	AND16
			NEXTOPCODE
Op24M0mod3:
lbl24mod3a:	Direct
lbl24mod3b:	BIT16
			NEXTOPCODE
Op25M0mod3:
lbl25mod3a:	Direct
lbl25mod3b:	AND16
			NEXTOPCODE
Op26M0mod3:
lbl26mod3a:	Direct
lbl26mod3b:	ROL16
			NEXTOPCODE
Op27M0mod3:
lbl27mod3a:	DirectIndirectLong

lbl27mod3b:	AND16
			NEXTOPCODE
Op28mod3:
lbl28mod3:	Op28X0M0
			NEXTOPCODE
.pool
Op29M0mod3:
lbl29mod3:	Op29M0
			NEXTOPCODE
Op2AM0mod3:
lbl2Amod3a:	A_ROL16
			NEXTOPCODE
Op2Bmod3:
lbl2Bmod3:	Op2B
			NEXTOPCODE
Op2CM0mod3:
lbl2Cmod3a:	Absolute
lbl2Cmod3b:	BIT16
			NEXTOPCODE
Op2DM0mod3:
lbl2Dmod3a:	Absolute
lbl2Dmod3b:	AND16
			NEXTOPCODE
Op2EM0mod3:
lbl2Emod3a:	Absolute
lbl2Emod3b:	ROL16
			NEXTOPCODE
Op2FM0mod3:
lbl2Fmod3a:	AbsoluteLong
lbl2Fmod3b:	AND16
			NEXTOPCODE
Op30mod3:
lbl30mod3:	Op30
			NEXTOPCODE
Op31M0mod3:
lbl31mod3a:	DirectIndirectIndexed0
lbl31mod3b:	AND16
			NEXTOPCODE
Op32M0mod3:
lbl32mod3a:	DirectIndirect
lbl32mod3b:	AND16
			NEXTOPCODE
Op33M0mod3:
lbl33mod3a:	StackasmRelativeIndirectIndexed0
lbl33mod3b:	AND16
			NEXTOPCODE
Op34M0mod3:
lbl34mod3a:	DirectIndexedX0
lbl34mod3b:	BIT16
			NEXTOPCODE
Op35M0mod3:
lbl35mod3a:	DirectIndexedX0
lbl35mod3b:	AND16
			NEXTOPCODE
Op36M0mod3:
lbl36mod3a:	DirectIndexedX0
lbl36mod3b:	ROL16
			NEXTOPCODE
Op37M0mod3:
lbl37mod3a:	DirectIndirectIndexedLong0
lbl37mod3b:	AND16
			NEXTOPCODE
Op38mod3:
lbl38mod3:	Op38
			NEXTOPCODE
Op39M0mod3:
lbl39mod3a:	AbsoluteIndexedY0
lbl39mod3b:	AND16
			NEXTOPCODE
Op3AM0mod3:
lbl3Amod3a:	A_DEC16
			NEXTOPCODE
Op3Bmod3:
lbl3Bmod3:	Op3BM0
			NEXTOPCODE
Op3CM0mod3:
lbl3Cmod3a:	AbsoluteIndexedX0
lbl3Cmod3b:	BIT16
			NEXTOPCODE
Op3DM0mod3:
lbl3Dmod3a:	AbsoluteIndexedX0
lbl3Dmod3b:	AND16
			NEXTOPCODE
Op3EM0mod3:
lbl3Emod3a:	AbsoluteIndexedX0
lbl3Emod3b:	ROL16
			NEXTOPCODE
Op3FM0mod3:
lbl3Fmod3a:	AbsoluteLongIndexedX0
lbl3Fmod3b:	AND16
			NEXTOPCODE
Op40mod3:
lbl40mod3:	Op40X0M0
			NEXTOPCODE
.pool						
Op41M0mod3:
lbl41mod3a:	DirectIndexedIndirect0
lbl41mod3b:	EOR16
			NEXTOPCODE
Op42mod3:
lbl42mod3:	Op42
			NEXTOPCODE
Op43M0mod3:
lbl43mod3a:	StackasmRelative
lbl43mod3b:	EOR16
			NEXTOPCODE
Op44X0mod3:
lbl44mod3:	Op44X0M0
			NEXTOPCODE
Op45M0mod3:
lbl45mod3a:	Direct
lbl45mod3b:	EOR16
			NEXTOPCODE
Op46M0mod3:
lbl46mod3a:	Direct
lbl46mod3b:	LSR16
			NEXTOPCODE
Op47M0mod3:
lbl47mod3a:	DirectIndirectLong
lbl47mod3b:	EOR16
			NEXTOPCODE
Op48M0mod3:
lbl48mod3:	Op48M0
			NEXTOPCODE
Op49M0mod3:
lbl49mod3:	Op49M0
			NEXTOPCODE
Op4AM0mod3:
lbl4Amod3a:	A_LSR16
			NEXTOPCODE
Op4Bmod3:
lbl4Bmod3:	Op4B
			NEXTOPCODE
Op4Cmod3:
lbl4Cmod3:	Op4C
			NEXTOPCODE
Op4DM0mod3:
lbl4Dmod3a:	Absolute
lbl4Dmod3b:	EOR16
			NEXTOPCODE
Op4EM0mod3:
lbl4Emod3a:	Absolute
lbl4Emod3b:	LSR16
			NEXTOPCODE
Op4FM0mod3:
lbl4Fmod3a:	AbsoluteLong
lbl4Fmod3b:	EOR16
			NEXTOPCODE
Op50mod3:
lbl50mod3:	Op50
			NEXTOPCODE
Op51M0mod3:
lbl51mod3a:	DirectIndirectIndexed0
lbl51mod3b:	EOR16
			NEXTOPCODE
Op52M0mod3:
lbl52mod3a:	DirectIndirect
lbl52mod3b:	EOR16
			NEXTOPCODE
Op53M0mod3:
lbl53mod3a:	StackasmRelativeIndirectIndexed0
lbl53mod3b:	EOR16
			NEXTOPCODE
Op54X0mod3:
lbl54mod3:	Op54X0M0
			NEXTOPCODE
Op55M0mod3:
lbl55mod3a:	DirectIndexedX0
lbl55mod3b:	EOR16
			NEXTOPCODE
Op56M0mod3:
lbl56mod3a:	DirectIndexedX0
lbl56mod3b:	LSR16
			NEXTOPCODE
Op57M0mod3:
lbl57mod3a:	DirectIndirectIndexedLong0
lbl57mod3b:	EOR16
			NEXTOPCODE
Op58mod3:
lbl58mod3:	Op58
			NEXTOPCODE
Op59M0mod3:
lbl59mod3a:	AbsoluteIndexedY0
lbl59mod3b:	EOR16
			NEXTOPCODE
Op5AX0mod3:
lbl5Amod3:	Op5AX0
			NEXTOPCODE
Op5Bmod3:
lbl5Bmod3:	Op5BM0
			NEXTOPCODE
Op5Cmod3:
lbl5Cmod3:	Op5C
			NEXTOPCODE
Op5DM0mod3:
lbl5Dmod3a:	AbsoluteIndexedX0
lbl5Dmod3b:	EOR16
			NEXTOPCODE
Op5EM0mod3:
lbl5Emod3a:	AbsoluteIndexedX0
lbl5Emod3b:	LSR16
			NEXTOPCODE
Op5FM0mod3:
lbl5Fmod3a:	AbsoluteLongIndexedX0
lbl5Fmod3b:	EOR16
			NEXTOPCODE
Op60mod3:
lbl60mod3:	Op60
			NEXTOPCODE
Op61M0mod3:
lbl61mod3a:	DirectIndexedIndirect0
lbl61mod3b:	ADC16
			NEXTOPCODE
Op62mod3:
lbl62mod3:	Op62
			NEXTOPCODE
Op63M0mod3:
lbl63mod3a:	StackasmRelative
lbl63mod3b:	ADC16
			NEXTOPCODE
.pool			
Op64M0mod3:
lbl64mod3a:	Direct
lbl64mod3b:	STZ16
			NEXTOPCODE
Op65M0mod3:
lbl65mod3a:	Direct
lbl65mod3b:	ADC16
			NEXTOPCODE
.pool			
Op66M0mod3:
lbl66mod3a:	Direct
lbl66mod3b:	ROR16
			NEXTOPCODE
Op67M0mod3:
lbl67mod3a:	DirectIndirectLong
lbl67mod3b:	ADC16
			NEXTOPCODE
.pool			
Op68M0mod3:
lbl68mod3:	Op68M0
			NEXTOPCODE
Op69M0mod3:
lbl69mod3a:	Immediate16
lbl69mod3b:	ADC16
			NEXTOPCODE
.pool			
Op6AM0mod3:
lbl6Amod3a:	A_ROR16
			NEXTOPCODE
Op6Bmod3:
lbl6Bmod3:	Op6B
			NEXTOPCODE
Op6Cmod3:
lbl6Cmod3:	Op6C
			NEXTOPCODE
Op6DM0mod3:
lbl6Dmod3a:	Absolute
lbl6Dmod3b:	ADC16
			NEXTOPCODE
Op6EM0mod3:
lbl6Emod3a:	Absolute
lbl6Emod3b:	ROR16
			NEXTOPCODE
Op6FM0mod3:
lbl6Fmod3a:	AbsoluteLong
lbl6Fmod3b:	ADC16
			NEXTOPCODE
Op70mod3:
lbl70mod3:	Op70
			NEXTOPCODE
Op71M0mod3:
lbl71mod3a:	DirectIndirectIndexed0
lbl71mod3b:	ADC16
			NEXTOPCODE
Op72M0mod3:
lbl72mod3a:	DirectIndirect
lbl72mod3b:	ADC16
			NEXTOPCODE
Op73M0mod3:
lbl73mod3a:	StackasmRelativeIndirectIndexed0
lbl73mod3b:	ADC16
			NEXTOPCODE
.pool
Op74M0mod3:
lbl74mod3a:	DirectIndexedX0
lbl74mod3b:	STZ16
			NEXTOPCODE
Op75M0mod3:
lbl75mod3a:	DirectIndexedX0
lbl75mod3b:	ADC16
			NEXTOPCODE
.pool
Op76M0mod3:
lbl76mod3a:	DirectIndexedX0
lbl76mod3b:	ROR16
			NEXTOPCODE
Op77M0mod3:
lbl77mod3a:	DirectIndirectIndexedLong0
lbl77mod3b:	ADC16
			NEXTOPCODE
Op78mod3:
lbl78mod3:	Op78
			NEXTOPCODE
Op79M0mod3:
lbl79mod3a:	AbsoluteIndexedY0
lbl79mod3b:	ADC16
			NEXTOPCODE
Op7AX0mod3:
lbl7Amod3:	Op7AX0
			NEXTOPCODE
Op7Bmod3:
lbl7Bmod3:	Op7BM0
			NEXTOPCODE
Op7Cmod3:
lbl7Cmod3:	AbsoluteIndexedIndirectX0
		Op7C
			NEXTOPCODE
Op7DM0mod3:
lbl7Dmod3a:	AbsoluteIndexedX0
lbl7Dmod3b:	ADC16
			NEXTOPCODE
Op7EM0mod3:
lbl7Emod3a:	AbsoluteIndexedX0
lbl7Emod3b:	ROR16
			NEXTOPCODE
Op7FM0mod3:
lbl7Fmod3a:	AbsoluteLongIndexedX0
lbl7Fmod3b:	ADC16
			NEXTOPCODE
.pool			
Op80mod3:
lbl80mod3:	Op80
			NEXTOPCODE
Op81M0mod3:
lbl81mod3a:	DirectIndexedIndirect0
lbl81mod3b:	Op81M0
			NEXTOPCODE
Op82mod3:
lbl82mod3:	Op82
			NEXTOPCODE
Op83M0mod3:
lbl83mod3a:	StackasmRelative
lbl83mod3b:	STA16
			NEXTOPCODE
Op84X0mod3:
lbl84mod3a:	Direct
lbl84mod3b:	STY16
			NEXTOPCODE
Op85M0mod3:
lbl85mod3a:	Direct
lbl85mod3b:	STA16
			NEXTOPCODE
Op86X0mod3:
lbl86mod3a:	Direct
lbl86mod3b:	STX16
			NEXTOPCODE
Op87M0mod3:
lbl87mod3a:	DirectIndirectLong
lbl87mod3b:	STA16
			NEXTOPCODE
Op88X0mod3:
lbl88mod3:	Op88X0
			NEXTOPCODE
Op89M0mod3:
lbl89mod3:	Op89M0
			NEXTOPCODE
Op8AM0mod3:
lbl8Amod3:	Op8AM0X0
			NEXTOPCODE
Op8Bmod3:
lbl8Bmod3:	Op8B
			NEXTOPCODE
Op8CX0mod3:
lbl8Cmod3a:	Absolute
lbl8Cmod3b:	STY16
			NEXTOPCODE
Op8DM0mod3:
lbl8Dmod3a:	Absolute
lbl8Dmod3b:	STA16
			NEXTOPCODE
Op8EX0mod3:
lbl8Emod3a:	Absolute
lbl8Emod3b:	STX16
			NEXTOPCODE
Op8FM0mod3:
lbl8Fmod3a:	AbsoluteLong
lbl8Fmod3b:	STA16
			NEXTOPCODE
Op90mod3:
lbl90mod3:	Op90
			NEXTOPCODE
Op91M0mod3:
lbl91mod3a:	DirectIndirectIndexed0
lbl91mod3b:	STA16
			NEXTOPCODE
Op92M0mod3:
lbl92mod3a:	DirectIndirect
lbl92mod3b:	STA16
			NEXTOPCODE
Op93M0mod3:
lbl93mod3a:	StackasmRelativeIndirectIndexed0
lbl93mod3b:	STA16
			NEXTOPCODE
Op94X0mod3:
lbl94mod3a:	DirectIndexedX0
lbl94mod3b:	STY16
			NEXTOPCODE
Op95M0mod3:
lbl95mod3a:	DirectIndexedX0
lbl95mod3b:	STA16
			NEXTOPCODE
Op96X0mod3:
lbl96mod3a:	DirectIndexedY0
lbl96mod3b:	STX16
			NEXTOPCODE
Op97M0mod3:
lbl97mod3a:	DirectIndirectIndexedLong0
lbl97mod3b:	STA16
			NEXTOPCODE
Op98M0mod3:
lbl98mod3:	Op98M0X0
			NEXTOPCODE
Op99M0mod3:
lbl99mod3a:	AbsoluteIndexedY0
lbl99mod3b:	STA16
			NEXTOPCODE
Op9Amod3:
lbl9Amod3:	Op9AX0
			NEXTOPCODE
Op9BX0mod3:
lbl9Bmod3:	Op9BX0
			NEXTOPCODE
Op9CM0mod3:
lbl9Cmod3a:	Absolute
lbl9Cmod3b:	STZ16
			NEXTOPCODE
Op9DM0mod3:
lbl9Dmod3a:	AbsoluteIndexedX0
lbl9Dmod3b:	STA16
			NEXTOPCODE
Op9EM0mod3:	
lbl9Emod3:	AbsoluteIndexedX0		
		STZ16
			NEXTOPCODE
Op9FM0mod3:
lbl9Fmod3a:	AbsoluteLongIndexedX0
lbl9Fmod3b:	STA16
			NEXTOPCODE
OpA0X0mod3:
lblA0mod3:	OpA0X0
			NEXTOPCODE
OpA1M0mod3:
lblA1mod3a:	DirectIndexedIndirect0
lblA1mod3b:	LDA16
			NEXTOPCODE
OpA2X0mod3:
lblA2mod3:	OpA2X0
			NEXTOPCODE
OpA3M0mod3:
lblA3mod3a:	StackasmRelative
lblA3mod3b:	LDA16
			NEXTOPCODE
OpA4X0mod3:
lblA4mod3a:	Direct
lblA4mod3b:	LDY16
			NEXTOPCODE
OpA5M0mod3:
lblA5mod3a:	Direct
lblA5mod3b:	LDA16
			NEXTOPCODE
OpA6X0mod3:
lblA6mod3a:	Direct
lblA6mod3b:	LDX16
			NEXTOPCODE
OpA7M0mod3:
lblA7mod3a:	DirectIndirectLong
lblA7mod3b:	LDA16
			NEXTOPCODE
OpA8X0mod3:
lblA8mod3:	OpA8X0M0
			NEXTOPCODE
OpA9M0mod3:
lblA9mod3:	OpA9M0
			NEXTOPCODE
OpAAX0mod3:
lblAAmod3:	OpAAX0M0
			NEXTOPCODE
OpABmod3:
lblABmod3:	OpAB
			NEXTOPCODE
OpACX0mod3:
lblACmod3a:	Absolute
lblACmod3b:	LDY16
			NEXTOPCODE
OpADM0mod3:
lblADmod3a:	Absolute
lblADmod3b:	LDA16
			NEXTOPCODE
OpAEX0mod3:
lblAEmod3a:	Absolute
lblAEmod3b:	LDX16
			NEXTOPCODE
OpAFM0mod3:
lblAFmod3a:	AbsoluteLong
lblAFmod3b:	LDA16
			NEXTOPCODE
OpB0mod3:
lblB0mod3:	OpB0
			NEXTOPCODE
OpB1M0mod3:
lblB1mod3a:	DirectIndirectIndexed0
lblB1mod3b:	LDA16
			NEXTOPCODE
OpB2M0mod3:
lblB2mod3a:	DirectIndirect
lblB2mod3b:	LDA16
			NEXTOPCODE
OpB3M0mod3:
lblB3mod3a:	StackasmRelativeIndirectIndexed0
lblB3mod3b:	LDA16
			NEXTOPCODE
OpB4X0mod3:
lblB4mod3a:	DirectIndexedX0
lblB4mod3b:	LDY16
			NEXTOPCODE
OpB5M0mod3:
lblB5mod3a:	DirectIndexedX0
lblB5mod3b:	LDA16
			NEXTOPCODE
OpB6X0mod3:
lblB6mod3a:	DirectIndexedY0
lblB6mod3b:	LDX16
			NEXTOPCODE
OpB7M0mod3:
lblB7mod3a:	DirectIndirectIndexedLong0
lblB7mod3b:	LDA16
			NEXTOPCODE
OpB8mod3:
lblB8mod3:	OpB8
			NEXTOPCODE
OpB9M0mod3:
lblB9mod3a:	AbsoluteIndexedY0
lblB9mod3b:	LDA16
			NEXTOPCODE
OpBAX0mod3:
lblBAmod3:	OpBAX0
			NEXTOPCODE
OpBBX0mod3:
lblBBmod3:	OpBBX0
			NEXTOPCODE
OpBCX0mod3:
lblBCmod3a:	AbsoluteIndexedX0
lblBCmod3b:	LDY16
			NEXTOPCODE
OpBDM0mod3:
lblBDmod3a:	AbsoluteIndexedX0
lblBDmod3b:	LDA16
			NEXTOPCODE
OpBEX0mod3:
lblBEmod3a:	AbsoluteIndexedY0
lblBEmod3b:	LDX16
			NEXTOPCODE
OpBFM0mod3:
lblBFmod3a:	AbsoluteLongIndexedX0
lblBFmod3b:	LDA16
			NEXTOPCODE
OpC0X0mod3:
lblC0mod3:	OpC0X0
			NEXTOPCODE
OpC1M0mod3:
lblC1mod3a:	DirectIndexedIndirect0
lblC1mod3b:	CMP16
			NEXTOPCODE
OpC2mod3:
lblC2mod3:	OpC2
			NEXTOPCODE
.pool
OpC3M0mod3:
lblC3mod3a:	StackasmRelative
lblC3mod3b:	CMP16
			NEXTOPCODE
OpC4X0mod3:
lblC4mod3a:	Direct
lblC4mod3b:	CMY16
			NEXTOPCODE
OpC5M0mod3:
lblC5mod3a:	Direct
lblC5mod3b:	CMP16
			NEXTOPCODE
OpC6M0mod3:
lblC6mod3a:	Direct
lblC6mod3b:	DEC16
			NEXTOPCODE
OpC7M0mod3:
lblC7mod3a:	DirectIndirectLong
lblC7mod3b:	CMP16
			NEXTOPCODE
OpC8X0mod3:
lblC8mod3:	OpC8X0
			NEXTOPCODE
OpC9M0mod3:
lblC9mod3:	OpC9M0
			NEXTOPCODE
OpCAX0mod3:
lblCAmod3:	OpCAX0
			NEXTOPCODE
OpCBmod3:
lblCBmod3:	OpCB
			NEXTOPCODE
OpCCX0mod3:
lblCCmod3a:	Absolute
lblCCmod3b:	CMY16
			NEXTOPCODE
OpCDM0mod3:
lblCDmod3a:	Absolute
lblCDmod3b:	CMP16
			NEXTOPCODE
OpCEM0mod3:
lblCEmod3a:	Absolute
lblCEmod3b:	DEC16
			NEXTOPCODE
OpCFM0mod3:
lblCFmod3a:	AbsoluteLong
lblCFmod3b:	CMP16
			NEXTOPCODE
OpD0mod3:

lblD0mod3:	OpD0
			NEXTOPCODE
OpD1M0mod3:
lblD1mod3a:	DirectIndirectIndexed0
lblD1mod3b:	CMP16
			NEXTOPCODE
OpD2M0mod3:
lblD2mod3a:	DirectIndirect
lblD2mod3b:	CMP16
			NEXTOPCODE
OpD3M0mod3:
lblD3mod3a:	StackasmRelativeIndirectIndexed0
lblD3mod3b:	CMP16
			NEXTOPCODE
OpD4mod3:
lblD4mod3:	OpD4
			NEXTOPCODE
OpD5M0mod3:
lblD5mod3a:	DirectIndexedX0
lblD5mod3b:	CMP16
			NEXTOPCODE
OpD6M0mod3:
lblD6mod3a:	DirectIndexedX0
lblD6mod3b:	DEC16
			NEXTOPCODE
OpD7M0mod3:
lblD7mod3a:	DirectIndirectIndexedLong0
lblD7mod3b:	CMP16
			NEXTOPCODE
OpD8mod3:
lblD8mod3:	OpD8
			NEXTOPCODE
OpD9M0mod3:
lblD9mod3a:	AbsoluteIndexedY0
lblD9mod3b:	CMP16
			NEXTOPCODE
OpDAX0mod3:
lblDAmod3:	OpDAX0
			NEXTOPCODE
OpDBmod3:
lblDBmod3:	OpDB
			NEXTOPCODE
OpDCmod3:
lblDCmod3:	OpDC
			NEXTOPCODE
OpDDM0mod3:
lblDDmod3a:	AbsoluteIndexedX0
lblDDmod3b:	CMP16
			NEXTOPCODE
OpDEM0mod3:
lblDEmod3a:	AbsoluteIndexedX0
lblDEmod3b:	DEC16
			NEXTOPCODE
OpDFM0mod3:
lblDFmod3a:	AbsoluteLongIndexedX0
lblDFmod3b:	CMP16
			NEXTOPCODE
OpE0X0mod3:
lblE0mod3:	OpE0X0
			NEXTOPCODE
OpE1M0mod3:
lblE1mod3a:	DirectIndexedIndirect0
lblE1mod3b:	SBC16
			NEXTOPCODE
OpE2mod3:
lblE2mod3:	OpE2
			NEXTOPCODE
.pool
OpE3M0mod3:
lblE3mod3a:	StackasmRelative
lblE3mod3b:	SBC16
			NEXTOPCODE
OpE4X0mod3:
lblE4mod3a:	Direct
lblE4mod3b:	CMX16
			NEXTOPCODE
OpE5M0mod3:
lblE5mod3a:	Direct
lblE5mod3b:	SBC16
			NEXTOPCODE
OpE6M0mod3:
lblE6mod3a:	Direct
lblE6mod3b:	INC16
			NEXTOPCODE
OpE7M0mod3:
lblE7mod3a:	DirectIndirectLong
lblE7mod3b:	SBC16
			NEXTOPCODE
OpE8X0mod3:
lblE8mod3:	OpE8X0
			NEXTOPCODE
OpE9M0mod3:
lblE9mod3a:	Immediate16
lblE9mod3b:	SBC16
			NEXTOPCODE
OpEAmod3:
lblEAmod3:	OpEA
			NEXTOPCODE
OpEBmod3:
lblEBmod3:	OpEBM0
			NEXTOPCODE
OpECX0mod3:
lblECmod3a:	Absolute
lblECmod3b:	CMX16
			NEXTOPCODE
OpEDM0mod3:
lblEDmod3a:	Absolute
lblEDmod3b:	SBC16
			NEXTOPCODE
OpEEM0mod3:
lblEEmod3a:	Absolute
lblEEmod3b:	INC16
			NEXTOPCODE
OpEFM0mod3:
lblEFmod3a:	AbsoluteLong
lblEFmod3b:	SBC16
			NEXTOPCODE
OpF0mod3:
lblF0mod3:	OpF0
			NEXTOPCODE
OpF1M0mod3:
lblF1mod3a:	DirectIndirectIndexed0
lblF1mod3b:	SBC16
			NEXTOPCODE
OpF2M0mod3:
lblF2mod3a:	DirectIndirect
lblF2mod3b:	SBC16
			NEXTOPCODE
OpF3M0mod3:
lblF3mod3a:	StackasmRelativeIndirectIndexed0
lblF3mod3b:	SBC16
			NEXTOPCODE
OpF4mod3:
lblF4mod3:	OpF4
			NEXTOPCODE
OpF5M0mod3:
lblF5mod3a:	DirectIndexedX0
lblF5mod3b:	SBC16
			NEXTOPCODE
OpF6M0mod3:
lblF6mod3a:	DirectIndexedX0
lblF6mod3b:	INC16
			NEXTOPCODE
OpF7M0mod3:
lblF7mod3a:	DirectIndirectIndexedLong0
lblF7mod3b:	SBC16
			NEXTOPCODE
OpF8mod3:
lblF8mod3:	OpF8
			NEXTOPCODE
OpF9M0mod3:
lblF9mod3a:	AbsoluteIndexedY0
lblF9mod3b:	SBC16
			NEXTOPCODE
OpFAX0mod3:
lblFAmod3:	OpFAX0
			NEXTOPCODE
OpFBmod3:
lblFBmod3:	OpFB
			NEXTOPCODE
OpFCmod3:
lblFCmod3:	OpFCX0
			NEXTOPCODE
OpFDM0mod3:
lblFDmod3a:	AbsoluteIndexedX0
lblFDmod3b:	SBC16
			NEXTOPCODE
OpFEM0mod3:
lblFEmod3a:	AbsoluteIndexedX0
lblFEmod3b:	INC16
			NEXTOPCODE
OpFFM0mod3:
lblFFmod3a:	AbsoluteLongIndexedX0
lblFFmod3b:	SBC16
			NEXTOPCODE
.pool

jumptable4:		.long	Op00mod4
			.long	Op01M0mod4
			.long	Op02mod4
			.long	Op03M0mod4
			.long	Op04M0mod4
			.long	Op05M0mod4
			.long	Op06M0mod4
			.long	Op07M0mod4
			.long	Op08mod4
			.long	Op09M0mod4
			.long	Op0AM0mod4
			.long	Op0Bmod4
			.long	Op0CM0mod4
			.long	Op0DM0mod4
			.long	Op0EM0mod4
			.long	Op0FM0mod4
			.long	Op10mod4
			.long	Op11M0mod4
			.long	Op12M0mod4
			.long	Op13M0mod4
			.long	Op14M0mod4
			.long	Op15M0mod4
			.long	Op16M0mod4
			.long	Op17M0mod4
			.long	Op18mod4
			.long	Op19M0mod4
			.long	Op1AM0mod4
			.long	Op1Bmod4
			.long	Op1CM0mod4
			.long	Op1DM0mod4
			.long	Op1EM0mod4
			.long	Op1FM0mod4
			.long	Op20mod4
			.long	Op21M0mod4
			.long	Op22mod4
			.long	Op23M0mod4
			.long	Op24M0mod4
			.long	Op25M0mod4
			.long	Op26M0mod4
			.long	Op27M0mod4
			.long	Op28mod4
			.long	Op29M0mod4
			.long	Op2AM0mod4
			.long	Op2Bmod4
			.long	Op2CM0mod4
			.long	Op2DM0mod4
			.long	Op2EM0mod4
			.long	Op2FM0mod4
			.long	Op30mod4
			.long	Op31M0mod4
			.long	Op32M0mod4
			.long	Op33M0mod4
			.long	Op34M0mod4
			.long	Op35M0mod4
			.long	Op36M0mod4
			.long	Op37M0mod4
			.long	Op38mod4
			.long	Op39M0mod4
			.long	Op3AM0mod4
			.long	Op3Bmod4
			.long	Op3CM0mod4
			.long	Op3DM0mod4
			.long	Op3EM0mod4
			.long	Op3FM0mod4
			.long	Op40mod4
			.long	Op41M0mod4
			.long	Op42mod4
			.long	Op43M0mod4
			.long	Op44X1mod4
			.long	Op45M0mod4
			.long	Op46M0mod4
			.long	Op47M0mod4
			.long	Op48M0mod4
			.long	Op49M0mod4
			.long	Op4AM0mod4
			.long	Op4Bmod4
			.long	Op4Cmod4
			.long	Op4DM0mod4
			.long	Op4EM0mod4
			.long	Op4FM0mod4
			.long	Op50mod4
			.long	Op51M0mod4
			.long	Op52M0mod4
			.long	Op53M0mod4
			.long	Op54X1mod4
			.long	Op55M0mod4
			.long	Op56M0mod4
			.long	Op57M0mod4
			.long	Op58mod4
			.long	Op59M0mod4
			.long	Op5AX1mod4
			.long	Op5Bmod4
			.long	Op5Cmod4
			.long	Op5DM0mod4
			.long	Op5EM0mod4
			.long	Op5FM0mod4
			.long	Op60mod4
			.long	Op61M0mod4
			.long	Op62mod4
			.long	Op63M0mod4
			.long	Op64M0mod4
			.long	Op65M0mod4
			.long	Op66M0mod4
			.long	Op67M0mod4
			.long	Op68M0mod4
			.long	Op69M0mod4
			.long	Op6AM0mod4
			.long	Op6Bmod4
			.long	Op6Cmod4
			.long	Op6DM0mod4
			.long	Op6EM0mod4
			.long	Op6FM0mod4
			.long	Op70mod4
			.long	Op71M0mod4
			.long	Op72M0mod4
			.long	Op73M0mod4
			.long	Op74M0mod4
			.long	Op75M0mod4
			.long	Op76M0mod4
			.long	Op77M0mod4
			.long	Op78mod4
			.long	Op79M0mod4
			.long	Op7AX1mod4
			.long	Op7Bmod4
			.long	Op7Cmod4
			.long	Op7DM0mod4
			.long	Op7EM0mod4
			.long	Op7FM0mod4
			.long	Op80mod4
			.long	Op81M0mod4
			.long	Op82mod4
			.long	Op83M0mod4
			.long	Op84X1mod4
			.long	Op85M0mod4
			.long	Op86X1mod4
			.long	Op87M0mod4
			.long	Op88X1mod4
			.long	Op89M0mod4
			.long	Op8AM0mod4
			.long	Op8Bmod4
			.long	Op8CX1mod4
			.long	Op8DM0mod4
			.long	Op8EX1mod4
			.long	Op8FM0mod4
			.long	Op90mod4
			.long	Op91M0mod4
			.long	Op92M0mod4
			.long	Op93M0mod4
			.long	Op94X1mod4
			.long	Op95M0mod4
			.long	Op96X1mod4
			.long	Op97M0mod4
			.long	Op98M0mod4
			.long	Op99M0mod4
			.long	Op9Amod4
			.long	Op9BX1mod4
			.long	Op9CM0mod4
			.long	Op9DM0mod4

			.long	Op9EM0mod4
			.long	Op9FM0mod4
			.long	OpA0X1mod4
			.long	OpA1M0mod4
			.long	OpA2X1mod4
			.long	OpA3M0mod4
			.long	OpA4X1mod4
			.long	OpA5M0mod4
			.long	OpA6X1mod4
			.long	OpA7M0mod4
			.long	OpA8X1mod4
			.long	OpA9M0mod4
			.long	OpAAX1mod4
			.long	OpABmod4
			.long	OpACX1mod4
			.long	OpADM0mod4
			.long	OpAEX1mod4
			.long	OpAFM0mod4
			.long	OpB0mod4
			.long	OpB1M0mod4
			.long	OpB2M0mod4
			.long	OpB3M0mod4
			.long	OpB4X1mod4
			.long	OpB5M0mod4
			.long	OpB6X1mod4
			.long	OpB7M0mod4
			.long	OpB8mod4
			.long	OpB9M0mod4
			.long	OpBAX1mod4
			.long	OpBBX1mod4
			.long	OpBCX1mod4
			.long	OpBDM0mod4
			.long	OpBEX1mod4
			.long	OpBFM0mod4
			.long	OpC0X1mod4
			.long	OpC1M0mod4
			.long	OpC2mod4
			.long	OpC3M0mod4
			.long	OpC4X1mod4
			.long	OpC5M0mod4
			.long	OpC6M0mod4
			.long	OpC7M0mod4
			.long	OpC8X1mod4
			.long	OpC9M0mod4
			.long	OpCAX1mod4
			.long	OpCBmod4
			.long	OpCCX1mod4
			.long	OpCDM0mod4
			.long	OpCEM0mod4
			.long	OpCFM0mod4
			.long	OpD0mod4
			.long	OpD1M0mod4
			.long	OpD2M0mod4
			.long	OpD3M0mod4
			.long	OpD4mod4
			.long	OpD5M0mod4
			.long	OpD6M0mod4
			.long	OpD7M0mod4
			.long	OpD8mod4
			.long	OpD9M0mod4
			.long	OpDAX1mod4
			.long	OpDBmod4
			.long	OpDCmod4
			.long	OpDDM0mod4
			.long	OpDEM0mod4
			.long	OpDFM0mod4
			.long	OpE0X1mod4
			.long	OpE1M0mod4
			.long	OpE2mod4
			.long	OpE3M0mod4
			.long	OpE4X1mod4
			.long	OpE5M0mod4
			.long	OpE6M0mod4
			.long	OpE7M0mod4
			.long	OpE8X1mod4
			.long	OpE9M0mod4
			.long	OpEAmod4
			.long	OpEBmod4
			.long	OpECX1mod4
			.long	OpEDM0mod4
			.long	OpEEM0mod4
			.long	OpEFM0mod4
			.long	OpF0mod4
			.long	OpF1M0mod4
			.long	OpF2M0mod4
			.long	OpF3M0mod4
			.long	OpF4mod4
			.long	OpF5M0mod4
			.long	OpF6M0mod4
			.long	OpF7M0mod4
			.long	OpF8mod4
			.long	OpF9M0mod4
			.long	OpFAX1mod4
			.long	OpFBmod4
			.long	OpFCmod4
			.long	OpFDM0mod4
			.long	OpFEM0mod4
			.long	OpFFM0mod4
Op00mod4:
lbl00mod4:	Op00
			NEXTOPCODE
Op01M0mod4:
lbl01mod4a:	DirectIndexedIndirect1
lbl01mod4b:	ORA16
			NEXTOPCODE
Op02mod4:
lbl02mod4:	Op02
			NEXTOPCODE
Op03M0mod4:
lbl03mod4a:	StackasmRelative
lbl03mod4b:	ORA16
			NEXTOPCODE
Op04M0mod4:
lbl04mod4a:	Direct
lbl04mod4b:	TSB16
			NEXTOPCODE
Op05M0mod4:
lbl05mod4a:	Direct
lbl05mod4b:	ORA16
			NEXTOPCODE
Op06M0mod4:
lbl06mod4a:	Direct
lbl06mod4b:	ASL16
			NEXTOPCODE
Op07M0mod4:
lbl07mod4a:	DirectIndirectLong
lbl07mod4b:	ORA16
			NEXTOPCODE
Op08mod4:
lbl08mod4:	Op08
			NEXTOPCODE
Op09M0mod4:
lbl09mod4:	Op09M0
			NEXTOPCODE
Op0AM0mod4:
lbl0Amod4a:	A_ASL16
			NEXTOPCODE
Op0Bmod4:
lbl0Bmod4:	Op0B
			NEXTOPCODE
Op0CM0mod4:
lbl0Cmod4a:	Absolute
lbl0Cmod4b:	TSB16
			NEXTOPCODE
Op0DM0mod4:
lbl0Dmod4a:	Absolute
lbl0Dmod4b:	ORA16
			NEXTOPCODE
Op0EM0mod4:
lbl0Emod4a:	Absolute
lbl0Emod4b:	ASL16
			NEXTOPCODE
Op0FM0mod4:
lbl0Fmod4a:	AbsoluteLong
lbl0Fmod4b:	ORA16
			NEXTOPCODE
Op10mod4:
lbl10mod4:	Op10
			NEXTOPCODE
Op11M0mod4:
lbl11mod4a:	DirectIndirectIndexed1
lbl11mod4b:	ORA16
			NEXTOPCODE
Op12M0mod4:
lbl12mod4a:	DirectIndirect
lbl12mod4b:	ORA16
			NEXTOPCODE
Op13M0mod4:
lbl13mod4a:	StackasmRelativeIndirectIndexed1
lbl13mod4b:	ORA16
			NEXTOPCODE
Op14M0mod4:
lbl14mod4a:	Direct
lbl14mod4b:	TRB16
			NEXTOPCODE
Op15M0mod4:
lbl15mod4a:	DirectIndexedX1
lbl15mod4b:	ORA16
			NEXTOPCODE
Op16M0mod4:
lbl16mod4a:	DirectIndexedX1
lbl16mod4b:	ASL16
			NEXTOPCODE
Op17M0mod4:
lbl17mod4a:	DirectIndirectIndexedLong1
lbl17mod4b:	ORA16
			NEXTOPCODE
Op18mod4:
lbl18mod4:	Op18
			NEXTOPCODE
Op19M0mod4:
lbl19mod4a:	AbsoluteIndexedY1
lbl19mod4b:	ORA16
			NEXTOPCODE
Op1AM0mod4:
lbl1Amod4a:	A_INC16
			NEXTOPCODE
Op1Bmod4:
lbl1Bmod4:	Op1BM0
			NEXTOPCODE
Op1CM0mod4:
lbl1Cmod4a:	Absolute
lbl1Cmod4b:	TRB16
			NEXTOPCODE
Op1DM0mod4:
lbl1Dmod4a:	AbsoluteIndexedX1
lbl1Dmod4b:	ORA16
			NEXTOPCODE
Op1EM0mod4:
lbl1Emod4a:	AbsoluteIndexedX1
lbl1Emod4b:	ASL16
			NEXTOPCODE
Op1FM0mod4:
lbl1Fmod4a:	AbsoluteLongIndexedX1
lbl1Fmod4b:	ORA16
			NEXTOPCODE
Op20mod4:
lbl20mod4:	Op20
			NEXTOPCODE
Op21M0mod4:
lbl21mod4a:	DirectIndexedIndirect1
lbl21mod4b:	AND16
			NEXTOPCODE
Op22mod4:
lbl22mod4:	Op22
			NEXTOPCODE
Op23M0mod4:
lbl23mod4a:	StackasmRelative
lbl23mod4b:	AND16
			NEXTOPCODE
Op24M0mod4:
lbl24mod4a:	Direct
lbl24mod4b:	BIT16
			NEXTOPCODE
Op25M0mod4:
lbl25mod4a:	Direct
lbl25mod4b:	AND16
			NEXTOPCODE
Op26M0mod4:
lbl26mod4a:	Direct
lbl26mod4b:	ROL16
			NEXTOPCODE
Op27M0mod4:
lbl27mod4a:	DirectIndirectLong
lbl27mod4b:	AND16
			NEXTOPCODE
Op28mod4:
lbl28mod4:	Op28X1M0
			NEXTOPCODE
.pool
Op29M0mod4:
lbl29mod4:	Op29M0
			NEXTOPCODE
Op2AM0mod4:
lbl2Amod4a:	A_ROL16
			NEXTOPCODE
Op2Bmod4:
lbl2Bmod4:	Op2B
			NEXTOPCODE
Op2CM0mod4:
lbl2Cmod4a:	Absolute
lbl2Cmod4b:	BIT16
			NEXTOPCODE
Op2DM0mod4:
lbl2Dmod4a:	Absolute
lbl2Dmod4b:	AND16
			NEXTOPCODE
Op2EM0mod4:
lbl2Emod4a:	Absolute
lbl2Emod4b:	ROL16
			NEXTOPCODE
Op2FM0mod4:
lbl2Fmod4a:	AbsoluteLong
lbl2Fmod4b:	AND16
			NEXTOPCODE
Op30mod4:
lbl30mod4:	Op30
			NEXTOPCODE
Op31M0mod4:
lbl31mod4a:	DirectIndirectIndexed1
lbl31mod4b:	AND16
			NEXTOPCODE
Op32M0mod4:
lbl32mod4a:	DirectIndirect
lbl32mod4b:	AND16
			NEXTOPCODE
Op33M0mod4:
lbl33mod4a:	StackasmRelativeIndirectIndexed1
lbl33mod4b:	AND16
			NEXTOPCODE
Op34M0mod4:
lbl34mod4a:	DirectIndexedX1
lbl34mod4b:	BIT16
			NEXTOPCODE
Op35M0mod4:
lbl35mod4a:	DirectIndexedX1
lbl35mod4b:	AND16
			NEXTOPCODE
Op36M0mod4:
lbl36mod4a:	DirectIndexedX1
lbl36mod4b:	ROL16
			NEXTOPCODE
Op37M0mod4:
lbl37mod4a:	DirectIndirectIndexedLong1
lbl37mod4b:	AND16
			NEXTOPCODE
Op38mod4:
lbl38mod4:	Op38
			NEXTOPCODE
Op39M0mod4:
lbl39mod4a:	AbsoluteIndexedY1
lbl39mod4b:	AND16
			NEXTOPCODE
Op3AM0mod4:
lbl3Amod4a:	A_DEC16
			NEXTOPCODE
Op3Bmod4:
lbl3Bmod4:	Op3BM0
			NEXTOPCODE
Op3CM0mod4:
lbl3Cmod4a:	AbsoluteIndexedX1
lbl3Cmod4b:	BIT16
			NEXTOPCODE
Op3DM0mod4:
lbl3Dmod4a:	AbsoluteIndexedX1
lbl3Dmod4b:	AND16
			NEXTOPCODE
Op3EM0mod4:
lbl3Emod4a:	AbsoluteIndexedX1
lbl3Emod4b:	ROL16
			NEXTOPCODE
Op3FM0mod4:
lbl3Fmod4a:	AbsoluteLongIndexedX1
lbl3Fmod4b:	AND16
			NEXTOPCODE
Op40mod4:
lbl40mod4:	Op40X1M0
			NEXTOPCODE
.pool						
Op41M0mod4:
lbl41mod4a:	DirectIndexedIndirect1
lbl41mod4b:	EOR16
			NEXTOPCODE
Op42mod4:
lbl42mod4:	Op42
			NEXTOPCODE
Op43M0mod4:
lbl43mod4a:	StackasmRelative
lbl43mod4b:	EOR16
			NEXTOPCODE
Op44X1mod4:
lbl44mod4:	Op44X1M0
			NEXTOPCODE
Op45M0mod4:
lbl45mod4a:	Direct
lbl45mod4b:	EOR16
			NEXTOPCODE
Op46M0mod4:
lbl46mod4a:	Direct
lbl46mod4b:	LSR16
			NEXTOPCODE
Op47M0mod4:
lbl47mod4a:	DirectIndirectLong
lbl47mod4b:	EOR16
			NEXTOPCODE
Op48M0mod4:
lbl48mod4:	Op48M0
			NEXTOPCODE
Op49M0mod4:
lbl49mod4:	Op49M0
			NEXTOPCODE
Op4AM0mod4:
lbl4Amod4a:	A_LSR16
			NEXTOPCODE
Op4Bmod4:
lbl4Bmod4:	Op4B
			NEXTOPCODE
Op4Cmod4:
lbl4Cmod4:	Op4C
			NEXTOPCODE
Op4DM0mod4:
lbl4Dmod4a:	Absolute
lbl4Dmod4b:	EOR16
			NEXTOPCODE
Op4EM0mod4:
lbl4Emod4a:	Absolute
lbl4Emod4b:	LSR16
			NEXTOPCODE
Op4FM0mod4:
lbl4Fmod4a:	AbsoluteLong
lbl4Fmod4b:	EOR16
			NEXTOPCODE
Op50mod4:
lbl50mod4:	Op50
			NEXTOPCODE
Op51M0mod4:
lbl51mod4a:	DirectIndirectIndexed1
lbl51mod4b:	EOR16
			NEXTOPCODE
Op52M0mod4:
lbl52mod4a:	DirectIndirect
lbl52mod4b:	EOR16
			NEXTOPCODE
Op53M0mod4:
lbl53mod4a:	StackasmRelativeIndirectIndexed1
lbl53mod4b:	EOR16
			NEXTOPCODE

Op54X1mod4:
lbl54mod4:	Op54X1M0
			NEXTOPCODE
Op55M0mod4:
lbl55mod4a:	DirectIndexedX1
lbl55mod4b:	EOR16
			NEXTOPCODE
Op56M0mod4:
lbl56mod4a:	DirectIndexedX1
lbl56mod4b:	LSR16
			NEXTOPCODE
Op57M0mod4:
lbl57mod4a:	DirectIndirectIndexedLong1
lbl57mod4b:	EOR16
			NEXTOPCODE
Op58mod4:
lbl58mod4:	Op58
			NEXTOPCODE
Op59M0mod4:
lbl59mod4a:	AbsoluteIndexedY1
lbl59mod4b:	EOR16
			NEXTOPCODE
Op5AX1mod4:
lbl5Amod4:	Op5AX1
			NEXTOPCODE
Op5Bmod4:
lbl5Bmod4:	Op5BM0
			NEXTOPCODE
Op5Cmod4:
lbl5Cmod4:	Op5C
			NEXTOPCODE
Op5DM0mod4:
lbl5Dmod4a:	AbsoluteIndexedX1
lbl5Dmod4b:	EOR16
			NEXTOPCODE
Op5EM0mod4:
lbl5Emod4a:	AbsoluteIndexedX1
lbl5Emod4b:	LSR16
			NEXTOPCODE
Op5FM0mod4:
lbl5Fmod4a:	AbsoluteLongIndexedX1
lbl5Fmod4b:	EOR16
			NEXTOPCODE
Op60mod4:
lbl60mod4:	Op60
			NEXTOPCODE
Op61M0mod4:
lbl61mod4a:	DirectIndexedIndirect1
lbl61mod4b:	ADC16
			NEXTOPCODE
Op62mod4:
lbl62mod4:	Op62
			NEXTOPCODE
Op63M0mod4:
lbl63mod4a:	StackasmRelative
lbl63mod4b:	ADC16
			NEXTOPCODE
.pool			
Op64M0mod4:
lbl64mod4a:	Direct
lbl64mod4b:	STZ16
			NEXTOPCODE
Op65M0mod4:
lbl65mod4a:	Direct
lbl65mod4b:	ADC16
			NEXTOPCODE
.pool			
Op66M0mod4:
lbl66mod4a:	Direct
lbl66mod4b:	ROR16
			NEXTOPCODE
Op67M0mod4:
lbl67mod4a:	DirectIndirectLong
lbl67mod4b:	ADC16
			NEXTOPCODE
.pool			
Op68M0mod4:
lbl68mod4:	Op68M0
			NEXTOPCODE
Op69M0mod4:
lbl69mod4a:	Immediate16
lbl69mod4b:	ADC16
			NEXTOPCODE
.pool			
Op6AM0mod4:
lbl6Amod4a:	A_ROR16
			NEXTOPCODE
Op6Bmod4:
lbl6Bmod4:	Op6B
			NEXTOPCODE
Op6Cmod4:
lbl6Cmod4:	Op6C
			NEXTOPCODE
Op6DM0mod4:
lbl6Dmod4a:	Absolute
lbl6Dmod4b:	ADC16
			NEXTOPCODE
Op6EM0mod4:
lbl6Emod4a:	Absolute
lbl6Emod4b:	ROR16
			NEXTOPCODE
Op6FM0mod4:
lbl6Fmod4a:	AbsoluteLong
lbl6Fmod4b:	ADC16
			NEXTOPCODE
Op70mod4:
lbl70mod4:	Op70
			NEXTOPCODE
Op71M0mod4:
lbl71mod4a:	DirectIndirectIndexed1
lbl71mod4b:	ADC16
			NEXTOPCODE
Op72M0mod4:
lbl72mod4a:	DirectIndirect
lbl72mod4b:	ADC16
			NEXTOPCODE
Op73M0mod4:
lbl73mod4a:	StackasmRelativeIndirectIndexed1
lbl73mod4b:	ADC16
			NEXTOPCODE
.pool
Op74M0mod4:
lbl74mod4a:	DirectIndexedX1
lbl74mod4b:	STZ16
			NEXTOPCODE
Op75M0mod4:
lbl75mod4a:	DirectIndexedX1
lbl75mod4b:	ADC16
			NEXTOPCODE
.pool
Op76M0mod4:
lbl76mod4a:	DirectIndexedX1
lbl76mod4b:	ROR16
			NEXTOPCODE
Op77M0mod4:
lbl77mod4a:	DirectIndirectIndexedLong1
lbl77mod4b:	ADC16
			NEXTOPCODE
Op78mod4:
lbl78mod4:	Op78
			NEXTOPCODE
Op79M0mod4:
lbl79mod4a:	AbsoluteIndexedY1
lbl79mod4b:	ADC16
			NEXTOPCODE
Op7AX1mod4:
lbl7Amod4:	Op7AX1
			NEXTOPCODE
Op7Bmod4:
lbl7Bmod4:	Op7BM0
			NEXTOPCODE
Op7Cmod4:
lbl7Cmod4:	AbsoluteIndexedIndirectX1
		Op7C
			NEXTOPCODE
Op7DM0mod4:
lbl7Dmod4a:	AbsoluteIndexedX1
lbl7Dmod4b:	ADC16
			NEXTOPCODE
Op7EM0mod4:
lbl7Emod4a:	AbsoluteIndexedX1
lbl7Emod4b:	ROR16
			NEXTOPCODE
Op7FM0mod4:
lbl7Fmod4a:	AbsoluteLongIndexedX1
lbl7Fmod4b:	ADC16
			NEXTOPCODE
.pool			
Op80mod4:
lbl80mod4:	Op80
			NEXTOPCODE
Op81M0mod4:
lbl81mod4a:	DirectIndexedIndirect1
lbl81mod4b:	Op81M0
			NEXTOPCODE
Op82mod4:
lbl82mod4:	Op82
			NEXTOPCODE
Op83M0mod4:
lbl83mod4a:	StackasmRelative
lbl83mod4b:	STA16
			NEXTOPCODE
Op84X1mod4:
lbl84mod4a:	Direct
lbl84mod4b:	STY8
			NEXTOPCODE
Op85M0mod4:
lbl85mod4a:	Direct
lbl85mod4b:	STA16
			NEXTOPCODE
Op86X1mod4:
lbl86mod4a:	Direct
lbl86mod4b:	STX8
			NEXTOPCODE
Op87M0mod4:
lbl87mod4a:	DirectIndirectLong
lbl87mod4b:	STA16
			NEXTOPCODE
Op88X1mod4:
lbl88mod4:	Op88X1
			NEXTOPCODE
Op89M0mod4:
lbl89mod4:	Op89M0
			NEXTOPCODE
Op8AM0mod4:
lbl8Amod4:	Op8AM0X1
			NEXTOPCODE
Op8Bmod4:
lbl8Bmod4:	Op8B
			NEXTOPCODE
Op8CX1mod4:
lbl8Cmod4a:	Absolute
lbl8Cmod4b:	STY8
			NEXTOPCODE
Op8DM0mod4:
lbl8Dmod4a:	Absolute
lbl8Dmod4b:	STA16
			NEXTOPCODE
Op8EX1mod4:
lbl8Emod4a:	Absolute
lbl8Emod4b:	STX8
			NEXTOPCODE
Op8FM0mod4:
lbl8Fmod4a:	AbsoluteLong
lbl8Fmod4b:	STA16
			NEXTOPCODE
Op90mod4:
lbl90mod4:	Op90
			NEXTOPCODE
Op91M0mod4:
lbl91mod4a:	DirectIndirectIndexed1
lbl91mod4b:	STA16
			NEXTOPCODE
Op92M0mod4:
lbl92mod4a:	DirectIndirect
lbl92mod4b:	STA16
			NEXTOPCODE
Op93M0mod4:
lbl93mod4a:	StackasmRelativeIndirectIndexed1
lbl93mod4b:	STA16
			NEXTOPCODE
Op94X1mod4:
lbl94mod4a:	DirectIndexedX1
lbl94mod4b:	STY8
			NEXTOPCODE
Op95M0mod4:
lbl95mod4a:	DirectIndexedX1
lbl95mod4b:	STA16
			NEXTOPCODE
Op96X1mod4:
lbl96mod4a:	DirectIndexedY1
lbl96mod4b:	STX8
			NEXTOPCODE
Op97M0mod4:
lbl97mod4a:	DirectIndirectIndexedLong1
lbl97mod4b:	STA16
			NEXTOPCODE
Op98M0mod4:
lbl98mod4:	Op98M0X1
			NEXTOPCODE
Op99M0mod4:
lbl99mod4a:	AbsoluteIndexedY1
lbl99mod4b:	STA16
			NEXTOPCODE
Op9Amod4:
lbl9Amod4:	Op9AX1
			NEXTOPCODE
Op9BX1mod4:
lbl9Bmod4:	Op9BX1
			NEXTOPCODE
Op9CM0mod4:
lbl9Cmod4a:	Absolute
lbl9Cmod4b:	STZ16
			NEXTOPCODE
Op9DM0mod4:
lbl9Dmod4a:	AbsoluteIndexedX1
lbl9Dmod4b:	STA16
			NEXTOPCODE
Op9EM0mod4:	
lbl9Emod4:	AbsoluteIndexedX1		
		STZ16
			NEXTOPCODE
Op9FM0mod4:
lbl9Fmod4a:	AbsoluteLongIndexedX1
lbl9Fmod4b:	STA16
			NEXTOPCODE
OpA0X1mod4:
lblA0mod4:	OpA0X1
			NEXTOPCODE
OpA1M0mod4:
lblA1mod4a:	DirectIndexedIndirect1
lblA1mod4b:	LDA16
			NEXTOPCODE
OpA2X1mod4:
lblA2mod4:	OpA2X1
			NEXTOPCODE
OpA3M0mod4:
lblA3mod4a:	StackasmRelative
lblA3mod4b:	LDA16
			NEXTOPCODE
OpA4X1mod4:
lblA4mod4a:	Direct
lblA4mod4b:	LDY8
			NEXTOPCODE
OpA5M0mod4:
lblA5mod4a:	Direct
lblA5mod4b:	LDA16
			NEXTOPCODE
OpA6X1mod4:
lblA6mod4a:	Direct
lblA6mod4b:	LDX8
			NEXTOPCODE
OpA7M0mod4:
lblA7mod4a:	DirectIndirectLong
lblA7mod4b:	LDA16
			NEXTOPCODE
OpA8X1mod4:
lblA8mod4:	OpA8X1M0
			NEXTOPCODE
OpA9M0mod4:
lblA9mod4:	OpA9M0
			NEXTOPCODE
OpAAX1mod4:
lblAAmod4:	OpAAX1M0
			NEXTOPCODE
OpABmod4:
lblABmod4:	OpAB
			NEXTOPCODE
OpACX1mod4:
lblACmod4a:	Absolute
lblACmod4b:	LDY8
			NEXTOPCODE
OpADM0mod4:
lblADmod4a:	Absolute
lblADmod4b:	LDA16
			NEXTOPCODE
OpAEX1mod4:
lblAEmod4a:	Absolute
lblAEmod4b:	LDX8
			NEXTOPCODE
OpAFM0mod4:
lblAFmod4a:	AbsoluteLong
lblAFmod4b:	LDA16
			NEXTOPCODE
OpB0mod4:
lblB0mod4:	OpB0
			NEXTOPCODE
OpB1M0mod4:
lblB1mod4a:	DirectIndirectIndexed1
lblB1mod4b:	LDA16
			NEXTOPCODE
OpB2M0mod4:
lblB2mod4a:	DirectIndirect
lblB2mod4b:	LDA16
			NEXTOPCODE
OpB3M0mod4:
lblB3mod4a:	StackasmRelativeIndirectIndexed1
lblB3mod4b:	LDA16
			NEXTOPCODE
OpB4X1mod4:
lblB4mod4a:	DirectIndexedX1
lblB4mod4b:	LDY8
			NEXTOPCODE
OpB5M0mod4:
lblB5mod4a:	DirectIndexedX1
lblB5mod4b:	LDA16
			NEXTOPCODE
OpB6X1mod4:
lblB6mod4a:	DirectIndexedY1
lblB6mod4b:	LDX8
			NEXTOPCODE
OpB7M0mod4:
lblB7mod4a:	DirectIndirectIndexedLong1
lblB7mod4b:	LDA16
			NEXTOPCODE
OpB8mod4:
lblB8mod4:	OpB8
			NEXTOPCODE
OpB9M0mod4:
lblB9mod4a:	AbsoluteIndexedY1
lblB9mod4b:	LDA16
			NEXTOPCODE
OpBAX1mod4:
lblBAmod4:	OpBAX1
			NEXTOPCODE
OpBBX1mod4:
lblBBmod4:	OpBBX1
			NEXTOPCODE
OpBCX1mod4:
lblBCmod4a:	AbsoluteIndexedX1
lblBCmod4b:	LDY8
			NEXTOPCODE
OpBDM0mod4:
lblBDmod4a:	AbsoluteIndexedX1
lblBDmod4b:	LDA16
			NEXTOPCODE
OpBEX1mod4:
lblBEmod4a:	AbsoluteIndexedY1
lblBEmod4b:	LDX8
			NEXTOPCODE
OpBFM0mod4:
lblBFmod4a:	AbsoluteLongIndexedX1
lblBFmod4b:	LDA16
			NEXTOPCODE
OpC0X1mod4:
lblC0mod4:	OpC0X1
			NEXTOPCODE
OpC1M0mod4:
lblC1mod4a:	DirectIndexedIndirect1
lblC1mod4b:	CMP16
			NEXTOPCODE
OpC2mod4:
lblC2mod4:	OpC2
			NEXTOPCODE
.pool
OpC3M0mod4:
lblC3mod4a:	StackasmRelative
lblC3mod4b:	CMP16
			NEXTOPCODE
OpC4X1mod4:
lblC4mod4a:	Direct
lblC4mod4b:	CMY8
			NEXTOPCODE
OpC5M0mod4:
lblC5mod4a:	Direct
lblC5mod4b:	CMP16
			NEXTOPCODE
OpC6M0mod4:
lblC6mod4a:	Direct
lblC6mod4b:	DEC16
			NEXTOPCODE
OpC7M0mod4:
lblC7mod4a:	DirectIndirectLong
lblC7mod4b:	CMP16
			NEXTOPCODE
OpC8X1mod4:
lblC8mod4:	OpC8X1
			NEXTOPCODE
OpC9M0mod4:
lblC9mod4:	OpC9M0
			NEXTOPCODE
OpCAX1mod4:
lblCAmod4:	OpCAX1
			NEXTOPCODE
OpCBmod4:
lblCBmod4:	OpCB
			NEXTOPCODE
OpCCX1mod4:
lblCCmod4a:	Absolute
lblCCmod4b:	CMY8
			NEXTOPCODE
OpCDM0mod4:
lblCDmod4a:	Absolute
lblCDmod4b:	CMP16
			NEXTOPCODE
OpCEM0mod4:
lblCEmod4a:	Absolute
lblCEmod4b:	DEC16
			NEXTOPCODE
OpCFM0mod4:
lblCFmod4a:	AbsoluteLong
lblCFmod4b:	CMP16
			NEXTOPCODE
OpD0mod4:
lblD0mod4:	OpD0
			NEXTOPCODE
OpD1M0mod4:
lblD1mod4a:	DirectIndirectIndexed1
lblD1mod4b:	CMP16

			NEXTOPCODE
OpD2M0mod4:
lblD2mod4a:	DirectIndirect
lblD2mod4b:	CMP16
			NEXTOPCODE
OpD3M0mod4:
lblD3mod4a:	StackasmRelativeIndirectIndexed1
lblD3mod4b:	CMP16
			NEXTOPCODE
OpD4mod4:
lblD4mod4:	OpD4
			NEXTOPCODE
OpD5M0mod4:
lblD5mod4a:	DirectIndexedX1
lblD5mod4b:	CMP16
			NEXTOPCODE
OpD6M0mod4:
lblD6mod4a:	DirectIndexedX1
lblD6mod4b:	DEC16
			NEXTOPCODE
OpD7M0mod4:
lblD7mod4a:	DirectIndirectIndexedLong1
lblD7mod4b:	CMP16
			NEXTOPCODE
OpD8mod4:
lblD8mod4:	OpD8
			NEXTOPCODE
OpD9M0mod4:
lblD9mod4a:	AbsoluteIndexedY1
lblD9mod4b:	CMP16
			NEXTOPCODE
OpDAX1mod4:
lblDAmod4:	OpDAX1
			NEXTOPCODE
OpDBmod4:
lblDBmod4:	OpDB
			NEXTOPCODE
OpDCmod4:
lblDCmod4:	OpDC
			NEXTOPCODE
OpDDM0mod4:
lblDDmod4a:	AbsoluteIndexedX1
lblDDmod4b:	CMP16
			NEXTOPCODE
OpDEM0mod4:
lblDEmod4a:	AbsoluteIndexedX1
lblDEmod4b:	DEC16
			NEXTOPCODE
OpDFM0mod4:
lblDFmod4a:	AbsoluteLongIndexedX1
lblDFmod4b:	CMP16
			NEXTOPCODE
OpE0X1mod4:
lblE0mod4:	OpE0X1
			NEXTOPCODE
OpE1M0mod4:
lblE1mod4a:	DirectIndexedIndirect1
lblE1mod4b:	SBC16
			NEXTOPCODE
OpE2mod4:
lblE2mod4:	OpE2
			NEXTOPCODE
.pool
OpE3M0mod4:
lblE3mod4a:	StackasmRelative
lblE3mod4b:	SBC16
			NEXTOPCODE
OpE4X1mod4:
lblE4mod4a:	Direct
lblE4mod4b:	CMX8
			NEXTOPCODE
OpE5M0mod4:
lblE5mod4a:	Direct
lblE5mod4b:	SBC16
			NEXTOPCODE
OpE6M0mod4:
lblE6mod4a:	Direct
lblE6mod4b:	INC16
			NEXTOPCODE
OpE7M0mod4:
lblE7mod4a:	DirectIndirectLong
lblE7mod4b:	SBC16
			NEXTOPCODE
OpE8X1mod4:
lblE8mod4:	OpE8X1
			NEXTOPCODE
OpE9M0mod4:
lblE9mod4a:	Immediate16
lblE9mod4b:	SBC16
			NEXTOPCODE
OpEAmod4:
lblEAmod4:	OpEA
			NEXTOPCODE
OpEBmod4:
lblEBmod4:	OpEBM0
			NEXTOPCODE
OpECX1mod4:
lblECmod4a:	Absolute
lblECmod4b:	CMX8
			NEXTOPCODE
OpEDM0mod4:
lblEDmod4a:	Absolute
lblEDmod4b:	SBC16
			NEXTOPCODE
OpEEM0mod4:
lblEEmod4a:	Absolute
lblEEmod4b:	INC16
			NEXTOPCODE
OpEFM0mod4:
lblEFmod4a:	AbsoluteLong
lblEFmod4b:	SBC16
			NEXTOPCODE
OpF0mod4:
lblF0mod4:	OpF0
			NEXTOPCODE
OpF1M0mod4:
lblF1mod4a:	DirectIndirectIndexed1
lblF1mod4b:	SBC16
			NEXTOPCODE
OpF2M0mod4:
lblF2mod4a:	DirectIndirect
lblF2mod4b:	SBC16
			NEXTOPCODE
OpF3M0mod4:
lblF3mod4a:	StackasmRelativeIndirectIndexed1
lblF3mod4b:	SBC16
			NEXTOPCODE
OpF4mod4:
lblF4mod4:	OpF4
			NEXTOPCODE
OpF5M0mod4:
lblF5mod4a:	DirectIndexedX1
lblF5mod4b:	SBC16
			NEXTOPCODE
OpF6M0mod4:
lblF6mod4a:	DirectIndexedX1
lblF6mod4b:	INC16
			NEXTOPCODE
OpF7M0mod4:
lblF7mod4a:	DirectIndirectIndexedLong1
lblF7mod4b:	SBC16
			NEXTOPCODE
OpF8mod4:
lblF8mod4:	OpF8
			NEXTOPCODE
OpF9M0mod4:
lblF9mod4a:	AbsoluteIndexedY1
lblF9mod4b:	SBC16
			NEXTOPCODE
OpFAX1mod4:
lblFAmod4:	OpFAX1
			NEXTOPCODE
OpFBmod4:
lblFBmod4:	OpFB
			NEXTOPCODE
OpFCmod4:
lblFCmod4:	OpFCX1
			NEXTOPCODE
OpFDM0mod4:
lblFDmod4a:	AbsoluteIndexedX1
lblFDmod4b:	SBC16
			NEXTOPCODE
OpFEM0mod4:
lblFEmod4a:	AbsoluteIndexedX1
lblFEmod4b:	INC16
			NEXTOPCODE
OpFFM0mod4:
lblFFmod4a:	AbsoluteLongIndexedX1
lblFFmod4b:	SBC16
			NEXTOPCODE

			
			.pool

