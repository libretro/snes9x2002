	.align 4
   .text
	.globl  DecodeBlockAsm
	
/*
;Bit-Rate Expand Waveform
;
;Desc:
;   Decompresses a 9-byte bit-rate reduced block into 16 16-bit samples.
;   This procedure is designed to be recursively called to decompress a series of blocks.
;In:
;   R0=ESI-> Sample Block
;   R1=EDI   -> Output buffer
;   R2=EDX   =3D Last sample of previous block (32-bit)
;   R3=EBX   =3D Next to last sample (sign extended from 16-bits)
;Out:
;   R0=ESI -> Next Block
;   R1=EDI -> After last sample
;   R2=EDX =3D Last sample (32-bit)
;   R3=EBX =3D Next to last sample (16-bit)
;Destroys:
;   R4=EAX	
*/

@ void DecodeBlockAsm2 (int8 *, int16 *, int32 *, int32 *);
@ DecodeBlockAsm2 (compressed, raw, &ch->previous [0], &ch->previous [1]);
	.align 4
DecodeBlockAsm:
	stmfd	sp!, {r2, r3, r4, r5, r6, r7}
	
	LDRB	R4,[R0],#1

	LDR		R2,[R2]
	LDR		R3,[R3]

	CMP	R4,#0xD0
	MOVHS	R5,#0
	rsblo	r5, r4, #0xcf
	MOVLO	R5,R5,LSR #4
						
	MOV	R6,#8	
	TST	R4,#0xC
	BEQ	Method0
	TST	R4,#0x8
	BEQ	Method1
	TST	R4,#0x4
	BEQ	Method2
	B	Method3			@ ;Must use method 3
/*
ALIGN	16
	;[Smp] ----------------------------------*/
Method0:
	ADD	R5,R5,#16

.macro	MMethod0
.endm	


Method0loop:

	@ two in a go

	LDRB	R4,[R0],#1
	ldrb	r7,[r0],#1

	MOV	R2,R4,LSL #(28)
	MOV	R4,R4,LSL #(24)
	BIC	R4,R4,#0x0F000000
	 	
	MOV	R4,R4,ASR R5	
	MOV	R2,R2,ASR R5
		
	STRH	R4,[R1],#2
	STRH	R2,[R1],#2

	@SUBS	R6,R6,#1
	@beq	Exit0

	@LDRB	R4,[R0],#1

	MOV	R2,R7,LSL #(28)
	MOV	R4,R7,LSL #(24)
	BIC	R4,R4,#0x0F000000
	 	
	MOV	R4,R4,ASR R5	
	MOV	R2,R2,ASR R5
		
	STRH	R4,[R1],#2
	STRH	R2,[R1],#2

	@SUBS	R6,R6,#1
	subs	r6, r6, #2
	BNE	Method0loop

	mov	r3, r4

	ldmfd	sp!, {r0, r1, r4, r5, r6, r7}
	STR		R2,[R0]
	STR		R3,[R1]
		
	bx	lr	


@ ALIGN	16
@ 	;[Delta]+[Smp-1](15/16) -----------------
Method1:
	ADD	R7,R5,#16
Method1loop:	
		LDRSB   R3,[R0]
		BIC	R3,R3,#0xF
		MOV	R3,R3,LSL #8
		MOV	R3,R3,ASR R5

		MOV	R4,R2,LSL #16		
		ADD	R3,R3,R4,ASR #16
		SUB	R3,R3,R4,ASR #20

		STRH	R3,[R1],#2

		LDRSB   R2,[R0],#1		
		MOV	R2,R2,LSL #(12+16)		
		MOV	R2,R2,ASR R7

		MOV	R4,R3,LSL #16		
		ADD	R2,R2,R4,ASR #16
		SUB	R2,R2,R4,ASR #20

		STRH	R2,[R1],#2

	SUBS	R6,R6,#1
	BNE	Method1loop
	
	MOV	R3,R3,LSL #16
	MOV	R3,R3,ASR #16
	
	ldmfd	sp!, {r0, r1, r4, r5, r6, r7}

	STR		R2,[R0]
	STR		R3,[R1]
		
	bx	lr	

	@ ;[Delta]+[Smp-1](61/32)-[Smp-2](30/32) --
Method2:
	ADD	R7,R5,#16
Method2loop:
		LDRSB	R4,[R0], #1
		mov	r12, r4
		BIC	R4,R4,#0xF
		MOV	R4,R4,LSL #8
		MOV	R4,R4,ASR R5

		SUB	R4,R4,R3
		ADD	R4,R4,R3,ASR #4
		MOV	R3,R2
		
		BIC	R2,R2,#3
		ADD	R4,R4,R2,LSL #1		
		SUB	R4,R4,R2,ASR #4						
		SUB	R4,R4,R2,ASR #5
		STRH	R4,[R1],#2

		MOV	R2,R12,LSL #(12+16)		
		MOV	R2,R2,ASR R7

		SUB	R2,R2,R3
		ADD	R2,R2,R3,ASR #4
		MOV	R3,R4
		
		BIC	R4,R4,#3
		ADD	R2,R2,R4,LSL #1		
		SUB	R2,R2,R4,ASR #4						
		SUB	R2,R2,R4,ASR #5		

		STRH	R2,[R1],#2

	SUBS	R6,R6,#1
	BNE	Method2loop

	ldmfd	sp!, {r0, r1, r4, r5, r6, r7}
	STR		R2,[R0]
	STR		R3,[R1]
		
	bx	lr	

Method3:
	ADD	R7,R5,#16
Method3loop:
	LDRSB	R4,[R0], #1
	mov	r12, r4
	BIC	R4,R4,#0xF
	MOV	R4,R4,LSL #8
	MOV	R4,R4,ASR R5

	@ ;Subtract 13/16 of second sample -----
	SUB	R4,R4,R3
	ADD	R4,R4,R3,ASR #3
	ADD	R4,R4,R3,ASR #4
	MOV	R3,R2

	@ ;Add 115/64 of last sample -----------
	BIC	R2,R2,#3
	ADD	R4,R4,R2,LSL #1
	SUB	R4,R4,R2,ASR #3
	SUB	R4,R4,R2,ASR #4
	SUB	R4,R4,R2,ASR #6

	STRH	R4,[R1],#2

	MOV	R2,R12,LSL #(12+16)
	MOV	R2,R2,ASR R7

	SUB	R2,R2,R3
	ADD	R2,R2,R3,ASR #3
	ADD	R2,R2,R3,ASR #4
	MOV	R3,R4

	BIC	R4,R4,#3
	ADD	R2,R2,R4,LSL #1
	SUB	R2,R2,R4,ASR #3
	SUB	R2,R2,R4,ASR #4
	SUB	R2,R2,R4,ASR #6

	STRH	R4,[R1],#2

	SUBS	R6,R6,#1
	BNE	Method3loop
	
	ldmfd	sp!, {r0, r1, r4, r5, r6, r7}
	STR		R2,[R0]
	STR		R3,[R1]
		
	bx	lr	

.pool
