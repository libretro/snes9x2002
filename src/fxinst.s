	.file	"fxinst.cpp"
	.text
	.align	2
	.type	_Z7fx_stopv, %function
_Z7fx_stopv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L5
	ldr	r3, [r3, #72]
	bic	r2, r3, #32
	ldr	r3, .L5
	str	r2, [r3, #72]
	ldr	r2, .L5
	mov	r3, #0
	str	r3, [r2, #2036]
	ldr	r3, .L5
	ldr	r2, [r3, #2036]
	ldr	r3, .L5
	str	r2, [r3, #2040]
	ldr	r3, .L5
	ldr	r3, [r3, #152]
	add	r3, r3, #55
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	cmp	r3, #0
	blt	.L2
	ldr	r3, .L5
	ldr	r3, [r3, #72]
	orr	r2, r3, #32768
	ldr	r3, .L5
	str	r2, [r3, #72]
.L2:
	ldr	r2, .L5
	mov	r3, #0
	str	r3, [r2, #68]
	ldr	r2, .L5
	mov	r3, #1
	strb	r3, [r2, #109]
	ldr	r3, .L5
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L5
	str	r2, [r3, #72]
	ldr	r2, .L5
	ldr	r3, .L5
	str	r3, [r2, #104]
	ldr	r3, .L5
	ldr	r2, [r3, #104]
	ldr	r3, .L5
	str	r2, [r3, #100]
	ldr	r3, .L5
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L5
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L6:
	.align	2
.L5:
	.word	GSU
	.size	_Z7fx_stopv, .-_Z7fx_stopv
	.global	__gxx_personality_sj0
	.align	2
	.type	_Z6fx_nopv, %function
_Z6fx_nopv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L9
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L9
	str	r2, [r3, #72]
	ldr	r2, .L9
	ldr	r3, .L9
	str	r3, [r2, #104]
	ldr	r3, .L9
	ldr	r2, [r3, #104]
	ldr	r3, .L9
	str	r2, [r3, #100]
	ldr	r3, .L9
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L9
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L10:
	.align	2
.L9:
	.word	GSU
	.size	_Z6fx_nopv, .-_Z6fx_nopv
	.align	2
	.type	_Z6fx_lsrv, %function
_Z6fx_lsrv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L15
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r2, r3, #1
	ldr	r3, .L15
	str	r2, [r3, #124]
	ldr	r3, .L15
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, lsr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-16]
	ldr	r3, .L15
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L15
	str	r2, [r3, #60]
	ldr	r3, .L15
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L15
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L15
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L15
	ldr	r2, [r3, #100]
	ldr	r3, .L15+4
	cmp	r2, r3
	bne	.L12
	ldr	r3, .L15
	ldr	r2, [r3, #468]
	ldr	r3, .L15
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L15
	strb	r3, [r2, #108]
.L12:
	ldr	r3, .L15
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L15
	str	r2, [r3, #72]
	ldr	r2, .L15
	ldr	r3, .L15
	str	r3, [r2, #104]
	ldr	r3, .L15
	ldr	r2, [r3, #104]
	ldr	r3, .L15
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L16:
	.align	2
.L15:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_lsrv, .-_Z6fx_lsrv
	.align	2
	.type	_Z6fx_rolv, %function
_Z6fx_rolv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L21
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #1
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, .L21
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-16]
	ldr	r3, .L21
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #15
	and	r2, r3, #1
	ldr	r3, .L21
	str	r2, [r3, #124]
	ldr	r3, .L21
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L21
	str	r2, [r3, #60]
	ldr	r3, .L21
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L21
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L21
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L21
	ldr	r2, [r3, #100]
	ldr	r3, .L21+4
	cmp	r2, r3
	bne	.L18
	ldr	r3, .L21
	ldr	r2, [r3, #468]
	ldr	r3, .L21
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L21
	strb	r3, [r2, #108]
.L18:
	ldr	r3, .L21
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L21
	str	r2, [r3, #72]
	ldr	r2, .L21
	ldr	r3, .L21
	str	r3, [r2, #104]
	ldr	r3, .L21
	ldr	r2, [r3, #104]
	ldr	r3, .L21
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L22:
	.align	2
.L21:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_rolv, .-_Z6fx_rolv
	.align	2
	.type	_Z6fx_brav, %function
_Z6fx_brav:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L25
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L25
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L25
	str	r2, [r3, #60]
	ldr	r3, .L25
	ldr	r2, [r3, #472]
	ldr	r3, .L25
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L25
	strb	r3, [r2, #109]
	ldr	r3, .L25
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L25
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L26:
	.align	2
.L25:
	.word	GSU
	.size	_Z6fx_brav, .-_Z6fx_brav
	.align	2
	.type	_Z6fx_bltv, %function
_Z6fx_bltv:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	ldr	r3, .L36
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L36
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L36
	str	r2, [r3, #60]
	ldr	r3, .L36
	ldr	r2, [r3, #472]
	ldr	r3, .L36
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L36
	strb	r3, [r2, #109]
	ldr	r3, .L36
	ldr	r3, [r3, #116]
	and	r3, r3, #32768
	cmp	r3, #0
	moveq	r2, #0
	movne	r2, #1
	str	r2, [fp, #-24]
	ldr	r3, .L36
	ldr	r2, [r3, #128]
	ldr	r3, .L36+4
	cmp	r2, r3
	bgt	.L28
	ldr	r3, .L36
	ldr	r3, [r3, #128]
	cmn	r3, #32768
	bge	.L30
.L28:
	mov	r3, #1
	str	r3, [fp, #-20]
	b	.L31
.L30:
	mov	r2, #0
	str	r2, [fp, #-20]
.L31:
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-24]
	cmp	r2, r3
	beq	.L32
	ldr	r3, .L36
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L36
	str	r2, [r3, #60]
	b	.L35
.L32:
	ldr	r3, .L36
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L36
	str	r2, [r3, #60]
.L35:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L37:
	.align	2
.L36:
	.word	GSU
	.word	32767
	.size	_Z6fx_bltv, .-_Z6fx_bltv
	.align	2
	.type	_Z6fx_bgev, %function
_Z6fx_bgev:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	ldr	r3, .L47
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L47
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L47
	str	r2, [r3, #60]
	ldr	r3, .L47
	ldr	r2, [r3, #472]
	ldr	r3, .L47
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L47
	strb	r3, [r2, #109]
	ldr	r3, .L47
	ldr	r3, [r3, #116]
	and	r3, r3, #32768
	cmp	r3, #0
	moveq	r2, #0
	movne	r2, #1
	str	r2, [fp, #-24]
	ldr	r3, .L47
	ldr	r2, [r3, #128]
	ldr	r3, .L47+4
	cmp	r2, r3
	bgt	.L39
	ldr	r3, .L47
	ldr	r3, [r3, #128]
	cmn	r3, #32768
	bge	.L41
.L39:
	mov	r3, #1
	str	r3, [fp, #-20]
	b	.L42
.L41:
	mov	r2, #0
	str	r2, [fp, #-20]
.L42:
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-24]
	cmp	r2, r3
	bne	.L43
	ldr	r3, .L47
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L47
	str	r2, [r3, #60]
	b	.L46
.L43:
	ldr	r3, .L47
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L47
	str	r2, [r3, #60]
.L46:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L48:
	.align	2
.L47:
	.word	GSU
	.word	32767
	.size	_Z6fx_bgev, .-_Z6fx_bgev
	.align	2
	.type	_Z6fx_bnev, %function
_Z6fx_bnev:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L54
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L54
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L54
	str	r2, [r3, #60]
	ldr	r3, .L54
	ldr	r2, [r3, #472]
	ldr	r3, .L54
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L54
	strb	r3, [r2, #109]
	ldr	r3, .L54
	ldr	r3, [r3, #120]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	cmp	r3, #0
	beq	.L50
	ldr	r3, .L54
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L54
	str	r2, [r3, #60]
	b	.L53
.L50:
	ldr	r3, .L54
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L54
	str	r2, [r3, #60]
.L53:
	ldmib	sp, {fp, sp, pc}
.L55:
	.align	2
.L54:
	.word	GSU
	.size	_Z6fx_bnev, .-_Z6fx_bnev
	.align	2
	.type	_Z6fx_beqv, %function
_Z6fx_beqv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L61
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L61
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L61
	str	r2, [r3, #60]
	ldr	r3, .L61
	ldr	r2, [r3, #472]
	ldr	r3, .L61
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L61
	strb	r3, [r2, #109]
	ldr	r3, .L61
	ldr	r3, [r3, #120]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	cmp	r3, #0
	bne	.L57
	ldr	r3, .L61
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L61
	str	r2, [r3, #60]
	b	.L60
.L57:
	ldr	r3, .L61
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L61
	str	r2, [r3, #60]
.L60:
	ldmib	sp, {fp, sp, pc}
.L62:
	.align	2
.L61:
	.word	GSU
	.size	_Z6fx_beqv, .-_Z6fx_beqv
	.align	2
	.type	_Z6fx_bplv, %function
_Z6fx_bplv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L68
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L68
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L68
	str	r2, [r3, #60]
	ldr	r3, .L68
	ldr	r2, [r3, #472]
	ldr	r3, .L68
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L68
	strb	r3, [r2, #109]
	ldr	r3, .L68
	ldr	r3, [r3, #116]
	and	r3, r3, #32768
	cmp	r3, #0
	bne	.L64
	ldr	r3, .L68
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L68
	str	r2, [r3, #60]
	b	.L67
.L64:
	ldr	r3, .L68
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L68
	str	r2, [r3, #60]
.L67:
	ldmib	sp, {fp, sp, pc}
.L69:
	.align	2
.L68:
	.word	GSU
	.size	_Z6fx_bplv, .-_Z6fx_bplv
	.align	2
	.type	_Z6fx_bmiv, %function
_Z6fx_bmiv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L75
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L75
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L75
	str	r2, [r3, #60]
	ldr	r3, .L75
	ldr	r2, [r3, #472]
	ldr	r3, .L75
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L75
	strb	r3, [r2, #109]
	ldr	r3, .L75
	ldr	r3, [r3, #116]
	and	r3, r3, #32768
	cmp	r3, #0
	beq	.L71
	ldr	r3, .L75
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L75
	str	r2, [r3, #60]
	b	.L74
.L71:
	ldr	r3, .L75
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L75
	str	r2, [r3, #60]
.L74:
	ldmib	sp, {fp, sp, pc}
.L76:
	.align	2
.L75:
	.word	GSU
	.size	_Z6fx_bmiv, .-_Z6fx_bmiv
	.align	2
	.type	_Z6fx_bccv, %function
_Z6fx_bccv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L82
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L82
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L82
	str	r2, [r3, #60]
	ldr	r3, .L82
	ldr	r2, [r3, #472]
	ldr	r3, .L82
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L82
	strb	r3, [r2, #109]
	ldr	r3, .L82
	ldr	r3, [r3, #124]
	and	r3, r3, #1
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L78
	ldr	r3, .L82
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L82
	str	r2, [r3, #60]
	b	.L81
.L78:
	ldr	r3, .L82
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L82
	str	r2, [r3, #60]
.L81:
	ldmib	sp, {fp, sp, pc}
.L83:
	.align	2
.L82:
	.word	GSU
	.size	_Z6fx_bccv, .-_Z6fx_bccv
	.align	2
	.type	_Z6fx_bcsv, %function
_Z6fx_bcsv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L89
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L89
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L89
	str	r2, [r3, #60]
	ldr	r3, .L89
	ldr	r2, [r3, #472]
	ldr	r3, .L89
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L89
	strb	r3, [r2, #109]
	ldr	r3, .L89
	ldr	r3, [r3, #124]
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L85
	ldr	r3, .L89
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L89
	str	r2, [r3, #60]
	b	.L88
.L85:
	ldr	r3, .L89
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L89
	str	r2, [r3, #60]
.L88:
	ldmib	sp, {fp, sp, pc}
.L90:
	.align	2
.L89:
	.word	GSU
	.size	_Z6fx_bcsv, .-_Z6fx_bcsv
	.align	2
	.type	_Z6fx_bvcv, %function
_Z6fx_bvcv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L97
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L97
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L97
	str	r2, [r3, #60]
	ldr	r3, .L97
	ldr	r2, [r3, #472]
	ldr	r3, .L97
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L97
	strb	r3, [r2, #109]
	ldr	r3, .L97
	ldr	r2, [r3, #128]
	ldr	r3, .L97+4
	cmp	r2, r3
	bgt	.L92
	ldr	r3, .L97
	ldr	r3, [r3, #128]
	cmn	r3, #32768
	blt	.L92
	ldr	r3, .L97
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L97
	str	r2, [r3, #60]
	b	.L96
.L92:
	ldr	r3, .L97
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L97
	str	r2, [r3, #60]
.L96:
	ldmib	sp, {fp, sp, pc}
.L98:
	.align	2
.L97:
	.word	GSU
	.word	32767
	.size	_Z6fx_bvcv, .-_Z6fx_bvcv
	.align	2
	.type	_Z6fx_bvsv, %function
_Z6fx_bvsv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L105
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L105
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L105
	str	r2, [r3, #60]
	ldr	r3, .L105
	ldr	r2, [r3, #472]
	ldr	r3, .L105
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L105
	strb	r3, [r2, #109]
	ldr	r3, .L105
	ldr	r2, [r3, #128]
	ldr	r3, .L105+4
	cmp	r2, r3
	bgt	.L100
	ldr	r3, .L105
	ldr	r3, [r3, #128]
	cmn	r3, #32768
	bge	.L102
.L100:
	ldr	r3, .L105
	ldr	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	add	r2, r2, r3
	ldr	r3, .L105
	str	r2, [r3, #60]
	b	.L104
.L102:
	ldr	r3, .L105
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L105
	str	r2, [r3, #60]
.L104:
	ldmib	sp, {fp, sp, pc}
.L106:
	.align	2
.L105:
	.word	GSU
	.word	32767
	.size	_Z6fx_bvsv, .-_Z6fx_bvsv
	.align	2
	.type	_Z8fx_to_r0v, %function
_Z8fx_to_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L112
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L108
	ldr	r3, .L112
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L112
	str	r2, [r3, #0]
	ldr	r3, .L112
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L112
	str	r2, [r3, #72]
	ldr	r2, .L112
	ldr	r3, .L112
	str	r3, [r2, #104]
	ldr	r3, .L112
	ldr	r2, [r3, #104]
	ldr	r3, .L112
	str	r2, [r3, #100]
	b	.L110
.L108:
	ldr	r2, .L112
	ldr	r3, .L112
	str	r3, [r2, #100]
.L110:
	ldr	r3, .L112
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L112
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L113:
	.align	2
.L112:
	.word	GSU
	.size	_Z8fx_to_r0v, .-_Z8fx_to_r0v
	.align	2
	.type	_Z8fx_to_r1v, %function
_Z8fx_to_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L119
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L115
	ldr	r3, .L119
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L119
	str	r2, [r3, #4]
	ldr	r3, .L119
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L119
	str	r2, [r3, #72]
	ldr	r2, .L119
	ldr	r3, .L119
	str	r3, [r2, #104]
	ldr	r3, .L119
	ldr	r2, [r3, #104]
	ldr	r3, .L119
	str	r2, [r3, #100]
	b	.L117
.L115:
	ldr	r2, .L119
	ldr	r3, .L119+4
	str	r3, [r2, #100]
.L117:
	ldr	r3, .L119
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L119
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L120:
	.align	2
.L119:
	.word	GSU
	.word	GSU+4
	.size	_Z8fx_to_r1v, .-_Z8fx_to_r1v
	.align	2
	.type	_Z8fx_to_r2v, %function
_Z8fx_to_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L126
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L122
	ldr	r3, .L126
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L126
	str	r2, [r3, #8]
	ldr	r3, .L126
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L126
	str	r2, [r3, #72]
	ldr	r2, .L126
	ldr	r3, .L126
	str	r3, [r2, #104]
	ldr	r3, .L126
	ldr	r2, [r3, #104]
	ldr	r3, .L126
	str	r2, [r3, #100]
	b	.L124
.L122:
	ldr	r2, .L126
	ldr	r3, .L126+4
	str	r3, [r2, #100]
.L124:
	ldr	r3, .L126
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L126
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L127:
	.align	2
.L126:
	.word	GSU
	.word	GSU+8
	.size	_Z8fx_to_r2v, .-_Z8fx_to_r2v
	.align	2
	.type	_Z8fx_to_r3v, %function
_Z8fx_to_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L133
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L129
	ldr	r3, .L133
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L133
	str	r2, [r3, #12]
	ldr	r3, .L133
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L133
	str	r2, [r3, #72]
	ldr	r2, .L133
	ldr	r3, .L133
	str	r3, [r2, #104]
	ldr	r3, .L133
	ldr	r2, [r3, #104]
	ldr	r3, .L133
	str	r2, [r3, #100]
	b	.L131
.L129:
	ldr	r2, .L133
	ldr	r3, .L133+4
	str	r3, [r2, #100]
.L131:
	ldr	r3, .L133
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L133
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L134:
	.align	2
.L133:
	.word	GSU
	.word	GSU+12
	.size	_Z8fx_to_r3v, .-_Z8fx_to_r3v
	.align	2
	.type	_Z8fx_to_r4v, %function
_Z8fx_to_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L140
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L136
	ldr	r3, .L140
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L140
	str	r2, [r3, #16]
	ldr	r3, .L140
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L140
	str	r2, [r3, #72]
	ldr	r2, .L140
	ldr	r3, .L140
	str	r3, [r2, #104]
	ldr	r3, .L140
	ldr	r2, [r3, #104]
	ldr	r3, .L140
	str	r2, [r3, #100]
	b	.L138
.L136:
	ldr	r2, .L140
	ldr	r3, .L140+4
	str	r3, [r2, #100]
.L138:
	ldr	r3, .L140
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L140
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L141:
	.align	2
.L140:
	.word	GSU
	.word	GSU+16
	.size	_Z8fx_to_r4v, .-_Z8fx_to_r4v
	.align	2
	.type	_Z8fx_to_r5v, %function
_Z8fx_to_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L147
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L143
	ldr	r3, .L147
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L147
	str	r2, [r3, #20]
	ldr	r3, .L147
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L147
	str	r2, [r3, #72]
	ldr	r2, .L147
	ldr	r3, .L147
	str	r3, [r2, #104]
	ldr	r3, .L147
	ldr	r2, [r3, #104]
	ldr	r3, .L147
	str	r2, [r3, #100]
	b	.L145
.L143:
	ldr	r2, .L147
	ldr	r3, .L147+4
	str	r3, [r2, #100]
.L145:
	ldr	r3, .L147
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L147
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L148:
	.align	2
.L147:
	.word	GSU
	.word	GSU+20
	.size	_Z8fx_to_r5v, .-_Z8fx_to_r5v
	.align	2
	.type	_Z8fx_to_r6v, %function
_Z8fx_to_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L154
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L150
	ldr	r3, .L154
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L154
	str	r2, [r3, #24]
	ldr	r3, .L154
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L154
	str	r2, [r3, #72]
	ldr	r2, .L154
	ldr	r3, .L154
	str	r3, [r2, #104]
	ldr	r3, .L154
	ldr	r2, [r3, #104]
	ldr	r3, .L154
	str	r2, [r3, #100]
	b	.L152
.L150:
	ldr	r2, .L154
	ldr	r3, .L154+4
	str	r3, [r2, #100]
.L152:
	ldr	r3, .L154
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L154
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L155:
	.align	2
.L154:
	.word	GSU
	.word	GSU+24
	.size	_Z8fx_to_r6v, .-_Z8fx_to_r6v
	.align	2
	.type	_Z8fx_to_r7v, %function
_Z8fx_to_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L161
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L157
	ldr	r3, .L161
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L161
	str	r2, [r3, #28]
	ldr	r3, .L161
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L161
	str	r2, [r3, #72]
	ldr	r2, .L161
	ldr	r3, .L161
	str	r3, [r2, #104]
	ldr	r3, .L161
	ldr	r2, [r3, #104]
	ldr	r3, .L161
	str	r2, [r3, #100]
	b	.L159
.L157:
	ldr	r2, .L161
	ldr	r3, .L161+4
	str	r3, [r2, #100]
.L159:
	ldr	r3, .L161
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L161
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L162:
	.align	2
.L161:
	.word	GSU
	.word	GSU+28
	.size	_Z8fx_to_r7v, .-_Z8fx_to_r7v
	.align	2
	.type	_Z8fx_to_r8v, %function
_Z8fx_to_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L168
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L164
	ldr	r3, .L168
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L168
	str	r2, [r3, #32]
	ldr	r3, .L168
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L168
	str	r2, [r3, #72]
	ldr	r2, .L168
	ldr	r3, .L168
	str	r3, [r2, #104]
	ldr	r3, .L168
	ldr	r2, [r3, #104]
	ldr	r3, .L168
	str	r2, [r3, #100]
	b	.L166
.L164:
	ldr	r2, .L168
	ldr	r3, .L168+4
	str	r3, [r2, #100]
.L166:
	ldr	r3, .L168
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L168
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L169:
	.align	2
.L168:
	.word	GSU
	.word	GSU+32
	.size	_Z8fx_to_r8v, .-_Z8fx_to_r8v
	.align	2
	.type	_Z8fx_to_r9v, %function
_Z8fx_to_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L175
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L171
	ldr	r3, .L175
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L175
	str	r2, [r3, #36]
	ldr	r3, .L175
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L175
	str	r2, [r3, #72]
	ldr	r2, .L175
	ldr	r3, .L175
	str	r3, [r2, #104]
	ldr	r3, .L175
	ldr	r2, [r3, #104]
	ldr	r3, .L175
	str	r2, [r3, #100]
	b	.L173
.L171:
	ldr	r2, .L175
	ldr	r3, .L175+4
	str	r3, [r2, #100]
.L173:
	ldr	r3, .L175
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L175
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L176:
	.align	2
.L175:
	.word	GSU
	.word	GSU+36
	.size	_Z8fx_to_r9v, .-_Z8fx_to_r9v
	.align	2
	.type	_Z9fx_to_r10v, %function
_Z9fx_to_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L182
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L178
	ldr	r3, .L182
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L182
	str	r2, [r3, #40]
	ldr	r3, .L182
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L182
	str	r2, [r3, #72]
	ldr	r2, .L182
	ldr	r3, .L182
	str	r3, [r2, #104]
	ldr	r3, .L182
	ldr	r2, [r3, #104]
	ldr	r3, .L182
	str	r2, [r3, #100]
	b	.L180
.L178:
	ldr	r2, .L182
	ldr	r3, .L182+4
	str	r3, [r2, #100]
.L180:
	ldr	r3, .L182
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L182
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L183:
	.align	2
.L182:
	.word	GSU
	.word	GSU+40
	.size	_Z9fx_to_r10v, .-_Z9fx_to_r10v
	.align	2
	.type	_Z9fx_to_r11v, %function
_Z9fx_to_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L189
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L185
	ldr	r3, .L189
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L189
	str	r2, [r3, #44]
	ldr	r3, .L189
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L189
	str	r2, [r3, #72]
	ldr	r2, .L189
	ldr	r3, .L189
	str	r3, [r2, #104]
	ldr	r3, .L189
	ldr	r2, [r3, #104]
	ldr	r3, .L189
	str	r2, [r3, #100]
	b	.L187
.L185:
	ldr	r2, .L189
	ldr	r3, .L189+4
	str	r3, [r2, #100]
.L187:
	ldr	r3, .L189
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L189
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L190:
	.align	2
.L189:
	.word	GSU
	.word	GSU+44
	.size	_Z9fx_to_r11v, .-_Z9fx_to_r11v
	.align	2
	.type	_Z9fx_to_r12v, %function
_Z9fx_to_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L196
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L192
	ldr	r3, .L196
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L196
	str	r2, [r3, #48]
	ldr	r3, .L196
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L196
	str	r2, [r3, #72]
	ldr	r2, .L196
	ldr	r3, .L196
	str	r3, [r2, #104]
	ldr	r3, .L196
	ldr	r2, [r3, #104]
	ldr	r3, .L196
	str	r2, [r3, #100]
	b	.L194
.L192:
	ldr	r2, .L196
	ldr	r3, .L196+4
	str	r3, [r2, #100]
.L194:
	ldr	r3, .L196
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L196
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L197:
	.align	2
.L196:
	.word	GSU
	.word	GSU+48
	.size	_Z9fx_to_r12v, .-_Z9fx_to_r12v
	.align	2
	.type	_Z9fx_to_r13v, %function
_Z9fx_to_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L203
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L199
	ldr	r3, .L203
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L203
	str	r2, [r3, #52]
	ldr	r3, .L203
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L203
	str	r2, [r3, #72]
	ldr	r2, .L203
	ldr	r3, .L203
	str	r3, [r2, #104]
	ldr	r3, .L203
	ldr	r2, [r3, #104]
	ldr	r3, .L203
	str	r2, [r3, #100]
	b	.L201
.L199:
	ldr	r2, .L203
	ldr	r3, .L203+4
	str	r3, [r2, #100]
.L201:
	ldr	r3, .L203
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L203
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L204:
	.align	2
.L203:
	.word	GSU
	.word	GSU+52
	.size	_Z9fx_to_r13v, .-_Z9fx_to_r13v
	.align	2
	.type	_Z9fx_to_r14v, %function
_Z9fx_to_r14v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L210
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L206
	ldr	r3, .L210
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L210
	str	r2, [r3, #56]
	ldr	r3, .L210
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L210
	str	r2, [r3, #72]
	ldr	r2, .L210
	ldr	r3, .L210
	str	r3, [r2, #104]
	ldr	r3, .L210
	ldr	r2, [r3, #104]
	ldr	r3, .L210
	str	r2, [r3, #100]
	ldr	r3, .L210
	ldr	r2, [r3, #468]
	ldr	r3, .L210
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L210
	strb	r3, [r2, #108]
	b	.L208
.L206:
	ldr	r2, .L210
	ldr	r3, .L210+4
	str	r3, [r2, #100]
.L208:
	ldr	r3, .L210
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L210
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L211:
	.align	2
.L210:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_to_r14v, .-_Z9fx_to_r14v
	.align	2
	.type	_Z9fx_to_r15v, %function
_Z9fx_to_r15v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L217
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L213
	ldr	r3, .L217
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L217
	str	r2, [r3, #60]
	ldr	r3, .L217
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L217
	str	r2, [r3, #72]
	ldr	r2, .L217
	ldr	r3, .L217
	str	r3, [r2, #104]
	ldr	r3, .L217
	ldr	r2, [r3, #104]
	ldr	r3, .L217
	str	r2, [r3, #100]
	b	.L216
.L213:
	ldr	r2, .L217
	ldr	r3, .L217+4
	str	r3, [r2, #100]
	ldr	r3, .L217
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L217
	str	r2, [r3, #60]
.L216:
	ldmfd	sp, {fp, sp, pc}
.L218:
	.align	2
.L217:
	.word	GSU
	.word	GSU+60
	.size	_Z9fx_to_r15v, .-_Z9fx_to_r15v
	.align	2
	.type	_Z10fx_with_r0v, %function
_Z10fx_with_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L221
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L221
	str	r2, [r3, #72]
	ldr	r2, .L221
	ldr	r3, .L221
	str	r3, [r2, #100]
	ldr	r3, .L221
	ldr	r2, [r3, #100]
	ldr	r3, .L221
	str	r2, [r3, #104]
	ldr	r3, .L221
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L221
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L222:
	.align	2
.L221:
	.word	GSU
	.size	_Z10fx_with_r0v, .-_Z10fx_with_r0v
	.align	2
	.type	_Z10fx_with_r1v, %function
_Z10fx_with_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L225
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L225
	str	r2, [r3, #72]
	ldr	r2, .L225
	ldr	r3, .L225+4
	str	r3, [r2, #100]
	ldr	r3, .L225
	ldr	r2, [r3, #100]
	ldr	r3, .L225
	str	r2, [r3, #104]
	ldr	r3, .L225
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L225
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L226:
	.align	2
.L225:
	.word	GSU
	.word	GSU+4
	.size	_Z10fx_with_r1v, .-_Z10fx_with_r1v
	.align	2
	.type	_Z10fx_with_r2v, %function
_Z10fx_with_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L229
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L229
	str	r2, [r3, #72]
	ldr	r2, .L229
	ldr	r3, .L229+4
	str	r3, [r2, #100]
	ldr	r3, .L229
	ldr	r2, [r3, #100]
	ldr	r3, .L229
	str	r2, [r3, #104]
	ldr	r3, .L229
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L229
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L230:
	.align	2
.L229:
	.word	GSU
	.word	GSU+8
	.size	_Z10fx_with_r2v, .-_Z10fx_with_r2v
	.align	2
	.type	_Z10fx_with_r3v, %function
_Z10fx_with_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L233
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L233
	str	r2, [r3, #72]
	ldr	r2, .L233
	ldr	r3, .L233+4
	str	r3, [r2, #100]
	ldr	r3, .L233
	ldr	r2, [r3, #100]
	ldr	r3, .L233
	str	r2, [r3, #104]
	ldr	r3, .L233
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L233
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L234:
	.align	2
.L233:
	.word	GSU
	.word	GSU+12
	.size	_Z10fx_with_r3v, .-_Z10fx_with_r3v
	.align	2
	.type	_Z10fx_with_r4v, %function
_Z10fx_with_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L237
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L237
	str	r2, [r3, #72]
	ldr	r2, .L237
	ldr	r3, .L237+4
	str	r3, [r2, #100]
	ldr	r3, .L237
	ldr	r2, [r3, #100]
	ldr	r3, .L237
	str	r2, [r3, #104]
	ldr	r3, .L237
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L237
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L238:
	.align	2
.L237:
	.word	GSU
	.word	GSU+16
	.size	_Z10fx_with_r4v, .-_Z10fx_with_r4v
	.align	2
	.type	_Z10fx_with_r5v, %function
_Z10fx_with_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L241
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L241
	str	r2, [r3, #72]
	ldr	r2, .L241
	ldr	r3, .L241+4
	str	r3, [r2, #100]
	ldr	r3, .L241
	ldr	r2, [r3, #100]
	ldr	r3, .L241
	str	r2, [r3, #104]
	ldr	r3, .L241
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L241
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L242:
	.align	2
.L241:
	.word	GSU
	.word	GSU+20
	.size	_Z10fx_with_r5v, .-_Z10fx_with_r5v
	.align	2
	.type	_Z10fx_with_r6v, %function
_Z10fx_with_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L245
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L245
	str	r2, [r3, #72]
	ldr	r2, .L245
	ldr	r3, .L245+4
	str	r3, [r2, #100]
	ldr	r3, .L245
	ldr	r2, [r3, #100]
	ldr	r3, .L245
	str	r2, [r3, #104]
	ldr	r3, .L245
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L245
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L246:
	.align	2
.L245:
	.word	GSU
	.word	GSU+24
	.size	_Z10fx_with_r6v, .-_Z10fx_with_r6v
	.align	2
	.type	_Z10fx_with_r7v, %function
_Z10fx_with_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L249
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L249
	str	r2, [r3, #72]
	ldr	r2, .L249
	ldr	r3, .L249+4
	str	r3, [r2, #100]
	ldr	r3, .L249
	ldr	r2, [r3, #100]
	ldr	r3, .L249
	str	r2, [r3, #104]
	ldr	r3, .L249
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L249
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L250:
	.align	2
.L249:
	.word	GSU
	.word	GSU+28
	.size	_Z10fx_with_r7v, .-_Z10fx_with_r7v
	.align	2
	.type	_Z10fx_with_r8v, %function
_Z10fx_with_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L253
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L253
	str	r2, [r3, #72]
	ldr	r2, .L253
	ldr	r3, .L253+4
	str	r3, [r2, #100]
	ldr	r3, .L253
	ldr	r2, [r3, #100]
	ldr	r3, .L253
	str	r2, [r3, #104]
	ldr	r3, .L253
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L253
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L254:
	.align	2
.L253:
	.word	GSU
	.word	GSU+32
	.size	_Z10fx_with_r8v, .-_Z10fx_with_r8v
	.align	2
	.type	_Z10fx_with_r9v, %function
_Z10fx_with_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L257
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L257
	str	r2, [r3, #72]
	ldr	r2, .L257
	ldr	r3, .L257+4
	str	r3, [r2, #100]
	ldr	r3, .L257
	ldr	r2, [r3, #100]
	ldr	r3, .L257
	str	r2, [r3, #104]
	ldr	r3, .L257
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L257
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L258:
	.align	2
.L257:
	.word	GSU
	.word	GSU+36
	.size	_Z10fx_with_r9v, .-_Z10fx_with_r9v
	.align	2
	.type	_Z11fx_with_r10v, %function
_Z11fx_with_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L261
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L261
	str	r2, [r3, #72]
	ldr	r2, .L261
	ldr	r3, .L261+4
	str	r3, [r2, #100]
	ldr	r3, .L261
	ldr	r2, [r3, #100]
	ldr	r3, .L261
	str	r2, [r3, #104]
	ldr	r3, .L261
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L261
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L262:
	.align	2
.L261:
	.word	GSU
	.word	GSU+40
	.size	_Z11fx_with_r10v, .-_Z11fx_with_r10v
	.align	2
	.type	_Z11fx_with_r11v, %function
_Z11fx_with_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L265
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L265
	str	r2, [r3, #72]
	ldr	r2, .L265
	ldr	r3, .L265+4
	str	r3, [r2, #100]
	ldr	r3, .L265
	ldr	r2, [r3, #100]
	ldr	r3, .L265
	str	r2, [r3, #104]
	ldr	r3, .L265
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L265
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L266:
	.align	2
.L265:
	.word	GSU
	.word	GSU+44
	.size	_Z11fx_with_r11v, .-_Z11fx_with_r11v
	.align	2
	.type	_Z11fx_with_r12v, %function
_Z11fx_with_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L269
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L269
	str	r2, [r3, #72]
	ldr	r2, .L269
	ldr	r3, .L269+4
	str	r3, [r2, #100]
	ldr	r3, .L269
	ldr	r2, [r3, #100]
	ldr	r3, .L269
	str	r2, [r3, #104]
	ldr	r3, .L269
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L269
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L270:
	.align	2
.L269:
	.word	GSU
	.word	GSU+48
	.size	_Z11fx_with_r12v, .-_Z11fx_with_r12v
	.align	2
	.type	_Z11fx_with_r13v, %function
_Z11fx_with_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L273
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L273
	str	r2, [r3, #72]
	ldr	r2, .L273
	ldr	r3, .L273+4
	str	r3, [r2, #100]
	ldr	r3, .L273
	ldr	r2, [r3, #100]
	ldr	r3, .L273
	str	r2, [r3, #104]
	ldr	r3, .L273
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L273
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L274:
	.align	2
.L273:
	.word	GSU
	.word	GSU+52
	.size	_Z11fx_with_r13v, .-_Z11fx_with_r13v
	.align	2
	.type	_Z11fx_with_r14v, %function
_Z11fx_with_r14v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L277
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L277
	str	r2, [r3, #72]
	ldr	r2, .L277
	ldr	r3, .L277+4
	str	r3, [r2, #100]
	ldr	r3, .L277
	ldr	r2, [r3, #100]
	ldr	r3, .L277
	str	r2, [r3, #104]
	ldr	r3, .L277
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L277
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L278:
	.align	2
.L277:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_with_r14v, .-_Z11fx_with_r14v
	.align	2
	.type	_Z11fx_with_r15v, %function
_Z11fx_with_r15v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L281
	ldr	r3, [r3, #72]
	orr	r2, r3, #4096
	ldr	r3, .L281
	str	r2, [r3, #72]
	ldr	r2, .L281
	ldr	r3, .L281+4
	str	r3, [r2, #100]
	ldr	r3, .L281
	ldr	r2, [r3, #100]
	ldr	r3, .L281
	str	r2, [r3, #104]
	ldr	r3, .L281
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L281
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L282:
	.align	2
.L281:
	.word	GSU
	.word	GSU+60
	.size	_Z11fx_with_r15v, .-_Z11fx_with_r15v
	.align	2
	.type	_Z9fx_stw_r0v, %function
_Z9fx_stw_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L285
	ldr	r2, [r3, #0]
	ldr	r3, .L285
	str	r2, [r3, #96]
	ldr	r3, .L285
	ldr	r2, [r3, #464]
	ldr	r3, .L285
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L285
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L285
	ldr	r2, [r3, #464]
	ldr	r3, .L285
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L285
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L285
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L285
	str	r2, [r3, #72]
	ldr	r2, .L285
	ldr	r3, .L285
	str	r3, [r2, #104]
	ldr	r3, .L285
	ldr	r2, [r3, #104]
	ldr	r3, .L285
	str	r2, [r3, #100]
	ldr	r3, .L285
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L285
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L286:
	.align	2
.L285:
	.word	GSU
	.size	_Z9fx_stw_r0v, .-_Z9fx_stw_r0v
	.align	2
	.type	_Z9fx_stw_r1v, %function
_Z9fx_stw_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L289
	ldr	r2, [r3, #4]
	ldr	r3, .L289
	str	r2, [r3, #96]
	ldr	r3, .L289
	ldr	r2, [r3, #464]
	ldr	r3, .L289
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L289
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L289
	ldr	r2, [r3, #464]
	ldr	r3, .L289
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L289
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L289
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L289
	str	r2, [r3, #72]
	ldr	r2, .L289
	ldr	r3, .L289
	str	r3, [r2, #104]
	ldr	r3, .L289
	ldr	r2, [r3, #104]
	ldr	r3, .L289
	str	r2, [r3, #100]
	ldr	r3, .L289
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L289
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L290:
	.align	2
.L289:
	.word	GSU
	.size	_Z9fx_stw_r1v, .-_Z9fx_stw_r1v
	.align	2
	.type	_Z9fx_stw_r2v, %function
_Z9fx_stw_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L293
	ldr	r2, [r3, #8]
	ldr	r3, .L293
	str	r2, [r3, #96]
	ldr	r3, .L293
	ldr	r2, [r3, #464]
	ldr	r3, .L293
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L293
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L293
	ldr	r2, [r3, #464]
	ldr	r3, .L293
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L293
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L293
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L293
	str	r2, [r3, #72]
	ldr	r2, .L293
	ldr	r3, .L293
	str	r3, [r2, #104]
	ldr	r3, .L293
	ldr	r2, [r3, #104]
	ldr	r3, .L293
	str	r2, [r3, #100]
	ldr	r3, .L293
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L293
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L294:
	.align	2
.L293:
	.word	GSU
	.size	_Z9fx_stw_r2v, .-_Z9fx_stw_r2v
	.align	2
	.type	_Z9fx_stw_r3v, %function
_Z9fx_stw_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L297
	ldr	r2, [r3, #12]
	ldr	r3, .L297
	str	r2, [r3, #96]
	ldr	r3, .L297
	ldr	r2, [r3, #464]
	ldr	r3, .L297
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L297
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L297
	ldr	r2, [r3, #464]
	ldr	r3, .L297
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L297
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L297
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L297
	str	r2, [r3, #72]
	ldr	r2, .L297
	ldr	r3, .L297
	str	r3, [r2, #104]
	ldr	r3, .L297
	ldr	r2, [r3, #104]
	ldr	r3, .L297
	str	r2, [r3, #100]
	ldr	r3, .L297
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L297
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L298:
	.align	2
.L297:
	.word	GSU
	.size	_Z9fx_stw_r3v, .-_Z9fx_stw_r3v
	.align	2
	.type	_Z9fx_stw_r4v, %function
_Z9fx_stw_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L301
	ldr	r2, [r3, #16]
	ldr	r3, .L301
	str	r2, [r3, #96]
	ldr	r3, .L301
	ldr	r2, [r3, #464]
	ldr	r3, .L301
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L301
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L301
	ldr	r2, [r3, #464]
	ldr	r3, .L301
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L301
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L301
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L301
	str	r2, [r3, #72]
	ldr	r2, .L301
	ldr	r3, .L301
	str	r3, [r2, #104]
	ldr	r3, .L301
	ldr	r2, [r3, #104]
	ldr	r3, .L301
	str	r2, [r3, #100]
	ldr	r3, .L301
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L301
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L302:
	.align	2
.L301:
	.word	GSU
	.size	_Z9fx_stw_r4v, .-_Z9fx_stw_r4v
	.align	2
	.type	_Z9fx_stw_r5v, %function
_Z9fx_stw_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L305
	ldr	r2, [r3, #20]
	ldr	r3, .L305
	str	r2, [r3, #96]
	ldr	r3, .L305
	ldr	r2, [r3, #464]
	ldr	r3, .L305
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L305
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L305
	ldr	r2, [r3, #464]
	ldr	r3, .L305
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L305
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L305
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L305
	str	r2, [r3, #72]
	ldr	r2, .L305
	ldr	r3, .L305
	str	r3, [r2, #104]
	ldr	r3, .L305
	ldr	r2, [r3, #104]
	ldr	r3, .L305
	str	r2, [r3, #100]
	ldr	r3, .L305
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L305
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L306:
	.align	2
.L305:
	.word	GSU
	.size	_Z9fx_stw_r5v, .-_Z9fx_stw_r5v
	.align	2
	.type	_Z9fx_stw_r6v, %function
_Z9fx_stw_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L309
	ldr	r2, [r3, #24]
	ldr	r3, .L309
	str	r2, [r3, #96]
	ldr	r3, .L309
	ldr	r2, [r3, #464]
	ldr	r3, .L309
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L309
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L309
	ldr	r2, [r3, #464]
	ldr	r3, .L309
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L309
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L309
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L309
	str	r2, [r3, #72]
	ldr	r2, .L309
	ldr	r3, .L309
	str	r3, [r2, #104]
	ldr	r3, .L309
	ldr	r2, [r3, #104]
	ldr	r3, .L309
	str	r2, [r3, #100]
	ldr	r3, .L309
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L309
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L310:
	.align	2
.L309:
	.word	GSU
	.size	_Z9fx_stw_r6v, .-_Z9fx_stw_r6v
	.align	2
	.type	_Z9fx_stw_r7v, %function
_Z9fx_stw_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L313
	ldr	r2, [r3, #28]
	ldr	r3, .L313
	str	r2, [r3, #96]
	ldr	r3, .L313
	ldr	r2, [r3, #464]
	ldr	r3, .L313
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L313
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L313
	ldr	r2, [r3, #464]
	ldr	r3, .L313
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L313
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L313
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L313
	str	r2, [r3, #72]
	ldr	r2, .L313
	ldr	r3, .L313
	str	r3, [r2, #104]
	ldr	r3, .L313
	ldr	r2, [r3, #104]
	ldr	r3, .L313
	str	r2, [r3, #100]
	ldr	r3, .L313
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L313
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L314:
	.align	2
.L313:
	.word	GSU
	.size	_Z9fx_stw_r7v, .-_Z9fx_stw_r7v
	.align	2
	.type	_Z9fx_stw_r8v, %function
_Z9fx_stw_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L317
	ldr	r2, [r3, #32]
	ldr	r3, .L317
	str	r2, [r3, #96]
	ldr	r3, .L317
	ldr	r2, [r3, #464]
	ldr	r3, .L317
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L317
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L317
	ldr	r2, [r3, #464]
	ldr	r3, .L317
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L317
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L317
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L317
	str	r2, [r3, #72]
	ldr	r2, .L317
	ldr	r3, .L317
	str	r3, [r2, #104]
	ldr	r3, .L317
	ldr	r2, [r3, #104]
	ldr	r3, .L317
	str	r2, [r3, #100]
	ldr	r3, .L317
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L317
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L318:
	.align	2
.L317:
	.word	GSU
	.size	_Z9fx_stw_r8v, .-_Z9fx_stw_r8v
	.align	2
	.type	_Z9fx_stw_r9v, %function
_Z9fx_stw_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L321
	ldr	r2, [r3, #36]
	ldr	r3, .L321
	str	r2, [r3, #96]
	ldr	r3, .L321
	ldr	r2, [r3, #464]
	ldr	r3, .L321
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L321
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L321
	ldr	r2, [r3, #464]
	ldr	r3, .L321
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L321
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L321
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L321
	str	r2, [r3, #72]
	ldr	r2, .L321
	ldr	r3, .L321
	str	r3, [r2, #104]
	ldr	r3, .L321
	ldr	r2, [r3, #104]
	ldr	r3, .L321
	str	r2, [r3, #100]
	ldr	r3, .L321
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L321
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L322:
	.align	2
.L321:
	.word	GSU
	.size	_Z9fx_stw_r9v, .-_Z9fx_stw_r9v
	.align	2
	.type	_Z10fx_stw_r10v, %function
_Z10fx_stw_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L325
	ldr	r2, [r3, #40]
	ldr	r3, .L325
	str	r2, [r3, #96]
	ldr	r3, .L325
	ldr	r2, [r3, #464]
	ldr	r3, .L325
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L325
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L325
	ldr	r2, [r3, #464]
	ldr	r3, .L325
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L325
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L325
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L325
	str	r2, [r3, #72]
	ldr	r2, .L325
	ldr	r3, .L325
	str	r3, [r2, #104]
	ldr	r3, .L325
	ldr	r2, [r3, #104]
	ldr	r3, .L325
	str	r2, [r3, #100]
	ldr	r3, .L325
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L325
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L326:
	.align	2
.L325:
	.word	GSU
	.size	_Z10fx_stw_r10v, .-_Z10fx_stw_r10v
	.align	2
	.type	_Z10fx_stw_r11v, %function
_Z10fx_stw_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L329
	ldr	r2, [r3, #44]
	ldr	r3, .L329
	str	r2, [r3, #96]
	ldr	r3, .L329
	ldr	r2, [r3, #464]
	ldr	r3, .L329
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L329
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L329
	ldr	r2, [r3, #464]
	ldr	r3, .L329
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L329
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L329
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L329
	str	r2, [r3, #72]
	ldr	r2, .L329
	ldr	r3, .L329
	str	r3, [r2, #104]
	ldr	r3, .L329
	ldr	r2, [r3, #104]
	ldr	r3, .L329
	str	r2, [r3, #100]
	ldr	r3, .L329
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L329
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L330:
	.align	2
.L329:
	.word	GSU
	.size	_Z10fx_stw_r11v, .-_Z10fx_stw_r11v
	.align	2
	.type	_Z9fx_stb_r0v, %function
_Z9fx_stb_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L333
	ldr	r2, [r3, #0]
	ldr	r3, .L333
	str	r2, [r3, #96]
	ldr	r3, .L333
	ldr	r2, [r3, #464]
	ldr	r3, .L333
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L333
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L333
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L333
	str	r2, [r3, #72]
	ldr	r2, .L333
	ldr	r3, .L333
	str	r3, [r2, #104]
	ldr	r3, .L333
	ldr	r2, [r3, #104]
	ldr	r3, .L333
	str	r2, [r3, #100]
	ldr	r3, .L333
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L333
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L334:
	.align	2
.L333:
	.word	GSU
	.size	_Z9fx_stb_r0v, .-_Z9fx_stb_r0v
	.align	2
	.type	_Z9fx_stb_r1v, %function
_Z9fx_stb_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L337
	ldr	r2, [r3, #4]
	ldr	r3, .L337
	str	r2, [r3, #96]
	ldr	r3, .L337
	ldr	r2, [r3, #464]
	ldr	r3, .L337
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L337
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L337
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L337
	str	r2, [r3, #72]
	ldr	r2, .L337
	ldr	r3, .L337
	str	r3, [r2, #104]
	ldr	r3, .L337
	ldr	r2, [r3, #104]
	ldr	r3, .L337
	str	r2, [r3, #100]
	ldr	r3, .L337
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L337
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L338:
	.align	2
.L337:
	.word	GSU
	.size	_Z9fx_stb_r1v, .-_Z9fx_stb_r1v
	.align	2
	.type	_Z9fx_stb_r2v, %function
_Z9fx_stb_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L341
	ldr	r2, [r3, #8]
	ldr	r3, .L341
	str	r2, [r3, #96]
	ldr	r3, .L341
	ldr	r2, [r3, #464]
	ldr	r3, .L341
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L341
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L341
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L341
	str	r2, [r3, #72]
	ldr	r2, .L341
	ldr	r3, .L341
	str	r3, [r2, #104]
	ldr	r3, .L341
	ldr	r2, [r3, #104]
	ldr	r3, .L341
	str	r2, [r3, #100]
	ldr	r3, .L341
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L341
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L342:
	.align	2
.L341:
	.word	GSU
	.size	_Z9fx_stb_r2v, .-_Z9fx_stb_r2v
	.align	2
	.type	_Z9fx_stb_r3v, %function
_Z9fx_stb_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L345
	ldr	r2, [r3, #12]
	ldr	r3, .L345
	str	r2, [r3, #96]
	ldr	r3, .L345
	ldr	r2, [r3, #464]
	ldr	r3, .L345
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L345
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L345
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L345
	str	r2, [r3, #72]
	ldr	r2, .L345
	ldr	r3, .L345
	str	r3, [r2, #104]
	ldr	r3, .L345
	ldr	r2, [r3, #104]
	ldr	r3, .L345
	str	r2, [r3, #100]
	ldr	r3, .L345
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L345
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L346:
	.align	2
.L345:
	.word	GSU
	.size	_Z9fx_stb_r3v, .-_Z9fx_stb_r3v
	.align	2
	.type	_Z9fx_stb_r4v, %function
_Z9fx_stb_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L349
	ldr	r2, [r3, #16]
	ldr	r3, .L349
	str	r2, [r3, #96]
	ldr	r3, .L349
	ldr	r2, [r3, #464]
	ldr	r3, .L349
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L349
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L349
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L349
	str	r2, [r3, #72]
	ldr	r2, .L349
	ldr	r3, .L349
	str	r3, [r2, #104]
	ldr	r3, .L349
	ldr	r2, [r3, #104]
	ldr	r3, .L349
	str	r2, [r3, #100]
	ldr	r3, .L349
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L349
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L350:
	.align	2
.L349:
	.word	GSU
	.size	_Z9fx_stb_r4v, .-_Z9fx_stb_r4v
	.align	2
	.type	_Z9fx_stb_r5v, %function
_Z9fx_stb_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L353
	ldr	r2, [r3, #20]
	ldr	r3, .L353
	str	r2, [r3, #96]
	ldr	r3, .L353
	ldr	r2, [r3, #464]
	ldr	r3, .L353
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L353
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L353
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L353
	str	r2, [r3, #72]
	ldr	r2, .L353
	ldr	r3, .L353
	str	r3, [r2, #104]
	ldr	r3, .L353
	ldr	r2, [r3, #104]
	ldr	r3, .L353
	str	r2, [r3, #100]
	ldr	r3, .L353
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L353
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L354:
	.align	2
.L353:
	.word	GSU
	.size	_Z9fx_stb_r5v, .-_Z9fx_stb_r5v
	.align	2
	.type	_Z9fx_stb_r6v, %function
_Z9fx_stb_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L357
	ldr	r2, [r3, #24]
	ldr	r3, .L357
	str	r2, [r3, #96]
	ldr	r3, .L357
	ldr	r2, [r3, #464]
	ldr	r3, .L357
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L357
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L357
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L357
	str	r2, [r3, #72]
	ldr	r2, .L357
	ldr	r3, .L357
	str	r3, [r2, #104]
	ldr	r3, .L357
	ldr	r2, [r3, #104]
	ldr	r3, .L357
	str	r2, [r3, #100]
	ldr	r3, .L357
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L357
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L358:
	.align	2
.L357:
	.word	GSU
	.size	_Z9fx_stb_r6v, .-_Z9fx_stb_r6v
	.align	2
	.type	_Z9fx_stb_r7v, %function
_Z9fx_stb_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L361
	ldr	r2, [r3, #28]
	ldr	r3, .L361
	str	r2, [r3, #96]
	ldr	r3, .L361
	ldr	r2, [r3, #464]
	ldr	r3, .L361
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L361
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L361
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L361
	str	r2, [r3, #72]
	ldr	r2, .L361
	ldr	r3, .L361
	str	r3, [r2, #104]
	ldr	r3, .L361
	ldr	r2, [r3, #104]
	ldr	r3, .L361
	str	r2, [r3, #100]
	ldr	r3, .L361
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L361
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L362:
	.align	2
.L361:
	.word	GSU
	.size	_Z9fx_stb_r7v, .-_Z9fx_stb_r7v
	.align	2
	.type	_Z9fx_stb_r8v, %function
_Z9fx_stb_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L365
	ldr	r2, [r3, #32]
	ldr	r3, .L365
	str	r2, [r3, #96]
	ldr	r3, .L365
	ldr	r2, [r3, #464]
	ldr	r3, .L365
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L365
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L365
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L365
	str	r2, [r3, #72]
	ldr	r2, .L365
	ldr	r3, .L365
	str	r3, [r2, #104]
	ldr	r3, .L365
	ldr	r2, [r3, #104]
	ldr	r3, .L365
	str	r2, [r3, #100]
	ldr	r3, .L365
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L365
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L366:
	.align	2
.L365:
	.word	GSU
	.size	_Z9fx_stb_r8v, .-_Z9fx_stb_r8v
	.align	2
	.type	_Z9fx_stb_r9v, %function
_Z9fx_stb_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L369
	ldr	r2, [r3, #36]
	ldr	r3, .L369
	str	r2, [r3, #96]
	ldr	r3, .L369
	ldr	r2, [r3, #464]
	ldr	r3, .L369
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L369
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L369
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L369
	str	r2, [r3, #72]
	ldr	r2, .L369
	ldr	r3, .L369
	str	r3, [r2, #104]
	ldr	r3, .L369
	ldr	r2, [r3, #104]
	ldr	r3, .L369
	str	r2, [r3, #100]
	ldr	r3, .L369
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L369
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L370:
	.align	2
.L369:
	.word	GSU
	.size	_Z9fx_stb_r9v, .-_Z9fx_stb_r9v
	.align	2
	.type	_Z10fx_stb_r10v, %function
_Z10fx_stb_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L373
	ldr	r2, [r3, #40]
	ldr	r3, .L373
	str	r2, [r3, #96]
	ldr	r3, .L373
	ldr	r2, [r3, #464]
	ldr	r3, .L373
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L373
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L373
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L373
	str	r2, [r3, #72]
	ldr	r2, .L373
	ldr	r3, .L373
	str	r3, [r2, #104]
	ldr	r3, .L373
	ldr	r2, [r3, #104]
	ldr	r3, .L373
	str	r2, [r3, #100]
	ldr	r3, .L373
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L373
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L374:
	.align	2
.L373:
	.word	GSU
	.size	_Z10fx_stb_r10v, .-_Z10fx_stb_r10v
	.align	2
	.type	_Z10fx_stb_r11v, %function
_Z10fx_stb_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L377
	ldr	r2, [r3, #44]
	ldr	r3, .L377
	str	r2, [r3, #96]
	ldr	r3, .L377
	ldr	r2, [r3, #464]
	ldr	r3, .L377
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L377
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L377
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L377
	str	r2, [r3, #72]
	ldr	r2, .L377
	ldr	r3, .L377
	str	r3, [r2, #104]
	ldr	r3, .L377
	ldr	r2, [r3, #104]
	ldr	r3, .L377
	str	r2, [r3, #100]
	ldr	r3, .L377
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L377
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L378:
	.align	2
.L377:
	.word	GSU
	.size	_Z10fx_stb_r11v, .-_Z10fx_stb_r11v
	.align	2
	.type	_Z7fx_loopv, %function
_Z7fx_loopv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L384
	ldr	r3, [r3, #48]
	sub	r2, r3, #1
	ldr	r3, .L384
	str	r2, [r3, #48]
	ldr	r3, .L384
	ldr	r2, [r3, #48]
	ldr	r3, .L384
	str	r2, [r3, #120]
	ldr	r3, .L384
	ldr	r2, [r3, #120]
	ldr	r3, .L384
	str	r2, [r3, #116]
	ldr	r3, .L384
	ldr	r3, [r3, #48]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	cmp	r3, #0
	beq	.L380
	ldr	r3, .L384
	ldr	r2, [r3, #52]
	ldr	r3, .L384
	str	r2, [r3, #60]
	b	.L382
.L380:
	ldr	r3, .L384
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L384
	str	r2, [r3, #60]
.L382:
	ldr	r3, .L384
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L384
	str	r2, [r3, #72]
	ldr	r2, .L384
	ldr	r3, .L384
	str	r3, [r2, #104]
	ldr	r3, .L384
	ldr	r2, [r3, #104]
	ldr	r3, .L384
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L385:
	.align	2
.L384:
	.word	GSU
	.size	_Z7fx_loopv, .-_Z7fx_loopv
	.align	2
	.type	_Z7fx_alt1v, %function
_Z7fx_alt1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L388
	ldr	r3, [r3, #72]
	orr	r2, r3, #256
	ldr	r3, .L388
	str	r2, [r3, #72]
	ldr	r3, .L388
	ldr	r3, [r3, #72]
	bic	r2, r3, #4096
	ldr	r3, .L388
	str	r2, [r3, #72]
	ldr	r3, .L388
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L388
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L389:
	.align	2
.L388:
	.word	GSU
	.size	_Z7fx_alt1v, .-_Z7fx_alt1v
	.align	2
	.type	_Z7fx_alt2v, %function
_Z7fx_alt2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L392
	ldr	r3, [r3, #72]
	orr	r2, r3, #512
	ldr	r3, .L392
	str	r2, [r3, #72]
	ldr	r3, .L392
	ldr	r3, [r3, #72]
	bic	r2, r3, #4096
	ldr	r3, .L392
	str	r2, [r3, #72]
	ldr	r3, .L392
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L392
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L393:
	.align	2
.L392:
	.word	GSU
	.size	_Z7fx_alt2v, .-_Z7fx_alt2v
	.align	2
	.type	_Z7fx_alt3v, %function
_Z7fx_alt3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L396
	ldr	r3, [r3, #72]
	orr	r2, r3, #256
	ldr	r3, .L396
	str	r2, [r3, #72]
	ldr	r3, .L396
	ldr	r3, [r3, #72]
	orr	r2, r3, #512
	ldr	r3, .L396
	str	r2, [r3, #72]
	ldr	r3, .L396
	ldr	r3, [r3, #72]
	bic	r2, r3, #4096
	ldr	r3, .L396
	str	r2, [r3, #72]
	ldr	r3, .L396
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L396
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L397:
	.align	2
.L396:
	.word	GSU
	.size	_Z7fx_alt3v, .-_Z7fx_alt3v
	.align	2
	.type	_Z9fx_ldw_r0v, %function
_Z9fx_ldw_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L402
	ldr	r2, [r3, #0]
	ldr	r3, .L402
	str	r2, [r3, #96]
	ldr	r3, .L402
	ldr	r2, [r3, #464]
	ldr	r3, .L402
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L402
	ldr	r2, [r3, #464]
	ldr	r3, .L402
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L402
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L402
	str	r2, [r3, #60]
	ldr	r3, .L402
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L402
	ldr	r2, [r3, #100]
	ldr	r3, .L402+4
	cmp	r2, r3
	bne	.L399
	ldr	r3, .L402
	ldr	r2, [r3, #468]
	ldr	r3, .L402
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L402
	strb	r3, [r2, #108]
.L399:
	ldr	r3, .L402
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L402
	str	r2, [r3, #72]
	ldr	r2, .L402
	ldr	r3, .L402
	str	r3, [r2, #104]
	ldr	r3, .L402
	ldr	r2, [r3, #104]
	ldr	r3, .L402
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L403:
	.align	2
.L402:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r0v, .-_Z9fx_ldw_r0v
	.align	2
	.type	_Z9fx_ldw_r1v, %function
_Z9fx_ldw_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L408
	ldr	r2, [r3, #4]
	ldr	r3, .L408
	str	r2, [r3, #96]
	ldr	r3, .L408
	ldr	r2, [r3, #464]
	ldr	r3, .L408
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L408
	ldr	r2, [r3, #464]
	ldr	r3, .L408
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L408
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L408
	str	r2, [r3, #60]
	ldr	r3, .L408
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L408
	ldr	r2, [r3, #100]
	ldr	r3, .L408+4
	cmp	r2, r3
	bne	.L405
	ldr	r3, .L408
	ldr	r2, [r3, #468]
	ldr	r3, .L408
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L408
	strb	r3, [r2, #108]
.L405:
	ldr	r3, .L408
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L408
	str	r2, [r3, #72]
	ldr	r2, .L408
	ldr	r3, .L408
	str	r3, [r2, #104]
	ldr	r3, .L408
	ldr	r2, [r3, #104]
	ldr	r3, .L408
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L409:
	.align	2
.L408:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r1v, .-_Z9fx_ldw_r1v
	.align	2
	.type	_Z9fx_ldw_r2v, %function
_Z9fx_ldw_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L414
	ldr	r2, [r3, #8]
	ldr	r3, .L414
	str	r2, [r3, #96]
	ldr	r3, .L414
	ldr	r2, [r3, #464]
	ldr	r3, .L414
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L414
	ldr	r2, [r3, #464]
	ldr	r3, .L414
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L414
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L414
	str	r2, [r3, #60]
	ldr	r3, .L414
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L414
	ldr	r2, [r3, #100]
	ldr	r3, .L414+4
	cmp	r2, r3
	bne	.L411
	ldr	r3, .L414
	ldr	r2, [r3, #468]
	ldr	r3, .L414
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L414
	strb	r3, [r2, #108]
.L411:
	ldr	r3, .L414
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L414
	str	r2, [r3, #72]
	ldr	r2, .L414
	ldr	r3, .L414
	str	r3, [r2, #104]
	ldr	r3, .L414
	ldr	r2, [r3, #104]
	ldr	r3, .L414
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L415:
	.align	2
.L414:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r2v, .-_Z9fx_ldw_r2v
	.align	2
	.type	_Z9fx_ldw_r3v, %function
_Z9fx_ldw_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L420
	ldr	r2, [r3, #12]
	ldr	r3, .L420
	str	r2, [r3, #96]
	ldr	r3, .L420
	ldr	r2, [r3, #464]
	ldr	r3, .L420
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L420
	ldr	r2, [r3, #464]
	ldr	r3, .L420
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L420
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L420
	str	r2, [r3, #60]
	ldr	r3, .L420
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L420
	ldr	r2, [r3, #100]
	ldr	r3, .L420+4
	cmp	r2, r3
	bne	.L417
	ldr	r3, .L420
	ldr	r2, [r3, #468]
	ldr	r3, .L420
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L420
	strb	r3, [r2, #108]
.L417:
	ldr	r3, .L420
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L420
	str	r2, [r3, #72]
	ldr	r2, .L420
	ldr	r3, .L420
	str	r3, [r2, #104]
	ldr	r3, .L420
	ldr	r2, [r3, #104]
	ldr	r3, .L420
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L421:
	.align	2
.L420:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r3v, .-_Z9fx_ldw_r3v
	.align	2
	.type	_Z9fx_ldw_r4v, %function
_Z9fx_ldw_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L426
	ldr	r2, [r3, #16]
	ldr	r3, .L426
	str	r2, [r3, #96]
	ldr	r3, .L426
	ldr	r2, [r3, #464]
	ldr	r3, .L426
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L426
	ldr	r2, [r3, #464]
	ldr	r3, .L426
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L426
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L426
	str	r2, [r3, #60]
	ldr	r3, .L426
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L426
	ldr	r2, [r3, #100]
	ldr	r3, .L426+4
	cmp	r2, r3
	bne	.L423
	ldr	r3, .L426
	ldr	r2, [r3, #468]
	ldr	r3, .L426
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L426
	strb	r3, [r2, #108]
.L423:
	ldr	r3, .L426
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L426
	str	r2, [r3, #72]
	ldr	r2, .L426
	ldr	r3, .L426
	str	r3, [r2, #104]
	ldr	r3, .L426
	ldr	r2, [r3, #104]
	ldr	r3, .L426
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L427:
	.align	2
.L426:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r4v, .-_Z9fx_ldw_r4v
	.align	2
	.type	_Z9fx_ldw_r5v, %function
_Z9fx_ldw_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L432
	ldr	r2, [r3, #20]
	ldr	r3, .L432
	str	r2, [r3, #96]
	ldr	r3, .L432
	ldr	r2, [r3, #464]
	ldr	r3, .L432
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L432
	ldr	r2, [r3, #464]
	ldr	r3, .L432
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L432
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L432
	str	r2, [r3, #60]
	ldr	r3, .L432
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L432
	ldr	r2, [r3, #100]
	ldr	r3, .L432+4
	cmp	r2, r3
	bne	.L429
	ldr	r3, .L432
	ldr	r2, [r3, #468]
	ldr	r3, .L432
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L432
	strb	r3, [r2, #108]
.L429:
	ldr	r3, .L432
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L432
	str	r2, [r3, #72]
	ldr	r2, .L432
	ldr	r3, .L432
	str	r3, [r2, #104]
	ldr	r3, .L432
	ldr	r2, [r3, #104]
	ldr	r3, .L432
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L433:
	.align	2
.L432:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r5v, .-_Z9fx_ldw_r5v
	.align	2
	.type	_Z9fx_ldw_r6v, %function
_Z9fx_ldw_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L438
	ldr	r2, [r3, #24]
	ldr	r3, .L438
	str	r2, [r3, #96]
	ldr	r3, .L438
	ldr	r2, [r3, #464]
	ldr	r3, .L438
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L438
	ldr	r2, [r3, #464]
	ldr	r3, .L438
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L438
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L438
	str	r2, [r3, #60]
	ldr	r3, .L438
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L438
	ldr	r2, [r3, #100]
	ldr	r3, .L438+4
	cmp	r2, r3
	bne	.L435
	ldr	r3, .L438
	ldr	r2, [r3, #468]
	ldr	r3, .L438
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L438
	strb	r3, [r2, #108]
.L435:
	ldr	r3, .L438
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L438
	str	r2, [r3, #72]
	ldr	r2, .L438
	ldr	r3, .L438
	str	r3, [r2, #104]
	ldr	r3, .L438
	ldr	r2, [r3, #104]
	ldr	r3, .L438
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L439:
	.align	2
.L438:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r6v, .-_Z9fx_ldw_r6v
	.align	2
	.type	_Z9fx_ldw_r7v, %function
_Z9fx_ldw_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L444
	ldr	r2, [r3, #28]
	ldr	r3, .L444
	str	r2, [r3, #96]
	ldr	r3, .L444
	ldr	r2, [r3, #464]
	ldr	r3, .L444
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L444
	ldr	r2, [r3, #464]
	ldr	r3, .L444
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L444
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L444
	str	r2, [r3, #60]
	ldr	r3, .L444
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L444
	ldr	r2, [r3, #100]
	ldr	r3, .L444+4
	cmp	r2, r3
	bne	.L441
	ldr	r3, .L444
	ldr	r2, [r3, #468]
	ldr	r3, .L444
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L444
	strb	r3, [r2, #108]
.L441:
	ldr	r3, .L444
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L444
	str	r2, [r3, #72]
	ldr	r2, .L444
	ldr	r3, .L444
	str	r3, [r2, #104]
	ldr	r3, .L444
	ldr	r2, [r3, #104]
	ldr	r3, .L444
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L445:
	.align	2
.L444:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r7v, .-_Z9fx_ldw_r7v
	.align	2
	.type	_Z9fx_ldw_r8v, %function
_Z9fx_ldw_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L450
	ldr	r2, [r3, #32]
	ldr	r3, .L450
	str	r2, [r3, #96]
	ldr	r3, .L450
	ldr	r2, [r3, #464]
	ldr	r3, .L450
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L450
	ldr	r2, [r3, #464]
	ldr	r3, .L450
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L450
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L450
	str	r2, [r3, #60]
	ldr	r3, .L450
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L450
	ldr	r2, [r3, #100]
	ldr	r3, .L450+4
	cmp	r2, r3
	bne	.L447
	ldr	r3, .L450
	ldr	r2, [r3, #468]
	ldr	r3, .L450
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L450
	strb	r3, [r2, #108]
.L447:
	ldr	r3, .L450
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L450
	str	r2, [r3, #72]
	ldr	r2, .L450
	ldr	r3, .L450
	str	r3, [r2, #104]
	ldr	r3, .L450
	ldr	r2, [r3, #104]
	ldr	r3, .L450
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L451:
	.align	2
.L450:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r8v, .-_Z9fx_ldw_r8v
	.align	2
	.type	_Z9fx_ldw_r9v, %function
_Z9fx_ldw_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L456
	ldr	r2, [r3, #36]
	ldr	r3, .L456
	str	r2, [r3, #96]
	ldr	r3, .L456
	ldr	r2, [r3, #464]
	ldr	r3, .L456
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L456
	ldr	r2, [r3, #464]
	ldr	r3, .L456
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L456
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L456
	str	r2, [r3, #60]
	ldr	r3, .L456
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L456
	ldr	r2, [r3, #100]
	ldr	r3, .L456+4
	cmp	r2, r3
	bne	.L453
	ldr	r3, .L456
	ldr	r2, [r3, #468]
	ldr	r3, .L456
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L456
	strb	r3, [r2, #108]
.L453:
	ldr	r3, .L456
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L456
	str	r2, [r3, #72]
	ldr	r2, .L456
	ldr	r3, .L456
	str	r3, [r2, #104]
	ldr	r3, .L456
	ldr	r2, [r3, #104]
	ldr	r3, .L456
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L457:
	.align	2
.L456:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldw_r9v, .-_Z9fx_ldw_r9v
	.align	2
	.type	_Z10fx_ldw_r10v, %function
_Z10fx_ldw_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L462
	ldr	r2, [r3, #40]
	ldr	r3, .L462
	str	r2, [r3, #96]
	ldr	r3, .L462
	ldr	r2, [r3, #464]
	ldr	r3, .L462
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L462
	ldr	r2, [r3, #464]
	ldr	r3, .L462
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L462
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L462
	str	r2, [r3, #60]
	ldr	r3, .L462
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L462
	ldr	r2, [r3, #100]
	ldr	r3, .L462+4
	cmp	r2, r3
	bne	.L459
	ldr	r3, .L462
	ldr	r2, [r3, #468]
	ldr	r3, .L462
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L462
	strb	r3, [r2, #108]
.L459:
	ldr	r3, .L462
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L462
	str	r2, [r3, #72]
	ldr	r2, .L462
	ldr	r3, .L462
	str	r3, [r2, #104]
	ldr	r3, .L462
	ldr	r2, [r3, #104]
	ldr	r3, .L462
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L463:
	.align	2
.L462:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_ldw_r10v, .-_Z10fx_ldw_r10v
	.align	2
	.type	_Z10fx_ldw_r11v, %function
_Z10fx_ldw_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L468
	ldr	r2, [r3, #44]
	ldr	r3, .L468
	str	r2, [r3, #96]
	ldr	r3, .L468
	ldr	r2, [r3, #464]
	ldr	r3, .L468
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L468
	ldr	r2, [r3, #464]
	ldr	r3, .L468
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L468
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L468
	str	r2, [r3, #60]
	ldr	r3, .L468
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L468
	ldr	r2, [r3, #100]
	ldr	r3, .L468+4
	cmp	r2, r3
	bne	.L465
	ldr	r3, .L468
	ldr	r2, [r3, #468]
	ldr	r3, .L468
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L468
	strb	r3, [r2, #108]
.L465:
	ldr	r3, .L468
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L468
	str	r2, [r3, #72]
	ldr	r2, .L468
	ldr	r3, .L468
	str	r3, [r2, #104]
	ldr	r3, .L468
	ldr	r2, [r3, #104]
	ldr	r3, .L468
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L469:
	.align	2
.L468:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_ldw_r11v, .-_Z10fx_ldw_r11v
	.align	2
	.type	_Z9fx_ldb_r0v, %function
_Z9fx_ldb_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L474
	ldr	r2, [r3, #0]
	ldr	r3, .L474
	str	r2, [r3, #96]
	ldr	r3, .L474
	ldr	r2, [r3, #464]
	ldr	r3, .L474
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L474
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L474
	str	r2, [r3, #60]
	ldr	r3, .L474
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L474
	ldr	r2, [r3, #100]
	ldr	r3, .L474+4
	cmp	r2, r3
	bne	.L471
	ldr	r3, .L474
	ldr	r2, [r3, #468]
	ldr	r3, .L474
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L474
	strb	r3, [r2, #108]
.L471:
	ldr	r3, .L474
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L474
	str	r2, [r3, #72]
	ldr	r2, .L474
	ldr	r3, .L474
	str	r3, [r2, #104]
	ldr	r3, .L474
	ldr	r2, [r3, #104]
	ldr	r3, .L474
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L475:
	.align	2
.L474:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r0v, .-_Z9fx_ldb_r0v
	.align	2
	.type	_Z9fx_ldb_r1v, %function
_Z9fx_ldb_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L480
	ldr	r2, [r3, #4]
	ldr	r3, .L480
	str	r2, [r3, #96]
	ldr	r3, .L480
	ldr	r2, [r3, #464]
	ldr	r3, .L480
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L480
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L480
	str	r2, [r3, #60]
	ldr	r3, .L480
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L480
	ldr	r2, [r3, #100]
	ldr	r3, .L480+4
	cmp	r2, r3
	bne	.L477
	ldr	r3, .L480
	ldr	r2, [r3, #468]
	ldr	r3, .L480
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L480
	strb	r3, [r2, #108]
.L477:
	ldr	r3, .L480
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L480
	str	r2, [r3, #72]
	ldr	r2, .L480
	ldr	r3, .L480
	str	r3, [r2, #104]
	ldr	r3, .L480
	ldr	r2, [r3, #104]
	ldr	r3, .L480
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L481:
	.align	2
.L480:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r1v, .-_Z9fx_ldb_r1v
	.align	2
	.type	_Z9fx_ldb_r2v, %function
_Z9fx_ldb_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L486
	ldr	r2, [r3, #8]
	ldr	r3, .L486
	str	r2, [r3, #96]
	ldr	r3, .L486
	ldr	r2, [r3, #464]
	ldr	r3, .L486
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L486
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L486
	str	r2, [r3, #60]
	ldr	r3, .L486
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L486
	ldr	r2, [r3, #100]
	ldr	r3, .L486+4
	cmp	r2, r3
	bne	.L483
	ldr	r3, .L486
	ldr	r2, [r3, #468]
	ldr	r3, .L486
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L486
	strb	r3, [r2, #108]
.L483:
	ldr	r3, .L486
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L486
	str	r2, [r3, #72]
	ldr	r2, .L486
	ldr	r3, .L486
	str	r3, [r2, #104]
	ldr	r3, .L486
	ldr	r2, [r3, #104]
	ldr	r3, .L486
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L487:
	.align	2
.L486:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r2v, .-_Z9fx_ldb_r2v
	.align	2
	.type	_Z9fx_ldb_r3v, %function
_Z9fx_ldb_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L492
	ldr	r2, [r3, #12]
	ldr	r3, .L492
	str	r2, [r3, #96]
	ldr	r3, .L492
	ldr	r2, [r3, #464]
	ldr	r3, .L492
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L492
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L492
	str	r2, [r3, #60]
	ldr	r3, .L492
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L492
	ldr	r2, [r3, #100]
	ldr	r3, .L492+4
	cmp	r2, r3
	bne	.L489
	ldr	r3, .L492
	ldr	r2, [r3, #468]
	ldr	r3, .L492
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L492
	strb	r3, [r2, #108]
.L489:
	ldr	r3, .L492
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L492
	str	r2, [r3, #72]
	ldr	r2, .L492
	ldr	r3, .L492
	str	r3, [r2, #104]
	ldr	r3, .L492
	ldr	r2, [r3, #104]
	ldr	r3, .L492
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L493:
	.align	2
.L492:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r3v, .-_Z9fx_ldb_r3v
	.align	2
	.type	_Z9fx_ldb_r4v, %function
_Z9fx_ldb_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L498
	ldr	r2, [r3, #16]
	ldr	r3, .L498
	str	r2, [r3, #96]
	ldr	r3, .L498
	ldr	r2, [r3, #464]
	ldr	r3, .L498
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L498
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L498
	str	r2, [r3, #60]
	ldr	r3, .L498
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L498
	ldr	r2, [r3, #100]
	ldr	r3, .L498+4
	cmp	r2, r3
	bne	.L495
	ldr	r3, .L498
	ldr	r2, [r3, #468]
	ldr	r3, .L498
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L498
	strb	r3, [r2, #108]
.L495:
	ldr	r3, .L498
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L498
	str	r2, [r3, #72]
	ldr	r2, .L498
	ldr	r3, .L498
	str	r3, [r2, #104]
	ldr	r3, .L498
	ldr	r2, [r3, #104]
	ldr	r3, .L498
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L499:
	.align	2
.L498:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r4v, .-_Z9fx_ldb_r4v
	.align	2
	.type	_Z9fx_ldb_r5v, %function
_Z9fx_ldb_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L504
	ldr	r2, [r3, #20]
	ldr	r3, .L504
	str	r2, [r3, #96]
	ldr	r3, .L504
	ldr	r2, [r3, #464]
	ldr	r3, .L504
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L504
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L504
	str	r2, [r3, #60]
	ldr	r3, .L504
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L504
	ldr	r2, [r3, #100]
	ldr	r3, .L504+4
	cmp	r2, r3
	bne	.L501
	ldr	r3, .L504
	ldr	r2, [r3, #468]
	ldr	r3, .L504
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L504
	strb	r3, [r2, #108]
.L501:
	ldr	r3, .L504
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L504
	str	r2, [r3, #72]
	ldr	r2, .L504
	ldr	r3, .L504
	str	r3, [r2, #104]
	ldr	r3, .L504
	ldr	r2, [r3, #104]
	ldr	r3, .L504
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L505:
	.align	2
.L504:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r5v, .-_Z9fx_ldb_r5v
	.align	2
	.type	_Z9fx_ldb_r6v, %function
_Z9fx_ldb_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L510
	ldr	r2, [r3, #24]
	ldr	r3, .L510
	str	r2, [r3, #96]
	ldr	r3, .L510
	ldr	r2, [r3, #464]
	ldr	r3, .L510
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L510
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L510
	str	r2, [r3, #60]
	ldr	r3, .L510
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L510
	ldr	r2, [r3, #100]
	ldr	r3, .L510+4
	cmp	r2, r3
	bne	.L507
	ldr	r3, .L510
	ldr	r2, [r3, #468]
	ldr	r3, .L510
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L510
	strb	r3, [r2, #108]
.L507:
	ldr	r3, .L510
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L510
	str	r2, [r3, #72]
	ldr	r2, .L510
	ldr	r3, .L510
	str	r3, [r2, #104]
	ldr	r3, .L510
	ldr	r2, [r3, #104]
	ldr	r3, .L510
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L511:
	.align	2
.L510:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r6v, .-_Z9fx_ldb_r6v
	.align	2
	.type	_Z9fx_ldb_r7v, %function
_Z9fx_ldb_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L516
	ldr	r2, [r3, #28]
	ldr	r3, .L516
	str	r2, [r3, #96]
	ldr	r3, .L516
	ldr	r2, [r3, #464]
	ldr	r3, .L516
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L516
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L516
	str	r2, [r3, #60]
	ldr	r3, .L516
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L516
	ldr	r2, [r3, #100]
	ldr	r3, .L516+4
	cmp	r2, r3
	bne	.L513
	ldr	r3, .L516
	ldr	r2, [r3, #468]
	ldr	r3, .L516
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L516
	strb	r3, [r2, #108]
.L513:
	ldr	r3, .L516
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L516
	str	r2, [r3, #72]
	ldr	r2, .L516
	ldr	r3, .L516
	str	r3, [r2, #104]
	ldr	r3, .L516
	ldr	r2, [r3, #104]
	ldr	r3, .L516
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L517:
	.align	2
.L516:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r7v, .-_Z9fx_ldb_r7v
	.align	2
	.type	_Z9fx_ldb_r8v, %function
_Z9fx_ldb_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L522
	ldr	r2, [r3, #32]
	ldr	r3, .L522
	str	r2, [r3, #96]
	ldr	r3, .L522
	ldr	r2, [r3, #464]
	ldr	r3, .L522
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L522
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L522
	str	r2, [r3, #60]
	ldr	r3, .L522
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L522
	ldr	r2, [r3, #100]
	ldr	r3, .L522+4
	cmp	r2, r3
	bne	.L519
	ldr	r3, .L522
	ldr	r2, [r3, #468]
	ldr	r3, .L522
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L522
	strb	r3, [r2, #108]
.L519:
	ldr	r3, .L522
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L522
	str	r2, [r3, #72]
	ldr	r2, .L522
	ldr	r3, .L522
	str	r3, [r2, #104]
	ldr	r3, .L522
	ldr	r2, [r3, #104]
	ldr	r3, .L522
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L523:
	.align	2
.L522:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r8v, .-_Z9fx_ldb_r8v
	.align	2
	.type	_Z9fx_ldb_r9v, %function
_Z9fx_ldb_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L528
	ldr	r2, [r3, #36]
	ldr	r3, .L528
	str	r2, [r3, #96]
	ldr	r3, .L528
	ldr	r2, [r3, #464]
	ldr	r3, .L528
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L528
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L528
	str	r2, [r3, #60]
	ldr	r3, .L528
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L528
	ldr	r2, [r3, #100]
	ldr	r3, .L528+4
	cmp	r2, r3
	bne	.L525
	ldr	r3, .L528
	ldr	r2, [r3, #468]
	ldr	r3, .L528
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L528
	strb	r3, [r2, #108]
.L525:
	ldr	r3, .L528
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L528
	str	r2, [r3, #72]
	ldr	r2, .L528
	ldr	r3, .L528
	str	r3, [r2, #104]
	ldr	r3, .L528
	ldr	r2, [r3, #104]
	ldr	r3, .L528
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L529:
	.align	2
.L528:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_ldb_r9v, .-_Z9fx_ldb_r9v
	.align	2
	.type	_Z10fx_ldb_r10v, %function
_Z10fx_ldb_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L534
	ldr	r2, [r3, #40]
	ldr	r3, .L534
	str	r2, [r3, #96]
	ldr	r3, .L534
	ldr	r2, [r3, #464]
	ldr	r3, .L534
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L534
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L534
	str	r2, [r3, #60]
	ldr	r3, .L534
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L534
	ldr	r2, [r3, #100]
	ldr	r3, .L534+4
	cmp	r2, r3
	bne	.L531
	ldr	r3, .L534
	ldr	r2, [r3, #468]
	ldr	r3, .L534
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L534
	strb	r3, [r2, #108]
.L531:
	ldr	r3, .L534
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L534
	str	r2, [r3, #72]
	ldr	r2, .L534
	ldr	r3, .L534
	str	r3, [r2, #104]
	ldr	r3, .L534
	ldr	r2, [r3, #104]
	ldr	r3, .L534
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L535:
	.align	2
.L534:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_ldb_r10v, .-_Z10fx_ldb_r10v
	.align	2
	.type	_Z10fx_ldb_r11v, %function
_Z10fx_ldb_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L540
	ldr	r2, [r3, #44]
	ldr	r3, .L540
	str	r2, [r3, #96]
	ldr	r3, .L540
	ldr	r2, [r3, #464]
	ldr	r3, .L540
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L540
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L540
	str	r2, [r3, #60]
	ldr	r3, .L540
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L540
	ldr	r2, [r3, #100]
	ldr	r3, .L540+4
	cmp	r2, r3
	bne	.L537
	ldr	r3, .L540
	ldr	r2, [r3, #468]
	ldr	r3, .L540
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L540
	strb	r3, [r2, #108]
.L537:
	ldr	r3, .L540
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L540
	str	r2, [r3, #72]
	ldr	r2, .L540
	ldr	r3, .L540
	str	r3, [r2, #104]
	ldr	r3, .L540
	ldr	r2, [r3, #104]
	ldr	r3, .L540
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L541:
	.align	2
.L540:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_ldb_r11v, .-_Z10fx_ldb_r11v
	.align	2
	.type	_Z12fx_plot_2bitv, %function
_Z12fx_plot_2bitv:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	ldr	r3, .L559
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	str	r3, [fp, #-28]
	ldr	r3, .L559
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	str	r3, [fp, #-24]
	ldr	r3, .L559
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L559
	str	r2, [r3, #60]
	ldr	r3, .L559
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L559
	str	r2, [r3, #72]
	ldr	r2, .L559
	ldr	r3, .L559
	str	r3, [r2, #104]
	ldr	r3, .L559
	ldr	r2, [r3, #104]
	ldr	r3, .L559
	str	r2, [r3, #100]
	ldr	r3, .L559
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, .L559
	str	r2, [r3, #4]
	ldr	r3, .L559
	ldr	r2, [r3, #440]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bls	.L558
	ldr	r3, .L559
	ldr	r3, [r3, #68]
	and	r3, r3, #2
	cmp	r3, #0
	beq	.L545
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-24]
	eor	r3, r2, r3
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L547
	ldr	r3, .L559
	ldr	r3, [r3, #64]
	mov	r3, r3, lsr #4
	and	r3, r3, #255
	str	r3, [fp, #-32]
	b	.L549
.L547:
	ldr	r3, .L559
	ldr	r3, [r3, #64]
	and	r3, r3, #255
	str	r3, [fp, #-32]
.L549:
	ldr	r2, [fp, #-32]
	mov	r3, r2
	strb	r3, [fp, #-13]
	b	.L550
.L545:
	ldr	r3, .L559
	ldr	r3, [r3, #64]
	strb	r3, [fp, #-13]
.L550:
	ldr	r3, .L559
	ldr	r3, [r3, #68]
	and	r3, r3, #1
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L551
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #15
	cmp	r3, #0
	beq	.L558
.L551:
	ldr	r3, [fp, #-24]
	mov	r3, r3, lsr #3
	ldr	r2, .L559
	mov	r1, #184
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r0, [r3, #0]
	ldr	r3, [fp, #-28]
	mov	r3, r3, lsr #3
	ldr	r2, .L559
	mov	r1, #312
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r3, #0]
	add	r2, r0, r3
	ldr	r3, [fp, #-24]
	and	r3, r3, #7
	mov	r3, r3, asl #1
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	and	r2, r3, #7
	mov	r3, #128
	mov	r3, r3, asr r2
	strb	r3, [fp, #-14]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L553
	ldr	r3, [fp, #-20]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	ldr	r2, [fp, #-20]
	strb	r3, [r2, #0]
	b	.L555
.L553:
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	ldr	r2, [fp, #-20]
	strb	r3, [r2, #0]
.L555:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #2
	cmp	r3, #0
	beq	.L556
	ldr	r3, [fp, #-20]
	add	r1, r3, #1
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L558
.L556:
	ldr	r3, [fp, #-20]
	add	r1, r3, #1
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L558:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L560:
	.align	2
.L559:
	.word	GSU
	.size	_Z12fx_plot_2bitv, .-_Z12fx_plot_2bitv
	.align	2
	.type	_Z12fx_rpix_2bitv, %function
_Z12fx_rpix_2bitv:
	@ args = 0, pretend = 0, frame = 28
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #28
	ldr	r3, .L569
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	str	r3, [fp, #-28]
	ldr	r3, .L569
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	str	r3, [fp, #-24]
	ldr	r3, .L569
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L569
	str	r2, [r3, #60]
	ldr	r3, .L569
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L569
	str	r2, [r3, #72]
	ldr	r2, .L569
	ldr	r3, .L569
	str	r3, [r2, #104]
	ldr	r3, .L569
	ldr	r2, [r3, #104]
	ldr	r3, .L569
	str	r2, [r3, #100]
	ldr	r3, .L569
	ldr	r2, [r3, #440]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bls	.L568
	ldr	r3, [fp, #-24]
	mov	r3, r3, lsr #3
	ldr	r2, .L569
	mov	r1, #184
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r0, [r3, #0]
	ldr	r3, [fp, #-28]
	mov	r3, r3, lsr #3
	ldr	r2, .L569
	mov	r1, #312
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r3, #0]
	add	r2, r0, r3
	ldr	r3, [fp, #-24]
	and	r3, r3, #7
	mov	r3, r3, asl #1
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	and	r2, r3, #7
	mov	r3, #128
	mov	r3, r3, asr r2
	strb	r3, [fp, #-13]
	ldr	r3, .L569
	ldr	r2, [r3, #100]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L569
	ldr	r0, [r3, #100]
	ldr	r3, .L569
	ldr	r3, [r3, #100]
	ldr	r1, [r3, #0]
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	moveq	r3, #0
	movne	r3, #1
	orr	r3, r1, r3
	str	r3, [r0, #0]
	ldr	r3, .L569
	ldr	r3, [r3, #100]
	str	r3, [fp, #-40]
	ldr	r3, .L569
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L564
	mov	r1, #2
	str	r1, [fp, #-32]
	b	.L566
.L564:
	mov	r2, #0
	str	r2, [fp, #-32]
.L566:
	ldr	r1, [fp, #-36]
	ldr	r2, [fp, #-32]
	orr	r3, r1, r2
	ldr	r1, [fp, #-40]
	str	r3, [r1, #0]
	ldr	r3, .L569
	ldr	r2, [r3, #100]
	ldr	r3, .L569+4
	cmp	r2, r3
	bne	.L568
	ldr	r3, .L569
	ldr	r2, [r3, #468]
	ldr	r3, .L569
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L569
	strb	r3, [r2, #108]
.L568:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L570:
	.align	2
.L569:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_rpix_2bitv, .-_Z12fx_rpix_2bitv
	.align	2
	.type	_Z12fx_plot_4bitv, %function
_Z12fx_plot_4bitv:
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	ldr	r3, .L594
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	str	r3, [fp, #-28]
	ldr	r3, .L594
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	str	r3, [fp, #-24]
	ldr	r3, .L594
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L594
	str	r2, [r3, #60]
	ldr	r3, .L594
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L594
	str	r2, [r3, #72]
	ldr	r2, .L594
	ldr	r3, .L594
	str	r3, [r2, #104]
	ldr	r3, .L594
	ldr	r2, [r3, #104]
	ldr	r3, .L594
	str	r2, [r3, #100]
	ldr	r3, .L594
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, .L594
	str	r2, [r3, #4]
	ldr	r3, .L594
	ldr	r2, [r3, #440]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bls	.L593
	ldr	r3, .L594
	ldr	r3, [r3, #68]
	and	r3, r3, #2
	cmp	r3, #0
	beq	.L574
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-24]
	eor	r3, r2, r3
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L576
	ldr	r3, .L594
	ldr	r3, [r3, #64]
	mov	r3, r3, lsr #4
	and	r3, r3, #255
	str	r3, [fp, #-32]
	b	.L578
.L576:
	ldr	r3, .L594
	ldr	r3, [r3, #64]
	and	r3, r3, #255
	str	r3, [fp, #-32]
.L578:
	ldr	r2, [fp, #-32]
	mov	r3, r2
	strb	r3, [fp, #-13]
	b	.L579
.L574:
	ldr	r3, .L594
	ldr	r3, [r3, #64]
	strb	r3, [fp, #-13]
.L579:
	ldr	r3, .L594
	ldr	r3, [r3, #68]
	and	r3, r3, #1
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L580
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #15
	cmp	r3, #0
	beq	.L593
.L580:
	ldr	r3, [fp, #-24]
	mov	r3, r3, lsr #3
	ldr	r2, .L594
	mov	r1, #184
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r0, [r3, #0]
	ldr	r3, [fp, #-28]
	mov	r3, r3, lsr #3
	ldr	r2, .L594
	mov	r1, #312
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r3, #0]
	add	r2, r0, r3
	ldr	r3, [fp, #-24]
	and	r3, r3, #7
	mov	r3, r3, asl #1
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	and	r2, r3, #7
	mov	r3, #128
	mov	r3, r3, asr r2
	strb	r3, [fp, #-14]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L582
	ldr	r3, [fp, #-20]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	ldr	r2, [fp, #-20]
	strb	r3, [r2, #0]
	b	.L584
.L582:
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	ldr	r2, [fp, #-20]
	strb	r3, [r2, #0]
.L584:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #2
	cmp	r3, #0
	beq	.L585
	ldr	r3, [fp, #-20]
	add	r1, r3, #1
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L587
.L585:
	ldr	r3, [fp, #-20]
	add	r1, r3, #1
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L587:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #4
	cmp	r3, #0
	beq	.L588
	ldr	r3, [fp, #-20]
	add	r1, r3, #16
	ldr	r3, [fp, #-20]
	add	r3, r3, #16
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L590
.L588:
	ldr	r3, [fp, #-20]
	add	r1, r3, #16
	ldr	r3, [fp, #-20]
	add	r3, r3, #16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L590:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #8
	cmp	r3, #0
	beq	.L591
	ldr	r3, [fp, #-20]
	add	r1, r3, #17
	ldr	r3, [fp, #-20]
	add	r3, r3, #17
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L593
.L591:
	ldr	r3, [fp, #-20]
	add	r1, r3, #17
	ldr	r3, [fp, #-20]
	add	r3, r3, #17
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L593:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L595:
	.align	2
.L594:
	.word	GSU
	.size	_Z12fx_plot_4bitv, .-_Z12fx_plot_4bitv
	.align	2
	.type	_Z12fx_rpix_4bitv, %function
_Z12fx_rpix_4bitv:
	@ args = 0, pretend = 0, frame = 52
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #52
	ldr	r3, .L610
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	str	r3, [fp, #-28]
	ldr	r3, .L610
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	str	r3, [fp, #-24]
	ldr	r3, .L610
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L610
	str	r2, [r3, #60]
	ldr	r3, .L610
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L610
	str	r2, [r3, #72]
	ldr	r2, .L610
	ldr	r3, .L610
	str	r3, [r2, #104]
	ldr	r3, .L610
	ldr	r2, [r3, #104]
	ldr	r3, .L610
	str	r2, [r3, #100]
	ldr	r3, .L610
	ldr	r2, [r3, #440]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bls	.L609
	ldr	r3, [fp, #-24]
	mov	r3, r3, lsr #3
	ldr	r2, .L610
	mov	r1, #184
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r0, [r3, #0]
	ldr	r3, [fp, #-28]
	mov	r3, r3, lsr #3
	ldr	r2, .L610
	mov	r1, #312
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r3, #0]
	add	r2, r0, r3
	ldr	r3, [fp, #-24]
	and	r3, r3, #7
	mov	r3, r3, asl #1
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	and	r2, r3, #7
	mov	r3, #128
	mov	r3, r3, asr r2
	strb	r3, [fp, #-13]
	ldr	r3, .L610
	ldr	r2, [r3, #100]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L610
	ldr	r0, [r3, #100]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	ldr	r1, [r3, #0]
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	moveq	r3, #0
	movne	r3, #1
	orr	r3, r1, r3
	str	r3, [r0, #0]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	str	r3, [fp, #-64]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L599
	mov	r1, #2
	str	r1, [fp, #-56]
	b	.L601
.L599:
	mov	r2, #0
	str	r2, [fp, #-56]
.L601:
	ldr	r1, [fp, #-60]
	ldr	r2, [fp, #-56]
	orr	r3, r1, r2
	ldr	r1, [fp, #-64]
	str	r3, [r1, #0]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	str	r3, [fp, #-52]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-20]
	add	r3, r3, #16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L602
	mov	r2, #4
	str	r2, [fp, #-44]
	b	.L604
.L602:
	mov	r3, #0
	str	r3, [fp, #-44]
.L604:
	ldr	r1, [fp, #-48]
	ldr	r2, [fp, #-44]
	orr	r3, r1, r2
	ldr	r1, [fp, #-52]
	str	r3, [r1, #0]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	str	r3, [fp, #-40]
	ldr	r3, .L610
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-20]
	add	r3, r3, #17
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L605
	mov	r2, #8
	str	r2, [fp, #-32]
	b	.L607
.L605:
	mov	r3, #0
	str	r3, [fp, #-32]
.L607:
	ldr	r1, [fp, #-36]
	ldr	r2, [fp, #-32]
	orr	r3, r1, r2
	ldr	r1, [fp, #-40]
	str	r3, [r1, #0]
	ldr	r3, .L610
	ldr	r2, [r3, #100]
	ldr	r3, .L610+4
	cmp	r2, r3
	bne	.L609
	ldr	r3, .L610
	ldr	r2, [r3, #468]
	ldr	r3, .L610
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L610
	strb	r3, [r2, #108]
.L609:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L611:
	.align	2
.L610:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_rpix_4bitv, .-_Z12fx_rpix_4bitv
	.align	2
	.type	_Z12fx_plot_8bitv, %function
_Z12fx_plot_8bitv:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #16
	ldr	r3, .L645
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	str	r3, [fp, #-28]
	ldr	r3, .L645
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	str	r3, [fp, #-24]
	ldr	r3, .L645
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L645
	str	r2, [r3, #60]
	ldr	r3, .L645
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L645
	str	r2, [r3, #72]
	ldr	r2, .L645
	ldr	r3, .L645
	str	r3, [r2, #104]
	ldr	r3, .L645
	ldr	r2, [r3, #104]
	ldr	r3, .L645
	str	r2, [r3, #100]
	ldr	r3, .L645
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, .L645
	str	r2, [r3, #4]
	ldr	r3, .L645
	ldr	r2, [r3, #440]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bls	.L644
	ldr	r3, .L645
	ldr	r3, [r3, #64]
	strb	r3, [fp, #-13]
	ldr	r3, .L645
	ldr	r3, [r3, #68]
	and	r3, r3, #16
	cmp	r3, #0
	bne	.L615
	ldr	r3, .L645
	ldr	r3, [r3, #68]
	and	r3, r3, #1
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L619
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #15
	cmp	r3, #0
	beq	.L644
	b	.L619
.L615:
	ldr	r3, .L645
	ldr	r3, [r3, #68]
	and	r3, r3, #1
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L619
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L644
.L619:
	ldr	r3, [fp, #-24]
	mov	r3, r3, lsr #3
	ldr	r2, .L645
	mov	r1, #184
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r0, [r3, #0]
	ldr	r3, [fp, #-28]
	mov	r3, r3, lsr #3
	ldr	r2, .L645
	mov	r1, #312
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r3, #0]
	add	r2, r0, r3
	ldr	r3, [fp, #-24]
	and	r3, r3, #7
	mov	r3, r3, asl #1
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	and	r2, r3, #7
	mov	r3, #128
	mov	r3, r3, asr r2
	strb	r3, [fp, #-14]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #1
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L621
	ldr	r3, [fp, #-20]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	ldr	r2, [fp, #-20]
	strb	r3, [r2, #0]
	b	.L623
.L621:
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	ldr	r2, [fp, #-20]
	strb	r3, [r2, #0]
.L623:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #2
	cmp	r3, #0
	beq	.L624
	ldr	r3, [fp, #-20]
	add	r1, r3, #1
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L626
.L624:
	ldr	r3, [fp, #-20]
	add	r1, r3, #1
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L626:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #4
	cmp	r3, #0
	beq	.L627
	ldr	r3, [fp, #-20]
	add	r1, r3, #16
	ldr	r3, [fp, #-20]
	add	r3, r3, #16
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L629
.L627:
	ldr	r3, [fp, #-20]
	add	r1, r3, #16
	ldr	r3, [fp, #-20]
	add	r3, r3, #16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L629:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #8
	cmp	r3, #0
	beq	.L630
	ldr	r3, [fp, #-20]
	add	r1, r3, #17
	ldr	r3, [fp, #-20]
	add	r3, r3, #17
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L632
.L630:
	ldr	r3, [fp, #-20]
	add	r1, r3, #17
	ldr	r3, [fp, #-20]
	add	r3, r3, #17
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L632:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #16
	cmp	r3, #0
	beq	.L633
	ldr	r3, [fp, #-20]
	add	r1, r3, #32
	ldr	r3, [fp, #-20]
	add	r3, r3, #32
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L635
.L633:
	ldr	r3, [fp, #-20]
	add	r1, r3, #32
	ldr	r3, [fp, #-20]
	add	r3, r3, #32
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L635:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L636
	ldr	r3, [fp, #-20]
	add	r1, r3, #33
	ldr	r3, [fp, #-20]
	add	r3, r3, #33
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L638
.L636:
	ldr	r3, [fp, #-20]
	add	r1, r3, #33
	ldr	r3, [fp, #-20]
	add	r3, r3, #33
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L638:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L639
	ldr	r3, [fp, #-20]
	add	r1, r3, #48
	ldr	r3, [fp, #-20]
	add	r3, r3, #48
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L641
.L639:
	ldr	r3, [fp, #-20]
	add	r1, r3, #48
	ldr	r3, [fp, #-20]
	add	r3, r3, #48
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L641:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	cmp	r3, #0
	bge	.L642
	ldr	r3, [fp, #-20]
	add	r1, r3, #49
	ldr	r3, [fp, #-20]
	add	r3, r3, #49
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldrb	r3, [fp, #-14]
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [r1, #0]
	b	.L644
.L642:
	ldr	r3, [fp, #-20]
	add	r1, r3, #49
	ldr	r3, [fp, #-20]
	add	r3, r3, #49
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-14]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	and	r3, r3, #255
	strb	r3, [r1, #0]
.L644:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L646:
	.align	2
.L645:
	.word	GSU
	.size	_Z12fx_plot_8bitv, .-_Z12fx_plot_8bitv
	.align	2
	.type	_Z12fx_rpix_8bitv, %function
_Z12fx_rpix_8bitv:
	@ args = 0, pretend = 0, frame = 100
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #100
	ldr	r3, .L673
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	str	r3, [fp, #-28]
	ldr	r3, .L673
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	str	r3, [fp, #-24]
	ldr	r3, .L673
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L673
	str	r2, [r3, #60]
	ldr	r3, .L673
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L673
	str	r2, [r3, #72]
	ldr	r2, .L673
	ldr	r3, .L673
	str	r3, [r2, #104]
	ldr	r3, .L673
	ldr	r2, [r3, #104]
	ldr	r3, .L673
	str	r2, [r3, #100]
	ldr	r3, .L673
	ldr	r2, [r3, #440]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bls	.L672
	ldr	r3, [fp, #-24]
	mov	r3, r3, lsr #3
	ldr	r2, .L673
	mov	r1, #184
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r0, [r3, #0]
	ldr	r3, [fp, #-28]
	mov	r3, r3, lsr #3
	ldr	r2, .L673
	mov	r1, #312
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r3, #0]
	add	r2, r0, r3
	ldr	r3, [fp, #-24]
	and	r3, r3, #7
	mov	r3, r3, asl #1
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-28]
	and	r2, r3, #7
	mov	r3, #128
	mov	r3, r3, asr r2
	strb	r3, [fp, #-13]
	ldr	r3, .L673
	ldr	r2, [r3, #100]
	mov	r3, #0
	str	r3, [r2, #0]
	ldr	r3, .L673
	ldr	r0, [r3, #100]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r1, [r3, #0]
	ldr	r3, [fp, #-20]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	moveq	r3, #0
	movne	r3, #1
	orr	r3, r1, r3
	str	r3, [r0, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-112]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-108]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L650
	mov	r1, #2
	str	r1, [fp, #-104]
	b	.L652
.L650:
	mov	r2, #0
	str	r2, [fp, #-104]
.L652:
	ldr	r1, [fp, #-108]
	ldr	r2, [fp, #-104]
	orr	r3, r1, r2
	ldr	r1, [fp, #-112]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-100]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-96]
	ldr	r3, [fp, #-20]
	add	r3, r3, #16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L653
	mov	r2, #4
	str	r2, [fp, #-92]
	b	.L655
.L653:
	mov	r3, #0
	str	r3, [fp, #-92]
.L655:
	ldr	r1, [fp, #-96]
	ldr	r2, [fp, #-92]
	orr	r3, r1, r2
	ldr	r1, [fp, #-100]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-88]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-20]
	add	r3, r3, #17
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L656
	mov	r2, #8
	str	r2, [fp, #-80]
	b	.L658
.L656:
	mov	r3, #0
	str	r3, [fp, #-80]
.L658:
	ldr	r1, [fp, #-84]
	ldr	r2, [fp, #-80]
	orr	r3, r1, r2
	ldr	r1, [fp, #-88]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-76]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-72]
	ldr	r3, [fp, #-20]
	add	r3, r3, #32
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L659
	mov	r2, #16
	str	r2, [fp, #-68]
	b	.L661
.L659:
	mov	r3, #0
	str	r3, [fp, #-68]
.L661:
	ldr	r1, [fp, #-72]
	ldr	r2, [fp, #-68]
	orr	r3, r1, r2
	ldr	r1, [fp, #-76]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-64]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-20]
	add	r3, r3, #33
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L662
	mov	r2, #32
	str	r2, [fp, #-56]
	b	.L664
.L662:
	mov	r3, #0
	str	r3, [fp, #-56]
.L664:
	ldr	r1, [fp, #-60]
	ldr	r2, [fp, #-56]
	orr	r3, r1, r2
	ldr	r1, [fp, #-64]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-52]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-20]
	add	r3, r3, #48
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L665
	mov	r2, #64
	str	r2, [fp, #-44]
	b	.L667
.L665:
	mov	r3, #0
	str	r3, [fp, #-44]
.L667:
	ldr	r1, [fp, #-48]
	ldr	r2, [fp, #-44]
	orr	r3, r1, r2
	ldr	r1, [fp, #-52]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	str	r3, [fp, #-40]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-20]
	add	r3, r3, #49
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r2, r3
	cmp	r3, #0
	beq	.L668
	mov	r2, #128
	str	r2, [fp, #-32]
	b	.L670
.L668:
	mov	r3, #0
	str	r3, [fp, #-32]
.L670:
	ldr	r1, [fp, #-36]
	ldr	r2, [fp, #-32]
	orr	r3, r1, r2
	ldr	r1, [fp, #-40]
	str	r3, [r1, #0]
	ldr	r3, .L673
	ldr	r3, [r3, #100]
	ldr	r2, [r3, #0]
	ldr	r3, .L673
	str	r2, [r3, #120]
	ldr	r3, .L673
	ldr	r2, [r3, #100]
	ldr	r3, .L673+4
	cmp	r2, r3
	bne	.L672
	ldr	r3, .L673
	ldr	r2, [r3, #468]
	ldr	r3, .L673
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L673
	strb	r3, [r2, #108]
.L672:
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L674:
	.align	2
.L673:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_rpix_8bitv, .-_Z12fx_rpix_8bitv
	.align	2
	.type	_Z7fx_swapv, %function
_Z7fx_swapv:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	ldr	r3, .L679
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	strb	r3, [fp, #-18]
	ldr	r3, .L679
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	strb	r3, [fp, #-17]
	ldrb	r3, [fp, #-18]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldrb	r3, [fp, #-17]	@ zero_extendqisi2
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L679
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L679
	str	r2, [r3, #60]
	ldr	r3, .L679
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L679
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L679
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L679
	ldr	r2, [r3, #100]
	ldr	r3, .L679+4
	cmp	r2, r3
	bne	.L676
	ldr	r3, .L679
	ldr	r2, [r3, #468]
	ldr	r3, .L679
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L679
	strb	r3, [r2, #108]
.L676:
	ldr	r3, .L679
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L679
	str	r2, [r3, #72]
	ldr	r2, .L679
	ldr	r3, .L679
	str	r3, [r2, #104]
	ldr	r3, .L679
	ldr	r2, [r3, #104]
	ldr	r3, .L679
	str	r2, [r3, #100]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L680:
	.align	2
.L679:
	.word	GSU
	.word	GSU+56
	.size	_Z7fx_swapv, .-_Z7fx_swapv
	.align	2
	.type	_Z8fx_colorv, %function
_Z8fx_colorv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L688
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	strb	r3, [fp, #-13]
	ldr	r3, .L688
	ldr	r3, [r3, #68]
	and	r3, r3, #4
	cmp	r3, #0
	beq	.L682
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r2, r3, #255
	mov	r3, #240
	and	r2, r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, lsr #4
	and	r3, r3, #255
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [fp, #-13]
.L682:
	ldr	r3, .L688
	ldr	r3, [r3, #68]
	and	r3, r3, #8
	cmp	r3, #0
	beq	.L684
	ldr	r3, .L688
	ldr	r3, [r3, #64]
	and	r2, r3, #240
	ldr	r3, .L688
	str	r2, [r3, #64]
	ldr	r3, .L688
	ldr	r2, [r3, #64]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #15
	orr	r2, r2, r3
	ldr	r3, .L688
	str	r2, [r3, #64]
	b	.L686
.L684:
	ldrb	r2, [fp, #-13]	@ zero_extendqisi2
	ldr	r3, .L688
	str	r2, [r3, #64]
.L686:
	ldr	r3, .L688
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L688
	str	r2, [r3, #72]
	ldr	r2, .L688
	ldr	r3, .L688
	str	r3, [r2, #104]
	ldr	r3, .L688
	ldr	r2, [r3, #104]
	ldr	r3, .L688
	str	r2, [r3, #100]
	ldr	r3, .L688
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L688
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L689:
	.align	2
.L688:
	.word	GSU
	.size	_Z8fx_colorv, .-_Z8fx_colorv
	.align	2
	.type	_Z6fx_notv, %function
_Z6fx_notv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L694
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mvn	r3, r3
	str	r3, [fp, #-16]
	ldr	r3, .L694
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L694
	str	r2, [r3, #60]
	ldr	r3, .L694
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L694
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L694
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L694
	ldr	r2, [r3, #100]
	ldr	r3, .L694+4
	cmp	r2, r3
	bne	.L691
	ldr	r3, .L694
	ldr	r2, [r3, #468]
	ldr	r3, .L694
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L694
	strb	r3, [r2, #108]
.L691:
	ldr	r3, .L694
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L694
	str	r2, [r3, #72]
	ldr	r2, .L694
	ldr	r3, .L694
	str	r3, [r2, #104]
	ldr	r3, .L694
	ldr	r2, [r3, #104]
	ldr	r3, .L694
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L695:
	.align	2
.L694:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_notv, .-_Z6fx_notv
	.align	2
	.type	_Z9fx_add_r0v, %function
_Z9fx_add_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L700
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L700
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L700+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L700
	str	r2, [r3, #124]
	ldr	r3, .L700
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L700
	ldr	r3, [r3, #0]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L700
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L700
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L700
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L700
	str	r2, [r3, #120]
	ldr	r3, .L700
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L700
	str	r2, [r3, #60]
	ldr	r3, .L700
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L700
	ldr	r2, [r3, #100]
	ldr	r3, .L700+8
	cmp	r2, r3
	bne	.L697
	ldr	r3, .L700
	ldr	r2, [r3, #468]
	ldr	r3, .L700
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L700
	strb	r3, [r2, #108]
.L697:
	ldr	r3, .L700
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L700
	str	r2, [r3, #72]
	ldr	r2, .L700
	ldr	r3, .L700
	str	r3, [r2, #104]
	ldr	r3, .L700
	ldr	r2, [r3, #104]
	ldr	r3, .L700
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L701:
	.align	2
.L700:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r0v, .-_Z9fx_add_r0v
	.align	2
	.type	_Z9fx_add_r1v, %function
_Z9fx_add_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L706
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L706
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L706+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L706
	str	r2, [r3, #124]
	ldr	r3, .L706
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L706
	ldr	r3, [r3, #4]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L706
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L706
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L706
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L706
	str	r2, [r3, #120]
	ldr	r3, .L706
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L706
	str	r2, [r3, #60]
	ldr	r3, .L706
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L706
	ldr	r2, [r3, #100]
	ldr	r3, .L706+8
	cmp	r2, r3
	bne	.L703
	ldr	r3, .L706
	ldr	r2, [r3, #468]
	ldr	r3, .L706
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L706
	strb	r3, [r2, #108]
.L703:
	ldr	r3, .L706
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L706
	str	r2, [r3, #72]
	ldr	r2, .L706
	ldr	r3, .L706
	str	r3, [r2, #104]
	ldr	r3, .L706
	ldr	r2, [r3, #104]
	ldr	r3, .L706
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L707:
	.align	2
.L706:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r1v, .-_Z9fx_add_r1v
	.align	2
	.type	_Z9fx_add_r2v, %function
_Z9fx_add_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L712
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L712
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L712+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L712
	str	r2, [r3, #124]
	ldr	r3, .L712
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L712
	ldr	r3, [r3, #8]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L712
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L712
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L712
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L712
	str	r2, [r3, #120]
	ldr	r3, .L712
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L712
	str	r2, [r3, #60]
	ldr	r3, .L712
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L712
	ldr	r2, [r3, #100]
	ldr	r3, .L712+8
	cmp	r2, r3
	bne	.L709
	ldr	r3, .L712
	ldr	r2, [r3, #468]
	ldr	r3, .L712
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L712
	strb	r3, [r2, #108]
.L709:
	ldr	r3, .L712
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L712
	str	r2, [r3, #72]
	ldr	r2, .L712
	ldr	r3, .L712
	str	r3, [r2, #104]
	ldr	r3, .L712
	ldr	r2, [r3, #104]
	ldr	r3, .L712
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L713:
	.align	2
.L712:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r2v, .-_Z9fx_add_r2v
	.align	2
	.type	_Z9fx_add_r3v, %function
_Z9fx_add_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L718
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L718
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L718+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L718
	str	r2, [r3, #124]
	ldr	r3, .L718
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L718
	ldr	r3, [r3, #12]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L718
	ldr	r2, [r3, #12]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L718
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L718
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L718
	str	r2, [r3, #120]
	ldr	r3, .L718
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L718
	str	r2, [r3, #60]
	ldr	r3, .L718
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L718
	ldr	r2, [r3, #100]
	ldr	r3, .L718+8
	cmp	r2, r3
	bne	.L715
	ldr	r3, .L718
	ldr	r2, [r3, #468]
	ldr	r3, .L718
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L718
	strb	r3, [r2, #108]
.L715:
	ldr	r3, .L718
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L718
	str	r2, [r3, #72]
	ldr	r2, .L718
	ldr	r3, .L718
	str	r3, [r2, #104]
	ldr	r3, .L718
	ldr	r2, [r3, #104]
	ldr	r3, .L718
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L719:
	.align	2
.L718:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r3v, .-_Z9fx_add_r3v
	.align	2
	.type	_Z9fx_add_r4v, %function
_Z9fx_add_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L724
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L724
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L724+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L724
	str	r2, [r3, #124]
	ldr	r3, .L724
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L724
	ldr	r3, [r3, #16]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L724
	ldr	r2, [r3, #16]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L724
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L724
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L724
	str	r2, [r3, #120]
	ldr	r3, .L724
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L724
	str	r2, [r3, #60]
	ldr	r3, .L724
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L724
	ldr	r2, [r3, #100]
	ldr	r3, .L724+8
	cmp	r2, r3
	bne	.L721
	ldr	r3, .L724
	ldr	r2, [r3, #468]
	ldr	r3, .L724
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L724
	strb	r3, [r2, #108]
.L721:
	ldr	r3, .L724
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L724
	str	r2, [r3, #72]
	ldr	r2, .L724
	ldr	r3, .L724
	str	r3, [r2, #104]
	ldr	r3, .L724
	ldr	r2, [r3, #104]
	ldr	r3, .L724
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L725:
	.align	2
.L724:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r4v, .-_Z9fx_add_r4v
	.align	2
	.type	_Z9fx_add_r5v, %function
_Z9fx_add_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L730
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L730
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L730+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L730
	str	r2, [r3, #124]
	ldr	r3, .L730
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L730
	ldr	r3, [r3, #20]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L730
	ldr	r2, [r3, #20]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L730
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L730
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L730
	str	r2, [r3, #120]
	ldr	r3, .L730
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L730
	str	r2, [r3, #60]
	ldr	r3, .L730
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L730
	ldr	r2, [r3, #100]
	ldr	r3, .L730+8
	cmp	r2, r3
	bne	.L727
	ldr	r3, .L730
	ldr	r2, [r3, #468]
	ldr	r3, .L730
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L730
	strb	r3, [r2, #108]
.L727:
	ldr	r3, .L730
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L730
	str	r2, [r3, #72]
	ldr	r2, .L730
	ldr	r3, .L730
	str	r3, [r2, #104]
	ldr	r3, .L730
	ldr	r2, [r3, #104]
	ldr	r3, .L730
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L731:
	.align	2
.L730:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r5v, .-_Z9fx_add_r5v
	.align	2
	.type	_Z9fx_add_r6v, %function
_Z9fx_add_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L736
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L736
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L736+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L736
	str	r2, [r3, #124]
	ldr	r3, .L736
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L736
	ldr	r3, [r3, #24]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L736
	ldr	r2, [r3, #24]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L736
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L736
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L736
	str	r2, [r3, #120]
	ldr	r3, .L736
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L736
	str	r2, [r3, #60]
	ldr	r3, .L736
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L736
	ldr	r2, [r3, #100]
	ldr	r3, .L736+8
	cmp	r2, r3
	bne	.L733
	ldr	r3, .L736
	ldr	r2, [r3, #468]
	ldr	r3, .L736
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L736
	strb	r3, [r2, #108]
.L733:
	ldr	r3, .L736
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L736
	str	r2, [r3, #72]
	ldr	r2, .L736
	ldr	r3, .L736
	str	r3, [r2, #104]
	ldr	r3, .L736
	ldr	r2, [r3, #104]
	ldr	r3, .L736
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L737:
	.align	2
.L736:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r6v, .-_Z9fx_add_r6v
	.align	2
	.type	_Z9fx_add_r7v, %function
_Z9fx_add_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L742
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L742
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L742+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L742
	str	r2, [r3, #124]
	ldr	r3, .L742
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L742
	ldr	r3, [r3, #28]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L742
	ldr	r2, [r3, #28]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L742
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L742
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L742
	str	r2, [r3, #120]
	ldr	r3, .L742
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L742
	str	r2, [r3, #60]
	ldr	r3, .L742
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L742
	ldr	r2, [r3, #100]
	ldr	r3, .L742+8
	cmp	r2, r3
	bne	.L739
	ldr	r3, .L742
	ldr	r2, [r3, #468]
	ldr	r3, .L742
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L742
	strb	r3, [r2, #108]
.L739:
	ldr	r3, .L742
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L742
	str	r2, [r3, #72]
	ldr	r2, .L742
	ldr	r3, .L742
	str	r3, [r2, #104]
	ldr	r3, .L742
	ldr	r2, [r3, #104]
	ldr	r3, .L742
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L743:
	.align	2
.L742:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r7v, .-_Z9fx_add_r7v
	.align	2
	.type	_Z9fx_add_r8v, %function
_Z9fx_add_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L748
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L748
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L748+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L748
	str	r2, [r3, #124]
	ldr	r3, .L748
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L748
	ldr	r3, [r3, #32]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L748
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L748
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L748
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L748
	str	r2, [r3, #120]
	ldr	r3, .L748
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L748
	str	r2, [r3, #60]
	ldr	r3, .L748
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L748
	ldr	r2, [r3, #100]
	ldr	r3, .L748+8
	cmp	r2, r3
	bne	.L745
	ldr	r3, .L748
	ldr	r2, [r3, #468]
	ldr	r3, .L748
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L748
	strb	r3, [r2, #108]
.L745:
	ldr	r3, .L748
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L748
	str	r2, [r3, #72]
	ldr	r2, .L748
	ldr	r3, .L748
	str	r3, [r2, #104]
	ldr	r3, .L748
	ldr	r2, [r3, #104]
	ldr	r3, .L748
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L749:
	.align	2
.L748:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r8v, .-_Z9fx_add_r8v
	.align	2
	.type	_Z9fx_add_r9v, %function
_Z9fx_add_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L754
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L754
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L754+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L754
	str	r2, [r3, #124]
	ldr	r3, .L754
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L754
	ldr	r3, [r3, #36]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L754
	ldr	r2, [r3, #36]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L754
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L754
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L754
	str	r2, [r3, #120]
	ldr	r3, .L754
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L754
	str	r2, [r3, #60]
	ldr	r3, .L754
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L754
	ldr	r2, [r3, #100]
	ldr	r3, .L754+8
	cmp	r2, r3
	bne	.L751
	ldr	r3, .L754
	ldr	r2, [r3, #468]
	ldr	r3, .L754
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L754
	strb	r3, [r2, #108]
.L751:
	ldr	r3, .L754
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L754
	str	r2, [r3, #72]
	ldr	r2, .L754
	ldr	r3, .L754
	str	r3, [r2, #104]
	ldr	r3, .L754
	ldr	r2, [r3, #104]
	ldr	r3, .L754
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L755:
	.align	2
.L754:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_r9v, .-_Z9fx_add_r9v
	.align	2
	.type	_Z10fx_add_r10v, %function
_Z10fx_add_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L760
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L760
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L760+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L760
	str	r2, [r3, #124]
	ldr	r3, .L760
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L760
	ldr	r3, [r3, #40]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L760
	ldr	r2, [r3, #40]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L760
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L760
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L760
	str	r2, [r3, #120]
	ldr	r3, .L760
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L760
	str	r2, [r3, #60]
	ldr	r3, .L760
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L760
	ldr	r2, [r3, #100]
	ldr	r3, .L760+8
	cmp	r2, r3
	bne	.L757
	ldr	r3, .L760
	ldr	r2, [r3, #468]
	ldr	r3, .L760
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L760
	strb	r3, [r2, #108]
.L757:
	ldr	r3, .L760
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L760
	str	r2, [r3, #72]
	ldr	r2, .L760
	ldr	r3, .L760
	str	r3, [r2, #104]
	ldr	r3, .L760
	ldr	r2, [r3, #104]
	ldr	r3, .L760
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L761:
	.align	2
.L760:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_r10v, .-_Z10fx_add_r10v
	.align	2
	.type	_Z10fx_add_r11v, %function
_Z10fx_add_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L766
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L766
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L766+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L766
	str	r2, [r3, #124]
	ldr	r3, .L766
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L766
	ldr	r3, [r3, #44]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L766
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L766
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L766
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L766
	str	r2, [r3, #120]
	ldr	r3, .L766
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L766
	str	r2, [r3, #60]
	ldr	r3, .L766
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L766
	ldr	r2, [r3, #100]
	ldr	r3, .L766+8
	cmp	r2, r3
	bne	.L763
	ldr	r3, .L766
	ldr	r2, [r3, #468]
	ldr	r3, .L766
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L766
	strb	r3, [r2, #108]
.L763:
	ldr	r3, .L766
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L766
	str	r2, [r3, #72]
	ldr	r2, .L766
	ldr	r3, .L766
	str	r3, [r2, #104]
	ldr	r3, .L766
	ldr	r2, [r3, #104]
	ldr	r3, .L766
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L767:
	.align	2
.L766:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_r11v, .-_Z10fx_add_r11v
	.align	2
	.type	_Z10fx_add_r12v, %function
_Z10fx_add_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L772
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L772
	ldr	r3, [r3, #48]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L772+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L772
	str	r2, [r3, #124]
	ldr	r3, .L772
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L772
	ldr	r3, [r3, #48]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L772
	ldr	r2, [r3, #48]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L772
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L772
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L772
	str	r2, [r3, #120]
	ldr	r3, .L772
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L772
	str	r2, [r3, #60]
	ldr	r3, .L772
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L772
	ldr	r2, [r3, #100]
	ldr	r3, .L772+8
	cmp	r2, r3
	bne	.L769
	ldr	r3, .L772
	ldr	r2, [r3, #468]
	ldr	r3, .L772
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L772
	strb	r3, [r2, #108]
.L769:
	ldr	r3, .L772
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L772
	str	r2, [r3, #72]
	ldr	r2, .L772
	ldr	r3, .L772
	str	r3, [r2, #104]
	ldr	r3, .L772
	ldr	r2, [r3, #104]
	ldr	r3, .L772
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L773:
	.align	2
.L772:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_r12v, .-_Z10fx_add_r12v
	.align	2
	.type	_Z10fx_add_r13v, %function
_Z10fx_add_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L778
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L778
	ldr	r3, [r3, #52]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L778+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L778
	str	r2, [r3, #124]
	ldr	r3, .L778
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L778
	ldr	r3, [r3, #52]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L778
	ldr	r2, [r3, #52]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L778
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L778
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L778
	str	r2, [r3, #120]
	ldr	r3, .L778
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L778
	str	r2, [r3, #60]
	ldr	r3, .L778
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L778
	ldr	r2, [r3, #100]
	ldr	r3, .L778+8
	cmp	r2, r3
	bne	.L775
	ldr	r3, .L778
	ldr	r2, [r3, #468]
	ldr	r3, .L778
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L778
	strb	r3, [r2, #108]
.L775:
	ldr	r3, .L778
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L778
	str	r2, [r3, #72]
	ldr	r2, .L778
	ldr	r3, .L778
	str	r3, [r2, #104]
	ldr	r3, .L778
	ldr	r2, [r3, #104]
	ldr	r3, .L778
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L779:
	.align	2
.L778:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_r13v, .-_Z10fx_add_r13v
	.align	2
	.type	_Z10fx_add_r14v, %function
_Z10fx_add_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L784
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L784
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L784+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L784
	str	r2, [r3, #124]
	ldr	r3, .L784
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L784
	ldr	r3, [r3, #56]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L784
	ldr	r2, [r3, #56]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L784
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L784
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L784
	str	r2, [r3, #120]
	ldr	r3, .L784
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L784
	str	r2, [r3, #60]
	ldr	r3, .L784
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L784
	ldr	r2, [r3, #100]
	ldr	r3, .L784+8
	cmp	r2, r3
	bne	.L781
	ldr	r3, .L784
	ldr	r2, [r3, #468]
	ldr	r3, .L784
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L784
	strb	r3, [r2, #108]
.L781:
	ldr	r3, .L784
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L784
	str	r2, [r3, #72]
	ldr	r2, .L784
	ldr	r3, .L784
	str	r3, [r2, #104]
	ldr	r3, .L784
	ldr	r2, [r3, #104]
	ldr	r3, .L784
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L785:
	.align	2
.L784:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_r14v, .-_Z10fx_add_r14v
	.align	2
	.type	_Z10fx_add_r15v, %function
_Z10fx_add_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L790
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L790
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L790+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L790
	str	r2, [r3, #124]
	ldr	r3, .L790
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L790
	ldr	r3, [r3, #60]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L790
	ldr	r2, [r3, #60]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L790
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L790
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L790
	str	r2, [r3, #120]
	ldr	r3, .L790
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L790
	str	r2, [r3, #60]
	ldr	r3, .L790
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L790
	ldr	r2, [r3, #100]
	ldr	r3, .L790+8
	cmp	r2, r3
	bne	.L787
	ldr	r3, .L790
	ldr	r2, [r3, #468]
	ldr	r3, .L790
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L790
	strb	r3, [r2, #108]
.L787:
	ldr	r3, .L790
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L790
	str	r2, [r3, #72]
	ldr	r2, .L790
	ldr	r3, .L790
	str	r3, [r2, #104]
	ldr	r3, .L790
	ldr	r2, [r3, #104]
	ldr	r3, .L790
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L791:
	.align	2
.L790:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_r15v, .-_Z10fx_add_r15v
	.align	2
	.type	_Z9fx_adc_r0v, %function
_Z9fx_adc_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L796
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L796
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L796
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L796+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L796
	str	r2, [r3, #124]
	ldr	r3, .L796
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L796
	ldr	r3, [r3, #0]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L796
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L796
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L796
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L796
	str	r2, [r3, #120]
	ldr	r3, .L796
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L796
	str	r2, [r3, #60]
	ldr	r3, .L796
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L796
	ldr	r2, [r3, #100]
	ldr	r3, .L796+8
	cmp	r2, r3
	bne	.L793
	ldr	r3, .L796
	ldr	r2, [r3, #468]
	ldr	r3, .L796
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L796
	strb	r3, [r2, #108]
.L793:
	ldr	r3, .L796
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L796
	str	r2, [r3, #72]
	ldr	r2, .L796
	ldr	r3, .L796
	str	r3, [r2, #104]
	ldr	r3, .L796
	ldr	r2, [r3, #104]
	ldr	r3, .L796
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L797:
	.align	2
.L796:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r0v, .-_Z9fx_adc_r0v
	.align	2
	.type	_Z9fx_adc_r1v, %function
_Z9fx_adc_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L802
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L802
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L802
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L802+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L802
	str	r2, [r3, #124]
	ldr	r3, .L802
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L802
	ldr	r3, [r3, #4]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L802
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L802
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L802
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L802
	str	r2, [r3, #120]
	ldr	r3, .L802
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L802
	str	r2, [r3, #60]
	ldr	r3, .L802
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L802
	ldr	r2, [r3, #100]
	ldr	r3, .L802+8
	cmp	r2, r3
	bne	.L799
	ldr	r3, .L802
	ldr	r2, [r3, #468]
	ldr	r3, .L802
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L802
	strb	r3, [r2, #108]
.L799:
	ldr	r3, .L802
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L802
	str	r2, [r3, #72]
	ldr	r2, .L802
	ldr	r3, .L802
	str	r3, [r2, #104]
	ldr	r3, .L802
	ldr	r2, [r3, #104]
	ldr	r3, .L802
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L803:
	.align	2
.L802:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r1v, .-_Z9fx_adc_r1v
	.align	2
	.type	_Z9fx_adc_r2v, %function
_Z9fx_adc_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L808
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L808
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L808
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L808+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L808
	str	r2, [r3, #124]
	ldr	r3, .L808
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L808
	ldr	r3, [r3, #8]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L808
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L808
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L808
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L808
	str	r2, [r3, #120]
	ldr	r3, .L808
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L808
	str	r2, [r3, #60]
	ldr	r3, .L808
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L808
	ldr	r2, [r3, #100]
	ldr	r3, .L808+8
	cmp	r2, r3
	bne	.L805
	ldr	r3, .L808
	ldr	r2, [r3, #468]
	ldr	r3, .L808
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L808
	strb	r3, [r2, #108]
.L805:
	ldr	r3, .L808
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L808
	str	r2, [r3, #72]
	ldr	r2, .L808
	ldr	r3, .L808
	str	r3, [r2, #104]
	ldr	r3, .L808
	ldr	r2, [r3, #104]
	ldr	r3, .L808
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L809:
	.align	2
.L808:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r2v, .-_Z9fx_adc_r2v
	.align	2
	.type	_Z9fx_adc_r3v, %function
_Z9fx_adc_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L814
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L814
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L814
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L814+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L814
	str	r2, [r3, #124]
	ldr	r3, .L814
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L814
	ldr	r3, [r3, #12]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L814
	ldr	r2, [r3, #12]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L814
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L814
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L814
	str	r2, [r3, #120]
	ldr	r3, .L814
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L814
	str	r2, [r3, #60]
	ldr	r3, .L814
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L814
	ldr	r2, [r3, #100]
	ldr	r3, .L814+8
	cmp	r2, r3
	bne	.L811
	ldr	r3, .L814
	ldr	r2, [r3, #468]
	ldr	r3, .L814
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L814
	strb	r3, [r2, #108]
.L811:
	ldr	r3, .L814
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L814
	str	r2, [r3, #72]
	ldr	r2, .L814
	ldr	r3, .L814
	str	r3, [r2, #104]
	ldr	r3, .L814
	ldr	r2, [r3, #104]
	ldr	r3, .L814
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L815:
	.align	2
.L814:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r3v, .-_Z9fx_adc_r3v
	.align	2
	.type	_Z9fx_adc_r4v, %function
_Z9fx_adc_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L820
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L820
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L820
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L820+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L820
	str	r2, [r3, #124]
	ldr	r3, .L820
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L820
	ldr	r3, [r3, #16]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L820
	ldr	r2, [r3, #16]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L820
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L820
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L820
	str	r2, [r3, #120]
	ldr	r3, .L820
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L820
	str	r2, [r3, #60]
	ldr	r3, .L820
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L820
	ldr	r2, [r3, #100]
	ldr	r3, .L820+8
	cmp	r2, r3
	bne	.L817
	ldr	r3, .L820
	ldr	r2, [r3, #468]
	ldr	r3, .L820
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L820
	strb	r3, [r2, #108]
.L817:
	ldr	r3, .L820
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L820
	str	r2, [r3, #72]
	ldr	r2, .L820
	ldr	r3, .L820
	str	r3, [r2, #104]
	ldr	r3, .L820
	ldr	r2, [r3, #104]
	ldr	r3, .L820
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L821:
	.align	2
.L820:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r4v, .-_Z9fx_adc_r4v
	.align	2
	.type	_Z9fx_adc_r5v, %function
_Z9fx_adc_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L826
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L826
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L826
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L826+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L826
	str	r2, [r3, #124]
	ldr	r3, .L826
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L826
	ldr	r3, [r3, #20]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L826
	ldr	r2, [r3, #20]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L826
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L826
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L826
	str	r2, [r3, #120]
	ldr	r3, .L826
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L826
	str	r2, [r3, #60]
	ldr	r3, .L826
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L826
	ldr	r2, [r3, #100]
	ldr	r3, .L826+8
	cmp	r2, r3
	bne	.L823
	ldr	r3, .L826
	ldr	r2, [r3, #468]
	ldr	r3, .L826
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L826
	strb	r3, [r2, #108]
.L823:
	ldr	r3, .L826
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L826
	str	r2, [r3, #72]
	ldr	r2, .L826
	ldr	r3, .L826
	str	r3, [r2, #104]
	ldr	r3, .L826
	ldr	r2, [r3, #104]
	ldr	r3, .L826
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L827:
	.align	2
.L826:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r5v, .-_Z9fx_adc_r5v
	.align	2
	.type	_Z9fx_adc_r6v, %function
_Z9fx_adc_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L832
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L832
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L832
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L832+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L832
	str	r2, [r3, #124]
	ldr	r3, .L832
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L832
	ldr	r3, [r3, #24]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L832
	ldr	r2, [r3, #24]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L832
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L832
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L832
	str	r2, [r3, #120]
	ldr	r3, .L832
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L832
	str	r2, [r3, #60]
	ldr	r3, .L832
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L832
	ldr	r2, [r3, #100]
	ldr	r3, .L832+8
	cmp	r2, r3
	bne	.L829
	ldr	r3, .L832
	ldr	r2, [r3, #468]
	ldr	r3, .L832
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L832
	strb	r3, [r2, #108]
.L829:
	ldr	r3, .L832
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L832
	str	r2, [r3, #72]
	ldr	r2, .L832
	ldr	r3, .L832
	str	r3, [r2, #104]
	ldr	r3, .L832
	ldr	r2, [r3, #104]
	ldr	r3, .L832
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L833:
	.align	2
.L832:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r6v, .-_Z9fx_adc_r6v
	.align	2
	.type	_Z9fx_adc_r7v, %function
_Z9fx_adc_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L838
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L838
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L838
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L838+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L838
	str	r2, [r3, #124]
	ldr	r3, .L838
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L838
	ldr	r3, [r3, #28]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L838
	ldr	r2, [r3, #28]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L838
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L838
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L838
	str	r2, [r3, #120]
	ldr	r3, .L838
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L838
	str	r2, [r3, #60]
	ldr	r3, .L838
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L838
	ldr	r2, [r3, #100]
	ldr	r3, .L838+8
	cmp	r2, r3
	bne	.L835
	ldr	r3, .L838
	ldr	r2, [r3, #468]
	ldr	r3, .L838
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L838
	strb	r3, [r2, #108]
.L835:
	ldr	r3, .L838
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L838
	str	r2, [r3, #72]
	ldr	r2, .L838
	ldr	r3, .L838
	str	r3, [r2, #104]
	ldr	r3, .L838
	ldr	r2, [r3, #104]
	ldr	r3, .L838
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L839:
	.align	2
.L838:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r7v, .-_Z9fx_adc_r7v
	.align	2
	.type	_Z9fx_adc_r8v, %function
_Z9fx_adc_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L844
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L844
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L844
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L844+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L844
	str	r2, [r3, #124]
	ldr	r3, .L844
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L844
	ldr	r3, [r3, #32]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L844
	ldr	r2, [r3, #32]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L844
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L844
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L844
	str	r2, [r3, #120]
	ldr	r3, .L844
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L844
	str	r2, [r3, #60]
	ldr	r3, .L844
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L844
	ldr	r2, [r3, #100]
	ldr	r3, .L844+8
	cmp	r2, r3
	bne	.L841
	ldr	r3, .L844
	ldr	r2, [r3, #468]
	ldr	r3, .L844
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L844
	strb	r3, [r2, #108]
.L841:
	ldr	r3, .L844
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L844
	str	r2, [r3, #72]
	ldr	r2, .L844
	ldr	r3, .L844
	str	r3, [r2, #104]
	ldr	r3, .L844
	ldr	r2, [r3, #104]
	ldr	r3, .L844
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L845:
	.align	2
.L844:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r8v, .-_Z9fx_adc_r8v
	.align	2
	.type	_Z9fx_adc_r9v, %function
_Z9fx_adc_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L850
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L850
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L850
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L850+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L850
	str	r2, [r3, #124]
	ldr	r3, .L850
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L850
	ldr	r3, [r3, #36]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L850
	ldr	r2, [r3, #36]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L850
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L850
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L850
	str	r2, [r3, #120]
	ldr	r3, .L850
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L850
	str	r2, [r3, #60]
	ldr	r3, .L850
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L850
	ldr	r2, [r3, #100]
	ldr	r3, .L850+8
	cmp	r2, r3
	bne	.L847
	ldr	r3, .L850
	ldr	r2, [r3, #468]
	ldr	r3, .L850
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L850
	strb	r3, [r2, #108]
.L847:
	ldr	r3, .L850
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L850
	str	r2, [r3, #72]
	ldr	r2, .L850
	ldr	r3, .L850
	str	r3, [r2, #104]
	ldr	r3, .L850
	ldr	r2, [r3, #104]
	ldr	r3, .L850
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L851:
	.align	2
.L850:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_r9v, .-_Z9fx_adc_r9v
	.align	2
	.type	_Z10fx_adc_r10v, %function
_Z10fx_adc_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L856
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L856
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L856
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L856+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L856
	str	r2, [r3, #124]
	ldr	r3, .L856
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L856
	ldr	r3, [r3, #40]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L856
	ldr	r2, [r3, #40]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L856
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L856
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L856
	str	r2, [r3, #120]
	ldr	r3, .L856
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L856
	str	r2, [r3, #60]
	ldr	r3, .L856
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L856
	ldr	r2, [r3, #100]
	ldr	r3, .L856+8
	cmp	r2, r3
	bne	.L853
	ldr	r3, .L856
	ldr	r2, [r3, #468]
	ldr	r3, .L856
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L856
	strb	r3, [r2, #108]
.L853:
	ldr	r3, .L856
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L856
	str	r2, [r3, #72]
	ldr	r2, .L856
	ldr	r3, .L856
	str	r3, [r2, #104]
	ldr	r3, .L856
	ldr	r2, [r3, #104]
	ldr	r3, .L856
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L857:
	.align	2
.L856:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_r10v, .-_Z10fx_adc_r10v
	.align	2
	.type	_Z10fx_adc_r11v, %function
_Z10fx_adc_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L862
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L862
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L862
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L862+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L862
	str	r2, [r3, #124]
	ldr	r3, .L862
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L862
	ldr	r3, [r3, #44]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L862
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L862
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L862
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L862
	str	r2, [r3, #120]
	ldr	r3, .L862
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L862
	str	r2, [r3, #60]
	ldr	r3, .L862
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L862
	ldr	r2, [r3, #100]
	ldr	r3, .L862+8
	cmp	r2, r3
	bne	.L859
	ldr	r3, .L862
	ldr	r2, [r3, #468]
	ldr	r3, .L862
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L862
	strb	r3, [r2, #108]
.L859:
	ldr	r3, .L862
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L862
	str	r2, [r3, #72]
	ldr	r2, .L862
	ldr	r3, .L862
	str	r3, [r2, #104]
	ldr	r3, .L862
	ldr	r2, [r3, #104]
	ldr	r3, .L862
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L863:
	.align	2
.L862:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_r11v, .-_Z10fx_adc_r11v
	.align	2
	.type	_Z10fx_adc_r12v, %function
_Z10fx_adc_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L868
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L868
	ldr	r3, [r3, #48]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L868
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L868+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L868
	str	r2, [r3, #124]
	ldr	r3, .L868
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L868
	ldr	r3, [r3, #48]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L868
	ldr	r2, [r3, #48]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L868
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L868
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L868
	str	r2, [r3, #120]
	ldr	r3, .L868
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L868
	str	r2, [r3, #60]
	ldr	r3, .L868
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L868
	ldr	r2, [r3, #100]
	ldr	r3, .L868+8
	cmp	r2, r3
	bne	.L865
	ldr	r3, .L868
	ldr	r2, [r3, #468]
	ldr	r3, .L868
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L868
	strb	r3, [r2, #108]
.L865:
	ldr	r3, .L868
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L868
	str	r2, [r3, #72]
	ldr	r2, .L868
	ldr	r3, .L868
	str	r3, [r2, #104]
	ldr	r3, .L868
	ldr	r2, [r3, #104]
	ldr	r3, .L868
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L869:
	.align	2
.L868:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_r12v, .-_Z10fx_adc_r12v
	.align	2
	.type	_Z10fx_adc_r13v, %function
_Z10fx_adc_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L874
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L874
	ldr	r3, [r3, #52]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L874
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L874+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L874
	str	r2, [r3, #124]
	ldr	r3, .L874
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L874
	ldr	r3, [r3, #52]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L874
	ldr	r2, [r3, #52]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L874
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L874
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L874
	str	r2, [r3, #120]
	ldr	r3, .L874
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L874
	str	r2, [r3, #60]
	ldr	r3, .L874
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L874
	ldr	r2, [r3, #100]
	ldr	r3, .L874+8
	cmp	r2, r3
	bne	.L871
	ldr	r3, .L874
	ldr	r2, [r3, #468]
	ldr	r3, .L874
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L874
	strb	r3, [r2, #108]
.L871:
	ldr	r3, .L874
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L874
	str	r2, [r3, #72]
	ldr	r2, .L874
	ldr	r3, .L874
	str	r3, [r2, #104]
	ldr	r3, .L874
	ldr	r2, [r3, #104]
	ldr	r3, .L874
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L875:
	.align	2
.L874:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_r13v, .-_Z10fx_adc_r13v
	.align	2
	.type	_Z10fx_adc_r14v, %function
_Z10fx_adc_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L880
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L880
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L880
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L880+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L880
	str	r2, [r3, #124]
	ldr	r3, .L880
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L880
	ldr	r3, [r3, #56]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L880
	ldr	r2, [r3, #56]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L880
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L880
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L880
	str	r2, [r3, #120]
	ldr	r3, .L880
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L880
	str	r2, [r3, #60]
	ldr	r3, .L880
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L880
	ldr	r2, [r3, #100]
	ldr	r3, .L880+8
	cmp	r2, r3
	bne	.L877
	ldr	r3, .L880
	ldr	r2, [r3, #468]
	ldr	r3, .L880
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L880
	strb	r3, [r2, #108]
.L877:
	ldr	r3, .L880
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L880
	str	r2, [r3, #72]
	ldr	r2, .L880
	ldr	r3, .L880
	str	r3, [r2, #104]
	ldr	r3, .L880
	ldr	r2, [r3, #104]
	ldr	r3, .L880
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L881:
	.align	2
.L880:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_r14v, .-_Z10fx_adc_r14v
	.align	2
	.type	_Z10fx_adc_r15v, %function
_Z10fx_adc_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L886
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L886
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L886
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L886+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L886
	str	r2, [r3, #124]
	ldr	r3, .L886
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L886
	ldr	r3, [r3, #60]
	eor	r3, r2, r3
	mvn	r1, r3
	ldr	r3, .L886
	ldr	r2, [r3, #60]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L886
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L886
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L886
	str	r2, [r3, #120]
	ldr	r3, .L886
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L886
	str	r2, [r3, #60]
	ldr	r3, .L886
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L886
	ldr	r2, [r3, #100]
	ldr	r3, .L886+8
	cmp	r2, r3
	bne	.L883
	ldr	r3, .L886
	ldr	r2, [r3, #468]
	ldr	r3, .L886
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L886
	strb	r3, [r2, #108]
.L883:
	ldr	r3, .L886
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L886
	str	r2, [r3, #72]
	ldr	r2, .L886
	ldr	r3, .L886
	str	r3, [r2, #104]
	ldr	r3, .L886
	ldr	r2, [r3, #104]
	ldr	r3, .L886
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L887:
	.align	2
.L886:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_r15v, .-_Z10fx_adc_r15v
	.align	2
	.type	_Z9fx_add_i0v, %function
_Z9fx_add_i0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L892
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L892+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L892
	str	r2, [r3, #124]
	ldr	r3, .L892
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mvn	r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L892
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L892
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L892
	str	r2, [r3, #120]
	ldr	r3, .L892
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L892
	str	r2, [r3, #60]
	ldr	r3, .L892
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L892
	ldr	r2, [r3, #100]
	ldr	r3, .L892+8
	cmp	r2, r3
	bne	.L889
	ldr	r3, .L892
	ldr	r2, [r3, #468]
	ldr	r3, .L892
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L892
	strb	r3, [r2, #108]
.L889:
	ldr	r3, .L892
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L892
	str	r2, [r3, #72]
	ldr	r2, .L892
	ldr	r3, .L892
	str	r3, [r2, #104]
	ldr	r3, .L892
	ldr	r2, [r3, #104]
	ldr	r3, .L892
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L893:
	.align	2
.L892:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i0v, .-_Z9fx_add_i0v
	.align	2
	.type	_Z9fx_add_i1v, %function
_Z9fx_add_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L898
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L898+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L898
	str	r2, [r3, #124]
	ldr	r3, .L898
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #1
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #1
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L898
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L898
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L898
	str	r2, [r3, #120]
	ldr	r3, .L898
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L898
	str	r2, [r3, #60]
	ldr	r3, .L898
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L898
	ldr	r2, [r3, #100]
	ldr	r3, .L898+8
	cmp	r2, r3
	bne	.L895
	ldr	r3, .L898
	ldr	r2, [r3, #468]
	ldr	r3, .L898
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L898
	strb	r3, [r2, #108]
.L895:
	ldr	r3, .L898
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L898
	str	r2, [r3, #72]
	ldr	r2, .L898
	ldr	r3, .L898
	str	r3, [r2, #104]
	ldr	r3, .L898
	ldr	r2, [r3, #104]
	ldr	r3, .L898
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L899:
	.align	2
.L898:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i1v, .-_Z9fx_add_i1v
	.align	2
	.type	_Z9fx_add_i2v, %function
_Z9fx_add_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L904
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L904+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L904
	str	r2, [r3, #124]
	ldr	r3, .L904
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #2
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #2
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L904
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L904
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L904
	str	r2, [r3, #120]
	ldr	r3, .L904
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L904
	str	r2, [r3, #60]
	ldr	r3, .L904
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L904
	ldr	r2, [r3, #100]
	ldr	r3, .L904+8
	cmp	r2, r3
	bne	.L901
	ldr	r3, .L904
	ldr	r2, [r3, #468]
	ldr	r3, .L904
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L904
	strb	r3, [r2, #108]
.L901:
	ldr	r3, .L904
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L904
	str	r2, [r3, #72]
	ldr	r2, .L904
	ldr	r3, .L904
	str	r3, [r2, #104]
	ldr	r3, .L904
	ldr	r2, [r3, #104]
	ldr	r3, .L904
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L905:
	.align	2
.L904:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i2v, .-_Z9fx_add_i2v
	.align	2
	.type	_Z9fx_add_i3v, %function
_Z9fx_add_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L910
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L910+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L910
	str	r2, [r3, #124]
	ldr	r3, .L910
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #3
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #3
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L910
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L910
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L910
	str	r2, [r3, #120]
	ldr	r3, .L910
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L910
	str	r2, [r3, #60]
	ldr	r3, .L910
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L910
	ldr	r2, [r3, #100]
	ldr	r3, .L910+8
	cmp	r2, r3
	bne	.L907
	ldr	r3, .L910
	ldr	r2, [r3, #468]
	ldr	r3, .L910
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L910
	strb	r3, [r2, #108]
.L907:
	ldr	r3, .L910
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L910
	str	r2, [r3, #72]
	ldr	r2, .L910
	ldr	r3, .L910
	str	r3, [r2, #104]
	ldr	r3, .L910
	ldr	r2, [r3, #104]
	ldr	r3, .L910
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L911:
	.align	2
.L910:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i3v, .-_Z9fx_add_i3v
	.align	2
	.type	_Z9fx_add_i4v, %function
_Z9fx_add_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L916
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #4
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L916+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L916
	str	r2, [r3, #124]
	ldr	r3, .L916
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #4
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L916
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L916
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L916
	str	r2, [r3, #120]
	ldr	r3, .L916
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L916
	str	r2, [r3, #60]
	ldr	r3, .L916
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L916
	ldr	r2, [r3, #100]
	ldr	r3, .L916+8
	cmp	r2, r3
	bne	.L913
	ldr	r3, .L916
	ldr	r2, [r3, #468]
	ldr	r3, .L916
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L916
	strb	r3, [r2, #108]
.L913:
	ldr	r3, .L916
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L916
	str	r2, [r3, #72]
	ldr	r2, .L916
	ldr	r3, .L916
	str	r3, [r2, #104]
	ldr	r3, .L916
	ldr	r2, [r3, #104]
	ldr	r3, .L916
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L917:
	.align	2
.L916:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i4v, .-_Z9fx_add_i4v
	.align	2
	.type	_Z9fx_add_i5v, %function
_Z9fx_add_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L922
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #5
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L922+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L922
	str	r2, [r3, #124]
	ldr	r3, .L922
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #5
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #5
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L922
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L922
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L922
	str	r2, [r3, #120]
	ldr	r3, .L922
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L922
	str	r2, [r3, #60]
	ldr	r3, .L922
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L922
	ldr	r2, [r3, #100]
	ldr	r3, .L922+8
	cmp	r2, r3
	bne	.L919
	ldr	r3, .L922
	ldr	r2, [r3, #468]
	ldr	r3, .L922
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L922
	strb	r3, [r2, #108]
.L919:
	ldr	r3, .L922
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L922
	str	r2, [r3, #72]
	ldr	r2, .L922
	ldr	r3, .L922
	str	r3, [r2, #104]
	ldr	r3, .L922
	ldr	r2, [r3, #104]
	ldr	r3, .L922
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L923:
	.align	2
.L922:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i5v, .-_Z9fx_add_i5v
	.align	2
	.type	_Z9fx_add_i6v, %function
_Z9fx_add_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L928
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #6
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L928+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L928
	str	r2, [r3, #124]
	ldr	r3, .L928
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #6
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #6
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L928
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L928
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L928
	str	r2, [r3, #120]
	ldr	r3, .L928
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L928
	str	r2, [r3, #60]
	ldr	r3, .L928
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L928
	ldr	r2, [r3, #100]
	ldr	r3, .L928+8
	cmp	r2, r3
	bne	.L925
	ldr	r3, .L928
	ldr	r2, [r3, #468]
	ldr	r3, .L928
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L928
	strb	r3, [r2, #108]
.L925:
	ldr	r3, .L928
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L928
	str	r2, [r3, #72]
	ldr	r2, .L928
	ldr	r3, .L928
	str	r3, [r2, #104]
	ldr	r3, .L928
	ldr	r2, [r3, #104]
	ldr	r3, .L928
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L929:
	.align	2
.L928:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i6v, .-_Z9fx_add_i6v
	.align	2
	.type	_Z9fx_add_i7v, %function
_Z9fx_add_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L934
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #7
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L934+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L934
	str	r2, [r3, #124]
	ldr	r3, .L934
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #7
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #7
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L934
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L934
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L934
	str	r2, [r3, #120]
	ldr	r3, .L934
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L934
	str	r2, [r3, #60]
	ldr	r3, .L934
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L934
	ldr	r2, [r3, #100]
	ldr	r3, .L934+8
	cmp	r2, r3
	bne	.L931
	ldr	r3, .L934
	ldr	r2, [r3, #468]
	ldr	r3, .L934
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L934
	strb	r3, [r2, #108]
.L931:
	ldr	r3, .L934
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L934
	str	r2, [r3, #72]
	ldr	r2, .L934
	ldr	r3, .L934
	str	r3, [r2, #104]
	ldr	r3, .L934
	ldr	r2, [r3, #104]
	ldr	r3, .L934
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L935:
	.align	2
.L934:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i7v, .-_Z9fx_add_i7v
	.align	2
	.type	_Z9fx_add_i8v, %function
_Z9fx_add_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L940
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #8
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L940+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L940
	str	r2, [r3, #124]
	ldr	r3, .L940
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #8
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #8
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L940
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L940
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L940
	str	r2, [r3, #120]
	ldr	r3, .L940
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L940
	str	r2, [r3, #60]
	ldr	r3, .L940
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L940
	ldr	r2, [r3, #100]
	ldr	r3, .L940+8
	cmp	r2, r3
	bne	.L937
	ldr	r3, .L940
	ldr	r2, [r3, #468]
	ldr	r3, .L940
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L940
	strb	r3, [r2, #108]
.L937:
	ldr	r3, .L940
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L940
	str	r2, [r3, #72]
	ldr	r2, .L940
	ldr	r3, .L940
	str	r3, [r2, #104]
	ldr	r3, .L940
	ldr	r2, [r3, #104]
	ldr	r3, .L940
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L941:
	.align	2
.L940:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i8v, .-_Z9fx_add_i8v
	.align	2
	.type	_Z9fx_add_i9v, %function
_Z9fx_add_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L946
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #9
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L946+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L946
	str	r2, [r3, #124]
	ldr	r3, .L946
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #9
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #9
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L946
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L946
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L946
	str	r2, [r3, #120]
	ldr	r3, .L946
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L946
	str	r2, [r3, #60]
	ldr	r3, .L946
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L946
	ldr	r2, [r3, #100]
	ldr	r3, .L946+8
	cmp	r2, r3
	bne	.L943
	ldr	r3, .L946
	ldr	r2, [r3, #468]
	ldr	r3, .L946
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L946
	strb	r3, [r2, #108]
.L943:
	ldr	r3, .L946
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L946
	str	r2, [r3, #72]
	ldr	r2, .L946
	ldr	r3, .L946
	str	r3, [r2, #104]
	ldr	r3, .L946
	ldr	r2, [r3, #104]
	ldr	r3, .L946
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L947:
	.align	2
.L946:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_add_i9v, .-_Z9fx_add_i9v
	.align	2
	.type	_Z10fx_add_i10v, %function
_Z10fx_add_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L952
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #10
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L952+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L952
	str	r2, [r3, #124]
	ldr	r3, .L952
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #10
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #10
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L952
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L952
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L952
	str	r2, [r3, #120]
	ldr	r3, .L952
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L952
	str	r2, [r3, #60]
	ldr	r3, .L952
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L952
	ldr	r2, [r3, #100]
	ldr	r3, .L952+8
	cmp	r2, r3
	bne	.L949
	ldr	r3, .L952
	ldr	r2, [r3, #468]
	ldr	r3, .L952
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L952
	strb	r3, [r2, #108]
.L949:
	ldr	r3, .L952
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L952
	str	r2, [r3, #72]
	ldr	r2, .L952
	ldr	r3, .L952
	str	r3, [r2, #104]
	ldr	r3, .L952
	ldr	r2, [r3, #104]
	ldr	r3, .L952
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L953:
	.align	2
.L952:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_i10v, .-_Z10fx_add_i10v
	.align	2
	.type	_Z10fx_add_i11v, %function
_Z10fx_add_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L958
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #11
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L958+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L958
	str	r2, [r3, #124]
	ldr	r3, .L958
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #11
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #11
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L958
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L958
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L958
	str	r2, [r3, #120]
	ldr	r3, .L958
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L958
	str	r2, [r3, #60]
	ldr	r3, .L958
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L958
	ldr	r2, [r3, #100]
	ldr	r3, .L958+8
	cmp	r2, r3
	bne	.L955
	ldr	r3, .L958
	ldr	r2, [r3, #468]
	ldr	r3, .L958
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L958
	strb	r3, [r2, #108]
.L955:
	ldr	r3, .L958
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L958
	str	r2, [r3, #72]
	ldr	r2, .L958
	ldr	r3, .L958
	str	r3, [r2, #104]
	ldr	r3, .L958
	ldr	r2, [r3, #104]
	ldr	r3, .L958
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L959:
	.align	2
.L958:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_i11v, .-_Z10fx_add_i11v
	.align	2
	.type	_Z10fx_add_i12v, %function
_Z10fx_add_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L964
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #12
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L964+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L964
	str	r2, [r3, #124]
	ldr	r3, .L964
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #12
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #12
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L964
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L964
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L964
	str	r2, [r3, #120]
	ldr	r3, .L964
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L964
	str	r2, [r3, #60]
	ldr	r3, .L964
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L964
	ldr	r2, [r3, #100]
	ldr	r3, .L964+8
	cmp	r2, r3
	bne	.L961
	ldr	r3, .L964
	ldr	r2, [r3, #468]
	ldr	r3, .L964
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L964
	strb	r3, [r2, #108]
.L961:
	ldr	r3, .L964
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L964
	str	r2, [r3, #72]
	ldr	r2, .L964
	ldr	r3, .L964
	str	r3, [r2, #104]
	ldr	r3, .L964
	ldr	r2, [r3, #104]
	ldr	r3, .L964
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L965:
	.align	2
.L964:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_i12v, .-_Z10fx_add_i12v
	.align	2
	.type	_Z10fx_add_i13v, %function
_Z10fx_add_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L970
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #13
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L970+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L970
	str	r2, [r3, #124]
	ldr	r3, .L970
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #13
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #13
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L970
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L970
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L970
	str	r2, [r3, #120]
	ldr	r3, .L970
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L970
	str	r2, [r3, #60]
	ldr	r3, .L970
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L970
	ldr	r2, [r3, #100]
	ldr	r3, .L970+8
	cmp	r2, r3
	bne	.L967
	ldr	r3, .L970
	ldr	r2, [r3, #468]
	ldr	r3, .L970
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L970
	strb	r3, [r2, #108]
.L967:
	ldr	r3, .L970
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L970
	str	r2, [r3, #72]
	ldr	r2, .L970
	ldr	r3, .L970
	str	r3, [r2, #104]
	ldr	r3, .L970
	ldr	r2, [r3, #104]
	ldr	r3, .L970
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L971:
	.align	2
.L970:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_i13v, .-_Z10fx_add_i13v
	.align	2
	.type	_Z10fx_add_i14v, %function
_Z10fx_add_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L976
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #14
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L976+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L976
	str	r2, [r3, #124]
	ldr	r3, .L976
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #14
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #14
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L976
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L976
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L976
	str	r2, [r3, #120]
	ldr	r3, .L976
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L976
	str	r2, [r3, #60]
	ldr	r3, .L976
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L976
	ldr	r2, [r3, #100]
	ldr	r3, .L976+8
	cmp	r2, r3
	bne	.L973
	ldr	r3, .L976
	ldr	r2, [r3, #468]
	ldr	r3, .L976
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L976
	strb	r3, [r2, #108]
.L973:
	ldr	r3, .L976
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L976
	str	r2, [r3, #72]
	ldr	r2, .L976
	ldr	r3, .L976
	str	r3, [r2, #104]
	ldr	r3, .L976
	ldr	r2, [r3, #104]
	ldr	r3, .L976
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L977:
	.align	2
.L976:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_i14v, .-_Z10fx_add_i14v
	.align	2
	.type	_Z10fx_add_i15v, %function
_Z10fx_add_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L982
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #15
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L982+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L982
	str	r2, [r3, #124]
	ldr	r3, .L982
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #15
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #15
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L982
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L982
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L982
	str	r2, [r3, #120]
	ldr	r3, .L982
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L982
	str	r2, [r3, #60]
	ldr	r3, .L982
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L982
	ldr	r2, [r3, #100]
	ldr	r3, .L982+8
	cmp	r2, r3
	bne	.L979
	ldr	r3, .L982
	ldr	r2, [r3, #468]
	ldr	r3, .L982
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L982
	strb	r3, [r2, #108]
.L979:
	ldr	r3, .L982
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L982
	str	r2, [r3, #72]
	ldr	r2, .L982
	ldr	r3, .L982
	str	r3, [r2, #104]
	ldr	r3, .L982
	ldr	r2, [r3, #104]
	ldr	r3, .L982
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L983:
	.align	2
.L982:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_add_i15v, .-_Z10fx_add_i15v
	.align	2
	.type	_Z9fx_adc_i0v, %function
_Z9fx_adc_i0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L988
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L988
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L988+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L988
	str	r2, [r3, #124]
	ldr	r3, .L988
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mvn	r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L988
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L988
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L988
	str	r2, [r3, #120]
	ldr	r3, .L988
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L988
	str	r2, [r3, #60]
	ldr	r3, .L988
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L988
	ldr	r2, [r3, #100]
	ldr	r3, .L988+8
	cmp	r2, r3
	bne	.L985
	ldr	r3, .L988
	ldr	r2, [r3, #468]
	ldr	r3, .L988
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L988
	strb	r3, [r2, #108]
.L985:
	ldr	r3, .L988
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L988
	str	r2, [r3, #72]
	ldr	r2, .L988
	ldr	r3, .L988
	str	r3, [r2, #104]
	ldr	r3, .L988
	ldr	r2, [r3, #104]
	ldr	r3, .L988
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L989:
	.align	2
.L988:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i0v, .-_Z9fx_adc_i0v
	.align	2
	.type	_Z9fx_adc_i1v, %function
_Z9fx_adc_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L994
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #1
	ldr	r3, .L994
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L994+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L994
	str	r2, [r3, #124]
	ldr	r3, .L994
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #1
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #1
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L994
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L994
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L994
	str	r2, [r3, #120]
	ldr	r3, .L994
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L994
	str	r2, [r3, #60]
	ldr	r3, .L994
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L994
	ldr	r2, [r3, #100]
	ldr	r3, .L994+8
	cmp	r2, r3
	bne	.L991
	ldr	r3, .L994
	ldr	r2, [r3, #468]
	ldr	r3, .L994
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L994
	strb	r3, [r2, #108]
.L991:
	ldr	r3, .L994
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L994
	str	r2, [r3, #72]
	ldr	r2, .L994
	ldr	r3, .L994
	str	r3, [r2, #104]
	ldr	r3, .L994
	ldr	r2, [r3, #104]
	ldr	r3, .L994
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L995:
	.align	2
.L994:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i1v, .-_Z9fx_adc_i1v
	.align	2
	.type	_Z9fx_adc_i2v, %function
_Z9fx_adc_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1000
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #2
	ldr	r3, .L1000
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1000+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1000
	str	r2, [r3, #124]
	ldr	r3, .L1000
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #2
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #2
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1000
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1000
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1000
	str	r2, [r3, #120]
	ldr	r3, .L1000
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1000
	str	r2, [r3, #60]
	ldr	r3, .L1000
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1000
	ldr	r2, [r3, #100]
	ldr	r3, .L1000+8
	cmp	r2, r3
	bne	.L997
	ldr	r3, .L1000
	ldr	r2, [r3, #468]
	ldr	r3, .L1000
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1000
	strb	r3, [r2, #108]
.L997:
	ldr	r3, .L1000
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1000
	str	r2, [r3, #72]
	ldr	r2, .L1000
	ldr	r3, .L1000
	str	r3, [r2, #104]
	ldr	r3, .L1000
	ldr	r2, [r3, #104]
	ldr	r3, .L1000
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1001:
	.align	2
.L1000:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i2v, .-_Z9fx_adc_i2v
	.align	2
	.type	_Z9fx_adc_i3v, %function
_Z9fx_adc_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1006
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #3
	ldr	r3, .L1006
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1006+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1006
	str	r2, [r3, #124]
	ldr	r3, .L1006
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #3
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #3
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1006
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1006
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1006
	str	r2, [r3, #120]
	ldr	r3, .L1006
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1006
	str	r2, [r3, #60]
	ldr	r3, .L1006
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1006
	ldr	r2, [r3, #100]
	ldr	r3, .L1006+8
	cmp	r2, r3
	bne	.L1003
	ldr	r3, .L1006
	ldr	r2, [r3, #468]
	ldr	r3, .L1006
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1006
	strb	r3, [r2, #108]
.L1003:
	ldr	r3, .L1006
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1006
	str	r2, [r3, #72]
	ldr	r2, .L1006
	ldr	r3, .L1006
	str	r3, [r2, #104]
	ldr	r3, .L1006
	ldr	r2, [r3, #104]
	ldr	r3, .L1006
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1007:
	.align	2
.L1006:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i3v, .-_Z9fx_adc_i3v
	.align	2
	.type	_Z9fx_adc_i4v, %function
_Z9fx_adc_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1012
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #4
	ldr	r3, .L1012
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1012+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1012
	str	r2, [r3, #124]
	ldr	r3, .L1012
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #4
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1012
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1012
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1012
	str	r2, [r3, #120]
	ldr	r3, .L1012
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1012
	str	r2, [r3, #60]
	ldr	r3, .L1012
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1012
	ldr	r2, [r3, #100]
	ldr	r3, .L1012+8
	cmp	r2, r3
	bne	.L1009
	ldr	r3, .L1012
	ldr	r2, [r3, #468]
	ldr	r3, .L1012
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1012
	strb	r3, [r2, #108]
.L1009:
	ldr	r3, .L1012
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1012
	str	r2, [r3, #72]
	ldr	r2, .L1012
	ldr	r3, .L1012
	str	r3, [r2, #104]
	ldr	r3, .L1012
	ldr	r2, [r3, #104]
	ldr	r3, .L1012
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1013:
	.align	2
.L1012:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i4v, .-_Z9fx_adc_i4v
	.align	2
	.type	_Z9fx_adc_i5v, %function
_Z9fx_adc_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1018
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #5
	ldr	r3, .L1018
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1018+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1018
	str	r2, [r3, #124]
	ldr	r3, .L1018
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #5
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #5
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1018
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1018
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1018
	str	r2, [r3, #120]
	ldr	r3, .L1018
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1018
	str	r2, [r3, #60]
	ldr	r3, .L1018
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1018
	ldr	r2, [r3, #100]
	ldr	r3, .L1018+8
	cmp	r2, r3
	bne	.L1015
	ldr	r3, .L1018
	ldr	r2, [r3, #468]
	ldr	r3, .L1018
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1018
	strb	r3, [r2, #108]
.L1015:
	ldr	r3, .L1018
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1018
	str	r2, [r3, #72]
	ldr	r2, .L1018
	ldr	r3, .L1018
	str	r3, [r2, #104]
	ldr	r3, .L1018
	ldr	r2, [r3, #104]
	ldr	r3, .L1018
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1019:
	.align	2
.L1018:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i5v, .-_Z9fx_adc_i5v
	.align	2
	.type	_Z9fx_adc_i6v, %function
_Z9fx_adc_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1024
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #6
	ldr	r3, .L1024
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1024+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1024
	str	r2, [r3, #124]
	ldr	r3, .L1024
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #6
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #6
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1024
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1024
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1024
	str	r2, [r3, #120]
	ldr	r3, .L1024
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1024
	str	r2, [r3, #60]
	ldr	r3, .L1024
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1024
	ldr	r2, [r3, #100]
	ldr	r3, .L1024+8
	cmp	r2, r3
	bne	.L1021
	ldr	r3, .L1024
	ldr	r2, [r3, #468]
	ldr	r3, .L1024
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1024
	strb	r3, [r2, #108]
.L1021:
	ldr	r3, .L1024
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1024
	str	r2, [r3, #72]
	ldr	r2, .L1024
	ldr	r3, .L1024
	str	r3, [r2, #104]
	ldr	r3, .L1024
	ldr	r2, [r3, #104]
	ldr	r3, .L1024
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1025:
	.align	2
.L1024:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i6v, .-_Z9fx_adc_i6v
	.align	2
	.type	_Z9fx_adc_i7v, %function
_Z9fx_adc_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1030
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #7
	ldr	r3, .L1030
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1030+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1030
	str	r2, [r3, #124]
	ldr	r3, .L1030
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #7
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #7
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1030
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1030
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1030
	str	r2, [r3, #120]
	ldr	r3, .L1030
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1030
	str	r2, [r3, #60]
	ldr	r3, .L1030
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1030
	ldr	r2, [r3, #100]
	ldr	r3, .L1030+8
	cmp	r2, r3
	bne	.L1027
	ldr	r3, .L1030
	ldr	r2, [r3, #468]
	ldr	r3, .L1030
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1030
	strb	r3, [r2, #108]
.L1027:
	ldr	r3, .L1030
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1030
	str	r2, [r3, #72]
	ldr	r2, .L1030
	ldr	r3, .L1030
	str	r3, [r2, #104]
	ldr	r3, .L1030
	ldr	r2, [r3, #104]
	ldr	r3, .L1030
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1031:
	.align	2
.L1030:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i7v, .-_Z9fx_adc_i7v
	.align	2
	.type	_Z9fx_adc_i8v, %function
_Z9fx_adc_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1036
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #8
	ldr	r3, .L1036
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1036+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1036
	str	r2, [r3, #124]
	ldr	r3, .L1036
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #8
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #8
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1036
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1036
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1036
	str	r2, [r3, #120]
	ldr	r3, .L1036
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1036
	str	r2, [r3, #60]
	ldr	r3, .L1036
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1036
	ldr	r2, [r3, #100]
	ldr	r3, .L1036+8
	cmp	r2, r3
	bne	.L1033
	ldr	r3, .L1036
	ldr	r2, [r3, #468]
	ldr	r3, .L1036
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1036
	strb	r3, [r2, #108]
.L1033:
	ldr	r3, .L1036
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1036
	str	r2, [r3, #72]
	ldr	r2, .L1036
	ldr	r3, .L1036
	str	r3, [r2, #104]
	ldr	r3, .L1036
	ldr	r2, [r3, #104]
	ldr	r3, .L1036
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1037:
	.align	2
.L1036:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i8v, .-_Z9fx_adc_i8v
	.align	2
	.type	_Z9fx_adc_i9v, %function
_Z9fx_adc_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1042
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #9
	ldr	r3, .L1042
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1042+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1042
	str	r2, [r3, #124]
	ldr	r3, .L1042
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #9
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #9
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1042
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1042
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1042
	str	r2, [r3, #120]
	ldr	r3, .L1042
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1042
	str	r2, [r3, #60]
	ldr	r3, .L1042
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1042
	ldr	r2, [r3, #100]
	ldr	r3, .L1042+8
	cmp	r2, r3
	bne	.L1039
	ldr	r3, .L1042
	ldr	r2, [r3, #468]
	ldr	r3, .L1042
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1042
	strb	r3, [r2, #108]
.L1039:
	ldr	r3, .L1042
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1042
	str	r2, [r3, #72]
	ldr	r2, .L1042
	ldr	r3, .L1042
	str	r3, [r2, #104]
	ldr	r3, .L1042
	ldr	r2, [r3, #104]
	ldr	r3, .L1042
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1043:
	.align	2
.L1042:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z9fx_adc_i9v, .-_Z9fx_adc_i9v
	.align	2
	.type	_Z10fx_adc_i10v, %function
_Z10fx_adc_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1048
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #10
	ldr	r3, .L1048
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1048+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1048
	str	r2, [r3, #124]
	ldr	r3, .L1048
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #10
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #10
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1048
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1048
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1048
	str	r2, [r3, #120]
	ldr	r3, .L1048
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1048
	str	r2, [r3, #60]
	ldr	r3, .L1048
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1048
	ldr	r2, [r3, #100]
	ldr	r3, .L1048+8
	cmp	r2, r3
	bne	.L1045
	ldr	r3, .L1048
	ldr	r2, [r3, #468]
	ldr	r3, .L1048
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1048
	strb	r3, [r2, #108]
.L1045:
	ldr	r3, .L1048
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1048
	str	r2, [r3, #72]
	ldr	r2, .L1048
	ldr	r3, .L1048
	str	r3, [r2, #104]
	ldr	r3, .L1048
	ldr	r2, [r3, #104]
	ldr	r3, .L1048
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1049:
	.align	2
.L1048:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_i10v, .-_Z10fx_adc_i10v
	.align	2
	.type	_Z10fx_adc_i11v, %function
_Z10fx_adc_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1054
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #11
	ldr	r3, .L1054
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1054+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1054
	str	r2, [r3, #124]
	ldr	r3, .L1054
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #11
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #11
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1054
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1054
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1054
	str	r2, [r3, #120]
	ldr	r3, .L1054
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1054
	str	r2, [r3, #60]
	ldr	r3, .L1054
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1054
	ldr	r2, [r3, #100]
	ldr	r3, .L1054+8
	cmp	r2, r3
	bne	.L1051
	ldr	r3, .L1054
	ldr	r2, [r3, #468]
	ldr	r3, .L1054
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1054
	strb	r3, [r2, #108]
.L1051:
	ldr	r3, .L1054
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1054
	str	r2, [r3, #72]
	ldr	r2, .L1054
	ldr	r3, .L1054
	str	r3, [r2, #104]
	ldr	r3, .L1054
	ldr	r2, [r3, #104]
	ldr	r3, .L1054
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1055:
	.align	2
.L1054:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_i11v, .-_Z10fx_adc_i11v
	.align	2
	.type	_Z10fx_adc_i12v, %function
_Z10fx_adc_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1060
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #12
	ldr	r3, .L1060
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1060+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1060
	str	r2, [r3, #124]
	ldr	r3, .L1060
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #12
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #12
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1060
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1060
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1060
	str	r2, [r3, #120]
	ldr	r3, .L1060
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1060
	str	r2, [r3, #60]
	ldr	r3, .L1060
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1060
	ldr	r2, [r3, #100]
	ldr	r3, .L1060+8
	cmp	r2, r3
	bne	.L1057
	ldr	r3, .L1060
	ldr	r2, [r3, #468]
	ldr	r3, .L1060
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1060
	strb	r3, [r2, #108]
.L1057:
	ldr	r3, .L1060
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1060
	str	r2, [r3, #72]
	ldr	r2, .L1060
	ldr	r3, .L1060
	str	r3, [r2, #104]
	ldr	r3, .L1060
	ldr	r2, [r3, #104]
	ldr	r3, .L1060
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1061:
	.align	2
.L1060:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_i12v, .-_Z10fx_adc_i12v
	.align	2
	.type	_Z10fx_adc_i13v, %function
_Z10fx_adc_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1066
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #13
	ldr	r3, .L1066
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1066+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1066
	str	r2, [r3, #124]
	ldr	r3, .L1066
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #13
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #13
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1066
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1066
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1066
	str	r2, [r3, #120]
	ldr	r3, .L1066
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1066
	str	r2, [r3, #60]
	ldr	r3, .L1066
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1066
	ldr	r2, [r3, #100]
	ldr	r3, .L1066+8
	cmp	r2, r3
	bne	.L1063
	ldr	r3, .L1066
	ldr	r2, [r3, #468]
	ldr	r3, .L1066
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1066
	strb	r3, [r2, #108]
.L1063:
	ldr	r3, .L1066
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1066
	str	r2, [r3, #72]
	ldr	r2, .L1066
	ldr	r3, .L1066
	str	r3, [r2, #104]
	ldr	r3, .L1066
	ldr	r2, [r3, #104]
	ldr	r3, .L1066
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1067:
	.align	2
.L1066:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_i13v, .-_Z10fx_adc_i13v
	.align	2
	.type	_Z10fx_adc_i14v, %function
_Z10fx_adc_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1072
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #14
	ldr	r3, .L1072
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1072+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1072
	str	r2, [r3, #124]
	ldr	r3, .L1072
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #14
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #14
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1072
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1072
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1072
	str	r2, [r3, #120]
	ldr	r3, .L1072
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1072
	str	r2, [r3, #60]
	ldr	r3, .L1072
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1072
	ldr	r2, [r3, #100]
	ldr	r3, .L1072+8
	cmp	r2, r3
	bne	.L1069
	ldr	r3, .L1072
	ldr	r2, [r3, #468]
	ldr	r3, .L1072
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1072
	strb	r3, [r2, #108]
.L1069:
	ldr	r3, .L1072
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1072
	str	r2, [r3, #72]
	ldr	r2, .L1072
	ldr	r3, .L1072
	str	r3, [r2, #104]
	ldr	r3, .L1072
	ldr	r2, [r3, #104]
	ldr	r3, .L1072
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1073:
	.align	2
.L1072:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_i14v, .-_Z10fx_adc_i14v
	.align	2
	.type	_Z10fx_adc_i15v, %function
_Z10fx_adc_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1078
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r3, #15
	ldr	r3, .L1078
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1078+4
	cmp	r2, r3
	movle	r2, #0
	movgt	r2, #1
	ldr	r3, .L1078
	str	r2, [r3, #124]
	ldr	r3, .L1078
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	mvn	r3, #15
	eor	r2, r2, r3
	ldr	r3, [fp, #-16]
	eor	r3, r3, #15
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1078
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1078
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1078
	str	r2, [r3, #120]
	ldr	r3, .L1078
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1078
	str	r2, [r3, #60]
	ldr	r3, .L1078
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1078
	ldr	r2, [r3, #100]
	ldr	r3, .L1078+8
	cmp	r2, r3
	bne	.L1075
	ldr	r3, .L1078
	ldr	r2, [r3, #468]
	ldr	r3, .L1078
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1078
	strb	r3, [r2, #108]
.L1075:
	ldr	r3, .L1078
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1078
	str	r2, [r3, #72]
	ldr	r2, .L1078
	ldr	r3, .L1078
	str	r3, [r2, #104]
	ldr	r3, .L1078
	ldr	r2, [r3, #104]
	ldr	r3, .L1078
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1079:
	.align	2
.L1078:
	.word	GSU
	.word	65535
	.word	GSU+56
	.size	_Z10fx_adc_i15v, .-_Z10fx_adc_i15v
	.align	2
	.type	_Z9fx_sub_r0v, %function
_Z9fx_sub_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1084
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1084
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1084
	str	r2, [r3, #124]
	ldr	r3, .L1084
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1084
	ldr	r3, [r3, #0]
	eor	r1, r2, r3
	ldr	r3, .L1084
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1084
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1084
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1084
	str	r2, [r3, #120]
	ldr	r3, .L1084
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1084
	str	r2, [r3, #60]
	ldr	r3, .L1084
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1084
	ldr	r2, [r3, #100]
	ldr	r3, .L1084+4
	cmp	r2, r3
	bne	.L1081
	ldr	r3, .L1084
	ldr	r2, [r3, #468]
	ldr	r3, .L1084
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1084
	strb	r3, [r2, #108]
.L1081:
	ldr	r3, .L1084
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1084
	str	r2, [r3, #72]
	ldr	r2, .L1084
	ldr	r3, .L1084
	str	r3, [r2, #104]
	ldr	r3, .L1084
	ldr	r2, [r3, #104]
	ldr	r3, .L1084
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1085:
	.align	2
.L1084:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r0v, .-_Z9fx_sub_r0v
	.align	2
	.type	_Z9fx_sub_r1v, %function
_Z9fx_sub_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1090
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1090
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1090
	str	r2, [r3, #124]
	ldr	r3, .L1090
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1090
	ldr	r3, [r3, #4]
	eor	r1, r2, r3
	ldr	r3, .L1090
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1090
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1090
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1090
	str	r2, [r3, #120]
	ldr	r3, .L1090
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1090
	str	r2, [r3, #60]
	ldr	r3, .L1090
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1090
	ldr	r2, [r3, #100]
	ldr	r3, .L1090+4
	cmp	r2, r3
	bne	.L1087
	ldr	r3, .L1090
	ldr	r2, [r3, #468]
	ldr	r3, .L1090
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1090
	strb	r3, [r2, #108]
.L1087:
	ldr	r3, .L1090
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1090
	str	r2, [r3, #72]
	ldr	r2, .L1090
	ldr	r3, .L1090
	str	r3, [r2, #104]
	ldr	r3, .L1090
	ldr	r2, [r3, #104]
	ldr	r3, .L1090
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1091:
	.align	2
.L1090:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r1v, .-_Z9fx_sub_r1v
	.align	2
	.type	_Z9fx_sub_r2v, %function
_Z9fx_sub_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1096
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1096
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1096
	str	r2, [r3, #124]
	ldr	r3, .L1096
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1096
	ldr	r3, [r3, #8]
	eor	r1, r2, r3
	ldr	r3, .L1096
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1096
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1096
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1096
	str	r2, [r3, #120]
	ldr	r3, .L1096
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1096
	str	r2, [r3, #60]
	ldr	r3, .L1096
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1096
	ldr	r2, [r3, #100]
	ldr	r3, .L1096+4
	cmp	r2, r3
	bne	.L1093
	ldr	r3, .L1096
	ldr	r2, [r3, #468]
	ldr	r3, .L1096
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1096
	strb	r3, [r2, #108]
.L1093:
	ldr	r3, .L1096
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1096
	str	r2, [r3, #72]
	ldr	r2, .L1096
	ldr	r3, .L1096
	str	r3, [r2, #104]
	ldr	r3, .L1096
	ldr	r2, [r3, #104]
	ldr	r3, .L1096
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1097:
	.align	2
.L1096:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r2v, .-_Z9fx_sub_r2v
	.align	2
	.type	_Z9fx_sub_r3v, %function
_Z9fx_sub_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1102
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1102
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1102
	str	r2, [r3, #124]
	ldr	r3, .L1102
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1102
	ldr	r3, [r3, #12]
	eor	r1, r2, r3
	ldr	r3, .L1102
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1102
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1102
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1102
	str	r2, [r3, #120]
	ldr	r3, .L1102
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1102
	str	r2, [r3, #60]
	ldr	r3, .L1102
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1102
	ldr	r2, [r3, #100]
	ldr	r3, .L1102+4
	cmp	r2, r3
	bne	.L1099
	ldr	r3, .L1102
	ldr	r2, [r3, #468]
	ldr	r3, .L1102
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1102
	strb	r3, [r2, #108]
.L1099:
	ldr	r3, .L1102
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1102
	str	r2, [r3, #72]
	ldr	r2, .L1102
	ldr	r3, .L1102
	str	r3, [r2, #104]
	ldr	r3, .L1102
	ldr	r2, [r3, #104]
	ldr	r3, .L1102
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1103:
	.align	2
.L1102:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r3v, .-_Z9fx_sub_r3v
	.align	2
	.type	_Z9fx_sub_r4v, %function
_Z9fx_sub_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1108
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1108
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1108
	str	r2, [r3, #124]
	ldr	r3, .L1108
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1108
	ldr	r3, [r3, #16]
	eor	r1, r2, r3
	ldr	r3, .L1108
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1108
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1108
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1108
	str	r2, [r3, #120]
	ldr	r3, .L1108
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1108
	str	r2, [r3, #60]
	ldr	r3, .L1108
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1108
	ldr	r2, [r3, #100]
	ldr	r3, .L1108+4
	cmp	r2, r3
	bne	.L1105
	ldr	r3, .L1108
	ldr	r2, [r3, #468]
	ldr	r3, .L1108
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1108
	strb	r3, [r2, #108]
.L1105:
	ldr	r3, .L1108
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1108
	str	r2, [r3, #72]
	ldr	r2, .L1108
	ldr	r3, .L1108
	str	r3, [r2, #104]
	ldr	r3, .L1108
	ldr	r2, [r3, #104]
	ldr	r3, .L1108
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1109:
	.align	2
.L1108:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r4v, .-_Z9fx_sub_r4v
	.align	2
	.type	_Z9fx_sub_r5v, %function
_Z9fx_sub_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1114
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1114
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1114
	str	r2, [r3, #124]
	ldr	r3, .L1114
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1114
	ldr	r3, [r3, #20]
	eor	r1, r2, r3
	ldr	r3, .L1114
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1114
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1114
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1114
	str	r2, [r3, #120]
	ldr	r3, .L1114
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1114
	str	r2, [r3, #60]
	ldr	r3, .L1114
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1114
	ldr	r2, [r3, #100]
	ldr	r3, .L1114+4
	cmp	r2, r3
	bne	.L1111
	ldr	r3, .L1114
	ldr	r2, [r3, #468]
	ldr	r3, .L1114
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1114
	strb	r3, [r2, #108]
.L1111:
	ldr	r3, .L1114
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1114
	str	r2, [r3, #72]
	ldr	r2, .L1114
	ldr	r3, .L1114
	str	r3, [r2, #104]
	ldr	r3, .L1114
	ldr	r2, [r3, #104]
	ldr	r3, .L1114
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1115:
	.align	2
.L1114:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r5v, .-_Z9fx_sub_r5v
	.align	2
	.type	_Z9fx_sub_r6v, %function
_Z9fx_sub_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1120
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1120
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1120
	str	r2, [r3, #124]
	ldr	r3, .L1120
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1120
	ldr	r3, [r3, #24]
	eor	r1, r2, r3
	ldr	r3, .L1120
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1120
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1120
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1120
	str	r2, [r3, #120]
	ldr	r3, .L1120
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1120
	str	r2, [r3, #60]
	ldr	r3, .L1120
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1120
	ldr	r2, [r3, #100]
	ldr	r3, .L1120+4
	cmp	r2, r3
	bne	.L1117
	ldr	r3, .L1120
	ldr	r2, [r3, #468]
	ldr	r3, .L1120
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1120
	strb	r3, [r2, #108]
.L1117:
	ldr	r3, .L1120
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1120
	str	r2, [r3, #72]
	ldr	r2, .L1120
	ldr	r3, .L1120
	str	r3, [r2, #104]
	ldr	r3, .L1120
	ldr	r2, [r3, #104]
	ldr	r3, .L1120
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1121:
	.align	2
.L1120:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r6v, .-_Z9fx_sub_r6v
	.align	2
	.type	_Z9fx_sub_r7v, %function
_Z9fx_sub_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1126
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1126
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1126
	str	r2, [r3, #124]
	ldr	r3, .L1126
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1126
	ldr	r3, [r3, #28]
	eor	r1, r2, r3
	ldr	r3, .L1126
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1126
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1126
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1126
	str	r2, [r3, #120]
	ldr	r3, .L1126
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1126
	str	r2, [r3, #60]
	ldr	r3, .L1126
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1126
	ldr	r2, [r3, #100]
	ldr	r3, .L1126+4
	cmp	r2, r3
	bne	.L1123
	ldr	r3, .L1126
	ldr	r2, [r3, #468]
	ldr	r3, .L1126
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1126
	strb	r3, [r2, #108]
.L1123:
	ldr	r3, .L1126
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1126
	str	r2, [r3, #72]
	ldr	r2, .L1126
	ldr	r3, .L1126
	str	r3, [r2, #104]
	ldr	r3, .L1126
	ldr	r2, [r3, #104]
	ldr	r3, .L1126
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1127:
	.align	2
.L1126:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r7v, .-_Z9fx_sub_r7v
	.align	2
	.type	_Z9fx_sub_r8v, %function
_Z9fx_sub_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1132
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1132
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1132
	str	r2, [r3, #124]
	ldr	r3, .L1132
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1132
	ldr	r3, [r3, #32]
	eor	r1, r2, r3
	ldr	r3, .L1132
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1132
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1132
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1132
	str	r2, [r3, #120]
	ldr	r3, .L1132
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1132
	str	r2, [r3, #60]
	ldr	r3, .L1132
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1132
	ldr	r2, [r3, #100]
	ldr	r3, .L1132+4
	cmp	r2, r3
	bne	.L1129
	ldr	r3, .L1132
	ldr	r2, [r3, #468]
	ldr	r3, .L1132
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1132
	strb	r3, [r2, #108]
.L1129:
	ldr	r3, .L1132
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1132
	str	r2, [r3, #72]
	ldr	r2, .L1132
	ldr	r3, .L1132
	str	r3, [r2, #104]
	ldr	r3, .L1132
	ldr	r2, [r3, #104]
	ldr	r3, .L1132
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1133:
	.align	2
.L1132:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r8v, .-_Z9fx_sub_r8v
	.align	2
	.type	_Z9fx_sub_r9v, %function
_Z9fx_sub_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1138
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1138
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1138
	str	r2, [r3, #124]
	ldr	r3, .L1138
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1138
	ldr	r3, [r3, #36]
	eor	r1, r2, r3
	ldr	r3, .L1138
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1138
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1138
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1138
	str	r2, [r3, #120]
	ldr	r3, .L1138
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1138
	str	r2, [r3, #60]
	ldr	r3, .L1138
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1138
	ldr	r2, [r3, #100]
	ldr	r3, .L1138+4
	cmp	r2, r3
	bne	.L1135
	ldr	r3, .L1138
	ldr	r2, [r3, #468]
	ldr	r3, .L1138
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1138
	strb	r3, [r2, #108]
.L1135:
	ldr	r3, .L1138
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1138
	str	r2, [r3, #72]
	ldr	r2, .L1138
	ldr	r3, .L1138
	str	r3, [r2, #104]
	ldr	r3, .L1138
	ldr	r2, [r3, #104]
	ldr	r3, .L1138
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1139:
	.align	2
.L1138:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_r9v, .-_Z9fx_sub_r9v
	.align	2
	.type	_Z10fx_sub_r10v, %function
_Z10fx_sub_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1144
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1144
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1144
	str	r2, [r3, #124]
	ldr	r3, .L1144
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1144
	ldr	r3, [r3, #40]
	eor	r1, r2, r3
	ldr	r3, .L1144
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1144
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1144
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1144
	str	r2, [r3, #120]
	ldr	r3, .L1144
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1144
	str	r2, [r3, #60]
	ldr	r3, .L1144
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1144
	ldr	r2, [r3, #100]
	ldr	r3, .L1144+4
	cmp	r2, r3
	bne	.L1141
	ldr	r3, .L1144
	ldr	r2, [r3, #468]
	ldr	r3, .L1144
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1144
	strb	r3, [r2, #108]
.L1141:
	ldr	r3, .L1144
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1144
	str	r2, [r3, #72]
	ldr	r2, .L1144
	ldr	r3, .L1144
	str	r3, [r2, #104]
	ldr	r3, .L1144
	ldr	r2, [r3, #104]
	ldr	r3, .L1144
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1145:
	.align	2
.L1144:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_r10v, .-_Z10fx_sub_r10v
	.align	2
	.type	_Z10fx_sub_r11v, %function
_Z10fx_sub_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1150
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1150
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1150
	str	r2, [r3, #124]
	ldr	r3, .L1150
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1150
	ldr	r3, [r3, #44]
	eor	r1, r2, r3
	ldr	r3, .L1150
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1150
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1150
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1150
	str	r2, [r3, #120]
	ldr	r3, .L1150
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1150
	str	r2, [r3, #60]
	ldr	r3, .L1150
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1150
	ldr	r2, [r3, #100]
	ldr	r3, .L1150+4
	cmp	r2, r3
	bne	.L1147
	ldr	r3, .L1150
	ldr	r2, [r3, #468]
	ldr	r3, .L1150
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1150
	strb	r3, [r2, #108]
.L1147:
	ldr	r3, .L1150
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1150
	str	r2, [r3, #72]
	ldr	r2, .L1150
	ldr	r3, .L1150
	str	r3, [r2, #104]
	ldr	r3, .L1150
	ldr	r2, [r3, #104]
	ldr	r3, .L1150
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1151:
	.align	2
.L1150:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_r11v, .-_Z10fx_sub_r11v
	.align	2
	.type	_Z10fx_sub_r12v, %function
_Z10fx_sub_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1156
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1156
	ldr	r3, [r3, #48]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1156
	str	r2, [r3, #124]
	ldr	r3, .L1156
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1156
	ldr	r3, [r3, #48]
	eor	r1, r2, r3
	ldr	r3, .L1156
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1156
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1156
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1156
	str	r2, [r3, #120]
	ldr	r3, .L1156
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1156
	str	r2, [r3, #60]
	ldr	r3, .L1156
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1156
	ldr	r2, [r3, #100]
	ldr	r3, .L1156+4
	cmp	r2, r3
	bne	.L1153
	ldr	r3, .L1156
	ldr	r2, [r3, #468]
	ldr	r3, .L1156
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1156
	strb	r3, [r2, #108]
.L1153:
	ldr	r3, .L1156
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1156
	str	r2, [r3, #72]
	ldr	r2, .L1156
	ldr	r3, .L1156
	str	r3, [r2, #104]
	ldr	r3, .L1156
	ldr	r2, [r3, #104]
	ldr	r3, .L1156
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1157:
	.align	2
.L1156:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_r12v, .-_Z10fx_sub_r12v
	.align	2
	.type	_Z10fx_sub_r13v, %function
_Z10fx_sub_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1162
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1162
	ldr	r3, [r3, #52]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1162
	str	r2, [r3, #124]
	ldr	r3, .L1162
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1162
	ldr	r3, [r3, #52]
	eor	r1, r2, r3
	ldr	r3, .L1162
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1162
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1162
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1162
	str	r2, [r3, #120]
	ldr	r3, .L1162
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1162
	str	r2, [r3, #60]
	ldr	r3, .L1162
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1162
	ldr	r2, [r3, #100]
	ldr	r3, .L1162+4
	cmp	r2, r3
	bne	.L1159
	ldr	r3, .L1162
	ldr	r2, [r3, #468]
	ldr	r3, .L1162
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1162
	strb	r3, [r2, #108]
.L1159:
	ldr	r3, .L1162
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1162
	str	r2, [r3, #72]
	ldr	r2, .L1162
	ldr	r3, .L1162
	str	r3, [r2, #104]
	ldr	r3, .L1162
	ldr	r2, [r3, #104]
	ldr	r3, .L1162
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1163:
	.align	2
.L1162:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_r13v, .-_Z10fx_sub_r13v
	.align	2
	.type	_Z10fx_sub_r14v, %function
_Z10fx_sub_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1168
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1168
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1168
	str	r2, [r3, #124]
	ldr	r3, .L1168
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1168
	ldr	r3, [r3, #56]
	eor	r1, r2, r3
	ldr	r3, .L1168
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1168
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1168
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1168
	str	r2, [r3, #120]
	ldr	r3, .L1168
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1168
	str	r2, [r3, #60]
	ldr	r3, .L1168
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1168
	ldr	r2, [r3, #100]
	ldr	r3, .L1168+4
	cmp	r2, r3
	bne	.L1165
	ldr	r3, .L1168
	ldr	r2, [r3, #468]
	ldr	r3, .L1168
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1168
	strb	r3, [r2, #108]
.L1165:
	ldr	r3, .L1168
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1168
	str	r2, [r3, #72]
	ldr	r2, .L1168
	ldr	r3, .L1168
	str	r3, [r2, #104]
	ldr	r3, .L1168
	ldr	r2, [r3, #104]
	ldr	r3, .L1168
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1169:
	.align	2
.L1168:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_r14v, .-_Z10fx_sub_r14v
	.align	2
	.type	_Z10fx_sub_r15v, %function
_Z10fx_sub_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1174
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1174
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1174
	str	r2, [r3, #124]
	ldr	r3, .L1174
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1174
	ldr	r3, [r3, #60]
	eor	r1, r2, r3
	ldr	r3, .L1174
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1174
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1174
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1174
	str	r2, [r3, #120]
	ldr	r3, .L1174
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1174
	str	r2, [r3, #60]
	ldr	r3, .L1174
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1174
	ldr	r2, [r3, #100]
	ldr	r3, .L1174+4
	cmp	r2, r3
	bne	.L1171
	ldr	r3, .L1174
	ldr	r2, [r3, #468]
	ldr	r3, .L1174
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1174
	strb	r3, [r2, #108]
.L1171:
	ldr	r3, .L1174
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1174
	str	r2, [r3, #72]
	ldr	r2, .L1174
	ldr	r3, .L1174
	str	r3, [r2, #104]
	ldr	r3, .L1174
	ldr	r2, [r3, #104]
	ldr	r3, .L1174
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1175:
	.align	2
.L1174:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_r15v, .-_Z10fx_sub_r15v
	.align	2
	.type	_Z9fx_sbc_r0v, %function
_Z9fx_sbc_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1180
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1180
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1180
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1180
	str	r2, [r3, #124]
	ldr	r3, .L1180
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1180
	ldr	r3, [r3, #0]
	eor	r1, r2, r3
	ldr	r3, .L1180
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1180
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1180
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1180
	str	r2, [r3, #120]
	ldr	r3, .L1180
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1180
	str	r2, [r3, #60]
	ldr	r3, .L1180
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1180
	ldr	r2, [r3, #100]
	ldr	r3, .L1180+4
	cmp	r2, r3
	bne	.L1177
	ldr	r3, .L1180
	ldr	r2, [r3, #468]
	ldr	r3, .L1180
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1180
	strb	r3, [r2, #108]
.L1177:
	ldr	r3, .L1180
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1180
	str	r2, [r3, #72]
	ldr	r2, .L1180
	ldr	r3, .L1180
	str	r3, [r2, #104]
	ldr	r3, .L1180
	ldr	r2, [r3, #104]
	ldr	r3, .L1180
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1181:
	.align	2
.L1180:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r0v, .-_Z9fx_sbc_r0v
	.align	2
	.type	_Z9fx_sbc_r1v, %function
_Z9fx_sbc_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1186
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1186
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1186
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1186
	str	r2, [r3, #124]
	ldr	r3, .L1186
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1186
	ldr	r3, [r3, #4]
	eor	r1, r2, r3
	ldr	r3, .L1186
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1186
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1186
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1186
	str	r2, [r3, #120]
	ldr	r3, .L1186
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1186
	str	r2, [r3, #60]
	ldr	r3, .L1186
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1186
	ldr	r2, [r3, #100]
	ldr	r3, .L1186+4
	cmp	r2, r3
	bne	.L1183
	ldr	r3, .L1186
	ldr	r2, [r3, #468]
	ldr	r3, .L1186
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1186
	strb	r3, [r2, #108]
.L1183:
	ldr	r3, .L1186
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1186
	str	r2, [r3, #72]
	ldr	r2, .L1186
	ldr	r3, .L1186
	str	r3, [r2, #104]
	ldr	r3, .L1186
	ldr	r2, [r3, #104]
	ldr	r3, .L1186
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1187:
	.align	2
.L1186:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r1v, .-_Z9fx_sbc_r1v
	.align	2
	.type	_Z9fx_sbc_r2v, %function
_Z9fx_sbc_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1192
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1192
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1192
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1192
	str	r2, [r3, #124]
	ldr	r3, .L1192
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1192
	ldr	r3, [r3, #8]
	eor	r1, r2, r3
	ldr	r3, .L1192
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1192
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1192
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1192
	str	r2, [r3, #120]
	ldr	r3, .L1192
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1192
	str	r2, [r3, #60]
	ldr	r3, .L1192
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1192
	ldr	r2, [r3, #100]
	ldr	r3, .L1192+4
	cmp	r2, r3
	bne	.L1189
	ldr	r3, .L1192
	ldr	r2, [r3, #468]
	ldr	r3, .L1192
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1192
	strb	r3, [r2, #108]
.L1189:
	ldr	r3, .L1192
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1192
	str	r2, [r3, #72]
	ldr	r2, .L1192
	ldr	r3, .L1192
	str	r3, [r2, #104]
	ldr	r3, .L1192
	ldr	r2, [r3, #104]
	ldr	r3, .L1192
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1193:
	.align	2
.L1192:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r2v, .-_Z9fx_sbc_r2v
	.align	2
	.type	_Z9fx_sbc_r3v, %function
_Z9fx_sbc_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1198
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1198
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1198
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1198
	str	r2, [r3, #124]
	ldr	r3, .L1198
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1198
	ldr	r3, [r3, #12]
	eor	r1, r2, r3
	ldr	r3, .L1198
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1198
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1198
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1198
	str	r2, [r3, #120]
	ldr	r3, .L1198
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1198
	str	r2, [r3, #60]
	ldr	r3, .L1198
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1198
	ldr	r2, [r3, #100]
	ldr	r3, .L1198+4
	cmp	r2, r3
	bne	.L1195
	ldr	r3, .L1198
	ldr	r2, [r3, #468]
	ldr	r3, .L1198
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1198
	strb	r3, [r2, #108]
.L1195:
	ldr	r3, .L1198
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1198
	str	r2, [r3, #72]
	ldr	r2, .L1198
	ldr	r3, .L1198
	str	r3, [r2, #104]
	ldr	r3, .L1198
	ldr	r2, [r3, #104]
	ldr	r3, .L1198
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1199:
	.align	2
.L1198:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r3v, .-_Z9fx_sbc_r3v
	.align	2
	.type	_Z9fx_sbc_r4v, %function
_Z9fx_sbc_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1204
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1204
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1204
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1204
	str	r2, [r3, #124]
	ldr	r3, .L1204
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1204
	ldr	r3, [r3, #16]
	eor	r1, r2, r3
	ldr	r3, .L1204
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1204
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1204
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1204
	str	r2, [r3, #120]
	ldr	r3, .L1204
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1204
	str	r2, [r3, #60]
	ldr	r3, .L1204
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1204
	ldr	r2, [r3, #100]
	ldr	r3, .L1204+4
	cmp	r2, r3
	bne	.L1201
	ldr	r3, .L1204
	ldr	r2, [r3, #468]
	ldr	r3, .L1204
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1204
	strb	r3, [r2, #108]
.L1201:
	ldr	r3, .L1204
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1204
	str	r2, [r3, #72]
	ldr	r2, .L1204
	ldr	r3, .L1204
	str	r3, [r2, #104]
	ldr	r3, .L1204
	ldr	r2, [r3, #104]
	ldr	r3, .L1204
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1205:
	.align	2
.L1204:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r4v, .-_Z9fx_sbc_r4v
	.align	2
	.type	_Z9fx_sbc_r5v, %function
_Z9fx_sbc_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1210
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1210
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1210
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1210
	str	r2, [r3, #124]
	ldr	r3, .L1210
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1210
	ldr	r3, [r3, #20]
	eor	r1, r2, r3
	ldr	r3, .L1210
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1210
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1210
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1210
	str	r2, [r3, #120]
	ldr	r3, .L1210
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1210
	str	r2, [r3, #60]
	ldr	r3, .L1210
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1210
	ldr	r2, [r3, #100]
	ldr	r3, .L1210+4
	cmp	r2, r3
	bne	.L1207
	ldr	r3, .L1210
	ldr	r2, [r3, #468]
	ldr	r3, .L1210
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1210
	strb	r3, [r2, #108]
.L1207:
	ldr	r3, .L1210
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1210
	str	r2, [r3, #72]
	ldr	r2, .L1210
	ldr	r3, .L1210
	str	r3, [r2, #104]
	ldr	r3, .L1210
	ldr	r2, [r3, #104]
	ldr	r3, .L1210
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1211:
	.align	2
.L1210:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r5v, .-_Z9fx_sbc_r5v
	.align	2
	.type	_Z9fx_sbc_r6v, %function
_Z9fx_sbc_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1216
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1216
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1216
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1216
	str	r2, [r3, #124]
	ldr	r3, .L1216
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1216
	ldr	r3, [r3, #24]
	eor	r1, r2, r3
	ldr	r3, .L1216
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1216
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1216
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1216
	str	r2, [r3, #120]
	ldr	r3, .L1216
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1216
	str	r2, [r3, #60]
	ldr	r3, .L1216
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1216
	ldr	r2, [r3, #100]
	ldr	r3, .L1216+4
	cmp	r2, r3
	bne	.L1213
	ldr	r3, .L1216
	ldr	r2, [r3, #468]
	ldr	r3, .L1216
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1216
	strb	r3, [r2, #108]
.L1213:
	ldr	r3, .L1216
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1216
	str	r2, [r3, #72]
	ldr	r2, .L1216
	ldr	r3, .L1216
	str	r3, [r2, #104]
	ldr	r3, .L1216
	ldr	r2, [r3, #104]
	ldr	r3, .L1216
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1217:
	.align	2
.L1216:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r6v, .-_Z9fx_sbc_r6v
	.align	2
	.type	_Z9fx_sbc_r7v, %function
_Z9fx_sbc_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1222
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1222
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1222
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1222
	str	r2, [r3, #124]
	ldr	r3, .L1222
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1222
	ldr	r3, [r3, #28]
	eor	r1, r2, r3
	ldr	r3, .L1222
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1222
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1222
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1222
	str	r2, [r3, #120]
	ldr	r3, .L1222
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1222
	str	r2, [r3, #60]
	ldr	r3, .L1222
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1222
	ldr	r2, [r3, #100]
	ldr	r3, .L1222+4
	cmp	r2, r3
	bne	.L1219
	ldr	r3, .L1222
	ldr	r2, [r3, #468]
	ldr	r3, .L1222
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1222
	strb	r3, [r2, #108]
.L1219:
	ldr	r3, .L1222
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1222
	str	r2, [r3, #72]
	ldr	r2, .L1222
	ldr	r3, .L1222
	str	r3, [r2, #104]
	ldr	r3, .L1222
	ldr	r2, [r3, #104]
	ldr	r3, .L1222
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1223:
	.align	2
.L1222:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r7v, .-_Z9fx_sbc_r7v
	.align	2
	.type	_Z9fx_sbc_r8v, %function
_Z9fx_sbc_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1228
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1228
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1228
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1228
	str	r2, [r3, #124]
	ldr	r3, .L1228
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1228
	ldr	r3, [r3, #32]
	eor	r1, r2, r3
	ldr	r3, .L1228
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1228
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1228
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1228
	str	r2, [r3, #120]
	ldr	r3, .L1228
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1228
	str	r2, [r3, #60]
	ldr	r3, .L1228
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1228
	ldr	r2, [r3, #100]
	ldr	r3, .L1228+4
	cmp	r2, r3
	bne	.L1225
	ldr	r3, .L1228
	ldr	r2, [r3, #468]
	ldr	r3, .L1228
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1228
	strb	r3, [r2, #108]
.L1225:
	ldr	r3, .L1228
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1228
	str	r2, [r3, #72]
	ldr	r2, .L1228
	ldr	r3, .L1228
	str	r3, [r2, #104]
	ldr	r3, .L1228
	ldr	r2, [r3, #104]
	ldr	r3, .L1228
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1229:
	.align	2
.L1228:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r8v, .-_Z9fx_sbc_r8v
	.align	2
	.type	_Z9fx_sbc_r9v, %function
_Z9fx_sbc_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1234
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1234
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1234
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1234
	str	r2, [r3, #124]
	ldr	r3, .L1234
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1234
	ldr	r3, [r3, #36]
	eor	r1, r2, r3
	ldr	r3, .L1234
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1234
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1234
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1234
	str	r2, [r3, #120]
	ldr	r3, .L1234
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1234
	str	r2, [r3, #60]
	ldr	r3, .L1234
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1234
	ldr	r2, [r3, #100]
	ldr	r3, .L1234+4
	cmp	r2, r3
	bne	.L1231
	ldr	r3, .L1234
	ldr	r2, [r3, #468]
	ldr	r3, .L1234
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1234
	strb	r3, [r2, #108]
.L1231:
	ldr	r3, .L1234
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1234
	str	r2, [r3, #72]
	ldr	r2, .L1234
	ldr	r3, .L1234
	str	r3, [r2, #104]
	ldr	r3, .L1234
	ldr	r2, [r3, #104]
	ldr	r3, .L1234
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1235:
	.align	2
.L1234:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sbc_r9v, .-_Z9fx_sbc_r9v
	.align	2
	.type	_Z10fx_sbc_r10v, %function
_Z10fx_sbc_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1240
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1240
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1240
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1240
	str	r2, [r3, #124]
	ldr	r3, .L1240
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1240
	ldr	r3, [r3, #40]
	eor	r1, r2, r3
	ldr	r3, .L1240
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1240
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1240
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1240
	str	r2, [r3, #120]
	ldr	r3, .L1240
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1240
	str	r2, [r3, #60]
	ldr	r3, .L1240
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1240
	ldr	r2, [r3, #100]
	ldr	r3, .L1240+4
	cmp	r2, r3
	bne	.L1237
	ldr	r3, .L1240
	ldr	r2, [r3, #468]
	ldr	r3, .L1240
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1240
	strb	r3, [r2, #108]
.L1237:
	ldr	r3, .L1240
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1240
	str	r2, [r3, #72]
	ldr	r2, .L1240
	ldr	r3, .L1240
	str	r3, [r2, #104]
	ldr	r3, .L1240
	ldr	r2, [r3, #104]
	ldr	r3, .L1240
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1241:
	.align	2
.L1240:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sbc_r10v, .-_Z10fx_sbc_r10v
	.align	2
	.type	_Z10fx_sbc_r11v, %function
_Z10fx_sbc_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1246
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1246
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1246
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1246
	str	r2, [r3, #124]
	ldr	r3, .L1246
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1246
	ldr	r3, [r3, #44]
	eor	r1, r2, r3
	ldr	r3, .L1246
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1246
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1246
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1246
	str	r2, [r3, #120]
	ldr	r3, .L1246
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1246
	str	r2, [r3, #60]
	ldr	r3, .L1246
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1246
	ldr	r2, [r3, #100]
	ldr	r3, .L1246+4
	cmp	r2, r3
	bne	.L1243
	ldr	r3, .L1246
	ldr	r2, [r3, #468]
	ldr	r3, .L1246
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1246
	strb	r3, [r2, #108]
.L1243:
	ldr	r3, .L1246
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1246
	str	r2, [r3, #72]
	ldr	r2, .L1246
	ldr	r3, .L1246
	str	r3, [r2, #104]
	ldr	r3, .L1246
	ldr	r2, [r3, #104]
	ldr	r3, .L1246
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1247:
	.align	2
.L1246:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sbc_r11v, .-_Z10fx_sbc_r11v
	.align	2
	.type	_Z10fx_sbc_r12v, %function
_Z10fx_sbc_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1252
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1252
	ldr	r3, [r3, #48]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1252
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1252
	str	r2, [r3, #124]
	ldr	r3, .L1252
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1252
	ldr	r3, [r3, #48]
	eor	r1, r2, r3
	ldr	r3, .L1252
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1252
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1252
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1252
	str	r2, [r3, #120]
	ldr	r3, .L1252
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1252
	str	r2, [r3, #60]
	ldr	r3, .L1252
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1252
	ldr	r2, [r3, #100]
	ldr	r3, .L1252+4
	cmp	r2, r3
	bne	.L1249
	ldr	r3, .L1252
	ldr	r2, [r3, #468]
	ldr	r3, .L1252
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1252
	strb	r3, [r2, #108]
.L1249:
	ldr	r3, .L1252
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1252
	str	r2, [r3, #72]
	ldr	r2, .L1252
	ldr	r3, .L1252
	str	r3, [r2, #104]
	ldr	r3, .L1252
	ldr	r2, [r3, #104]
	ldr	r3, .L1252
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1253:
	.align	2
.L1252:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sbc_r12v, .-_Z10fx_sbc_r12v
	.align	2
	.type	_Z10fx_sbc_r13v, %function
_Z10fx_sbc_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1258
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1258
	ldr	r3, [r3, #52]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1258
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1258
	str	r2, [r3, #124]
	ldr	r3, .L1258
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1258
	ldr	r3, [r3, #52]
	eor	r1, r2, r3
	ldr	r3, .L1258
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1258
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1258
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1258
	str	r2, [r3, #120]
	ldr	r3, .L1258
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1258
	str	r2, [r3, #60]
	ldr	r3, .L1258
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1258
	ldr	r2, [r3, #100]
	ldr	r3, .L1258+4
	cmp	r2, r3
	bne	.L1255
	ldr	r3, .L1258
	ldr	r2, [r3, #468]
	ldr	r3, .L1258
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1258
	strb	r3, [r2, #108]
.L1255:
	ldr	r3, .L1258
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1258
	str	r2, [r3, #72]
	ldr	r2, .L1258
	ldr	r3, .L1258
	str	r3, [r2, #104]
	ldr	r3, .L1258
	ldr	r2, [r3, #104]
	ldr	r3, .L1258
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1259:
	.align	2
.L1258:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sbc_r13v, .-_Z10fx_sbc_r13v
	.align	2
	.type	_Z10fx_sbc_r14v, %function
_Z10fx_sbc_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1264
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1264
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1264
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1264
	str	r2, [r3, #124]
	ldr	r3, .L1264
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1264
	ldr	r3, [r3, #56]
	eor	r1, r2, r3
	ldr	r3, .L1264
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1264
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1264
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1264
	str	r2, [r3, #120]
	ldr	r3, .L1264
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1264
	str	r2, [r3, #60]
	ldr	r3, .L1264
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1264
	ldr	r2, [r3, #100]
	ldr	r3, .L1264+4
	cmp	r2, r3
	bne	.L1261
	ldr	r3, .L1264
	ldr	r2, [r3, #468]
	ldr	r3, .L1264
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1264
	strb	r3, [r2, #108]
.L1261:
	ldr	r3, .L1264
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1264
	str	r2, [r3, #72]
	ldr	r2, .L1264
	ldr	r3, .L1264
	str	r3, [r2, #104]
	ldr	r3, .L1264
	ldr	r2, [r3, #104]
	ldr	r3, .L1264
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1265:
	.align	2
.L1264:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sbc_r14v, .-_Z10fx_sbc_r14v
	.align	2
	.type	_Z10fx_sbc_r15v, %function
_Z10fx_sbc_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1270
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1270
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r2, r3, r2
	ldr	r3, .L1270
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1270
	str	r2, [r3, #124]
	ldr	r3, .L1270
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1270
	ldr	r3, [r3, #60]
	eor	r1, r2, r3
	ldr	r3, .L1270
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1270
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1270
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1270
	str	r2, [r3, #120]
	ldr	r3, .L1270
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1270
	str	r2, [r3, #60]
	ldr	r3, .L1270
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1270
	ldr	r2, [r3, #100]
	ldr	r3, .L1270+4
	cmp	r2, r3
	bne	.L1267
	ldr	r3, .L1270
	ldr	r2, [r3, #468]
	ldr	r3, .L1270
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1270
	strb	r3, [r2, #108]
.L1267:
	ldr	r3, .L1270
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1270
	str	r2, [r3, #72]
	ldr	r2, .L1270
	ldr	r3, .L1270
	str	r3, [r2, #104]
	ldr	r3, .L1270
	ldr	r2, [r3, #104]
	ldr	r3, .L1270
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1271:
	.align	2
.L1270:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sbc_r15v, .-_Z10fx_sbc_r15v
	.align	2
	.type	_Z9fx_sub_i0v, %function
_Z9fx_sub_i0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1276
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1276
	str	r2, [r3, #124]
	ldr	r3, .L1276
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	and	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1276
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1276
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1276
	str	r2, [r3, #120]
	ldr	r3, .L1276
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1276
	str	r2, [r3, #60]
	ldr	r3, .L1276
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1276
	ldr	r2, [r3, #100]
	ldr	r3, .L1276+4
	cmp	r2, r3
	bne	.L1273
	ldr	r3, .L1276
	ldr	r2, [r3, #468]
	ldr	r3, .L1276
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1276
	strb	r3, [r2, #108]
.L1273:
	ldr	r3, .L1276
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1276
	str	r2, [r3, #72]
	ldr	r2, .L1276
	ldr	r3, .L1276
	str	r3, [r2, #104]
	ldr	r3, .L1276
	ldr	r2, [r3, #104]
	ldr	r3, .L1276
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1277:
	.align	2
.L1276:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i0v, .-_Z9fx_sub_i0v
	.align	2
	.type	_Z9fx_sub_i1v, %function
_Z9fx_sub_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1282
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1282
	str	r2, [r3, #124]
	ldr	r3, .L1282
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #1
	ldr	r3, .L1282
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1282
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1282
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1282
	str	r2, [r3, #120]
	ldr	r3, .L1282
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1282
	str	r2, [r3, #60]
	ldr	r3, .L1282
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1282
	ldr	r2, [r3, #100]
	ldr	r3, .L1282+4
	cmp	r2, r3
	bne	.L1279
	ldr	r3, .L1282
	ldr	r2, [r3, #468]
	ldr	r3, .L1282
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1282
	strb	r3, [r2, #108]
.L1279:
	ldr	r3, .L1282
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1282
	str	r2, [r3, #72]
	ldr	r2, .L1282
	ldr	r3, .L1282
	str	r3, [r2, #104]
	ldr	r3, .L1282
	ldr	r2, [r3, #104]
	ldr	r3, .L1282
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1283:
	.align	2
.L1282:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i1v, .-_Z9fx_sub_i1v
	.align	2
	.type	_Z9fx_sub_i2v, %function
_Z9fx_sub_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1288
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1288
	str	r2, [r3, #124]
	ldr	r3, .L1288
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #2
	ldr	r3, .L1288
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1288
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1288
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1288
	str	r2, [r3, #120]
	ldr	r3, .L1288
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1288
	str	r2, [r3, #60]
	ldr	r3, .L1288
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1288
	ldr	r2, [r3, #100]
	ldr	r3, .L1288+4
	cmp	r2, r3
	bne	.L1285
	ldr	r3, .L1288
	ldr	r2, [r3, #468]
	ldr	r3, .L1288
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1288
	strb	r3, [r2, #108]
.L1285:
	ldr	r3, .L1288
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1288
	str	r2, [r3, #72]
	ldr	r2, .L1288
	ldr	r3, .L1288
	str	r3, [r2, #104]
	ldr	r3, .L1288
	ldr	r2, [r3, #104]
	ldr	r3, .L1288
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1289:
	.align	2
.L1288:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i2v, .-_Z9fx_sub_i2v
	.align	2
	.type	_Z9fx_sub_i3v, %function
_Z9fx_sub_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1294
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1294
	str	r2, [r3, #124]
	ldr	r3, .L1294
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #3
	ldr	r3, .L1294
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1294
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1294
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1294
	str	r2, [r3, #120]
	ldr	r3, .L1294
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1294
	str	r2, [r3, #60]
	ldr	r3, .L1294
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1294
	ldr	r2, [r3, #100]
	ldr	r3, .L1294+4
	cmp	r2, r3
	bne	.L1291
	ldr	r3, .L1294
	ldr	r2, [r3, #468]
	ldr	r3, .L1294
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1294
	strb	r3, [r2, #108]
.L1291:
	ldr	r3, .L1294
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1294
	str	r2, [r3, #72]
	ldr	r2, .L1294
	ldr	r3, .L1294
	str	r3, [r2, #104]
	ldr	r3, .L1294
	ldr	r2, [r3, #104]
	ldr	r3, .L1294
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1295:
	.align	2
.L1294:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i3v, .-_Z9fx_sub_i3v
	.align	2
	.type	_Z9fx_sub_i4v, %function
_Z9fx_sub_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1300
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #4
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1300
	str	r2, [r3, #124]
	ldr	r3, .L1300
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #4
	ldr	r3, .L1300
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1300
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1300
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1300
	str	r2, [r3, #120]
	ldr	r3, .L1300
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1300
	str	r2, [r3, #60]
	ldr	r3, .L1300
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1300
	ldr	r2, [r3, #100]
	ldr	r3, .L1300+4
	cmp	r2, r3
	bne	.L1297
	ldr	r3, .L1300
	ldr	r2, [r3, #468]
	ldr	r3, .L1300
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1300
	strb	r3, [r2, #108]
.L1297:
	ldr	r3, .L1300
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1300
	str	r2, [r3, #72]
	ldr	r2, .L1300
	ldr	r3, .L1300
	str	r3, [r2, #104]
	ldr	r3, .L1300
	ldr	r2, [r3, #104]
	ldr	r3, .L1300
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1301:
	.align	2
.L1300:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i4v, .-_Z9fx_sub_i4v
	.align	2
	.type	_Z9fx_sub_i5v, %function
_Z9fx_sub_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1306
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #5
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1306
	str	r2, [r3, #124]
	ldr	r3, .L1306
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #5
	ldr	r3, .L1306
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1306
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1306
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1306
	str	r2, [r3, #120]
	ldr	r3, .L1306
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1306
	str	r2, [r3, #60]
	ldr	r3, .L1306
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1306
	ldr	r2, [r3, #100]
	ldr	r3, .L1306+4
	cmp	r2, r3
	bne	.L1303
	ldr	r3, .L1306
	ldr	r2, [r3, #468]
	ldr	r3, .L1306
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1306
	strb	r3, [r2, #108]
.L1303:
	ldr	r3, .L1306
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1306
	str	r2, [r3, #72]
	ldr	r2, .L1306
	ldr	r3, .L1306
	str	r3, [r2, #104]
	ldr	r3, .L1306
	ldr	r2, [r3, #104]
	ldr	r3, .L1306
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1307:
	.align	2
.L1306:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i5v, .-_Z9fx_sub_i5v
	.align	2
	.type	_Z9fx_sub_i6v, %function
_Z9fx_sub_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1312
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #6
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1312
	str	r2, [r3, #124]
	ldr	r3, .L1312
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #6
	ldr	r3, .L1312
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1312
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1312
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1312
	str	r2, [r3, #120]
	ldr	r3, .L1312
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1312
	str	r2, [r3, #60]
	ldr	r3, .L1312
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1312
	ldr	r2, [r3, #100]
	ldr	r3, .L1312+4
	cmp	r2, r3
	bne	.L1309
	ldr	r3, .L1312
	ldr	r2, [r3, #468]
	ldr	r3, .L1312
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1312
	strb	r3, [r2, #108]
.L1309:
	ldr	r3, .L1312
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1312
	str	r2, [r3, #72]
	ldr	r2, .L1312
	ldr	r3, .L1312
	str	r3, [r2, #104]
	ldr	r3, .L1312
	ldr	r2, [r3, #104]
	ldr	r3, .L1312
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1313:
	.align	2
.L1312:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i6v, .-_Z9fx_sub_i6v
	.align	2
	.type	_Z9fx_sub_i7v, %function
_Z9fx_sub_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1318
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #7
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1318
	str	r2, [r3, #124]
	ldr	r3, .L1318
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #7
	ldr	r3, .L1318
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1318
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1318
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1318
	str	r2, [r3, #120]
	ldr	r3, .L1318
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1318
	str	r2, [r3, #60]
	ldr	r3, .L1318
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1318
	ldr	r2, [r3, #100]
	ldr	r3, .L1318+4
	cmp	r2, r3
	bne	.L1315
	ldr	r3, .L1318
	ldr	r2, [r3, #468]
	ldr	r3, .L1318
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1318
	strb	r3, [r2, #108]
.L1315:
	ldr	r3, .L1318
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1318
	str	r2, [r3, #72]
	ldr	r2, .L1318
	ldr	r3, .L1318
	str	r3, [r2, #104]
	ldr	r3, .L1318
	ldr	r2, [r3, #104]
	ldr	r3, .L1318
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1319:
	.align	2
.L1318:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i7v, .-_Z9fx_sub_i7v
	.align	2
	.type	_Z9fx_sub_i8v, %function
_Z9fx_sub_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1324
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #8
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1324
	str	r2, [r3, #124]
	ldr	r3, .L1324
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #8
	ldr	r3, .L1324
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1324
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1324
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1324
	str	r2, [r3, #120]
	ldr	r3, .L1324
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1324
	str	r2, [r3, #60]
	ldr	r3, .L1324
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1324
	ldr	r2, [r3, #100]
	ldr	r3, .L1324+4
	cmp	r2, r3
	bne	.L1321
	ldr	r3, .L1324
	ldr	r2, [r3, #468]
	ldr	r3, .L1324
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1324
	strb	r3, [r2, #108]
.L1321:
	ldr	r3, .L1324
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1324
	str	r2, [r3, #72]
	ldr	r2, .L1324
	ldr	r3, .L1324
	str	r3, [r2, #104]
	ldr	r3, .L1324
	ldr	r2, [r3, #104]
	ldr	r3, .L1324
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1325:
	.align	2
.L1324:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i8v, .-_Z9fx_sub_i8v
	.align	2
	.type	_Z9fx_sub_i9v, %function
_Z9fx_sub_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1330
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #9
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1330
	str	r2, [r3, #124]
	ldr	r3, .L1330
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #9
	ldr	r3, .L1330
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1330
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1330
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1330
	str	r2, [r3, #120]
	ldr	r3, .L1330
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1330
	str	r2, [r3, #60]
	ldr	r3, .L1330
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1330
	ldr	r2, [r3, #100]
	ldr	r3, .L1330+4
	cmp	r2, r3
	bne	.L1327
	ldr	r3, .L1330
	ldr	r2, [r3, #468]
	ldr	r3, .L1330
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1330
	strb	r3, [r2, #108]
.L1327:
	ldr	r3, .L1330
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1330
	str	r2, [r3, #72]
	ldr	r2, .L1330
	ldr	r3, .L1330
	str	r3, [r2, #104]
	ldr	r3, .L1330
	ldr	r2, [r3, #104]
	ldr	r3, .L1330
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1331:
	.align	2
.L1330:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_sub_i9v, .-_Z9fx_sub_i9v
	.align	2
	.type	_Z10fx_sub_i10v, %function
_Z10fx_sub_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1336
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #10
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1336
	str	r2, [r3, #124]
	ldr	r3, .L1336
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #10
	ldr	r3, .L1336
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1336
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1336
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1336
	str	r2, [r3, #120]
	ldr	r3, .L1336
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1336
	str	r2, [r3, #60]
	ldr	r3, .L1336
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1336
	ldr	r2, [r3, #100]
	ldr	r3, .L1336+4
	cmp	r2, r3
	bne	.L1333
	ldr	r3, .L1336
	ldr	r2, [r3, #468]
	ldr	r3, .L1336
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1336
	strb	r3, [r2, #108]
.L1333:
	ldr	r3, .L1336
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1336
	str	r2, [r3, #72]
	ldr	r2, .L1336
	ldr	r3, .L1336
	str	r3, [r2, #104]
	ldr	r3, .L1336
	ldr	r2, [r3, #104]
	ldr	r3, .L1336
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1337:
	.align	2
.L1336:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_i10v, .-_Z10fx_sub_i10v
	.align	2
	.type	_Z10fx_sub_i11v, %function
_Z10fx_sub_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1342
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #11
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1342
	str	r2, [r3, #124]
	ldr	r3, .L1342
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #11
	ldr	r3, .L1342
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1342
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1342
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1342
	str	r2, [r3, #120]
	ldr	r3, .L1342
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1342
	str	r2, [r3, #60]
	ldr	r3, .L1342
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1342
	ldr	r2, [r3, #100]
	ldr	r3, .L1342+4
	cmp	r2, r3
	bne	.L1339
	ldr	r3, .L1342
	ldr	r2, [r3, #468]
	ldr	r3, .L1342
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1342
	strb	r3, [r2, #108]
.L1339:
	ldr	r3, .L1342
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1342
	str	r2, [r3, #72]
	ldr	r2, .L1342
	ldr	r3, .L1342
	str	r3, [r2, #104]
	ldr	r3, .L1342
	ldr	r2, [r3, #104]
	ldr	r3, .L1342
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1343:
	.align	2
.L1342:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_i11v, .-_Z10fx_sub_i11v
	.align	2
	.type	_Z10fx_sub_i12v, %function
_Z10fx_sub_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1348
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #12
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1348
	str	r2, [r3, #124]
	ldr	r3, .L1348
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #12
	ldr	r3, .L1348
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1348
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1348
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1348
	str	r2, [r3, #120]
	ldr	r3, .L1348
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1348
	str	r2, [r3, #60]
	ldr	r3, .L1348
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1348
	ldr	r2, [r3, #100]
	ldr	r3, .L1348+4
	cmp	r2, r3
	bne	.L1345
	ldr	r3, .L1348
	ldr	r2, [r3, #468]
	ldr	r3, .L1348
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1348
	strb	r3, [r2, #108]
.L1345:
	ldr	r3, .L1348
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1348
	str	r2, [r3, #72]
	ldr	r2, .L1348
	ldr	r3, .L1348
	str	r3, [r2, #104]
	ldr	r3, .L1348
	ldr	r2, [r3, #104]
	ldr	r3, .L1348
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1349:
	.align	2
.L1348:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_i12v, .-_Z10fx_sub_i12v
	.align	2
	.type	_Z10fx_sub_i13v, %function
_Z10fx_sub_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1354
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #13
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1354
	str	r2, [r3, #124]
	ldr	r3, .L1354
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #13
	ldr	r3, .L1354
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1354
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1354
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1354
	str	r2, [r3, #120]
	ldr	r3, .L1354
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1354
	str	r2, [r3, #60]
	ldr	r3, .L1354
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1354
	ldr	r2, [r3, #100]
	ldr	r3, .L1354+4
	cmp	r2, r3
	bne	.L1351
	ldr	r3, .L1354
	ldr	r2, [r3, #468]
	ldr	r3, .L1354
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1354
	strb	r3, [r2, #108]
.L1351:
	ldr	r3, .L1354
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1354
	str	r2, [r3, #72]
	ldr	r2, .L1354
	ldr	r3, .L1354
	str	r3, [r2, #104]
	ldr	r3, .L1354
	ldr	r2, [r3, #104]
	ldr	r3, .L1354
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1355:
	.align	2
.L1354:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_i13v, .-_Z10fx_sub_i13v
	.align	2
	.type	_Z10fx_sub_i14v, %function
_Z10fx_sub_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1360
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #14
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1360
	str	r2, [r3, #124]
	ldr	r3, .L1360
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #14
	ldr	r3, .L1360
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1360
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1360
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1360
	str	r2, [r3, #120]
	ldr	r3, .L1360
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1360
	str	r2, [r3, #60]
	ldr	r3, .L1360
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1360
	ldr	r2, [r3, #100]
	ldr	r3, .L1360+4
	cmp	r2, r3
	bne	.L1357
	ldr	r3, .L1360
	ldr	r2, [r3, #468]
	ldr	r3, .L1360
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1360
	strb	r3, [r2, #108]
.L1357:
	ldr	r3, .L1360
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1360
	str	r2, [r3, #72]
	ldr	r2, .L1360
	ldr	r3, .L1360
	str	r3, [r2, #104]
	ldr	r3, .L1360
	ldr	r2, [r3, #104]
	ldr	r3, .L1360
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1361:
	.align	2
.L1360:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_i14v, .-_Z10fx_sub_i14v
	.align	2
	.type	_Z10fx_sub_i15v, %function
_Z10fx_sub_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1366
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	sub	r3, r3, #15
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1366
	str	r2, [r3, #124]
	ldr	r3, .L1366
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r1, r3, #15
	ldr	r3, .L1366
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1366
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1366
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1366
	str	r2, [r3, #120]
	ldr	r3, .L1366
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1366
	str	r2, [r3, #60]
	ldr	r3, .L1366
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L1366
	ldr	r2, [r3, #100]
	ldr	r3, .L1366+4
	cmp	r2, r3
	bne	.L1363
	ldr	r3, .L1366
	ldr	r2, [r3, #468]
	ldr	r3, .L1366
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1366
	strb	r3, [r2, #108]
.L1363:
	ldr	r3, .L1366
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1366
	str	r2, [r3, #72]
	ldr	r2, .L1366
	ldr	r3, .L1366
	str	r3, [r2, #104]
	ldr	r3, .L1366
	ldr	r2, [r3, #104]
	ldr	r3, .L1366
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1367:
	.align	2
.L1366:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_sub_i15v, .-_Z10fx_sub_i15v
	.align	2
	.type	_Z9fx_cmp_r0v, %function
_Z9fx_cmp_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1370
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1370
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1370
	str	r2, [r3, #124]
	ldr	r3, .L1370
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1370
	ldr	r3, [r3, #0]
	eor	r1, r2, r3
	ldr	r3, .L1370
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1370
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1370
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1370
	str	r2, [r3, #120]
	ldr	r3, .L1370
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1370
	str	r2, [r3, #60]
	ldr	r3, .L1370
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1370
	str	r2, [r3, #72]
	ldr	r2, .L1370
	ldr	r3, .L1370
	str	r3, [r2, #104]
	ldr	r3, .L1370
	ldr	r2, [r3, #104]
	ldr	r3, .L1370
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1371:
	.align	2
.L1370:
	.word	GSU
	.size	_Z9fx_cmp_r0v, .-_Z9fx_cmp_r0v
	.align	2
	.type	_Z9fx_cmp_r1v, %function
_Z9fx_cmp_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1374
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1374
	ldr	r3, [r3, #4]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1374
	str	r2, [r3, #124]
	ldr	r3, .L1374
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1374
	ldr	r3, [r3, #4]
	eor	r1, r2, r3
	ldr	r3, .L1374
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1374
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1374
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1374
	str	r2, [r3, #120]
	ldr	r3, .L1374
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1374
	str	r2, [r3, #60]
	ldr	r3, .L1374
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1374
	str	r2, [r3, #72]
	ldr	r2, .L1374
	ldr	r3, .L1374
	str	r3, [r2, #104]
	ldr	r3, .L1374
	ldr	r2, [r3, #104]
	ldr	r3, .L1374
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1375:
	.align	2
.L1374:
	.word	GSU
	.size	_Z9fx_cmp_r1v, .-_Z9fx_cmp_r1v
	.align	2
	.type	_Z9fx_cmp_r2v, %function
_Z9fx_cmp_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1378
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1378
	ldr	r3, [r3, #8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1378
	str	r2, [r3, #124]
	ldr	r3, .L1378
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1378
	ldr	r3, [r3, #8]
	eor	r1, r2, r3
	ldr	r3, .L1378
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1378
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1378
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1378
	str	r2, [r3, #120]
	ldr	r3, .L1378
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1378
	str	r2, [r3, #60]
	ldr	r3, .L1378
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1378
	str	r2, [r3, #72]
	ldr	r2, .L1378
	ldr	r3, .L1378
	str	r3, [r2, #104]
	ldr	r3, .L1378
	ldr	r2, [r3, #104]
	ldr	r3, .L1378
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1379:
	.align	2
.L1378:
	.word	GSU
	.size	_Z9fx_cmp_r2v, .-_Z9fx_cmp_r2v
	.align	2
	.type	_Z9fx_cmp_r3v, %function
_Z9fx_cmp_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1382
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1382
	ldr	r3, [r3, #12]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1382
	str	r2, [r3, #124]
	ldr	r3, .L1382
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1382
	ldr	r3, [r3, #12]
	eor	r1, r2, r3
	ldr	r3, .L1382
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1382
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1382
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1382
	str	r2, [r3, #120]
	ldr	r3, .L1382
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1382
	str	r2, [r3, #60]
	ldr	r3, .L1382
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1382
	str	r2, [r3, #72]
	ldr	r2, .L1382
	ldr	r3, .L1382
	str	r3, [r2, #104]
	ldr	r3, .L1382
	ldr	r2, [r3, #104]
	ldr	r3, .L1382
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1383:
	.align	2
.L1382:
	.word	GSU
	.size	_Z9fx_cmp_r3v, .-_Z9fx_cmp_r3v
	.align	2
	.type	_Z9fx_cmp_r4v, %function
_Z9fx_cmp_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1386
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1386
	ldr	r3, [r3, #16]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1386
	str	r2, [r3, #124]
	ldr	r3, .L1386
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1386
	ldr	r3, [r3, #16]
	eor	r1, r2, r3
	ldr	r3, .L1386
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1386
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1386
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1386
	str	r2, [r3, #120]
	ldr	r3, .L1386
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1386
	str	r2, [r3, #60]
	ldr	r3, .L1386
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1386
	str	r2, [r3, #72]
	ldr	r2, .L1386
	ldr	r3, .L1386
	str	r3, [r2, #104]
	ldr	r3, .L1386
	ldr	r2, [r3, #104]
	ldr	r3, .L1386
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1387:
	.align	2
.L1386:
	.word	GSU
	.size	_Z9fx_cmp_r4v, .-_Z9fx_cmp_r4v
	.align	2
	.type	_Z9fx_cmp_r5v, %function
_Z9fx_cmp_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1390
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1390
	ldr	r3, [r3, #20]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1390
	str	r2, [r3, #124]
	ldr	r3, .L1390
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1390
	ldr	r3, [r3, #20]
	eor	r1, r2, r3
	ldr	r3, .L1390
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1390
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1390
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1390
	str	r2, [r3, #120]
	ldr	r3, .L1390
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1390
	str	r2, [r3, #60]
	ldr	r3, .L1390
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1390
	str	r2, [r3, #72]
	ldr	r2, .L1390
	ldr	r3, .L1390
	str	r3, [r2, #104]
	ldr	r3, .L1390
	ldr	r2, [r3, #104]
	ldr	r3, .L1390
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1391:
	.align	2
.L1390:
	.word	GSU
	.size	_Z9fx_cmp_r5v, .-_Z9fx_cmp_r5v
	.align	2
	.type	_Z9fx_cmp_r6v, %function
_Z9fx_cmp_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1394
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1394
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1394
	str	r2, [r3, #124]
	ldr	r3, .L1394
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1394
	ldr	r3, [r3, #24]
	eor	r1, r2, r3
	ldr	r3, .L1394
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1394
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1394
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1394
	str	r2, [r3, #120]
	ldr	r3, .L1394
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1394
	str	r2, [r3, #60]
	ldr	r3, .L1394
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1394
	str	r2, [r3, #72]
	ldr	r2, .L1394
	ldr	r3, .L1394
	str	r3, [r2, #104]
	ldr	r3, .L1394
	ldr	r2, [r3, #104]
	ldr	r3, .L1394
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1395:
	.align	2
.L1394:
	.word	GSU
	.size	_Z9fx_cmp_r6v, .-_Z9fx_cmp_r6v
	.align	2
	.type	_Z9fx_cmp_r7v, %function
_Z9fx_cmp_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1398
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1398
	ldr	r3, [r3, #28]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1398
	str	r2, [r3, #124]
	ldr	r3, .L1398
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1398
	ldr	r3, [r3, #28]
	eor	r1, r2, r3
	ldr	r3, .L1398
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1398
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1398
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1398
	str	r2, [r3, #120]
	ldr	r3, .L1398
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1398
	str	r2, [r3, #60]
	ldr	r3, .L1398
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1398
	str	r2, [r3, #72]
	ldr	r2, .L1398
	ldr	r3, .L1398
	str	r3, [r2, #104]
	ldr	r3, .L1398
	ldr	r2, [r3, #104]
	ldr	r3, .L1398
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1399:
	.align	2
.L1398:
	.word	GSU
	.size	_Z9fx_cmp_r7v, .-_Z9fx_cmp_r7v
	.align	2
	.type	_Z9fx_cmp_r8v, %function
_Z9fx_cmp_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1402
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1402
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1402
	str	r2, [r3, #124]
	ldr	r3, .L1402
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1402
	ldr	r3, [r3, #32]
	eor	r1, r2, r3
	ldr	r3, .L1402
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1402
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1402
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1402
	str	r2, [r3, #120]
	ldr	r3, .L1402
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1402
	str	r2, [r3, #60]
	ldr	r3, .L1402
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1402
	str	r2, [r3, #72]
	ldr	r2, .L1402
	ldr	r3, .L1402
	str	r3, [r2, #104]
	ldr	r3, .L1402
	ldr	r2, [r3, #104]
	ldr	r3, .L1402
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1403:
	.align	2
.L1402:
	.word	GSU
	.size	_Z9fx_cmp_r8v, .-_Z9fx_cmp_r8v
	.align	2
	.type	_Z9fx_cmp_r9v, %function
_Z9fx_cmp_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1406
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1406
	ldr	r3, [r3, #36]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1406
	str	r2, [r3, #124]
	ldr	r3, .L1406
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1406
	ldr	r3, [r3, #36]
	eor	r1, r2, r3
	ldr	r3, .L1406
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1406
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1406
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1406
	str	r2, [r3, #120]
	ldr	r3, .L1406
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1406
	str	r2, [r3, #60]
	ldr	r3, .L1406
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1406
	str	r2, [r3, #72]
	ldr	r2, .L1406
	ldr	r3, .L1406
	str	r3, [r2, #104]
	ldr	r3, .L1406
	ldr	r2, [r3, #104]
	ldr	r3, .L1406
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1407:
	.align	2
.L1406:
	.word	GSU
	.size	_Z9fx_cmp_r9v, .-_Z9fx_cmp_r9v
	.align	2
	.type	_Z10fx_cmp_r10v, %function
_Z10fx_cmp_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1410
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1410
	ldr	r3, [r3, #40]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1410
	str	r2, [r3, #124]
	ldr	r3, .L1410
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1410
	ldr	r3, [r3, #40]
	eor	r1, r2, r3
	ldr	r3, .L1410
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1410
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1410
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1410
	str	r2, [r3, #120]
	ldr	r3, .L1410
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1410
	str	r2, [r3, #60]
	ldr	r3, .L1410
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1410
	str	r2, [r3, #72]
	ldr	r2, .L1410
	ldr	r3, .L1410
	str	r3, [r2, #104]
	ldr	r3, .L1410
	ldr	r2, [r3, #104]
	ldr	r3, .L1410
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1411:
	.align	2
.L1410:
	.word	GSU
	.size	_Z10fx_cmp_r10v, .-_Z10fx_cmp_r10v
	.align	2
	.type	_Z10fx_cmp_r11v, %function
_Z10fx_cmp_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1414
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1414
	ldr	r3, [r3, #44]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1414
	str	r2, [r3, #124]
	ldr	r3, .L1414
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1414
	ldr	r3, [r3, #44]
	eor	r1, r2, r3
	ldr	r3, .L1414
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1414
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1414
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1414
	str	r2, [r3, #120]
	ldr	r3, .L1414
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1414
	str	r2, [r3, #60]
	ldr	r3, .L1414
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1414
	str	r2, [r3, #72]
	ldr	r2, .L1414
	ldr	r3, .L1414
	str	r3, [r2, #104]
	ldr	r3, .L1414
	ldr	r2, [r3, #104]
	ldr	r3, .L1414
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1415:
	.align	2
.L1414:
	.word	GSU
	.size	_Z10fx_cmp_r11v, .-_Z10fx_cmp_r11v
	.align	2
	.type	_Z10fx_cmp_r12v, %function
_Z10fx_cmp_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1418
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1418
	ldr	r3, [r3, #48]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1418
	str	r2, [r3, #124]
	ldr	r3, .L1418
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1418
	ldr	r3, [r3, #48]
	eor	r1, r2, r3
	ldr	r3, .L1418
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1418
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1418
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1418
	str	r2, [r3, #120]
	ldr	r3, .L1418
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1418
	str	r2, [r3, #60]
	ldr	r3, .L1418
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1418
	str	r2, [r3, #72]
	ldr	r2, .L1418
	ldr	r3, .L1418
	str	r3, [r2, #104]
	ldr	r3, .L1418
	ldr	r2, [r3, #104]
	ldr	r3, .L1418
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1419:
	.align	2
.L1418:
	.word	GSU
	.size	_Z10fx_cmp_r12v, .-_Z10fx_cmp_r12v
	.align	2
	.type	_Z10fx_cmp_r13v, %function
_Z10fx_cmp_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1422
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1422
	ldr	r3, [r3, #52]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1422
	str	r2, [r3, #124]
	ldr	r3, .L1422
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1422
	ldr	r3, [r3, #52]
	eor	r1, r2, r3
	ldr	r3, .L1422
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1422
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1422
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1422
	str	r2, [r3, #120]
	ldr	r3, .L1422
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1422
	str	r2, [r3, #60]
	ldr	r3, .L1422
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1422
	str	r2, [r3, #72]
	ldr	r2, .L1422
	ldr	r3, .L1422
	str	r3, [r2, #104]
	ldr	r3, .L1422
	ldr	r2, [r3, #104]
	ldr	r3, .L1422
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1423:
	.align	2
.L1422:
	.word	GSU
	.size	_Z10fx_cmp_r13v, .-_Z10fx_cmp_r13v
	.align	2
	.type	_Z10fx_cmp_r14v, %function
_Z10fx_cmp_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1426
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1426
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1426
	str	r2, [r3, #124]
	ldr	r3, .L1426
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1426
	ldr	r3, [r3, #56]
	eor	r1, r2, r3
	ldr	r3, .L1426
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1426
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1426
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1426
	str	r2, [r3, #120]
	ldr	r3, .L1426
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1426
	str	r2, [r3, #60]
	ldr	r3, .L1426
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1426
	str	r2, [r3, #72]
	ldr	r2, .L1426
	ldr	r3, .L1426
	str	r3, [r2, #104]
	ldr	r3, .L1426
	ldr	r2, [r3, #104]
	ldr	r3, .L1426
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1427:
	.align	2
.L1426:
	.word	GSU
	.size	_Z10fx_cmp_r14v, .-_Z10fx_cmp_r14v
	.align	2
	.type	_Z10fx_cmp_r15v, %function
_Z10fx_cmp_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1430
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L1430
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mvn	r3, r3
	mov	r2, r3, lsr #31
	ldr	r3, .L1430
	str	r2, [r3, #124]
	ldr	r3, .L1430
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1430
	ldr	r3, [r3, #60]
	eor	r1, r2, r3
	ldr	r3, .L1430
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	eor	r3, r2, r3
	and	r3, r1, r3
	and	r2, r3, #32768
	ldr	r3, .L1430
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1430
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1430
	str	r2, [r3, #120]
	ldr	r3, .L1430
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1430
	str	r2, [r3, #60]
	ldr	r3, .L1430
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1430
	str	r2, [r3, #72]
	ldr	r2, .L1430
	ldr	r3, .L1430
	str	r3, [r2, #104]
	ldr	r3, .L1430
	ldr	r2, [r3, #104]
	ldr	r3, .L1430
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1431:
	.align	2
.L1430:
	.word	GSU
	.size	_Z10fx_cmp_r15v, .-_Z10fx_cmp_r15v
	.align	2
	.type	_Z8fx_mergev, %function
_Z8fx_mergev:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1436
	ldr	r3, [r3, #28]
	and	r2, r3, #65280
	ldr	r3, .L1436
	ldr	r3, [r3, #32]
	and	r3, r3, #65280
	mov	r3, r3, lsr #8
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1436
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1436
	str	r2, [r3, #60]
	ldr	r3, .L1436
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1436+4
	and	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L1436
	str	r2, [r3, #128]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1436+8
	and	r3, r2, r3
	cmp	r3, #0
	movne	r2, #0
	moveq	r2, #1
	ldr	r3, .L1436
	str	r2, [r3, #120]
	ldr	r3, [fp, #-16]
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r2, r3
	and	r2, r3, #32768
	ldr	r3, .L1436
	str	r2, [r3, #116]
	ldr	r2, [fp, #-16]
	ldr	r3, .L1436+12
	and	r3, r2, r3
	cmp	r3, #0
	moveq	r2, #0
	movne	r2, #1
	ldr	r3, .L1436
	str	r2, [r3, #124]
	ldr	r3, .L1436
	ldr	r2, [r3, #100]
	ldr	r3, .L1436+16
	cmp	r2, r3
	bne	.L1433
	ldr	r3, .L1436
	ldr	r2, [r3, #468]
	ldr	r3, .L1436
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1436
	strb	r3, [r2, #108]
.L1433:
	ldr	r3, .L1436
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1436
	str	r2, [r3, #72]
	ldr	r2, .L1436
	ldr	r3, .L1436
	str	r3, [r2, #104]
	ldr	r3, .L1436
	ldr	r2, [r3, #104]
	ldr	r3, .L1436
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1437:
	.align	2
.L1436:
	.word	GSU
	.word	49344
	.word	61680
	.word	57568
	.word	GSU+56
	.size	_Z8fx_mergev, .-_Z8fx_mergev
	.align	2
	.type	_Z9fx_and_r1v, %function
_Z9fx_and_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1442
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1442
	ldr	r3, [r3, #4]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1442
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1442
	str	r2, [r3, #60]
	ldr	r3, .L1442
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1442
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1442
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1442
	ldr	r2, [r3, #100]
	ldr	r3, .L1442+4
	cmp	r2, r3
	bne	.L1439
	ldr	r3, .L1442
	ldr	r2, [r3, #468]
	ldr	r3, .L1442
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1442
	strb	r3, [r2, #108]
.L1439:
	ldr	r3, .L1442
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1442
	str	r2, [r3, #72]
	ldr	r2, .L1442
	ldr	r3, .L1442
	str	r3, [r2, #104]
	ldr	r3, .L1442
	ldr	r2, [r3, #104]
	ldr	r3, .L1442
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1443:
	.align	2
.L1442:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r1v, .-_Z9fx_and_r1v
	.align	2
	.type	_Z9fx_and_r2v, %function
_Z9fx_and_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1448
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1448
	ldr	r3, [r3, #8]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1448
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1448
	str	r2, [r3, #60]
	ldr	r3, .L1448
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1448
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1448
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1448
	ldr	r2, [r3, #100]
	ldr	r3, .L1448+4
	cmp	r2, r3
	bne	.L1445
	ldr	r3, .L1448
	ldr	r2, [r3, #468]
	ldr	r3, .L1448
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1448
	strb	r3, [r2, #108]
.L1445:
	ldr	r3, .L1448
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1448
	str	r2, [r3, #72]
	ldr	r2, .L1448
	ldr	r3, .L1448
	str	r3, [r2, #104]
	ldr	r3, .L1448
	ldr	r2, [r3, #104]
	ldr	r3, .L1448
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1449:
	.align	2
.L1448:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r2v, .-_Z9fx_and_r2v
	.align	2
	.type	_Z9fx_and_r3v, %function
_Z9fx_and_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1454
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1454
	ldr	r3, [r3, #12]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1454
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1454
	str	r2, [r3, #60]
	ldr	r3, .L1454
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1454
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1454
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1454
	ldr	r2, [r3, #100]
	ldr	r3, .L1454+4
	cmp	r2, r3
	bne	.L1451
	ldr	r3, .L1454
	ldr	r2, [r3, #468]
	ldr	r3, .L1454
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1454
	strb	r3, [r2, #108]
.L1451:
	ldr	r3, .L1454
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1454
	str	r2, [r3, #72]
	ldr	r2, .L1454
	ldr	r3, .L1454
	str	r3, [r2, #104]
	ldr	r3, .L1454
	ldr	r2, [r3, #104]
	ldr	r3, .L1454
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1455:
	.align	2
.L1454:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r3v, .-_Z9fx_and_r3v
	.align	2
	.type	_Z9fx_and_r4v, %function
_Z9fx_and_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1460
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1460
	ldr	r3, [r3, #16]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1460
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1460
	str	r2, [r3, #60]
	ldr	r3, .L1460
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1460
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1460
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1460
	ldr	r2, [r3, #100]
	ldr	r3, .L1460+4
	cmp	r2, r3
	bne	.L1457
	ldr	r3, .L1460
	ldr	r2, [r3, #468]
	ldr	r3, .L1460
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1460
	strb	r3, [r2, #108]
.L1457:
	ldr	r3, .L1460
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1460
	str	r2, [r3, #72]
	ldr	r2, .L1460
	ldr	r3, .L1460
	str	r3, [r2, #104]
	ldr	r3, .L1460
	ldr	r2, [r3, #104]
	ldr	r3, .L1460
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1461:
	.align	2
.L1460:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r4v, .-_Z9fx_and_r4v
	.align	2
	.type	_Z9fx_and_r5v, %function
_Z9fx_and_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1466
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1466
	ldr	r3, [r3, #20]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1466
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1466
	str	r2, [r3, #60]
	ldr	r3, .L1466
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1466
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1466
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1466
	ldr	r2, [r3, #100]
	ldr	r3, .L1466+4
	cmp	r2, r3
	bne	.L1463
	ldr	r3, .L1466
	ldr	r2, [r3, #468]
	ldr	r3, .L1466
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1466
	strb	r3, [r2, #108]
.L1463:
	ldr	r3, .L1466
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1466
	str	r2, [r3, #72]
	ldr	r2, .L1466
	ldr	r3, .L1466
	str	r3, [r2, #104]
	ldr	r3, .L1466
	ldr	r2, [r3, #104]
	ldr	r3, .L1466
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1467:
	.align	2
.L1466:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r5v, .-_Z9fx_and_r5v
	.align	2
	.type	_Z9fx_and_r6v, %function
_Z9fx_and_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1472
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1472
	ldr	r3, [r3, #24]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1472
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1472
	str	r2, [r3, #60]
	ldr	r3, .L1472
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1472
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1472
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1472
	ldr	r2, [r3, #100]
	ldr	r3, .L1472+4
	cmp	r2, r3
	bne	.L1469
	ldr	r3, .L1472
	ldr	r2, [r3, #468]
	ldr	r3, .L1472
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1472
	strb	r3, [r2, #108]
.L1469:
	ldr	r3, .L1472
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1472
	str	r2, [r3, #72]
	ldr	r2, .L1472
	ldr	r3, .L1472
	str	r3, [r2, #104]
	ldr	r3, .L1472
	ldr	r2, [r3, #104]
	ldr	r3, .L1472
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1473:
	.align	2
.L1472:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r6v, .-_Z9fx_and_r6v
	.align	2
	.type	_Z9fx_and_r7v, %function
_Z9fx_and_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1478
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1478
	ldr	r3, [r3, #28]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1478
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1478
	str	r2, [r3, #60]
	ldr	r3, .L1478
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1478
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1478
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1478
	ldr	r2, [r3, #100]
	ldr	r3, .L1478+4
	cmp	r2, r3
	bne	.L1475
	ldr	r3, .L1478
	ldr	r2, [r3, #468]
	ldr	r3, .L1478
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1478
	strb	r3, [r2, #108]
.L1475:
	ldr	r3, .L1478
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1478
	str	r2, [r3, #72]
	ldr	r2, .L1478
	ldr	r3, .L1478
	str	r3, [r2, #104]
	ldr	r3, .L1478
	ldr	r2, [r3, #104]
	ldr	r3, .L1478
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1479:
	.align	2
.L1478:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r7v, .-_Z9fx_and_r7v
	.align	2
	.type	_Z9fx_and_r8v, %function
_Z9fx_and_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1484
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1484
	ldr	r3, [r3, #32]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1484
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1484
	str	r2, [r3, #60]
	ldr	r3, .L1484
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1484
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1484
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1484
	ldr	r2, [r3, #100]
	ldr	r3, .L1484+4
	cmp	r2, r3
	bne	.L1481
	ldr	r3, .L1484
	ldr	r2, [r3, #468]
	ldr	r3, .L1484
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1484
	strb	r3, [r2, #108]
.L1481:
	ldr	r3, .L1484
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1484
	str	r2, [r3, #72]
	ldr	r2, .L1484
	ldr	r3, .L1484
	str	r3, [r2, #104]
	ldr	r3, .L1484
	ldr	r2, [r3, #104]
	ldr	r3, .L1484
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1485:
	.align	2
.L1484:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r8v, .-_Z9fx_and_r8v
	.align	2
	.type	_Z9fx_and_r9v, %function
_Z9fx_and_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1490
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1490
	ldr	r3, [r3, #36]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1490
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1490
	str	r2, [r3, #60]
	ldr	r3, .L1490
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1490
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1490
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1490
	ldr	r2, [r3, #100]
	ldr	r3, .L1490+4
	cmp	r2, r3
	bne	.L1487
	ldr	r3, .L1490
	ldr	r2, [r3, #468]
	ldr	r3, .L1490
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1490
	strb	r3, [r2, #108]
.L1487:
	ldr	r3, .L1490
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1490
	str	r2, [r3, #72]
	ldr	r2, .L1490
	ldr	r3, .L1490
	str	r3, [r2, #104]
	ldr	r3, .L1490
	ldr	r2, [r3, #104]
	ldr	r3, .L1490
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1491:
	.align	2
.L1490:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_r9v, .-_Z9fx_and_r9v
	.align	2
	.type	_Z10fx_and_r10v, %function
_Z10fx_and_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1496
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1496
	ldr	r3, [r3, #40]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1496
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1496
	str	r2, [r3, #60]
	ldr	r3, .L1496
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1496
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1496
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1496
	ldr	r2, [r3, #100]
	ldr	r3, .L1496+4
	cmp	r2, r3
	bne	.L1493
	ldr	r3, .L1496
	ldr	r2, [r3, #468]
	ldr	r3, .L1496
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1496
	strb	r3, [r2, #108]
.L1493:
	ldr	r3, .L1496
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1496
	str	r2, [r3, #72]
	ldr	r2, .L1496
	ldr	r3, .L1496
	str	r3, [r2, #104]
	ldr	r3, .L1496
	ldr	r2, [r3, #104]
	ldr	r3, .L1496
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1497:
	.align	2
.L1496:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_r10v, .-_Z10fx_and_r10v
	.align	2
	.type	_Z10fx_and_r11v, %function
_Z10fx_and_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1502
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1502
	ldr	r3, [r3, #44]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1502
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1502
	str	r2, [r3, #60]
	ldr	r3, .L1502
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1502
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1502
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1502
	ldr	r2, [r3, #100]
	ldr	r3, .L1502+4
	cmp	r2, r3
	bne	.L1499
	ldr	r3, .L1502
	ldr	r2, [r3, #468]
	ldr	r3, .L1502
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1502
	strb	r3, [r2, #108]
.L1499:
	ldr	r3, .L1502
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1502
	str	r2, [r3, #72]
	ldr	r2, .L1502
	ldr	r3, .L1502
	str	r3, [r2, #104]
	ldr	r3, .L1502
	ldr	r2, [r3, #104]
	ldr	r3, .L1502
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1503:
	.align	2
.L1502:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_r11v, .-_Z10fx_and_r11v
	.align	2
	.type	_Z10fx_and_r12v, %function
_Z10fx_and_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1508
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1508
	ldr	r3, [r3, #48]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1508
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1508
	str	r2, [r3, #60]
	ldr	r3, .L1508
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1508
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1508
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1508
	ldr	r2, [r3, #100]
	ldr	r3, .L1508+4
	cmp	r2, r3
	bne	.L1505
	ldr	r3, .L1508
	ldr	r2, [r3, #468]
	ldr	r3, .L1508
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1508
	strb	r3, [r2, #108]
.L1505:
	ldr	r3, .L1508
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1508
	str	r2, [r3, #72]
	ldr	r2, .L1508
	ldr	r3, .L1508
	str	r3, [r2, #104]
	ldr	r3, .L1508
	ldr	r2, [r3, #104]
	ldr	r3, .L1508
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1509:
	.align	2
.L1508:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_r12v, .-_Z10fx_and_r12v
	.align	2
	.type	_Z10fx_and_r13v, %function
_Z10fx_and_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1514
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1514
	ldr	r3, [r3, #52]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1514
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1514
	str	r2, [r3, #60]
	ldr	r3, .L1514
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1514
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1514
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1514
	ldr	r2, [r3, #100]
	ldr	r3, .L1514+4
	cmp	r2, r3
	bne	.L1511
	ldr	r3, .L1514
	ldr	r2, [r3, #468]
	ldr	r3, .L1514
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1514
	strb	r3, [r2, #108]
.L1511:
	ldr	r3, .L1514
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1514
	str	r2, [r3, #72]
	ldr	r2, .L1514
	ldr	r3, .L1514
	str	r3, [r2, #104]
	ldr	r3, .L1514
	ldr	r2, [r3, #104]
	ldr	r3, .L1514
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1515:
	.align	2
.L1514:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_r13v, .-_Z10fx_and_r13v
	.align	2
	.type	_Z10fx_and_r14v, %function
_Z10fx_and_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1520
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1520
	ldr	r3, [r3, #56]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1520
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1520
	str	r2, [r3, #60]
	ldr	r3, .L1520
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1520
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1520
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1520
	ldr	r2, [r3, #100]
	ldr	r3, .L1520+4
	cmp	r2, r3
	bne	.L1517
	ldr	r3, .L1520
	ldr	r2, [r3, #468]
	ldr	r3, .L1520
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1520
	strb	r3, [r2, #108]
.L1517:
	ldr	r3, .L1520
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1520
	str	r2, [r3, #72]
	ldr	r2, .L1520
	ldr	r3, .L1520
	str	r3, [r2, #104]
	ldr	r3, .L1520
	ldr	r2, [r3, #104]
	ldr	r3, .L1520
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1521:
	.align	2
.L1520:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_r14v, .-_Z10fx_and_r14v
	.align	2
	.type	_Z10fx_and_r15v, %function
_Z10fx_and_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1526
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1526
	ldr	r3, [r3, #60]
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1526
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1526
	str	r2, [r3, #60]
	ldr	r3, .L1526
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1526
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1526
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1526
	ldr	r2, [r3, #100]
	ldr	r3, .L1526+4
	cmp	r2, r3
	bne	.L1523
	ldr	r3, .L1526
	ldr	r2, [r3, #468]
	ldr	r3, .L1526
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1526
	strb	r3, [r2, #108]
.L1523:
	ldr	r3, .L1526
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1526
	str	r2, [r3, #72]
	ldr	r2, .L1526
	ldr	r3, .L1526
	str	r3, [r2, #104]
	ldr	r3, .L1526
	ldr	r2, [r3, #104]
	ldr	r3, .L1526
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1527:
	.align	2
.L1526:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_r15v, .-_Z10fx_and_r15v
	.align	2
	.type	_Z9fx_bic_r1v, %function
_Z9fx_bic_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1532
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1532
	ldr	r3, [r3, #4]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1532
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1532
	str	r2, [r3, #60]
	ldr	r3, .L1532
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1532
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1532
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1532
	ldr	r2, [r3, #100]
	ldr	r3, .L1532+4
	cmp	r2, r3
	bne	.L1529
	ldr	r3, .L1532
	ldr	r2, [r3, #468]
	ldr	r3, .L1532
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1532
	strb	r3, [r2, #108]
.L1529:
	ldr	r3, .L1532
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1532
	str	r2, [r3, #72]
	ldr	r2, .L1532
	ldr	r3, .L1532
	str	r3, [r2, #104]
	ldr	r3, .L1532
	ldr	r2, [r3, #104]
	ldr	r3, .L1532
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1533:
	.align	2
.L1532:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r1v, .-_Z9fx_bic_r1v
	.align	2
	.type	_Z9fx_bic_r2v, %function
_Z9fx_bic_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1538
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1538
	ldr	r3, [r3, #8]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1538
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1538
	str	r2, [r3, #60]
	ldr	r3, .L1538
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1538
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1538
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1538
	ldr	r2, [r3, #100]
	ldr	r3, .L1538+4
	cmp	r2, r3
	bne	.L1535
	ldr	r3, .L1538
	ldr	r2, [r3, #468]
	ldr	r3, .L1538
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1538
	strb	r3, [r2, #108]
.L1535:
	ldr	r3, .L1538
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1538
	str	r2, [r3, #72]
	ldr	r2, .L1538
	ldr	r3, .L1538
	str	r3, [r2, #104]
	ldr	r3, .L1538
	ldr	r2, [r3, #104]
	ldr	r3, .L1538
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1539:
	.align	2
.L1538:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r2v, .-_Z9fx_bic_r2v
	.align	2
	.type	_Z9fx_bic_r3v, %function
_Z9fx_bic_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1544
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1544
	ldr	r3, [r3, #12]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1544
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1544
	str	r2, [r3, #60]
	ldr	r3, .L1544
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1544
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1544
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1544
	ldr	r2, [r3, #100]
	ldr	r3, .L1544+4
	cmp	r2, r3
	bne	.L1541
	ldr	r3, .L1544
	ldr	r2, [r3, #468]
	ldr	r3, .L1544
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1544
	strb	r3, [r2, #108]
.L1541:
	ldr	r3, .L1544
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1544
	str	r2, [r3, #72]
	ldr	r2, .L1544
	ldr	r3, .L1544
	str	r3, [r2, #104]
	ldr	r3, .L1544
	ldr	r2, [r3, #104]
	ldr	r3, .L1544
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1545:
	.align	2
.L1544:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r3v, .-_Z9fx_bic_r3v
	.align	2
	.type	_Z9fx_bic_r4v, %function
_Z9fx_bic_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1550
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1550
	ldr	r3, [r3, #16]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1550
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1550
	str	r2, [r3, #60]
	ldr	r3, .L1550
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1550
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1550
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1550
	ldr	r2, [r3, #100]
	ldr	r3, .L1550+4
	cmp	r2, r3
	bne	.L1547
	ldr	r3, .L1550
	ldr	r2, [r3, #468]
	ldr	r3, .L1550
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1550
	strb	r3, [r2, #108]
.L1547:
	ldr	r3, .L1550
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1550
	str	r2, [r3, #72]
	ldr	r2, .L1550
	ldr	r3, .L1550
	str	r3, [r2, #104]
	ldr	r3, .L1550
	ldr	r2, [r3, #104]
	ldr	r3, .L1550
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1551:
	.align	2
.L1550:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r4v, .-_Z9fx_bic_r4v
	.align	2
	.type	_Z9fx_bic_r5v, %function
_Z9fx_bic_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1556
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1556
	ldr	r3, [r3, #20]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1556
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1556
	str	r2, [r3, #60]
	ldr	r3, .L1556
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1556
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1556
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1556
	ldr	r2, [r3, #100]
	ldr	r3, .L1556+4
	cmp	r2, r3
	bne	.L1553
	ldr	r3, .L1556
	ldr	r2, [r3, #468]
	ldr	r3, .L1556
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1556
	strb	r3, [r2, #108]
.L1553:
	ldr	r3, .L1556
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1556
	str	r2, [r3, #72]
	ldr	r2, .L1556
	ldr	r3, .L1556
	str	r3, [r2, #104]
	ldr	r3, .L1556
	ldr	r2, [r3, #104]
	ldr	r3, .L1556
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1557:
	.align	2
.L1556:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r5v, .-_Z9fx_bic_r5v
	.align	2
	.type	_Z9fx_bic_r6v, %function
_Z9fx_bic_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1562
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1562
	ldr	r3, [r3, #24]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1562
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1562
	str	r2, [r3, #60]
	ldr	r3, .L1562
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1562
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1562
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1562
	ldr	r2, [r3, #100]
	ldr	r3, .L1562+4
	cmp	r2, r3
	bne	.L1559
	ldr	r3, .L1562
	ldr	r2, [r3, #468]
	ldr	r3, .L1562
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1562
	strb	r3, [r2, #108]
.L1559:
	ldr	r3, .L1562
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1562
	str	r2, [r3, #72]
	ldr	r2, .L1562
	ldr	r3, .L1562
	str	r3, [r2, #104]
	ldr	r3, .L1562
	ldr	r2, [r3, #104]
	ldr	r3, .L1562
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1563:
	.align	2
.L1562:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r6v, .-_Z9fx_bic_r6v
	.align	2
	.type	_Z9fx_bic_r7v, %function
_Z9fx_bic_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1568
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1568
	ldr	r3, [r3, #28]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1568
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1568
	str	r2, [r3, #60]
	ldr	r3, .L1568
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1568
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1568
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1568
	ldr	r2, [r3, #100]
	ldr	r3, .L1568+4
	cmp	r2, r3
	bne	.L1565
	ldr	r3, .L1568
	ldr	r2, [r3, #468]
	ldr	r3, .L1568
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1568
	strb	r3, [r2, #108]
.L1565:
	ldr	r3, .L1568
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1568
	str	r2, [r3, #72]
	ldr	r2, .L1568
	ldr	r3, .L1568
	str	r3, [r2, #104]
	ldr	r3, .L1568
	ldr	r2, [r3, #104]
	ldr	r3, .L1568
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1569:
	.align	2
.L1568:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r7v, .-_Z9fx_bic_r7v
	.align	2
	.type	_Z9fx_bic_r8v, %function
_Z9fx_bic_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1574
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1574
	ldr	r3, [r3, #32]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1574
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1574
	str	r2, [r3, #60]
	ldr	r3, .L1574
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1574
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1574
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1574
	ldr	r2, [r3, #100]
	ldr	r3, .L1574+4
	cmp	r2, r3
	bne	.L1571
	ldr	r3, .L1574
	ldr	r2, [r3, #468]
	ldr	r3, .L1574
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1574
	strb	r3, [r2, #108]
.L1571:
	ldr	r3, .L1574
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1574
	str	r2, [r3, #72]
	ldr	r2, .L1574
	ldr	r3, .L1574
	str	r3, [r2, #104]
	ldr	r3, .L1574
	ldr	r2, [r3, #104]
	ldr	r3, .L1574
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1575:
	.align	2
.L1574:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r8v, .-_Z9fx_bic_r8v
	.align	2
	.type	_Z9fx_bic_r9v, %function
_Z9fx_bic_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1580
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1580
	ldr	r3, [r3, #36]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1580
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1580
	str	r2, [r3, #60]
	ldr	r3, .L1580
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1580
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1580
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1580
	ldr	r2, [r3, #100]
	ldr	r3, .L1580+4
	cmp	r2, r3
	bne	.L1577
	ldr	r3, .L1580
	ldr	r2, [r3, #468]
	ldr	r3, .L1580
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1580
	strb	r3, [r2, #108]
.L1577:
	ldr	r3, .L1580
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1580
	str	r2, [r3, #72]
	ldr	r2, .L1580
	ldr	r3, .L1580
	str	r3, [r2, #104]
	ldr	r3, .L1580
	ldr	r2, [r3, #104]
	ldr	r3, .L1580
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1581:
	.align	2
.L1580:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_r9v, .-_Z9fx_bic_r9v
	.align	2
	.type	_Z10fx_bic_r10v, %function
_Z10fx_bic_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1586
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1586
	ldr	r3, [r3, #40]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1586
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1586
	str	r2, [r3, #60]
	ldr	r3, .L1586
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1586
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1586
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1586
	ldr	r2, [r3, #100]
	ldr	r3, .L1586+4
	cmp	r2, r3
	bne	.L1583
	ldr	r3, .L1586
	ldr	r2, [r3, #468]
	ldr	r3, .L1586
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1586
	strb	r3, [r2, #108]
.L1583:
	ldr	r3, .L1586
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1586
	str	r2, [r3, #72]
	ldr	r2, .L1586
	ldr	r3, .L1586
	str	r3, [r2, #104]
	ldr	r3, .L1586
	ldr	r2, [r3, #104]
	ldr	r3, .L1586
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1587:
	.align	2
.L1586:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_r10v, .-_Z10fx_bic_r10v
	.align	2
	.type	_Z10fx_bic_r11v, %function
_Z10fx_bic_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1592
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1592
	ldr	r3, [r3, #44]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1592
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1592
	str	r2, [r3, #60]
	ldr	r3, .L1592
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1592
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1592
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1592
	ldr	r2, [r3, #100]
	ldr	r3, .L1592+4
	cmp	r2, r3
	bne	.L1589
	ldr	r3, .L1592
	ldr	r2, [r3, #468]
	ldr	r3, .L1592
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1592
	strb	r3, [r2, #108]
.L1589:
	ldr	r3, .L1592
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1592
	str	r2, [r3, #72]
	ldr	r2, .L1592
	ldr	r3, .L1592
	str	r3, [r2, #104]
	ldr	r3, .L1592
	ldr	r2, [r3, #104]
	ldr	r3, .L1592
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1593:
	.align	2
.L1592:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_r11v, .-_Z10fx_bic_r11v
	.align	2
	.type	_Z10fx_bic_r12v, %function
_Z10fx_bic_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1598
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1598
	ldr	r3, [r3, #48]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1598
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1598
	str	r2, [r3, #60]
	ldr	r3, .L1598
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1598
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1598
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1598
	ldr	r2, [r3, #100]
	ldr	r3, .L1598+4
	cmp	r2, r3
	bne	.L1595
	ldr	r3, .L1598
	ldr	r2, [r3, #468]
	ldr	r3, .L1598
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1598
	strb	r3, [r2, #108]
.L1595:
	ldr	r3, .L1598
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1598
	str	r2, [r3, #72]
	ldr	r2, .L1598
	ldr	r3, .L1598
	str	r3, [r2, #104]
	ldr	r3, .L1598
	ldr	r2, [r3, #104]
	ldr	r3, .L1598
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1599:
	.align	2
.L1598:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_r12v, .-_Z10fx_bic_r12v
	.align	2
	.type	_Z10fx_bic_r13v, %function
_Z10fx_bic_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1604
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1604
	ldr	r3, [r3, #52]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1604
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1604
	str	r2, [r3, #60]
	ldr	r3, .L1604
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1604
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1604
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1604
	ldr	r2, [r3, #100]
	ldr	r3, .L1604+4
	cmp	r2, r3
	bne	.L1601
	ldr	r3, .L1604
	ldr	r2, [r3, #468]
	ldr	r3, .L1604
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1604
	strb	r3, [r2, #108]
.L1601:
	ldr	r3, .L1604
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1604
	str	r2, [r3, #72]
	ldr	r2, .L1604
	ldr	r3, .L1604
	str	r3, [r2, #104]
	ldr	r3, .L1604
	ldr	r2, [r3, #104]
	ldr	r3, .L1604
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1605:
	.align	2
.L1604:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_r13v, .-_Z10fx_bic_r13v
	.align	2
	.type	_Z10fx_bic_r14v, %function
_Z10fx_bic_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1610
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1610
	ldr	r3, [r3, #56]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1610
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1610
	str	r2, [r3, #60]
	ldr	r3, .L1610
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1610
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1610
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1610
	ldr	r2, [r3, #100]
	ldr	r3, .L1610+4
	cmp	r2, r3
	bne	.L1607
	ldr	r3, .L1610
	ldr	r2, [r3, #468]
	ldr	r3, .L1610
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1610
	strb	r3, [r2, #108]
.L1607:
	ldr	r3, .L1610
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1610
	str	r2, [r3, #72]
	ldr	r2, .L1610
	ldr	r3, .L1610
	str	r3, [r2, #104]
	ldr	r3, .L1610
	ldr	r2, [r3, #104]
	ldr	r3, .L1610
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1611:
	.align	2
.L1610:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_r14v, .-_Z10fx_bic_r14v
	.align	2
	.type	_Z10fx_bic_r15v, %function
_Z10fx_bic_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1616
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L1616
	ldr	r3, [r3, #60]
	mvn	r3, r3
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1616
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1616
	str	r2, [r3, #60]
	ldr	r3, .L1616
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1616
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1616
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1616
	ldr	r2, [r3, #100]
	ldr	r3, .L1616+4
	cmp	r2, r3
	bne	.L1613
	ldr	r3, .L1616
	ldr	r2, [r3, #468]
	ldr	r3, .L1616
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1616
	strb	r3, [r2, #108]
.L1613:
	ldr	r3, .L1616
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1616
	str	r2, [r3, #72]
	ldr	r2, .L1616
	ldr	r3, .L1616
	str	r3, [r2, #104]
	ldr	r3, .L1616
	ldr	r2, [r3, #104]
	ldr	r3, .L1616
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1617:
	.align	2
.L1616:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_r15v, .-_Z10fx_bic_r15v
	.align	2
	.type	_Z9fx_and_i1v, %function
_Z9fx_and_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1622
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, .L1622
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1622
	str	r2, [r3, #60]
	ldr	r3, .L1622
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1622
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1622
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1622
	ldr	r2, [r3, #100]
	ldr	r3, .L1622+4
	cmp	r2, r3
	bne	.L1619
	ldr	r3, .L1622
	ldr	r2, [r3, #468]
	ldr	r3, .L1622
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1622
	strb	r3, [r2, #108]
.L1619:
	ldr	r3, .L1622
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1622
	str	r2, [r3, #72]
	ldr	r2, .L1622
	ldr	r3, .L1622
	str	r3, [r2, #104]
	ldr	r3, .L1622
	ldr	r2, [r3, #104]
	ldr	r3, .L1622
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1623:
	.align	2
.L1622:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i1v, .-_Z9fx_and_i1v
	.align	2
	.type	_Z9fx_and_i2v, %function
_Z9fx_and_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1628
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r3, .L1628
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1628
	str	r2, [r3, #60]
	ldr	r3, .L1628
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1628
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1628
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1628
	ldr	r2, [r3, #100]
	ldr	r3, .L1628+4
	cmp	r2, r3
	bne	.L1625
	ldr	r3, .L1628
	ldr	r2, [r3, #468]
	ldr	r3, .L1628
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1628
	strb	r3, [r2, #108]
.L1625:
	ldr	r3, .L1628
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1628
	str	r2, [r3, #72]
	ldr	r2, .L1628
	ldr	r3, .L1628
	str	r3, [r2, #104]
	ldr	r3, .L1628
	ldr	r2, [r3, #104]
	ldr	r3, .L1628
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1629:
	.align	2
.L1628:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i2v, .-_Z9fx_and_i2v
	.align	2
	.type	_Z9fx_and_i3v, %function
_Z9fx_and_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1634
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #3
	str	r3, [fp, #-16]
	ldr	r3, .L1634
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1634
	str	r2, [r3, #60]
	ldr	r3, .L1634
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1634
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1634
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1634
	ldr	r2, [r3, #100]
	ldr	r3, .L1634+4
	cmp	r2, r3
	bne	.L1631
	ldr	r3, .L1634
	ldr	r2, [r3, #468]
	ldr	r3, .L1634
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1634
	strb	r3, [r2, #108]
.L1631:
	ldr	r3, .L1634
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1634
	str	r2, [r3, #72]
	ldr	r2, .L1634
	ldr	r3, .L1634
	str	r3, [r2, #104]
	ldr	r3, .L1634
	ldr	r2, [r3, #104]
	ldr	r3, .L1634
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1635:
	.align	2
.L1634:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i3v, .-_Z9fx_and_i3v
	.align	2
	.type	_Z9fx_and_i4v, %function
_Z9fx_and_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1640
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #4
	str	r3, [fp, #-16]
	ldr	r3, .L1640
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1640
	str	r2, [r3, #60]
	ldr	r3, .L1640
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1640
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1640
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1640
	ldr	r2, [r3, #100]
	ldr	r3, .L1640+4
	cmp	r2, r3
	bne	.L1637
	ldr	r3, .L1640
	ldr	r2, [r3, #468]
	ldr	r3, .L1640
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1640
	strb	r3, [r2, #108]
.L1637:
	ldr	r3, .L1640
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1640
	str	r2, [r3, #72]
	ldr	r2, .L1640
	ldr	r3, .L1640
	str	r3, [r2, #104]
	ldr	r3, .L1640
	ldr	r2, [r3, #104]
	ldr	r3, .L1640
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1641:
	.align	2
.L1640:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i4v, .-_Z9fx_and_i4v
	.align	2
	.type	_Z9fx_and_i5v, %function
_Z9fx_and_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1646
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #5
	str	r3, [fp, #-16]
	ldr	r3, .L1646
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1646
	str	r2, [r3, #60]
	ldr	r3, .L1646
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1646
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1646
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1646
	ldr	r2, [r3, #100]
	ldr	r3, .L1646+4
	cmp	r2, r3
	bne	.L1643
	ldr	r3, .L1646
	ldr	r2, [r3, #468]
	ldr	r3, .L1646
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1646
	strb	r3, [r2, #108]
.L1643:
	ldr	r3, .L1646
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1646
	str	r2, [r3, #72]
	ldr	r2, .L1646
	ldr	r3, .L1646
	str	r3, [r2, #104]
	ldr	r3, .L1646
	ldr	r2, [r3, #104]
	ldr	r3, .L1646
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1647:
	.align	2
.L1646:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i5v, .-_Z9fx_and_i5v
	.align	2
	.type	_Z9fx_and_i6v, %function
_Z9fx_and_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1652
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #6
	str	r3, [fp, #-16]
	ldr	r3, .L1652
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1652
	str	r2, [r3, #60]
	ldr	r3, .L1652
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1652
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1652
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1652
	ldr	r2, [r3, #100]
	ldr	r3, .L1652+4
	cmp	r2, r3
	bne	.L1649
	ldr	r3, .L1652
	ldr	r2, [r3, #468]
	ldr	r3, .L1652
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1652
	strb	r3, [r2, #108]
.L1649:
	ldr	r3, .L1652
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1652
	str	r2, [r3, #72]
	ldr	r2, .L1652
	ldr	r3, .L1652
	str	r3, [r2, #104]
	ldr	r3, .L1652
	ldr	r2, [r3, #104]
	ldr	r3, .L1652
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1653:
	.align	2
.L1652:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i6v, .-_Z9fx_and_i6v
	.align	2
	.type	_Z9fx_and_i7v, %function
_Z9fx_and_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1658
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #7
	str	r3, [fp, #-16]
	ldr	r3, .L1658
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1658
	str	r2, [r3, #60]
	ldr	r3, .L1658
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1658
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1658
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1658
	ldr	r2, [r3, #100]
	ldr	r3, .L1658+4
	cmp	r2, r3
	bne	.L1655
	ldr	r3, .L1658
	ldr	r2, [r3, #468]
	ldr	r3, .L1658
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1658
	strb	r3, [r2, #108]
.L1655:
	ldr	r3, .L1658
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1658
	str	r2, [r3, #72]
	ldr	r2, .L1658
	ldr	r3, .L1658
	str	r3, [r2, #104]
	ldr	r3, .L1658
	ldr	r2, [r3, #104]
	ldr	r3, .L1658
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1659:
	.align	2
.L1658:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i7v, .-_Z9fx_and_i7v
	.align	2
	.type	_Z9fx_and_i8v, %function
_Z9fx_and_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1664
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #8
	str	r3, [fp, #-16]
	ldr	r3, .L1664
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1664
	str	r2, [r3, #60]
	ldr	r3, .L1664
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1664
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1664
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1664
	ldr	r2, [r3, #100]
	ldr	r3, .L1664+4
	cmp	r2, r3
	bne	.L1661
	ldr	r3, .L1664
	ldr	r2, [r3, #468]
	ldr	r3, .L1664
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1664
	strb	r3, [r2, #108]
.L1661:
	ldr	r3, .L1664
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1664
	str	r2, [r3, #72]
	ldr	r2, .L1664
	ldr	r3, .L1664
	str	r3, [r2, #104]
	ldr	r3, .L1664
	ldr	r2, [r3, #104]
	ldr	r3, .L1664
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1665:
	.align	2
.L1664:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i8v, .-_Z9fx_and_i8v
	.align	2
	.type	_Z9fx_and_i9v, %function
_Z9fx_and_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1670
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #9
	str	r3, [fp, #-16]
	ldr	r3, .L1670
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1670
	str	r2, [r3, #60]
	ldr	r3, .L1670
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1670
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1670
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1670
	ldr	r2, [r3, #100]
	ldr	r3, .L1670+4
	cmp	r2, r3
	bne	.L1667
	ldr	r3, .L1670
	ldr	r2, [r3, #468]
	ldr	r3, .L1670
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1670
	strb	r3, [r2, #108]
.L1667:
	ldr	r3, .L1670
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1670
	str	r2, [r3, #72]
	ldr	r2, .L1670
	ldr	r3, .L1670
	str	r3, [r2, #104]
	ldr	r3, .L1670
	ldr	r2, [r3, #104]
	ldr	r3, .L1670
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1671:
	.align	2
.L1670:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_and_i9v, .-_Z9fx_and_i9v
	.align	2
	.type	_Z10fx_and_i10v, %function
_Z10fx_and_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1676
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #10
	str	r3, [fp, #-16]
	ldr	r3, .L1676
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1676
	str	r2, [r3, #60]
	ldr	r3, .L1676
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1676
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1676
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1676
	ldr	r2, [r3, #100]
	ldr	r3, .L1676+4
	cmp	r2, r3
	bne	.L1673
	ldr	r3, .L1676
	ldr	r2, [r3, #468]
	ldr	r3, .L1676
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1676
	strb	r3, [r2, #108]
.L1673:
	ldr	r3, .L1676
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1676
	str	r2, [r3, #72]
	ldr	r2, .L1676
	ldr	r3, .L1676
	str	r3, [r2, #104]
	ldr	r3, .L1676
	ldr	r2, [r3, #104]
	ldr	r3, .L1676
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1677:
	.align	2
.L1676:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_i10v, .-_Z10fx_and_i10v
	.align	2
	.type	_Z10fx_and_i11v, %function
_Z10fx_and_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1682
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #11
	str	r3, [fp, #-16]
	ldr	r3, .L1682
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1682
	str	r2, [r3, #60]
	ldr	r3, .L1682
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1682
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1682
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1682
	ldr	r2, [r3, #100]
	ldr	r3, .L1682+4
	cmp	r2, r3
	bne	.L1679
	ldr	r3, .L1682
	ldr	r2, [r3, #468]
	ldr	r3, .L1682
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1682
	strb	r3, [r2, #108]
.L1679:
	ldr	r3, .L1682
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1682
	str	r2, [r3, #72]
	ldr	r2, .L1682
	ldr	r3, .L1682
	str	r3, [r2, #104]
	ldr	r3, .L1682
	ldr	r2, [r3, #104]
	ldr	r3, .L1682
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1683:
	.align	2
.L1682:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_i11v, .-_Z10fx_and_i11v
	.align	2
	.type	_Z10fx_and_i12v, %function
_Z10fx_and_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1688
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #12
	str	r3, [fp, #-16]
	ldr	r3, .L1688
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1688
	str	r2, [r3, #60]
	ldr	r3, .L1688
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1688
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1688
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1688
	ldr	r2, [r3, #100]
	ldr	r3, .L1688+4
	cmp	r2, r3
	bne	.L1685
	ldr	r3, .L1688
	ldr	r2, [r3, #468]
	ldr	r3, .L1688
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1688
	strb	r3, [r2, #108]
.L1685:
	ldr	r3, .L1688
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1688
	str	r2, [r3, #72]
	ldr	r2, .L1688
	ldr	r3, .L1688
	str	r3, [r2, #104]
	ldr	r3, .L1688
	ldr	r2, [r3, #104]
	ldr	r3, .L1688
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1689:
	.align	2
.L1688:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_i12v, .-_Z10fx_and_i12v
	.align	2
	.type	_Z10fx_and_i13v, %function
_Z10fx_and_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1694
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #13
	str	r3, [fp, #-16]
	ldr	r3, .L1694
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1694
	str	r2, [r3, #60]
	ldr	r3, .L1694
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1694
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1694
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1694
	ldr	r2, [r3, #100]
	ldr	r3, .L1694+4
	cmp	r2, r3
	bne	.L1691
	ldr	r3, .L1694
	ldr	r2, [r3, #468]
	ldr	r3, .L1694
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1694
	strb	r3, [r2, #108]
.L1691:
	ldr	r3, .L1694
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1694
	str	r2, [r3, #72]
	ldr	r2, .L1694
	ldr	r3, .L1694
	str	r3, [r2, #104]
	ldr	r3, .L1694
	ldr	r2, [r3, #104]
	ldr	r3, .L1694
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1695:
	.align	2
.L1694:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_i13v, .-_Z10fx_and_i13v
	.align	2
	.type	_Z10fx_and_i14v, %function
_Z10fx_and_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1700
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #14
	str	r3, [fp, #-16]
	ldr	r3, .L1700
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1700
	str	r2, [r3, #60]
	ldr	r3, .L1700
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1700
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1700
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1700
	ldr	r2, [r3, #100]
	ldr	r3, .L1700+4
	cmp	r2, r3
	bne	.L1697
	ldr	r3, .L1700
	ldr	r2, [r3, #468]
	ldr	r3, .L1700
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1700
	strb	r3, [r2, #108]
.L1697:
	ldr	r3, .L1700
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1700
	str	r2, [r3, #72]
	ldr	r2, .L1700
	ldr	r3, .L1700
	str	r3, [r2, #104]
	ldr	r3, .L1700
	ldr	r2, [r3, #104]
	ldr	r3, .L1700
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1701:
	.align	2
.L1700:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_i14v, .-_Z10fx_and_i14v
	.align	2
	.type	_Z10fx_and_i15v, %function
_Z10fx_and_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1706
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #15
	str	r3, [fp, #-16]
	ldr	r3, .L1706
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1706
	str	r2, [r3, #60]
	ldr	r3, .L1706
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1706
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1706
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1706
	ldr	r2, [r3, #100]
	ldr	r3, .L1706+4
	cmp	r2, r3
	bne	.L1703
	ldr	r3, .L1706
	ldr	r2, [r3, #468]
	ldr	r3, .L1706
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1706
	strb	r3, [r2, #108]
.L1703:
	ldr	r3, .L1706
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1706
	str	r2, [r3, #72]
	ldr	r2, .L1706
	ldr	r3, .L1706
	str	r3, [r2, #104]
	ldr	r3, .L1706
	ldr	r2, [r3, #104]
	ldr	r3, .L1706
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1707:
	.align	2
.L1706:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_and_i15v, .-_Z10fx_and_i15v
	.align	2
	.type	_Z9fx_bic_i1v, %function
_Z9fx_bic_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1712
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, .L1712
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1712
	str	r2, [r3, #60]
	ldr	r3, .L1712
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1712
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1712
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1712
	ldr	r2, [r3, #100]
	ldr	r3, .L1712+4
	cmp	r2, r3
	bne	.L1709
	ldr	r3, .L1712
	ldr	r2, [r3, #468]
	ldr	r3, .L1712
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1712
	strb	r3, [r2, #108]
.L1709:
	ldr	r3, .L1712
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1712
	str	r2, [r3, #72]
	ldr	r2, .L1712
	ldr	r3, .L1712
	str	r3, [r2, #104]
	ldr	r3, .L1712
	ldr	r2, [r3, #104]
	ldr	r3, .L1712
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1713:
	.align	2
.L1712:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i1v, .-_Z9fx_bic_i1v
	.align	2
	.type	_Z9fx_bic_i2v, %function
_Z9fx_bic_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1718
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r3, .L1718
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1718
	str	r2, [r3, #60]
	ldr	r3, .L1718
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1718
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1718
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1718
	ldr	r2, [r3, #100]
	ldr	r3, .L1718+4
	cmp	r2, r3
	bne	.L1715
	ldr	r3, .L1718
	ldr	r2, [r3, #468]
	ldr	r3, .L1718
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1718
	strb	r3, [r2, #108]
.L1715:
	ldr	r3, .L1718
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1718
	str	r2, [r3, #72]
	ldr	r2, .L1718
	ldr	r3, .L1718
	str	r3, [r2, #104]
	ldr	r3, .L1718
	ldr	r2, [r3, #104]
	ldr	r3, .L1718
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1719:
	.align	2
.L1718:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i2v, .-_Z9fx_bic_i2v
	.align	2
	.type	_Z9fx_bic_i3v, %function
_Z9fx_bic_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1724
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #3
	str	r3, [fp, #-16]
	ldr	r3, .L1724
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1724
	str	r2, [r3, #60]
	ldr	r3, .L1724
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1724
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1724
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1724
	ldr	r2, [r3, #100]
	ldr	r3, .L1724+4
	cmp	r2, r3
	bne	.L1721
	ldr	r3, .L1724
	ldr	r2, [r3, #468]
	ldr	r3, .L1724
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1724
	strb	r3, [r2, #108]
.L1721:
	ldr	r3, .L1724
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1724
	str	r2, [r3, #72]
	ldr	r2, .L1724
	ldr	r3, .L1724
	str	r3, [r2, #104]
	ldr	r3, .L1724
	ldr	r2, [r3, #104]
	ldr	r3, .L1724
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1725:
	.align	2
.L1724:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i3v, .-_Z9fx_bic_i3v
	.align	2
	.type	_Z9fx_bic_i4v, %function
_Z9fx_bic_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1730
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #4
	str	r3, [fp, #-16]
	ldr	r3, .L1730
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1730
	str	r2, [r3, #60]
	ldr	r3, .L1730
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1730
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1730
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1730
	ldr	r2, [r3, #100]
	ldr	r3, .L1730+4
	cmp	r2, r3
	bne	.L1727
	ldr	r3, .L1730
	ldr	r2, [r3, #468]
	ldr	r3, .L1730
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1730
	strb	r3, [r2, #108]
.L1727:
	ldr	r3, .L1730
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1730
	str	r2, [r3, #72]
	ldr	r2, .L1730
	ldr	r3, .L1730
	str	r3, [r2, #104]
	ldr	r3, .L1730
	ldr	r2, [r3, #104]
	ldr	r3, .L1730
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1731:
	.align	2
.L1730:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i4v, .-_Z9fx_bic_i4v
	.align	2
	.type	_Z9fx_bic_i5v, %function
_Z9fx_bic_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1736
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #5
	str	r3, [fp, #-16]
	ldr	r3, .L1736
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1736
	str	r2, [r3, #60]
	ldr	r3, .L1736
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1736
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1736
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1736
	ldr	r2, [r3, #100]
	ldr	r3, .L1736+4
	cmp	r2, r3
	bne	.L1733
	ldr	r3, .L1736
	ldr	r2, [r3, #468]
	ldr	r3, .L1736
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1736
	strb	r3, [r2, #108]
.L1733:
	ldr	r3, .L1736
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1736
	str	r2, [r3, #72]
	ldr	r2, .L1736
	ldr	r3, .L1736
	str	r3, [r2, #104]
	ldr	r3, .L1736
	ldr	r2, [r3, #104]
	ldr	r3, .L1736
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1737:
	.align	2
.L1736:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i5v, .-_Z9fx_bic_i5v
	.align	2
	.type	_Z9fx_bic_i6v, %function
_Z9fx_bic_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1742
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #6
	str	r3, [fp, #-16]
	ldr	r3, .L1742
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1742
	str	r2, [r3, #60]
	ldr	r3, .L1742
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1742
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1742
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1742
	ldr	r2, [r3, #100]
	ldr	r3, .L1742+4
	cmp	r2, r3
	bne	.L1739
	ldr	r3, .L1742
	ldr	r2, [r3, #468]
	ldr	r3, .L1742
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1742
	strb	r3, [r2, #108]
.L1739:
	ldr	r3, .L1742
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1742
	str	r2, [r3, #72]
	ldr	r2, .L1742
	ldr	r3, .L1742
	str	r3, [r2, #104]
	ldr	r3, .L1742
	ldr	r2, [r3, #104]
	ldr	r3, .L1742
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1743:
	.align	2
.L1742:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i6v, .-_Z9fx_bic_i6v
	.align	2
	.type	_Z9fx_bic_i7v, %function
_Z9fx_bic_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1748
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #7
	str	r3, [fp, #-16]
	ldr	r3, .L1748
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1748
	str	r2, [r3, #60]
	ldr	r3, .L1748
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1748
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1748
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1748
	ldr	r2, [r3, #100]
	ldr	r3, .L1748+4
	cmp	r2, r3
	bne	.L1745
	ldr	r3, .L1748
	ldr	r2, [r3, #468]
	ldr	r3, .L1748
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1748
	strb	r3, [r2, #108]
.L1745:
	ldr	r3, .L1748
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1748
	str	r2, [r3, #72]
	ldr	r2, .L1748
	ldr	r3, .L1748
	str	r3, [r2, #104]
	ldr	r3, .L1748
	ldr	r2, [r3, #104]
	ldr	r3, .L1748
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1749:
	.align	2
.L1748:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i7v, .-_Z9fx_bic_i7v
	.align	2
	.type	_Z9fx_bic_i8v, %function
_Z9fx_bic_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1754
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #8
	str	r3, [fp, #-16]
	ldr	r3, .L1754
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1754
	str	r2, [r3, #60]
	ldr	r3, .L1754
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1754
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1754
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1754
	ldr	r2, [r3, #100]
	ldr	r3, .L1754+4
	cmp	r2, r3
	bne	.L1751
	ldr	r3, .L1754
	ldr	r2, [r3, #468]
	ldr	r3, .L1754
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1754
	strb	r3, [r2, #108]
.L1751:
	ldr	r3, .L1754
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1754
	str	r2, [r3, #72]
	ldr	r2, .L1754
	ldr	r3, .L1754
	str	r3, [r2, #104]
	ldr	r3, .L1754
	ldr	r2, [r3, #104]
	ldr	r3, .L1754
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1755:
	.align	2
.L1754:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i8v, .-_Z9fx_bic_i8v
	.align	2
	.type	_Z9fx_bic_i9v, %function
_Z9fx_bic_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1760
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #9
	str	r3, [fp, #-16]
	ldr	r3, .L1760
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1760
	str	r2, [r3, #60]
	ldr	r3, .L1760
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1760
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1760
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1760
	ldr	r2, [r3, #100]
	ldr	r3, .L1760+4
	cmp	r2, r3
	bne	.L1757
	ldr	r3, .L1760
	ldr	r2, [r3, #468]
	ldr	r3, .L1760
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1760
	strb	r3, [r2, #108]
.L1757:
	ldr	r3, .L1760
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1760
	str	r2, [r3, #72]
	ldr	r2, .L1760
	ldr	r3, .L1760
	str	r3, [r2, #104]
	ldr	r3, .L1760
	ldr	r2, [r3, #104]
	ldr	r3, .L1760
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1761:
	.align	2
.L1760:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_bic_i9v, .-_Z9fx_bic_i9v
	.align	2
	.type	_Z10fx_bic_i10v, %function
_Z10fx_bic_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1766
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #10
	str	r3, [fp, #-16]
	ldr	r3, .L1766
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1766
	str	r2, [r3, #60]
	ldr	r3, .L1766
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1766
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1766
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1766
	ldr	r2, [r3, #100]
	ldr	r3, .L1766+4
	cmp	r2, r3
	bne	.L1763
	ldr	r3, .L1766
	ldr	r2, [r3, #468]
	ldr	r3, .L1766
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1766
	strb	r3, [r2, #108]
.L1763:
	ldr	r3, .L1766
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1766
	str	r2, [r3, #72]
	ldr	r2, .L1766
	ldr	r3, .L1766
	str	r3, [r2, #104]
	ldr	r3, .L1766
	ldr	r2, [r3, #104]
	ldr	r3, .L1766
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1767:
	.align	2
.L1766:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_i10v, .-_Z10fx_bic_i10v
	.align	2
	.type	_Z10fx_bic_i11v, %function
_Z10fx_bic_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1772
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #11
	str	r3, [fp, #-16]
	ldr	r3, .L1772
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1772
	str	r2, [r3, #60]
	ldr	r3, .L1772
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1772
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1772
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1772
	ldr	r2, [r3, #100]
	ldr	r3, .L1772+4
	cmp	r2, r3
	bne	.L1769
	ldr	r3, .L1772
	ldr	r2, [r3, #468]
	ldr	r3, .L1772
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1772
	strb	r3, [r2, #108]
.L1769:
	ldr	r3, .L1772
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1772
	str	r2, [r3, #72]
	ldr	r2, .L1772
	ldr	r3, .L1772
	str	r3, [r2, #104]
	ldr	r3, .L1772
	ldr	r2, [r3, #104]
	ldr	r3, .L1772
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1773:
	.align	2
.L1772:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_i11v, .-_Z10fx_bic_i11v
	.align	2
	.type	_Z10fx_bic_i12v, %function
_Z10fx_bic_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1778
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #12
	str	r3, [fp, #-16]
	ldr	r3, .L1778
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1778
	str	r2, [r3, #60]
	ldr	r3, .L1778
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1778
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1778
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1778
	ldr	r2, [r3, #100]
	ldr	r3, .L1778+4
	cmp	r2, r3
	bne	.L1775
	ldr	r3, .L1778
	ldr	r2, [r3, #468]
	ldr	r3, .L1778
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1778
	strb	r3, [r2, #108]
.L1775:
	ldr	r3, .L1778
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1778
	str	r2, [r3, #72]
	ldr	r2, .L1778
	ldr	r3, .L1778
	str	r3, [r2, #104]
	ldr	r3, .L1778
	ldr	r2, [r3, #104]
	ldr	r3, .L1778
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1779:
	.align	2
.L1778:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_i12v, .-_Z10fx_bic_i12v
	.align	2
	.type	_Z10fx_bic_i13v, %function
_Z10fx_bic_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1784
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #13
	str	r3, [fp, #-16]
	ldr	r3, .L1784
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1784
	str	r2, [r3, #60]
	ldr	r3, .L1784
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1784
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1784
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1784
	ldr	r2, [r3, #100]
	ldr	r3, .L1784+4
	cmp	r2, r3
	bne	.L1781
	ldr	r3, .L1784
	ldr	r2, [r3, #468]
	ldr	r3, .L1784
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1784
	strb	r3, [r2, #108]
.L1781:
	ldr	r3, .L1784
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1784
	str	r2, [r3, #72]
	ldr	r2, .L1784
	ldr	r3, .L1784
	str	r3, [r2, #104]
	ldr	r3, .L1784
	ldr	r2, [r3, #104]
	ldr	r3, .L1784
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1785:
	.align	2
.L1784:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_i13v, .-_Z10fx_bic_i13v
	.align	2
	.type	_Z10fx_bic_i14v, %function
_Z10fx_bic_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1790
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #14
	str	r3, [fp, #-16]
	ldr	r3, .L1790
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1790
	str	r2, [r3, #60]
	ldr	r3, .L1790
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1790
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1790
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1790
	ldr	r2, [r3, #100]
	ldr	r3, .L1790+4
	cmp	r2, r3
	bne	.L1787
	ldr	r3, .L1790
	ldr	r2, [r3, #468]
	ldr	r3, .L1790
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1790
	strb	r3, [r2, #108]
.L1787:
	ldr	r3, .L1790
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1790
	str	r2, [r3, #72]
	ldr	r2, .L1790
	ldr	r3, .L1790
	str	r3, [r2, #104]
	ldr	r3, .L1790
	ldr	r2, [r3, #104]
	ldr	r3, .L1790
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1791:
	.align	2
.L1790:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_i14v, .-_Z10fx_bic_i14v
	.align	2
	.type	_Z10fx_bic_i15v, %function
_Z10fx_bic_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1796
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	bic	r3, r3, #15
	str	r3, [fp, #-16]
	ldr	r3, .L1796
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1796
	str	r2, [r3, #60]
	ldr	r3, .L1796
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1796
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1796
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1796
	ldr	r2, [r3, #100]
	ldr	r3, .L1796+4
	cmp	r2, r3
	bne	.L1793
	ldr	r3, .L1796
	ldr	r2, [r3, #468]
	ldr	r3, .L1796
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1796
	strb	r3, [r2, #108]
.L1793:
	ldr	r3, .L1796
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1796
	str	r2, [r3, #72]
	ldr	r2, .L1796
	ldr	r3, .L1796
	str	r3, [r2, #104]
	ldr	r3, .L1796
	ldr	r2, [r3, #104]
	ldr	r3, .L1796
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1797:
	.align	2
.L1796:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_bic_i15v, .-_Z10fx_bic_i15v
	.align	2
	.type	_Z10fx_mult_r0v, %function
_Z10fx_mult_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1802
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1802
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1802
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1802
	str	r2, [r3, #60]
	ldr	r3, .L1802
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1802
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1802
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1802
	ldr	r2, [r3, #100]
	ldr	r3, .L1802+4
	cmp	r2, r3
	bne	.L1799
	ldr	r3, .L1802
	ldr	r2, [r3, #468]
	ldr	r3, .L1802
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1802
	strb	r3, [r2, #108]
.L1799:
	ldr	r3, .L1802
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1802
	str	r2, [r3, #72]
	ldr	r2, .L1802
	ldr	r3, .L1802
	str	r3, [r2, #104]
	ldr	r3, .L1802
	ldr	r2, [r3, #104]
	ldr	r3, .L1802
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1803:
	.align	2
.L1802:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r0v, .-_Z10fx_mult_r0v
	.align	2
	.type	_Z10fx_mult_r1v, %function
_Z10fx_mult_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1808
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1808
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1808
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1808
	str	r2, [r3, #60]
	ldr	r3, .L1808
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1808
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1808
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1808
	ldr	r2, [r3, #100]
	ldr	r3, .L1808+4
	cmp	r2, r3
	bne	.L1805
	ldr	r3, .L1808
	ldr	r2, [r3, #468]
	ldr	r3, .L1808
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1808
	strb	r3, [r2, #108]
.L1805:
	ldr	r3, .L1808
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1808
	str	r2, [r3, #72]
	ldr	r2, .L1808
	ldr	r3, .L1808
	str	r3, [r2, #104]
	ldr	r3, .L1808
	ldr	r2, [r3, #104]
	ldr	r3, .L1808
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1809:
	.align	2
.L1808:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r1v, .-_Z10fx_mult_r1v
	.align	2
	.type	_Z10fx_mult_r2v, %function
_Z10fx_mult_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1814
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1814
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1814
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1814
	str	r2, [r3, #60]
	ldr	r3, .L1814
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1814
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1814
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1814
	ldr	r2, [r3, #100]
	ldr	r3, .L1814+4
	cmp	r2, r3
	bne	.L1811
	ldr	r3, .L1814
	ldr	r2, [r3, #468]
	ldr	r3, .L1814
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1814
	strb	r3, [r2, #108]
.L1811:
	ldr	r3, .L1814
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1814
	str	r2, [r3, #72]
	ldr	r2, .L1814
	ldr	r3, .L1814
	str	r3, [r2, #104]
	ldr	r3, .L1814
	ldr	r2, [r3, #104]
	ldr	r3, .L1814
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1815:
	.align	2
.L1814:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r2v, .-_Z10fx_mult_r2v
	.align	2
	.type	_Z10fx_mult_r3v, %function
_Z10fx_mult_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1820
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1820
	ldr	r3, [r3, #12]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1820
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1820
	str	r2, [r3, #60]
	ldr	r3, .L1820
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1820
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1820
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1820
	ldr	r2, [r3, #100]
	ldr	r3, .L1820+4
	cmp	r2, r3
	bne	.L1817
	ldr	r3, .L1820
	ldr	r2, [r3, #468]
	ldr	r3, .L1820
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1820
	strb	r3, [r2, #108]
.L1817:
	ldr	r3, .L1820
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1820
	str	r2, [r3, #72]
	ldr	r2, .L1820
	ldr	r3, .L1820
	str	r3, [r2, #104]
	ldr	r3, .L1820
	ldr	r2, [r3, #104]
	ldr	r3, .L1820
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1821:
	.align	2
.L1820:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r3v, .-_Z10fx_mult_r3v
	.align	2
	.type	_Z10fx_mult_r4v, %function
_Z10fx_mult_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1826
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1826
	ldr	r3, [r3, #16]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1826
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1826
	str	r2, [r3, #60]
	ldr	r3, .L1826
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1826
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1826
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1826
	ldr	r2, [r3, #100]
	ldr	r3, .L1826+4
	cmp	r2, r3
	bne	.L1823
	ldr	r3, .L1826
	ldr	r2, [r3, #468]
	ldr	r3, .L1826
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1826
	strb	r3, [r2, #108]
.L1823:
	ldr	r3, .L1826
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1826
	str	r2, [r3, #72]
	ldr	r2, .L1826
	ldr	r3, .L1826
	str	r3, [r2, #104]
	ldr	r3, .L1826
	ldr	r2, [r3, #104]
	ldr	r3, .L1826
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1827:
	.align	2
.L1826:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r4v, .-_Z10fx_mult_r4v
	.align	2
	.type	_Z10fx_mult_r5v, %function
_Z10fx_mult_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1832
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1832
	ldr	r3, [r3, #20]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1832
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1832
	str	r2, [r3, #60]
	ldr	r3, .L1832
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1832
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1832
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1832
	ldr	r2, [r3, #100]
	ldr	r3, .L1832+4
	cmp	r2, r3
	bne	.L1829
	ldr	r3, .L1832
	ldr	r2, [r3, #468]
	ldr	r3, .L1832
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1832
	strb	r3, [r2, #108]
.L1829:
	ldr	r3, .L1832
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1832
	str	r2, [r3, #72]
	ldr	r2, .L1832
	ldr	r3, .L1832
	str	r3, [r2, #104]
	ldr	r3, .L1832
	ldr	r2, [r3, #104]
	ldr	r3, .L1832
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1833:
	.align	2
.L1832:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r5v, .-_Z10fx_mult_r5v
	.align	2
	.type	_Z10fx_mult_r6v, %function
_Z10fx_mult_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1838
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1838
	ldr	r3, [r3, #24]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1838
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1838
	str	r2, [r3, #60]
	ldr	r3, .L1838
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1838
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1838
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1838
	ldr	r2, [r3, #100]
	ldr	r3, .L1838+4
	cmp	r2, r3
	bne	.L1835
	ldr	r3, .L1838
	ldr	r2, [r3, #468]
	ldr	r3, .L1838
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1838
	strb	r3, [r2, #108]
.L1835:
	ldr	r3, .L1838
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1838
	str	r2, [r3, #72]
	ldr	r2, .L1838
	ldr	r3, .L1838
	str	r3, [r2, #104]
	ldr	r3, .L1838
	ldr	r2, [r3, #104]
	ldr	r3, .L1838
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1839:
	.align	2
.L1838:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r6v, .-_Z10fx_mult_r6v
	.align	2
	.type	_Z10fx_mult_r7v, %function
_Z10fx_mult_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1844
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1844
	ldr	r3, [r3, #28]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1844
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1844
	str	r2, [r3, #60]
	ldr	r3, .L1844
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1844
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1844
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1844
	ldr	r2, [r3, #100]
	ldr	r3, .L1844+4
	cmp	r2, r3
	bne	.L1841
	ldr	r3, .L1844
	ldr	r2, [r3, #468]
	ldr	r3, .L1844
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1844
	strb	r3, [r2, #108]
.L1841:
	ldr	r3, .L1844
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1844
	str	r2, [r3, #72]
	ldr	r2, .L1844
	ldr	r3, .L1844
	str	r3, [r2, #104]
	ldr	r3, .L1844
	ldr	r2, [r3, #104]
	ldr	r3, .L1844
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1845:
	.align	2
.L1844:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r7v, .-_Z10fx_mult_r7v
	.align	2
	.type	_Z10fx_mult_r8v, %function
_Z10fx_mult_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1850
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1850
	ldr	r3, [r3, #32]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1850
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1850
	str	r2, [r3, #60]
	ldr	r3, .L1850
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1850
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1850
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1850
	ldr	r2, [r3, #100]
	ldr	r3, .L1850+4
	cmp	r2, r3
	bne	.L1847
	ldr	r3, .L1850
	ldr	r2, [r3, #468]
	ldr	r3, .L1850
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1850
	strb	r3, [r2, #108]
.L1847:
	ldr	r3, .L1850
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1850
	str	r2, [r3, #72]
	ldr	r2, .L1850
	ldr	r3, .L1850
	str	r3, [r2, #104]
	ldr	r3, .L1850
	ldr	r2, [r3, #104]
	ldr	r3, .L1850
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1851:
	.align	2
.L1850:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r8v, .-_Z10fx_mult_r8v
	.align	2
	.type	_Z10fx_mult_r9v, %function
_Z10fx_mult_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1856
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1856
	ldr	r3, [r3, #36]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1856
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1856
	str	r2, [r3, #60]
	ldr	r3, .L1856
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1856
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1856
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1856
	ldr	r2, [r3, #100]
	ldr	r3, .L1856+4
	cmp	r2, r3
	bne	.L1853
	ldr	r3, .L1856
	ldr	r2, [r3, #468]
	ldr	r3, .L1856
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1856
	strb	r3, [r2, #108]
.L1853:
	ldr	r3, .L1856
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1856
	str	r2, [r3, #72]
	ldr	r2, .L1856
	ldr	r3, .L1856
	str	r3, [r2, #104]
	ldr	r3, .L1856
	ldr	r2, [r3, #104]
	ldr	r3, .L1856
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1857:
	.align	2
.L1856:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_r9v, .-_Z10fx_mult_r9v
	.align	2
	.type	_Z11fx_mult_r10v, %function
_Z11fx_mult_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1862
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1862
	ldr	r3, [r3, #40]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1862
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1862
	str	r2, [r3, #60]
	ldr	r3, .L1862
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1862
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1862
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1862
	ldr	r2, [r3, #100]
	ldr	r3, .L1862+4
	cmp	r2, r3
	bne	.L1859
	ldr	r3, .L1862
	ldr	r2, [r3, #468]
	ldr	r3, .L1862
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1862
	strb	r3, [r2, #108]
.L1859:
	ldr	r3, .L1862
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1862
	str	r2, [r3, #72]
	ldr	r2, .L1862
	ldr	r3, .L1862
	str	r3, [r2, #104]
	ldr	r3, .L1862
	ldr	r2, [r3, #104]
	ldr	r3, .L1862
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1863:
	.align	2
.L1862:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_r10v, .-_Z11fx_mult_r10v
	.align	2
	.type	_Z11fx_mult_r11v, %function
_Z11fx_mult_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1868
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1868
	ldr	r3, [r3, #44]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1868
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1868
	str	r2, [r3, #60]
	ldr	r3, .L1868
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1868
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1868
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1868
	ldr	r2, [r3, #100]
	ldr	r3, .L1868+4
	cmp	r2, r3
	bne	.L1865
	ldr	r3, .L1868
	ldr	r2, [r3, #468]
	ldr	r3, .L1868
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1868
	strb	r3, [r2, #108]
.L1865:
	ldr	r3, .L1868
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1868
	str	r2, [r3, #72]
	ldr	r2, .L1868
	ldr	r3, .L1868
	str	r3, [r2, #104]
	ldr	r3, .L1868
	ldr	r2, [r3, #104]
	ldr	r3, .L1868
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1869:
	.align	2
.L1868:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_r11v, .-_Z11fx_mult_r11v
	.align	2
	.type	_Z11fx_mult_r12v, %function
_Z11fx_mult_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1874
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1874
	ldr	r3, [r3, #48]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1874
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1874
	str	r2, [r3, #60]
	ldr	r3, .L1874
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1874
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1874
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1874
	ldr	r2, [r3, #100]
	ldr	r3, .L1874+4
	cmp	r2, r3
	bne	.L1871
	ldr	r3, .L1874
	ldr	r2, [r3, #468]
	ldr	r3, .L1874
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1874
	strb	r3, [r2, #108]
.L1871:
	ldr	r3, .L1874
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1874
	str	r2, [r3, #72]
	ldr	r2, .L1874
	ldr	r3, .L1874
	str	r3, [r2, #104]
	ldr	r3, .L1874
	ldr	r2, [r3, #104]
	ldr	r3, .L1874
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1875:
	.align	2
.L1874:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_r12v, .-_Z11fx_mult_r12v
	.align	2
	.type	_Z11fx_mult_r13v, %function
_Z11fx_mult_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1880
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1880
	ldr	r3, [r3, #52]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1880
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1880
	str	r2, [r3, #60]
	ldr	r3, .L1880
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1880
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1880
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1880
	ldr	r2, [r3, #100]
	ldr	r3, .L1880+4
	cmp	r2, r3
	bne	.L1877
	ldr	r3, .L1880
	ldr	r2, [r3, #468]
	ldr	r3, .L1880
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1880
	strb	r3, [r2, #108]
.L1877:
	ldr	r3, .L1880
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1880
	str	r2, [r3, #72]
	ldr	r2, .L1880
	ldr	r3, .L1880
	str	r3, [r2, #104]
	ldr	r3, .L1880
	ldr	r2, [r3, #104]
	ldr	r3, .L1880
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1881:
	.align	2
.L1880:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_r13v, .-_Z11fx_mult_r13v
	.align	2
	.type	_Z11fx_mult_r14v, %function
_Z11fx_mult_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1886
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1886
	ldr	r3, [r3, #56]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1886
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1886
	str	r2, [r3, #60]
	ldr	r3, .L1886
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1886
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1886
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1886
	ldr	r2, [r3, #100]
	ldr	r3, .L1886+4
	cmp	r2, r3
	bne	.L1883
	ldr	r3, .L1886
	ldr	r2, [r3, #468]
	ldr	r3, .L1886
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1886
	strb	r3, [r2, #108]
.L1883:
	ldr	r3, .L1886
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1886
	str	r2, [r3, #72]
	ldr	r2, .L1886
	ldr	r3, .L1886
	str	r3, [r2, #104]
	ldr	r3, .L1886
	ldr	r2, [r3, #104]
	ldr	r3, .L1886
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1887:
	.align	2
.L1886:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_r14v, .-_Z11fx_mult_r14v
	.align	2
	.type	_Z11fx_mult_r15v, %function
_Z11fx_mult_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1892
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L1892
	ldr	r3, [r3, #60]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1892
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1892
	str	r2, [r3, #60]
	ldr	r3, .L1892
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1892
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1892
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1892
	ldr	r2, [r3, #100]
	ldr	r3, .L1892+4
	cmp	r2, r3
	bne	.L1889
	ldr	r3, .L1892
	ldr	r2, [r3, #468]
	ldr	r3, .L1892
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1892
	strb	r3, [r2, #108]
.L1889:
	ldr	r3, .L1892
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1892
	str	r2, [r3, #72]
	ldr	r2, .L1892
	ldr	r3, .L1892
	str	r3, [r2, #104]
	ldr	r3, .L1892
	ldr	r2, [r3, #104]
	ldr	r3, .L1892
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1893:
	.align	2
.L1892:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_r15v, .-_Z11fx_mult_r15v
	.align	2
	.type	_Z11fx_umult_r0v, %function
_Z11fx_umult_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1898
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1898
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1898
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1898
	str	r2, [r3, #60]
	ldr	r3, .L1898
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1898
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1898
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1898
	ldr	r2, [r3, #100]
	ldr	r3, .L1898+4
	cmp	r2, r3
	bne	.L1895
	ldr	r3, .L1898
	ldr	r2, [r3, #468]
	ldr	r3, .L1898
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1898
	strb	r3, [r2, #108]
.L1895:
	ldr	r3, .L1898
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1898
	str	r2, [r3, #72]
	ldr	r2, .L1898
	ldr	r3, .L1898
	str	r3, [r2, #104]
	ldr	r3, .L1898
	ldr	r2, [r3, #104]
	ldr	r3, .L1898
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1899:
	.align	2
.L1898:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r0v, .-_Z11fx_umult_r0v
	.align	2
	.type	_Z11fx_umult_r1v, %function
_Z11fx_umult_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1904
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1904
	ldr	r3, [r3, #4]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1904
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1904
	str	r2, [r3, #60]
	ldr	r3, .L1904
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1904
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1904
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1904
	ldr	r2, [r3, #100]
	ldr	r3, .L1904+4
	cmp	r2, r3
	bne	.L1901
	ldr	r3, .L1904
	ldr	r2, [r3, #468]
	ldr	r3, .L1904
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1904
	strb	r3, [r2, #108]
.L1901:
	ldr	r3, .L1904
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1904
	str	r2, [r3, #72]
	ldr	r2, .L1904
	ldr	r3, .L1904
	str	r3, [r2, #104]
	ldr	r3, .L1904
	ldr	r2, [r3, #104]
	ldr	r3, .L1904
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1905:
	.align	2
.L1904:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r1v, .-_Z11fx_umult_r1v
	.align	2
	.type	_Z11fx_umult_r2v, %function
_Z11fx_umult_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1910
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1910
	ldr	r3, [r3, #8]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1910
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1910
	str	r2, [r3, #60]
	ldr	r3, .L1910
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1910
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1910
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1910
	ldr	r2, [r3, #100]
	ldr	r3, .L1910+4
	cmp	r2, r3
	bne	.L1907
	ldr	r3, .L1910
	ldr	r2, [r3, #468]
	ldr	r3, .L1910
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1910
	strb	r3, [r2, #108]
.L1907:
	ldr	r3, .L1910
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1910
	str	r2, [r3, #72]
	ldr	r2, .L1910
	ldr	r3, .L1910
	str	r3, [r2, #104]
	ldr	r3, .L1910
	ldr	r2, [r3, #104]
	ldr	r3, .L1910
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1911:
	.align	2
.L1910:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r2v, .-_Z11fx_umult_r2v
	.align	2
	.type	_Z11fx_umult_r3v, %function
_Z11fx_umult_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1916
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1916
	ldr	r3, [r3, #12]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1916
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1916
	str	r2, [r3, #60]
	ldr	r3, .L1916
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1916
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1916
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1916
	ldr	r2, [r3, #100]
	ldr	r3, .L1916+4
	cmp	r2, r3
	bne	.L1913
	ldr	r3, .L1916
	ldr	r2, [r3, #468]
	ldr	r3, .L1916
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1916
	strb	r3, [r2, #108]
.L1913:
	ldr	r3, .L1916
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1916
	str	r2, [r3, #72]
	ldr	r2, .L1916
	ldr	r3, .L1916
	str	r3, [r2, #104]
	ldr	r3, .L1916
	ldr	r2, [r3, #104]
	ldr	r3, .L1916
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1917:
	.align	2
.L1916:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r3v, .-_Z11fx_umult_r3v
	.align	2
	.type	_Z11fx_umult_r4v, %function
_Z11fx_umult_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1922
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1922
	ldr	r3, [r3, #16]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1922
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1922
	str	r2, [r3, #60]
	ldr	r3, .L1922
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1922
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1922
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1922
	ldr	r2, [r3, #100]
	ldr	r3, .L1922+4
	cmp	r2, r3
	bne	.L1919
	ldr	r3, .L1922
	ldr	r2, [r3, #468]
	ldr	r3, .L1922
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1922
	strb	r3, [r2, #108]
.L1919:
	ldr	r3, .L1922
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1922
	str	r2, [r3, #72]
	ldr	r2, .L1922
	ldr	r3, .L1922
	str	r3, [r2, #104]
	ldr	r3, .L1922
	ldr	r2, [r3, #104]
	ldr	r3, .L1922
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1923:
	.align	2
.L1922:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r4v, .-_Z11fx_umult_r4v
	.align	2
	.type	_Z11fx_umult_r5v, %function
_Z11fx_umult_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1928
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1928
	ldr	r3, [r3, #20]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1928
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1928
	str	r2, [r3, #60]
	ldr	r3, .L1928
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1928
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1928
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1928
	ldr	r2, [r3, #100]
	ldr	r3, .L1928+4
	cmp	r2, r3
	bne	.L1925
	ldr	r3, .L1928
	ldr	r2, [r3, #468]
	ldr	r3, .L1928
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1928
	strb	r3, [r2, #108]
.L1925:
	ldr	r3, .L1928
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1928
	str	r2, [r3, #72]
	ldr	r2, .L1928
	ldr	r3, .L1928
	str	r3, [r2, #104]
	ldr	r3, .L1928
	ldr	r2, [r3, #104]
	ldr	r3, .L1928
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1929:
	.align	2
.L1928:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r5v, .-_Z11fx_umult_r5v
	.align	2
	.type	_Z11fx_umult_r6v, %function
_Z11fx_umult_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1934
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1934
	ldr	r3, [r3, #24]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1934
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1934
	str	r2, [r3, #60]
	ldr	r3, .L1934
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1934
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1934
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1934
	ldr	r2, [r3, #100]
	ldr	r3, .L1934+4
	cmp	r2, r3
	bne	.L1931
	ldr	r3, .L1934
	ldr	r2, [r3, #468]
	ldr	r3, .L1934
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1934
	strb	r3, [r2, #108]
.L1931:
	ldr	r3, .L1934
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1934
	str	r2, [r3, #72]
	ldr	r2, .L1934
	ldr	r3, .L1934
	str	r3, [r2, #104]
	ldr	r3, .L1934
	ldr	r2, [r3, #104]
	ldr	r3, .L1934
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1935:
	.align	2
.L1934:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r6v, .-_Z11fx_umult_r6v
	.align	2
	.type	_Z11fx_umult_r7v, %function
_Z11fx_umult_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1940
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1940
	ldr	r3, [r3, #28]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1940
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1940
	str	r2, [r3, #60]
	ldr	r3, .L1940
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1940
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1940
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1940
	ldr	r2, [r3, #100]
	ldr	r3, .L1940+4
	cmp	r2, r3
	bne	.L1937
	ldr	r3, .L1940
	ldr	r2, [r3, #468]
	ldr	r3, .L1940
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1940
	strb	r3, [r2, #108]
.L1937:
	ldr	r3, .L1940
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1940
	str	r2, [r3, #72]
	ldr	r2, .L1940
	ldr	r3, .L1940
	str	r3, [r2, #104]
	ldr	r3, .L1940
	ldr	r2, [r3, #104]
	ldr	r3, .L1940
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1941:
	.align	2
.L1940:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r7v, .-_Z11fx_umult_r7v
	.align	2
	.type	_Z11fx_umult_r8v, %function
_Z11fx_umult_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1946
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1946
	ldr	r3, [r3, #32]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1946
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1946
	str	r2, [r3, #60]
	ldr	r3, .L1946
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1946
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1946
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1946
	ldr	r2, [r3, #100]
	ldr	r3, .L1946+4
	cmp	r2, r3
	bne	.L1943
	ldr	r3, .L1946
	ldr	r2, [r3, #468]
	ldr	r3, .L1946
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1946
	strb	r3, [r2, #108]
.L1943:
	ldr	r3, .L1946
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1946
	str	r2, [r3, #72]
	ldr	r2, .L1946
	ldr	r3, .L1946
	str	r3, [r2, #104]
	ldr	r3, .L1946
	ldr	r2, [r3, #104]
	ldr	r3, .L1946
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1947:
	.align	2
.L1946:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r8v, .-_Z11fx_umult_r8v
	.align	2
	.type	_Z11fx_umult_r9v, %function
_Z11fx_umult_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1952
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1952
	ldr	r3, [r3, #36]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1952
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1952
	str	r2, [r3, #60]
	ldr	r3, .L1952
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1952
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1952
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1952
	ldr	r2, [r3, #100]
	ldr	r3, .L1952+4
	cmp	r2, r3
	bne	.L1949
	ldr	r3, .L1952
	ldr	r2, [r3, #468]
	ldr	r3, .L1952
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1952
	strb	r3, [r2, #108]
.L1949:
	ldr	r3, .L1952
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1952
	str	r2, [r3, #72]
	ldr	r2, .L1952
	ldr	r3, .L1952
	str	r3, [r2, #104]
	ldr	r3, .L1952
	ldr	r2, [r3, #104]
	ldr	r3, .L1952
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1953:
	.align	2
.L1952:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_r9v, .-_Z11fx_umult_r9v
	.align	2
	.type	_Z12fx_umult_r10v, %function
_Z12fx_umult_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1958
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1958
	ldr	r3, [r3, #40]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1958
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1958
	str	r2, [r3, #60]
	ldr	r3, .L1958
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1958
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1958
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1958
	ldr	r2, [r3, #100]
	ldr	r3, .L1958+4
	cmp	r2, r3
	bne	.L1955
	ldr	r3, .L1958
	ldr	r2, [r3, #468]
	ldr	r3, .L1958
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1958
	strb	r3, [r2, #108]
.L1955:
	ldr	r3, .L1958
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1958
	str	r2, [r3, #72]
	ldr	r2, .L1958
	ldr	r3, .L1958
	str	r3, [r2, #104]
	ldr	r3, .L1958
	ldr	r2, [r3, #104]
	ldr	r3, .L1958
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1959:
	.align	2
.L1958:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_r10v, .-_Z12fx_umult_r10v
	.align	2
	.type	_Z12fx_umult_r11v, %function
_Z12fx_umult_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1964
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1964
	ldr	r3, [r3, #44]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1964
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1964
	str	r2, [r3, #60]
	ldr	r3, .L1964
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1964
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1964
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1964
	ldr	r2, [r3, #100]
	ldr	r3, .L1964+4
	cmp	r2, r3
	bne	.L1961
	ldr	r3, .L1964
	ldr	r2, [r3, #468]
	ldr	r3, .L1964
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1964
	strb	r3, [r2, #108]
.L1961:
	ldr	r3, .L1964
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1964
	str	r2, [r3, #72]
	ldr	r2, .L1964
	ldr	r3, .L1964
	str	r3, [r2, #104]
	ldr	r3, .L1964
	ldr	r2, [r3, #104]
	ldr	r3, .L1964
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1965:
	.align	2
.L1964:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_r11v, .-_Z12fx_umult_r11v
	.align	2
	.type	_Z12fx_umult_r12v, %function
_Z12fx_umult_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1970
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1970
	ldr	r3, [r3, #48]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1970
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1970
	str	r2, [r3, #60]
	ldr	r3, .L1970
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1970
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1970
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1970
	ldr	r2, [r3, #100]
	ldr	r3, .L1970+4
	cmp	r2, r3
	bne	.L1967
	ldr	r3, .L1970
	ldr	r2, [r3, #468]
	ldr	r3, .L1970
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1970
	strb	r3, [r2, #108]
.L1967:
	ldr	r3, .L1970
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1970
	str	r2, [r3, #72]
	ldr	r2, .L1970
	ldr	r3, .L1970
	str	r3, [r2, #104]
	ldr	r3, .L1970
	ldr	r2, [r3, #104]
	ldr	r3, .L1970
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1971:
	.align	2
.L1970:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_r12v, .-_Z12fx_umult_r12v
	.align	2
	.type	_Z12fx_umult_r13v, %function
_Z12fx_umult_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1976
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1976
	ldr	r3, [r3, #52]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1976
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1976
	str	r2, [r3, #60]
	ldr	r3, .L1976
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1976
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1976
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1976
	ldr	r2, [r3, #100]
	ldr	r3, .L1976+4
	cmp	r2, r3
	bne	.L1973
	ldr	r3, .L1976
	ldr	r2, [r3, #468]
	ldr	r3, .L1976
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1976
	strb	r3, [r2, #108]
.L1973:
	ldr	r3, .L1976
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1976
	str	r2, [r3, #72]
	ldr	r2, .L1976
	ldr	r3, .L1976
	str	r3, [r2, #104]
	ldr	r3, .L1976
	ldr	r2, [r3, #104]
	ldr	r3, .L1976
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1977:
	.align	2
.L1976:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_r13v, .-_Z12fx_umult_r13v
	.align	2
	.type	_Z12fx_umult_r14v, %function
_Z12fx_umult_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1982
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1982
	ldr	r3, [r3, #56]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1982
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1982
	str	r2, [r3, #60]
	ldr	r3, .L1982
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1982
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1982
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1982
	ldr	r2, [r3, #100]
	ldr	r3, .L1982+4
	cmp	r2, r3
	bne	.L1979
	ldr	r3, .L1982
	ldr	r2, [r3, #468]
	ldr	r3, .L1982
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1982
	strb	r3, [r2, #108]
.L1979:
	ldr	r3, .L1982
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1982
	str	r2, [r3, #72]
	ldr	r2, .L1982
	ldr	r3, .L1982
	str	r3, [r2, #104]
	ldr	r3, .L1982
	ldr	r2, [r3, #104]
	ldr	r3, .L1982
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1983:
	.align	2
.L1982:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_r14v, .-_Z12fx_umult_r14v
	.align	2
	.type	_Z12fx_umult_r15v, %function
_Z12fx_umult_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L1988
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, .L1988
	ldr	r3, [r3, #60]
	and	r3, r3, #255
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L1988
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1988
	str	r2, [r3, #60]
	ldr	r3, .L1988
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1988
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1988
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1988
	ldr	r2, [r3, #100]
	ldr	r3, .L1988+4
	cmp	r2, r3
	bne	.L1985
	ldr	r3, .L1988
	ldr	r2, [r3, #468]
	ldr	r3, .L1988
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1988
	strb	r3, [r2, #108]
.L1985:
	ldr	r3, .L1988
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1988
	str	r2, [r3, #72]
	ldr	r2, .L1988
	ldr	r3, .L1988
	str	r3, [r2, #104]
	ldr	r3, .L1988
	ldr	r2, [r3, #104]
	ldr	r3, .L1988
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1989:
	.align	2
.L1988:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_r15v, .-_Z12fx_umult_r15v
	.align	2
	.type	_Z10fx_mult_i0v, %function
_Z10fx_mult_i0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	mov	r3, #0
	str	r3, [fp, #-16]
	ldr	r3, .L1994
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L1994
	str	r2, [r3, #60]
	ldr	r3, .L1994
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L1994
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L1994
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L1994
	ldr	r2, [r3, #100]
	ldr	r3, .L1994+4
	cmp	r2, r3
	bne	.L1991
	ldr	r3, .L1994
	ldr	r2, [r3, #468]
	ldr	r3, .L1994
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L1994
	strb	r3, [r2, #108]
.L1991:
	ldr	r3, .L1994
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L1994
	str	r2, [r3, #72]
	ldr	r2, .L1994
	ldr	r3, .L1994
	str	r3, [r2, #104]
	ldr	r3, .L1994
	ldr	r2, [r3, #104]
	ldr	r3, .L1994
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L1995:
	.align	2
.L1994:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i0v, .-_Z10fx_mult_i0v
	.align	2
	.type	_Z10fx_mult_i1v, %function
_Z10fx_mult_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2000
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	str	r3, [fp, #-16]
	ldr	r3, .L2000
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2000
	str	r2, [r3, #60]
	ldr	r3, .L2000
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2000
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2000
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2000
	ldr	r2, [r3, #100]
	ldr	r3, .L2000+4
	cmp	r2, r3
	bne	.L1997
	ldr	r3, .L2000
	ldr	r2, [r3, #468]
	ldr	r3, .L2000
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2000
	strb	r3, [r2, #108]
.L1997:
	ldr	r3, .L2000
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2000
	str	r2, [r3, #72]
	ldr	r2, .L2000
	ldr	r3, .L2000
	str	r3, [r2, #104]
	ldr	r3, .L2000
	ldr	r2, [r3, #104]
	ldr	r3, .L2000
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2001:
	.align	2
.L2000:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i1v, .-_Z10fx_mult_i1v
	.align	2
	.type	_Z10fx_mult_i2v, %function
_Z10fx_mult_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2006
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r3, r3, asl #1
	str	r3, [fp, #-16]
	ldr	r3, .L2006
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2006
	str	r2, [r3, #60]
	ldr	r3, .L2006
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2006
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2006
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2006
	ldr	r2, [r3, #100]
	ldr	r3, .L2006+4
	cmp	r2, r3
	bne	.L2003
	ldr	r3, .L2006
	ldr	r2, [r3, #468]
	ldr	r3, .L2006
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2006
	strb	r3, [r2, #108]
.L2003:
	ldr	r3, .L2006
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2006
	str	r2, [r3, #72]
	ldr	r2, .L2006
	ldr	r3, .L2006
	str	r3, [r2, #104]
	ldr	r3, .L2006
	ldr	r2, [r3, #104]
	ldr	r3, .L2006
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2007:
	.align	2
.L2006:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i2v, .-_Z10fx_mult_i2v
	.align	2
	.type	_Z10fx_mult_i3v, %function
_Z10fx_mult_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2012
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L2012
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2012
	str	r2, [r3, #60]
	ldr	r3, .L2012
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2012
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2012
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2012
	ldr	r2, [r3, #100]
	ldr	r3, .L2012+4
	cmp	r2, r3
	bne	.L2009
	ldr	r3, .L2012
	ldr	r2, [r3, #468]
	ldr	r3, .L2012
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2012
	strb	r3, [r2, #108]
.L2009:
	ldr	r3, .L2012
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2012
	str	r2, [r3, #72]
	ldr	r2, .L2012
	ldr	r3, .L2012
	str	r3, [r2, #104]
	ldr	r3, .L2012
	ldr	r2, [r3, #104]
	ldr	r3, .L2012
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2013:
	.align	2
.L2012:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i3v, .-_Z10fx_mult_i3v
	.align	2
	.type	_Z10fx_mult_i4v, %function
_Z10fx_mult_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2018
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r3, r3, asl #2
	str	r3, [fp, #-16]
	ldr	r3, .L2018
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2018
	str	r2, [r3, #60]
	ldr	r3, .L2018
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2018
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2018
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2018
	ldr	r2, [r3, #100]
	ldr	r3, .L2018+4
	cmp	r2, r3
	bne	.L2015
	ldr	r3, .L2018
	ldr	r2, [r3, #468]
	ldr	r3, .L2018
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2018
	strb	r3, [r2, #108]
.L2015:
	ldr	r3, .L2018
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2018
	str	r2, [r3, #72]
	ldr	r2, .L2018
	ldr	r3, .L2018
	str	r3, [r2, #104]
	ldr	r3, .L2018
	ldr	r2, [r3, #104]
	ldr	r3, .L2018
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2019:
	.align	2
.L2018:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i4v, .-_Z10fx_mult_i4v
	.align	2
	.type	_Z10fx_mult_i5v, %function
_Z10fx_mult_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2024
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L2024
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2024
	str	r2, [r3, #60]
	ldr	r3, .L2024
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2024
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2024
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2024
	ldr	r2, [r3, #100]
	ldr	r3, .L2024+4
	cmp	r2, r3
	bne	.L2021
	ldr	r3, .L2024
	ldr	r2, [r3, #468]
	ldr	r3, .L2024
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2024
	strb	r3, [r2, #108]
.L2021:
	ldr	r3, .L2024
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2024
	str	r2, [r3, #72]
	ldr	r2, .L2024
	ldr	r3, .L2024
	str	r3, [r2, #104]
	ldr	r3, .L2024
	ldr	r2, [r3, #104]
	ldr	r3, .L2024
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2025:
	.align	2
.L2024:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i5v, .-_Z10fx_mult_i5v
	.align	2
	.type	_Z10fx_mult_i6v, %function
_Z10fx_mult_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2030
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r2, r3, asl #1
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2030
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2030
	str	r2, [r3, #60]
	ldr	r3, .L2030
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2030
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2030
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2030
	ldr	r2, [r3, #100]
	ldr	r3, .L2030+4
	cmp	r2, r3
	bne	.L2027
	ldr	r3, .L2030
	ldr	r2, [r3, #468]
	ldr	r3, .L2030
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2030
	strb	r3, [r2, #108]
.L2027:
	ldr	r3, .L2030
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2030
	str	r2, [r3, #72]
	ldr	r2, .L2030
	ldr	r3, .L2030
	str	r3, [r2, #104]
	ldr	r3, .L2030
	ldr	r2, [r3, #104]
	ldr	r3, .L2030
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2031:
	.align	2
.L2030:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i6v, .-_Z10fx_mult_i6v
	.align	2
	.type	_Z10fx_mult_i7v, %function
_Z10fx_mult_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2036
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2036
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2036
	str	r2, [r3, #60]
	ldr	r3, .L2036
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2036
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2036
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2036
	ldr	r2, [r3, #100]
	ldr	r3, .L2036+4
	cmp	r2, r3
	bne	.L2033
	ldr	r3, .L2036
	ldr	r2, [r3, #468]
	ldr	r3, .L2036
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2036
	strb	r3, [r2, #108]
.L2033:
	ldr	r3, .L2036
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2036
	str	r2, [r3, #72]
	ldr	r2, .L2036
	ldr	r3, .L2036
	str	r3, [r2, #104]
	ldr	r3, .L2036
	ldr	r2, [r3, #104]
	ldr	r3, .L2036
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2037:
	.align	2
.L2036:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i7v, .-_Z10fx_mult_i7v
	.align	2
	.type	_Z10fx_mult_i8v, %function
_Z10fx_mult_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2042
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r3, r3, asl #3
	str	r3, [fp, #-16]
	ldr	r3, .L2042
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2042
	str	r2, [r3, #60]
	ldr	r3, .L2042
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2042
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2042
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2042
	ldr	r2, [r3, #100]
	ldr	r3, .L2042+4
	cmp	r2, r3
	bne	.L2039
	ldr	r3, .L2042
	ldr	r2, [r3, #468]
	ldr	r3, .L2042
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2042
	strb	r3, [r2, #108]
.L2039:
	ldr	r3, .L2042
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2042
	str	r2, [r3, #72]
	ldr	r2, .L2042
	ldr	r3, .L2042
	str	r3, [r2, #104]
	ldr	r3, .L2042
	ldr	r2, [r3, #104]
	ldr	r3, .L2042
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2043:
	.align	2
.L2042:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i8v, .-_Z10fx_mult_i8v
	.align	2
	.type	_Z10fx_mult_i9v, %function
_Z10fx_mult_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2048
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	mov	r3, r2
	mov	r3, r3, asl #3
	add	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L2048
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2048
	str	r2, [r3, #60]
	ldr	r3, .L2048
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2048
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2048
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2048
	ldr	r2, [r3, #100]
	ldr	r3, .L2048+4
	cmp	r2, r3
	bne	.L2045
	ldr	r3, .L2048
	ldr	r2, [r3, #468]
	ldr	r3, .L2048
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2048
	strb	r3, [r2, #108]
.L2045:
	ldr	r3, .L2048
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2048
	str	r2, [r3, #72]
	ldr	r2, .L2048
	ldr	r3, .L2048
	str	r3, [r2, #104]
	ldr	r3, .L2048
	ldr	r2, [r3, #104]
	ldr	r3, .L2048
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2049:
	.align	2
.L2048:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_mult_i9v, .-_Z10fx_mult_i9v
	.align	2
	.type	_Z11fx_mult_i10v, %function
_Z11fx_mult_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2054
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r2, r3, asl #1
	mov	r3, r2, asl #2
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2054
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2054
	str	r2, [r3, #60]
	ldr	r3, .L2054
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2054
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2054
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2054
	ldr	r2, [r3, #100]
	ldr	r3, .L2054+4
	cmp	r2, r3
	bne	.L2051
	ldr	r3, .L2054
	ldr	r2, [r3, #468]
	ldr	r3, .L2054
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2054
	strb	r3, [r2, #108]
.L2051:
	ldr	r3, .L2054
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2054
	str	r2, [r3, #72]
	ldr	r2, .L2054
	ldr	r3, .L2054
	str	r3, [r2, #104]
	ldr	r3, .L2054
	ldr	r2, [r3, #104]
	ldr	r3, .L2054
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2055:
	.align	2
.L2054:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_i10v, .-_Z11fx_mult_i10v
	.align	2
	.type	_Z11fx_mult_i11v, %function
_Z11fx_mult_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2060
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r1, r3, asr #24
	mov	r3, r1
	mov	r2, r3, asl #2
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	rsb	r3, r1, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2060
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2060
	str	r2, [r3, #60]
	ldr	r3, .L2060
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2060
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2060
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2060
	ldr	r2, [r3, #100]
	ldr	r3, .L2060+4
	cmp	r2, r3
	bne	.L2057
	ldr	r3, .L2060
	ldr	r2, [r3, #468]
	ldr	r3, .L2060
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2060
	strb	r3, [r2, #108]
.L2057:
	ldr	r3, .L2060
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2060
	str	r2, [r3, #72]
	ldr	r2, .L2060
	ldr	r3, .L2060
	str	r3, [r2, #104]
	ldr	r3, .L2060
	ldr	r2, [r3, #104]
	ldr	r3, .L2060
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2061:
	.align	2
.L2060:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_i11v, .-_Z11fx_mult_i11v
	.align	2
	.type	_Z11fx_mult_i12v, %function
_Z11fx_mult_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2066
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r2, r3, asl #2
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2066
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2066
	str	r2, [r3, #60]
	ldr	r3, .L2066
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2066
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2066
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2066
	ldr	r2, [r3, #100]
	ldr	r3, .L2066+4
	cmp	r2, r3
	bne	.L2063
	ldr	r3, .L2066
	ldr	r2, [r3, #468]
	ldr	r3, .L2066
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2066
	strb	r3, [r2, #108]
.L2063:
	ldr	r3, .L2066
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2066
	str	r2, [r3, #72]
	ldr	r2, .L2066
	ldr	r3, .L2066
	str	r3, [r2, #104]
	ldr	r3, .L2066
	ldr	r2, [r3, #104]
	ldr	r3, .L2066
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2067:
	.align	2
.L2066:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_i12v, .-_Z11fx_mult_i12v
	.align	2
	.type	_Z11fx_mult_i13v, %function
_Z11fx_mult_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2072
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r1, r3, asr #24
	mov	r3, r1
	mov	r2, r3, asl #2
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	add	r3, r3, r1
	str	r3, [fp, #-16]
	ldr	r3, .L2072
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2072
	str	r2, [r3, #60]
	ldr	r3, .L2072
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2072
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2072
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2072
	ldr	r2, [r3, #100]
	ldr	r3, .L2072+4
	cmp	r2, r3
	bne	.L2069
	ldr	r3, .L2072
	ldr	r2, [r3, #468]
	ldr	r3, .L2072
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2072
	strb	r3, [r2, #108]
.L2069:
	ldr	r3, .L2072
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2072
	str	r2, [r3, #72]
	ldr	r2, .L2072
	ldr	r3, .L2072
	str	r3, [r2, #104]
	ldr	r3, .L2072
	ldr	r2, [r3, #104]
	ldr	r3, .L2072
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2073:
	.align	2
.L2072:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_i13v, .-_Z11fx_mult_i13v
	.align	2
	.type	_Z11fx_mult_i14v, %function
_Z11fx_mult_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2078
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mov	r2, r3, asl #1
	mov	r3, r2, asl #3
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2078
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2078
	str	r2, [r3, #60]
	ldr	r3, .L2078
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2078
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2078
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2078
	ldr	r2, [r3, #100]
	ldr	r3, .L2078+4
	cmp	r2, r3
	bne	.L2075
	ldr	r3, .L2078
	ldr	r2, [r3, #468]
	ldr	r3, .L2078
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2078
	strb	r3, [r2, #108]
.L2075:
	ldr	r3, .L2078
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2078
	str	r2, [r3, #72]
	ldr	r2, .L2078
	ldr	r3, .L2078
	str	r3, [r2, #104]
	ldr	r3, .L2078
	ldr	r2, [r3, #104]
	ldr	r3, .L2078
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2079:
	.align	2
.L2078:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_i14v, .-_Z11fx_mult_i14v
	.align	2
	.type	_Z11fx_mult_i15v, %function
_Z11fx_mult_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2084
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	mov	r3, r2
	mov	r3, r3, asl #4
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2084
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2084
	str	r2, [r3, #60]
	ldr	r3, .L2084
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2084
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2084
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2084
	ldr	r2, [r3, #100]
	ldr	r3, .L2084+4
	cmp	r2, r3
	bne	.L2081
	ldr	r3, .L2084
	ldr	r2, [r3, #468]
	ldr	r3, .L2084
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2084
	strb	r3, [r2, #108]
.L2081:
	ldr	r3, .L2084
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2084
	str	r2, [r3, #72]
	ldr	r2, .L2084
	ldr	r3, .L2084
	str	r3, [r2, #104]
	ldr	r3, .L2084
	ldr	r2, [r3, #104]
	ldr	r3, .L2084
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2085:
	.align	2
.L2084:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_mult_i15v, .-_Z11fx_mult_i15v
	.align	2
	.type	_Z11fx_umult_i0v, %function
_Z11fx_umult_i0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	mov	r3, #0
	str	r3, [fp, #-16]
	ldr	r3, .L2090
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2090
	str	r2, [r3, #60]
	ldr	r3, .L2090
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2090
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2090
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2090
	ldr	r2, [r3, #100]
	ldr	r3, .L2090+4
	cmp	r2, r3
	bne	.L2087
	ldr	r3, .L2090
	ldr	r2, [r3, #468]
	ldr	r3, .L2090
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2090
	strb	r3, [r2, #108]
.L2087:
	ldr	r3, .L2090
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2090
	str	r2, [r3, #72]
	ldr	r2, .L2090
	ldr	r3, .L2090
	str	r3, [r2, #104]
	ldr	r3, .L2090
	ldr	r2, [r3, #104]
	ldr	r3, .L2090
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2091:
	.align	2
.L2090:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i0v, .-_Z11fx_umult_i0v
	.align	2
	.type	_Z11fx_umult_i1v, %function
_Z11fx_umult_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2096
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	str	r3, [fp, #-16]
	ldr	r3, .L2096
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2096
	str	r2, [r3, #60]
	ldr	r3, .L2096
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2096
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2096
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2096
	ldr	r2, [r3, #100]
	ldr	r3, .L2096+4
	cmp	r2, r3
	bne	.L2093
	ldr	r3, .L2096
	ldr	r2, [r3, #468]
	ldr	r3, .L2096
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2096
	strb	r3, [r2, #108]
.L2093:
	ldr	r3, .L2096
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2096
	str	r2, [r3, #72]
	ldr	r2, .L2096
	ldr	r3, .L2096
	str	r3, [r2, #104]
	ldr	r3, .L2096
	ldr	r2, [r3, #104]
	ldr	r3, .L2096
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2097:
	.align	2
.L2096:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i1v, .-_Z11fx_umult_i1v
	.align	2
	.type	_Z11fx_umult_i2v, %function
_Z11fx_umult_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2102
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #1
	str	r3, [fp, #-16]
	ldr	r3, .L2102
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2102
	str	r2, [r3, #60]
	ldr	r3, .L2102
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2102
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2102
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2102
	ldr	r2, [r3, #100]
	ldr	r3, .L2102+4
	cmp	r2, r3
	bne	.L2099
	ldr	r3, .L2102
	ldr	r2, [r3, #468]
	ldr	r3, .L2102
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2102
	strb	r3, [r2, #108]
.L2099:
	ldr	r3, .L2102
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2102
	str	r2, [r3, #72]
	ldr	r2, .L2102
	ldr	r3, .L2102
	str	r3, [r2, #104]
	ldr	r3, .L2102
	ldr	r2, [r3, #104]
	ldr	r3, .L2102
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2103:
	.align	2
.L2102:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i2v, .-_Z11fx_umult_i2v
	.align	2
	.type	_Z11fx_umult_i3v, %function
_Z11fx_umult_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2108
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #1
	add	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L2108
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2108
	str	r2, [r3, #60]
	ldr	r3, .L2108
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2108
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2108
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2108
	ldr	r2, [r3, #100]
	ldr	r3, .L2108+4
	cmp	r2, r3
	bne	.L2105
	ldr	r3, .L2108
	ldr	r2, [r3, #468]
	ldr	r3, .L2108
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2108
	strb	r3, [r2, #108]
.L2105:
	ldr	r3, .L2108
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2108
	str	r2, [r3, #72]
	ldr	r2, .L2108
	ldr	r3, .L2108
	str	r3, [r2, #104]
	ldr	r3, .L2108
	ldr	r2, [r3, #104]
	ldr	r3, .L2108
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2109:
	.align	2
.L2108:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i3v, .-_Z11fx_umult_i3v
	.align	2
	.type	_Z11fx_umult_i4v, %function
_Z11fx_umult_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2114
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #2
	str	r3, [fp, #-16]
	ldr	r3, .L2114
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2114
	str	r2, [r3, #60]
	ldr	r3, .L2114
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2114
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2114
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2114
	ldr	r2, [r3, #100]
	ldr	r3, .L2114+4
	cmp	r2, r3
	bne	.L2111
	ldr	r3, .L2114
	ldr	r2, [r3, #468]
	ldr	r3, .L2114
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2114
	strb	r3, [r2, #108]
.L2111:
	ldr	r3, .L2114
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2114
	str	r2, [r3, #72]
	ldr	r2, .L2114
	ldr	r3, .L2114
	str	r3, [r2, #104]
	ldr	r3, .L2114
	ldr	r2, [r3, #104]
	ldr	r3, .L2114
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2115:
	.align	2
.L2114:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i4v, .-_Z11fx_umult_i4v
	.align	2
	.type	_Z11fx_umult_i5v, %function
_Z11fx_umult_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2120
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L2120
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2120
	str	r2, [r3, #60]
	ldr	r3, .L2120
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2120
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2120
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2120
	ldr	r2, [r3, #100]
	ldr	r3, .L2120+4
	cmp	r2, r3
	bne	.L2117
	ldr	r3, .L2120
	ldr	r2, [r3, #468]
	ldr	r3, .L2120
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2120
	strb	r3, [r2, #108]
.L2117:
	ldr	r3, .L2120
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2120
	str	r2, [r3, #72]
	ldr	r2, .L2120
	ldr	r3, .L2120
	str	r3, [r2, #104]
	ldr	r3, .L2120
	ldr	r2, [r3, #104]
	ldr	r3, .L2120
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2121:
	.align	2
.L2120:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i5v, .-_Z11fx_umult_i5v
	.align	2
	.type	_Z11fx_umult_i6v, %function
_Z11fx_umult_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2126
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3, asl #1
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2126
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2126
	str	r2, [r3, #60]
	ldr	r3, .L2126
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2126
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2126
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2126
	ldr	r2, [r3, #100]
	ldr	r3, .L2126+4
	cmp	r2, r3
	bne	.L2123
	ldr	r3, .L2126
	ldr	r2, [r3, #468]
	ldr	r3, .L2126
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2126
	strb	r3, [r2, #108]
.L2123:
	ldr	r3, .L2126
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2126
	str	r2, [r3, #72]
	ldr	r2, .L2126
	ldr	r3, .L2126
	str	r3, [r2, #104]
	ldr	r3, .L2126
	ldr	r2, [r3, #104]
	ldr	r3, .L2126
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2127:
	.align	2
.L2126:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i6v, .-_Z11fx_umult_i6v
	.align	2
	.type	_Z11fx_umult_i7v, %function
_Z11fx_umult_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2132
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #3
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2132
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2132
	str	r2, [r3, #60]
	ldr	r3, .L2132
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2132
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2132
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2132
	ldr	r2, [r3, #100]
	ldr	r3, .L2132+4
	cmp	r2, r3
	bne	.L2129
	ldr	r3, .L2132
	ldr	r2, [r3, #468]
	ldr	r3, .L2132
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2132
	strb	r3, [r2, #108]
.L2129:
	ldr	r3, .L2132
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2132
	str	r2, [r3, #72]
	ldr	r2, .L2132
	ldr	r3, .L2132
	str	r3, [r2, #104]
	ldr	r3, .L2132
	ldr	r2, [r3, #104]
	ldr	r3, .L2132
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2133:
	.align	2
.L2132:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i7v, .-_Z11fx_umult_i7v
	.align	2
	.type	_Z11fx_umult_i8v, %function
_Z11fx_umult_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2138
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #3
	str	r3, [fp, #-16]
	ldr	r3, .L2138
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2138
	str	r2, [r3, #60]
	ldr	r3, .L2138
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2138
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2138
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2138
	ldr	r2, [r3, #100]
	ldr	r3, .L2138+4
	cmp	r2, r3
	bne	.L2135
	ldr	r3, .L2138
	ldr	r2, [r3, #468]
	ldr	r3, .L2138
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2138
	strb	r3, [r2, #108]
.L2135:
	ldr	r3, .L2138
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2138
	str	r2, [r3, #72]
	ldr	r2, .L2138
	ldr	r3, .L2138
	str	r3, [r2, #104]
	ldr	r3, .L2138
	ldr	r2, [r3, #104]
	ldr	r3, .L2138
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2139:
	.align	2
.L2138:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i8v, .-_Z11fx_umult_i8v
	.align	2
	.type	_Z11fx_umult_i9v, %function
_Z11fx_umult_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2144
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #3
	add	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L2144
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2144
	str	r2, [r3, #60]
	ldr	r3, .L2144
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2144
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2144
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2144
	ldr	r2, [r3, #100]
	ldr	r3, .L2144+4
	cmp	r2, r3
	bne	.L2141
	ldr	r3, .L2144
	ldr	r2, [r3, #468]
	ldr	r3, .L2144
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2144
	strb	r3, [r2, #108]
.L2141:
	ldr	r3, .L2144
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2144
	str	r2, [r3, #72]
	ldr	r2, .L2144
	ldr	r3, .L2144
	str	r3, [r2, #104]
	ldr	r3, .L2144
	ldr	r2, [r3, #104]
	ldr	r3, .L2144
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2145:
	.align	2
.L2144:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_umult_i9v, .-_Z11fx_umult_i9v
	.align	2
	.type	_Z12fx_umult_i10v, %function
_Z12fx_umult_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2150
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3, asl #1
	mov	r3, r2, asl #2
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2150
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2150
	str	r2, [r3, #60]
	ldr	r3, .L2150
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2150
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2150
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2150
	ldr	r2, [r3, #100]
	ldr	r3, .L2150+4
	cmp	r2, r3
	bne	.L2147
	ldr	r3, .L2150
	ldr	r2, [r3, #468]
	ldr	r3, .L2150
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2150
	strb	r3, [r2, #108]
.L2147:
	ldr	r3, .L2150
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2150
	str	r2, [r3, #72]
	ldr	r2, .L2150
	ldr	r3, .L2150
	str	r3, [r2, #104]
	ldr	r3, .L2150
	ldr	r2, [r3, #104]
	ldr	r3, .L2150
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2151:
	.align	2
.L2150:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_i10v, .-_Z12fx_umult_i10v
	.align	2
	.type	_Z12fx_umult_i11v, %function
_Z12fx_umult_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2156
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r1, r3
	mov	r3, r1
	mov	r2, r3, asl #2
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	rsb	r3, r1, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2156
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2156
	str	r2, [r3, #60]
	ldr	r3, .L2156
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2156
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2156
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2156
	ldr	r2, [r3, #100]
	ldr	r3, .L2156+4
	cmp	r2, r3
	bne	.L2153
	ldr	r3, .L2156
	ldr	r2, [r3, #468]
	ldr	r3, .L2156
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2156
	strb	r3, [r2, #108]
.L2153:
	ldr	r3, .L2156
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2156
	str	r2, [r3, #72]
	ldr	r2, .L2156
	ldr	r3, .L2156
	str	r3, [r2, #104]
	ldr	r3, .L2156
	ldr	r2, [r3, #104]
	ldr	r3, .L2156
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2157:
	.align	2
.L2156:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_i11v, .-_Z12fx_umult_i11v
	.align	2
	.type	_Z12fx_umult_i12v, %function
_Z12fx_umult_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2162
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3, asl #2
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2162
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2162
	str	r2, [r3, #60]
	ldr	r3, .L2162
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2162
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2162
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2162
	ldr	r2, [r3, #100]
	ldr	r3, .L2162+4
	cmp	r2, r3
	bne	.L2159
	ldr	r3, .L2162
	ldr	r2, [r3, #468]
	ldr	r3, .L2162
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2162
	strb	r3, [r2, #108]
.L2159:
	ldr	r3, .L2162
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2162
	str	r2, [r3, #72]
	ldr	r2, .L2162
	ldr	r3, .L2162
	str	r3, [r2, #104]
	ldr	r3, .L2162
	ldr	r2, [r3, #104]
	ldr	r3, .L2162
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2163:
	.align	2
.L2162:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_i12v, .-_Z12fx_umult_i12v
	.align	2
	.type	_Z12fx_umult_i13v, %function
_Z12fx_umult_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2168
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r1, r3
	mov	r3, r1
	mov	r2, r3, asl #2
	mov	r3, r2, asl #2
	rsb	r3, r2, r3
	add	r3, r3, r1
	str	r3, [fp, #-16]
	ldr	r3, .L2168
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2168
	str	r2, [r3, #60]
	ldr	r3, .L2168
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2168
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2168
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2168
	ldr	r2, [r3, #100]
	ldr	r3, .L2168+4
	cmp	r2, r3
	bne	.L2165
	ldr	r3, .L2168
	ldr	r2, [r3, #468]
	ldr	r3, .L2168
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2168
	strb	r3, [r2, #108]
.L2165:
	ldr	r3, .L2168
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2168
	str	r2, [r3, #72]
	ldr	r2, .L2168
	ldr	r3, .L2168
	str	r3, [r2, #104]
	ldr	r3, .L2168
	ldr	r2, [r3, #104]
	ldr	r3, .L2168
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2169:
	.align	2
.L2168:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_i13v, .-_Z12fx_umult_i13v
	.align	2
	.type	_Z12fx_umult_i14v, %function
_Z12fx_umult_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2174
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3, asl #1
	mov	r3, r2, asl #3
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2174
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2174
	str	r2, [r3, #60]
	ldr	r3, .L2174
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2174
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2174
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2174
	ldr	r2, [r3, #100]
	ldr	r3, .L2174+4
	cmp	r2, r3
	bne	.L2171
	ldr	r3, .L2174
	ldr	r2, [r3, #468]
	ldr	r3, .L2174
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2174
	strb	r3, [r2, #108]
.L2171:
	ldr	r3, .L2174
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2174
	str	r2, [r3, #72]
	ldr	r2, .L2174
	ldr	r3, .L2174
	str	r3, [r2, #104]
	ldr	r3, .L2174
	ldr	r2, [r3, #104]
	ldr	r3, .L2174
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2175:
	.align	2
.L2174:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_i14v, .-_Z12fx_umult_i14v
	.align	2
	.type	_Z12fx_umult_i15v, %function
_Z12fx_umult_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2180
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	mov	r3, r2
	mov	r3, r3, asl #4
	rsb	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2180
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2180
	str	r2, [r3, #60]
	ldr	r3, .L2180
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2180
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2180
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2180
	ldr	r2, [r3, #100]
	ldr	r3, .L2180+4
	cmp	r2, r3
	bne	.L2177
	ldr	r3, .L2180
	ldr	r2, [r3, #468]
	ldr	r3, .L2180
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2180
	strb	r3, [r2, #108]
.L2177:
	ldr	r3, .L2180
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2180
	str	r2, [r3, #72]
	ldr	r2, .L2180
	ldr	r3, .L2180
	str	r3, [r2, #104]
	ldr	r3, .L2180
	ldr	r2, [r3, #104]
	ldr	r3, .L2180
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2181:
	.align	2
.L2180:
	.word	GSU
	.word	GSU+56
	.size	_Z12fx_umult_i15v, .-_Z12fx_umult_i15v
	.align	2
	.type	_Z6fx_sbkv, %function
_Z6fx_sbkv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2184
	ldr	r2, [r3, #464]
	ldr	r3, .L2184
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L2184
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2184
	ldr	r2, [r3, #464]
	ldr	r3, .L2184
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, .L2184
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2184
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2184
	str	r2, [r3, #72]
	ldr	r2, .L2184
	ldr	r3, .L2184
	str	r3, [r2, #104]
	ldr	r3, .L2184
	ldr	r2, [r3, #104]
	ldr	r3, .L2184
	str	r2, [r3, #100]
	ldr	r3, .L2184
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2184
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2185:
	.align	2
.L2184:
	.word	GSU
	.size	_Z6fx_sbkv, .-_Z6fx_sbkv
	.align	2
	.type	_Z10fx_link_i1v, %function
_Z10fx_link_i1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2188
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2188
	str	r2, [r3, #44]
	ldr	r3, .L2188
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2188
	str	r2, [r3, #72]
	ldr	r2, .L2188
	ldr	r3, .L2188
	str	r3, [r2, #104]
	ldr	r3, .L2188
	ldr	r2, [r3, #104]
	ldr	r3, .L2188
	str	r2, [r3, #100]
	ldr	r3, .L2188
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2188
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2189:
	.align	2
.L2188:
	.word	GSU
	.size	_Z10fx_link_i1v, .-_Z10fx_link_i1v
	.align	2
	.type	_Z10fx_link_i2v, %function
_Z10fx_link_i2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2192
	ldr	r3, [r3, #60]
	add	r2, r3, #2
	ldr	r3, .L2192
	str	r2, [r3, #44]
	ldr	r3, .L2192
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2192
	str	r2, [r3, #72]
	ldr	r2, .L2192
	ldr	r3, .L2192
	str	r3, [r2, #104]
	ldr	r3, .L2192
	ldr	r2, [r3, #104]
	ldr	r3, .L2192
	str	r2, [r3, #100]
	ldr	r3, .L2192
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2192
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2193:
	.align	2
.L2192:
	.word	GSU
	.size	_Z10fx_link_i2v, .-_Z10fx_link_i2v
	.align	2
	.type	_Z10fx_link_i3v, %function
_Z10fx_link_i3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2196
	ldr	r3, [r3, #60]
	add	r2, r3, #3
	ldr	r3, .L2196
	str	r2, [r3, #44]
	ldr	r3, .L2196
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2196
	str	r2, [r3, #72]
	ldr	r2, .L2196
	ldr	r3, .L2196
	str	r3, [r2, #104]
	ldr	r3, .L2196
	ldr	r2, [r3, #104]
	ldr	r3, .L2196
	str	r2, [r3, #100]
	ldr	r3, .L2196
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2196
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2197:
	.align	2
.L2196:
	.word	GSU
	.size	_Z10fx_link_i3v, .-_Z10fx_link_i3v
	.align	2
	.type	_Z10fx_link_i4v, %function
_Z10fx_link_i4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2200
	ldr	r3, [r3, #60]
	add	r2, r3, #4
	ldr	r3, .L2200
	str	r2, [r3, #44]
	ldr	r3, .L2200
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2200
	str	r2, [r3, #72]
	ldr	r2, .L2200
	ldr	r3, .L2200
	str	r3, [r2, #104]
	ldr	r3, .L2200
	ldr	r2, [r3, #104]
	ldr	r3, .L2200
	str	r2, [r3, #100]
	ldr	r3, .L2200
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2200
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2201:
	.align	2
.L2200:
	.word	GSU
	.size	_Z10fx_link_i4v, .-_Z10fx_link_i4v
	.align	2
	.type	_Z6fx_sexv, %function
_Z6fx_sexv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2206
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	str	r3, [fp, #-16]
	ldr	r3, .L2206
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2206
	str	r2, [r3, #60]
	ldr	r3, .L2206
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2206
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2206
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2206
	ldr	r2, [r3, #100]
	ldr	r3, .L2206+4
	cmp	r2, r3
	bne	.L2203
	ldr	r3, .L2206
	ldr	r2, [r3, #468]
	ldr	r3, .L2206
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2206
	strb	r3, [r2, #108]
.L2203:
	ldr	r3, .L2206
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2206
	str	r2, [r3, #72]
	ldr	r2, .L2206
	ldr	r3, .L2206
	str	r3, [r2, #104]
	ldr	r3, .L2206
	ldr	r2, [r3, #104]
	ldr	r3, .L2206
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2207:
	.align	2
.L2206:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_sexv, .-_Z6fx_sexv
	.align	2
	.type	_Z6fx_asrv, %function
_Z6fx_asrv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2212
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r2, r3, #1
	ldr	r3, .L2212
	str	r2, [r3, #124]
	ldr	r3, .L2212
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r3, r3, asr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	str	r3, [fp, #-16]
	ldr	r3, .L2212
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2212
	str	r2, [r3, #60]
	ldr	r3, .L2212
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2212
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2212
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2212
	ldr	r2, [r3, #100]
	ldr	r3, .L2212+4
	cmp	r2, r3
	bne	.L2209
	ldr	r3, .L2212
	ldr	r2, [r3, #468]
	ldr	r3, .L2212
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2212
	strb	r3, [r2, #108]
.L2209:
	ldr	r3, .L2212
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2212
	str	r2, [r3, #72]
	ldr	r2, .L2212
	ldr	r3, .L2212
	str	r3, [r2, #104]
	ldr	r3, .L2212
	ldr	r2, [r3, #104]
	ldr	r3, .L2212
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2213:
	.align	2
.L2212:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_asrv, .-_Z6fx_asrv
	.align	2
	.type	_Z7fx_div2v, %function
_Z7fx_div2v:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	ldr	r3, .L2221
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	and	r2, r3, #1
	ldr	r3, .L2221
	str	r2, [r3, #124]
	ldr	r3, [fp, #-16]
	cmn	r3, #1
	bne	.L2215
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L2217
.L2215:
	ldr	r3, [fp, #-16]
	mov	r3, r3, asr #1
	str	r3, [fp, #-20]
.L2217:
	ldr	r3, .L2221
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2221
	str	r2, [r3, #60]
	ldr	r3, .L2221
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r2, .L2221
	ldr	r3, [fp, #-20]
	str	r3, [r2, #116]
	ldr	r2, .L2221
	ldr	r3, [fp, #-20]
	str	r3, [r2, #120]
	ldr	r3, .L2221
	ldr	r2, [r3, #100]
	ldr	r3, .L2221+4
	cmp	r2, r3
	bne	.L2218
	ldr	r3, .L2221
	ldr	r2, [r3, #468]
	ldr	r3, .L2221
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2221
	strb	r3, [r2, #108]
.L2218:
	ldr	r3, .L2221
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2221
	str	r2, [r3, #72]
	ldr	r2, .L2221
	ldr	r3, .L2221
	str	r3, [r2, #104]
	ldr	r3, .L2221
	ldr	r2, [r3, #104]
	ldr	r3, .L2221
	str	r2, [r3, #100]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L2222:
	.align	2
.L2221:
	.word	GSU
	.word	GSU+56
	.size	_Z7fx_div2v, .-_Z7fx_div2v
	.align	2
	.type	_Z6fx_rorv, %function
_Z6fx_rorv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2227
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, lsr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L2227
	ldr	r3, [r3, #124]
	mov	r3, r3, asl #15
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2227
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r2, r3, #1
	ldr	r3, .L2227
	str	r2, [r3, #124]
	ldr	r3, .L2227
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2227
	str	r2, [r3, #60]
	ldr	r3, .L2227
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2227
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2227
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2227
	ldr	r2, [r3, #100]
	ldr	r3, .L2227+4
	cmp	r2, r3
	bne	.L2224
	ldr	r3, .L2227
	ldr	r2, [r3, #468]
	ldr	r3, .L2227
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2227
	strb	r3, [r2, #108]
.L2224:
	ldr	r3, .L2227
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2227
	str	r2, [r3, #72]
	ldr	r2, .L2227
	ldr	r3, .L2227
	str	r3, [r2, #104]
	ldr	r3, .L2227
	ldr	r2, [r3, #104]
	ldr	r3, .L2227
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2228:
	.align	2
.L2227:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_rorv, .-_Z6fx_rorv
	.align	2
	.type	_Z9fx_jmp_r8v, %function
_Z9fx_jmp_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2231
	ldr	r2, [r3, #32]
	ldr	r3, .L2231
	str	r2, [r3, #60]
	ldr	r3, .L2231
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2231
	str	r2, [r3, #72]
	ldr	r2, .L2231
	ldr	r3, .L2231
	str	r3, [r2, #104]
	ldr	r3, .L2231
	ldr	r2, [r3, #104]
	ldr	r3, .L2231
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2232:
	.align	2
.L2231:
	.word	GSU
	.size	_Z9fx_jmp_r8v, .-_Z9fx_jmp_r8v
	.align	2
	.type	_Z9fx_jmp_r9v, %function
_Z9fx_jmp_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2235
	ldr	r2, [r3, #36]
	ldr	r3, .L2235
	str	r2, [r3, #60]
	ldr	r3, .L2235
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2235
	str	r2, [r3, #72]
	ldr	r2, .L2235
	ldr	r3, .L2235
	str	r3, [r2, #104]
	ldr	r3, .L2235
	ldr	r2, [r3, #104]
	ldr	r3, .L2235
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2236:
	.align	2
.L2235:
	.word	GSU
	.size	_Z9fx_jmp_r9v, .-_Z9fx_jmp_r9v
	.align	2
	.type	_Z10fx_jmp_r10v, %function
_Z10fx_jmp_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2239
	ldr	r2, [r3, #40]
	ldr	r3, .L2239
	str	r2, [r3, #60]
	ldr	r3, .L2239
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2239
	str	r2, [r3, #72]
	ldr	r2, .L2239
	ldr	r3, .L2239
	str	r3, [r2, #104]
	ldr	r3, .L2239
	ldr	r2, [r3, #104]
	ldr	r3, .L2239
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2240:
	.align	2
.L2239:
	.word	GSU
	.size	_Z10fx_jmp_r10v, .-_Z10fx_jmp_r10v
	.align	2
	.type	_Z10fx_jmp_r11v, %function
_Z10fx_jmp_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2243
	ldr	r2, [r3, #44]
	ldr	r3, .L2243
	str	r2, [r3, #60]
	ldr	r3, .L2243
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2243
	str	r2, [r3, #72]
	ldr	r2, .L2243
	ldr	r3, .L2243
	str	r3, [r2, #104]
	ldr	r3, .L2243
	ldr	r2, [r3, #104]
	ldr	r3, .L2243
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2244:
	.align	2
.L2243:
	.word	GSU
	.size	_Z10fx_jmp_r11v, .-_Z10fx_jmp_r11v
	.align	2
	.type	_Z10fx_jmp_r12v, %function
_Z10fx_jmp_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2247
	ldr	r2, [r3, #48]
	ldr	r3, .L2247
	str	r2, [r3, #60]
	ldr	r3, .L2247
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2247
	str	r2, [r3, #72]
	ldr	r2, .L2247
	ldr	r3, .L2247
	str	r3, [r2, #104]
	ldr	r3, .L2247
	ldr	r2, [r3, #104]
	ldr	r3, .L2247
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2248:
	.align	2
.L2247:
	.word	GSU
	.size	_Z10fx_jmp_r12v, .-_Z10fx_jmp_r12v
	.align	2
	.type	_Z10fx_jmp_r13v, %function
_Z10fx_jmp_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2251
	ldr	r2, [r3, #52]
	ldr	r3, .L2251
	str	r2, [r3, #60]
	ldr	r3, .L2251
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2251
	str	r2, [r3, #72]
	ldr	r2, .L2251
	ldr	r3, .L2251
	str	r3, [r2, #104]
	ldr	r3, .L2251
	ldr	r2, [r3, #104]
	ldr	r3, .L2251
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2252:
	.align	2
.L2251:
	.word	GSU
	.size	_Z10fx_jmp_r13v, .-_Z10fx_jmp_r13v
	.align	2
	.type	_Z6fx_lobv, %function
_Z6fx_lobv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2257
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	str	r3, [fp, #-16]
	ldr	r3, .L2257
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2257
	str	r2, [r3, #60]
	ldr	r3, .L2257
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	mov	r2, r3, asl #8
	ldr	r3, .L2257
	str	r2, [r3, #116]
	ldr	r3, [fp, #-16]
	mov	r2, r3, asl #8
	ldr	r3, .L2257
	str	r2, [r3, #120]
	ldr	r3, .L2257
	ldr	r2, [r3, #100]
	ldr	r3, .L2257+4
	cmp	r2, r3
	bne	.L2254
	ldr	r3, .L2257
	ldr	r2, [r3, #468]
	ldr	r3, .L2257
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2257
	strb	r3, [r2, #108]
.L2254:
	ldr	r3, .L2257
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2257
	str	r2, [r3, #72]
	ldr	r2, .L2257
	ldr	r3, .L2257
	str	r3, [r2, #104]
	ldr	r3, .L2257
	ldr	r2, [r3, #104]
	ldr	r3, .L2257
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2258:
	.align	2
.L2257:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_lobv, .-_Z6fx_lobv
	.align	2
	.type	_Z8fx_fmultv, %function
_Z8fx_fmultv:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	ldr	r3, .L2263
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, asr #16
	ldr	r3, .L2263
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	ldr	r3, .L2263
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2263
	str	r2, [r3, #60]
	ldr	r3, .L2263
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r2, .L2263
	ldr	r3, [fp, #-20]
	str	r3, [r2, #116]
	ldr	r2, .L2263
	ldr	r3, [fp, #-20]
	str	r3, [r2, #120]
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #15
	and	r2, r3, #1
	ldr	r3, .L2263
	str	r2, [r3, #124]
	ldr	r3, .L2263
	ldr	r2, [r3, #100]
	ldr	r3, .L2263+4
	cmp	r2, r3
	bne	.L2260
	ldr	r3, .L2263
	ldr	r2, [r3, #468]
	ldr	r3, .L2263
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2263
	strb	r3, [r2, #108]
.L2260:
	ldr	r3, .L2263
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2263
	str	r2, [r3, #72]
	ldr	r2, .L2263
	ldr	r3, .L2263
	str	r3, [r2, #104]
	ldr	r3, .L2263
	ldr	r2, [r3, #104]
	ldr	r3, .L2263
	str	r2, [r3, #100]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L2264:
	.align	2
.L2263:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_fmultv, .-_Z8fx_fmultv
	.align	2
	.type	_Z8fx_lmultv, %function
_Z8fx_lmultv:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	ldr	r3, .L2269
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, asr #16
	ldr	r3, .L2269
	ldr	r3, [r3, #24]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, .L2269
	ldr	r3, [fp, #-16]
	str	r3, [r2, #16]
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	ldr	r3, .L2269
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2269
	str	r2, [r3, #60]
	ldr	r3, .L2269
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r2, .L2269
	ldr	r3, [fp, #-20]
	str	r3, [r2, #116]
	ldr	r2, .L2269
	ldr	r3, [fp, #-20]
	str	r3, [r2, #120]
	ldr	r3, .L2269
	ldr	r3, [r3, #16]
	mov	r3, r3, lsr #15
	and	r2, r3, #1
	ldr	r3, .L2269
	str	r2, [r3, #124]
	ldr	r3, .L2269
	ldr	r2, [r3, #100]
	ldr	r3, .L2269+4
	cmp	r2, r3
	bne	.L2266
	ldr	r3, .L2269
	ldr	r2, [r3, #468]
	ldr	r3, .L2269
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2269
	strb	r3, [r2, #108]
.L2266:
	ldr	r3, .L2269
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2269
	str	r2, [r3, #72]
	ldr	r2, .L2269
	ldr	r3, .L2269
	str	r3, [r2, #104]
	ldr	r3, .L2269
	ldr	r2, [r3, #104]
	ldr	r3, .L2269
	str	r2, [r3, #100]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L2270:
	.align	2
.L2269:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_lmultv, .-_Z8fx_lmultv
	.align	2
	.type	_Z9fx_ibt_r0v, %function
_Z9fx_ibt_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2273
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2273
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2273
	str	r2, [r3, #60]
	ldr	r3, .L2273
	ldr	r2, [r3, #472]
	ldr	r3, .L2273
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2273
	strb	r3, [r2, #109]
	ldr	r3, .L2273
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2273
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2273
	str	r2, [r3, #0]
	ldr	r3, .L2273
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2273
	str	r2, [r3, #72]
	ldr	r2, .L2273
	ldr	r3, .L2273
	str	r3, [r2, #104]
	ldr	r3, .L2273
	ldr	r2, [r3, #104]
	ldr	r3, .L2273
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2274:
	.align	2
.L2273:
	.word	GSU
	.size	_Z9fx_ibt_r0v, .-_Z9fx_ibt_r0v
	.align	2
	.type	_Z9fx_ibt_r1v, %function
_Z9fx_ibt_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2277
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2277
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2277
	str	r2, [r3, #60]
	ldr	r3, .L2277
	ldr	r2, [r3, #472]
	ldr	r3, .L2277
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2277
	strb	r3, [r2, #109]
	ldr	r3, .L2277
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2277
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2277
	str	r2, [r3, #4]
	ldr	r3, .L2277
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2277
	str	r2, [r3, #72]
	ldr	r2, .L2277
	ldr	r3, .L2277
	str	r3, [r2, #104]
	ldr	r3, .L2277
	ldr	r2, [r3, #104]
	ldr	r3, .L2277
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2278:
	.align	2
.L2277:
	.word	GSU
	.size	_Z9fx_ibt_r1v, .-_Z9fx_ibt_r1v
	.align	2
	.type	_Z9fx_ibt_r2v, %function
_Z9fx_ibt_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2281
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2281
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2281
	str	r2, [r3, #60]
	ldr	r3, .L2281
	ldr	r2, [r3, #472]
	ldr	r3, .L2281
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2281
	strb	r3, [r2, #109]
	ldr	r3, .L2281
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2281
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2281
	str	r2, [r3, #8]
	ldr	r3, .L2281
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2281
	str	r2, [r3, #72]
	ldr	r2, .L2281
	ldr	r3, .L2281
	str	r3, [r2, #104]
	ldr	r3, .L2281
	ldr	r2, [r3, #104]
	ldr	r3, .L2281
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2282:
	.align	2
.L2281:
	.word	GSU
	.size	_Z9fx_ibt_r2v, .-_Z9fx_ibt_r2v
	.align	2
	.type	_Z9fx_ibt_r3v, %function
_Z9fx_ibt_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2285
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2285
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2285
	str	r2, [r3, #60]
	ldr	r3, .L2285
	ldr	r2, [r3, #472]
	ldr	r3, .L2285
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2285
	strb	r3, [r2, #109]
	ldr	r3, .L2285
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2285
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2285
	str	r2, [r3, #12]
	ldr	r3, .L2285
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2285
	str	r2, [r3, #72]
	ldr	r2, .L2285
	ldr	r3, .L2285
	str	r3, [r2, #104]
	ldr	r3, .L2285
	ldr	r2, [r3, #104]
	ldr	r3, .L2285
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2286:
	.align	2
.L2285:
	.word	GSU
	.size	_Z9fx_ibt_r3v, .-_Z9fx_ibt_r3v
	.align	2
	.type	_Z9fx_ibt_r4v, %function
_Z9fx_ibt_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2289
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2289
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2289
	str	r2, [r3, #60]
	ldr	r3, .L2289
	ldr	r2, [r3, #472]
	ldr	r3, .L2289
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2289
	strb	r3, [r2, #109]
	ldr	r3, .L2289
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2289
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2289
	str	r2, [r3, #16]
	ldr	r3, .L2289
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2289
	str	r2, [r3, #72]
	ldr	r2, .L2289
	ldr	r3, .L2289
	str	r3, [r2, #104]
	ldr	r3, .L2289
	ldr	r2, [r3, #104]
	ldr	r3, .L2289
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2290:
	.align	2
.L2289:
	.word	GSU
	.size	_Z9fx_ibt_r4v, .-_Z9fx_ibt_r4v
	.align	2
	.type	_Z9fx_ibt_r5v, %function
_Z9fx_ibt_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2293
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2293
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2293
	str	r2, [r3, #60]
	ldr	r3, .L2293
	ldr	r2, [r3, #472]
	ldr	r3, .L2293
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2293
	strb	r3, [r2, #109]
	ldr	r3, .L2293
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2293
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2293
	str	r2, [r3, #20]
	ldr	r3, .L2293
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2293
	str	r2, [r3, #72]
	ldr	r2, .L2293
	ldr	r3, .L2293
	str	r3, [r2, #104]
	ldr	r3, .L2293
	ldr	r2, [r3, #104]
	ldr	r3, .L2293
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2294:
	.align	2
.L2293:
	.word	GSU
	.size	_Z9fx_ibt_r5v, .-_Z9fx_ibt_r5v
	.align	2
	.type	_Z9fx_ibt_r6v, %function
_Z9fx_ibt_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2297
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2297
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2297
	str	r2, [r3, #60]
	ldr	r3, .L2297
	ldr	r2, [r3, #472]
	ldr	r3, .L2297
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2297
	strb	r3, [r2, #109]
	ldr	r3, .L2297
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2297
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2297
	str	r2, [r3, #24]
	ldr	r3, .L2297
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2297
	str	r2, [r3, #72]
	ldr	r2, .L2297
	ldr	r3, .L2297
	str	r3, [r2, #104]
	ldr	r3, .L2297
	ldr	r2, [r3, #104]
	ldr	r3, .L2297
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2298:
	.align	2
.L2297:
	.word	GSU
	.size	_Z9fx_ibt_r6v, .-_Z9fx_ibt_r6v
	.align	2
	.type	_Z9fx_ibt_r7v, %function
_Z9fx_ibt_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2301
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2301
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2301
	str	r2, [r3, #60]
	ldr	r3, .L2301
	ldr	r2, [r3, #472]
	ldr	r3, .L2301
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2301
	strb	r3, [r2, #109]
	ldr	r3, .L2301
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2301
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2301
	str	r2, [r3, #28]
	ldr	r3, .L2301
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2301
	str	r2, [r3, #72]
	ldr	r2, .L2301
	ldr	r3, .L2301
	str	r3, [r2, #104]
	ldr	r3, .L2301
	ldr	r2, [r3, #104]
	ldr	r3, .L2301
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2302:
	.align	2
.L2301:
	.word	GSU
	.size	_Z9fx_ibt_r7v, .-_Z9fx_ibt_r7v
	.align	2
	.type	_Z9fx_ibt_r8v, %function
_Z9fx_ibt_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2305
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2305
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2305
	str	r2, [r3, #60]
	ldr	r3, .L2305
	ldr	r2, [r3, #472]
	ldr	r3, .L2305
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2305
	strb	r3, [r2, #109]
	ldr	r3, .L2305
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2305
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2305
	str	r2, [r3, #32]
	ldr	r3, .L2305
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2305
	str	r2, [r3, #72]
	ldr	r2, .L2305
	ldr	r3, .L2305
	str	r3, [r2, #104]
	ldr	r3, .L2305
	ldr	r2, [r3, #104]
	ldr	r3, .L2305
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2306:
	.align	2
.L2305:
	.word	GSU
	.size	_Z9fx_ibt_r8v, .-_Z9fx_ibt_r8v
	.align	2
	.type	_Z9fx_ibt_r9v, %function
_Z9fx_ibt_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2309
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2309
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2309
	str	r2, [r3, #60]
	ldr	r3, .L2309
	ldr	r2, [r3, #472]
	ldr	r3, .L2309
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2309
	strb	r3, [r2, #109]
	ldr	r3, .L2309
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2309
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2309
	str	r2, [r3, #36]
	ldr	r3, .L2309
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2309
	str	r2, [r3, #72]
	ldr	r2, .L2309
	ldr	r3, .L2309
	str	r3, [r2, #104]
	ldr	r3, .L2309
	ldr	r2, [r3, #104]
	ldr	r3, .L2309
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2310:
	.align	2
.L2309:
	.word	GSU
	.size	_Z9fx_ibt_r9v, .-_Z9fx_ibt_r9v
	.align	2
	.type	_Z10fx_ibt_r10v, %function
_Z10fx_ibt_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2313
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2313
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2313
	str	r2, [r3, #60]
	ldr	r3, .L2313
	ldr	r2, [r3, #472]
	ldr	r3, .L2313
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2313
	strb	r3, [r2, #109]
	ldr	r3, .L2313
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2313
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2313
	str	r2, [r3, #40]
	ldr	r3, .L2313
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2313
	str	r2, [r3, #72]
	ldr	r2, .L2313
	ldr	r3, .L2313
	str	r3, [r2, #104]
	ldr	r3, .L2313
	ldr	r2, [r3, #104]
	ldr	r3, .L2313
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2314:
	.align	2
.L2313:
	.word	GSU
	.size	_Z10fx_ibt_r10v, .-_Z10fx_ibt_r10v
	.align	2
	.type	_Z10fx_ibt_r11v, %function
_Z10fx_ibt_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2317
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2317
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2317
	str	r2, [r3, #60]
	ldr	r3, .L2317
	ldr	r2, [r3, #472]
	ldr	r3, .L2317
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2317
	strb	r3, [r2, #109]
	ldr	r3, .L2317
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2317
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2317
	str	r2, [r3, #44]
	ldr	r3, .L2317
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2317
	str	r2, [r3, #72]
	ldr	r2, .L2317
	ldr	r3, .L2317
	str	r3, [r2, #104]
	ldr	r3, .L2317
	ldr	r2, [r3, #104]
	ldr	r3, .L2317
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2318:
	.align	2
.L2317:
	.word	GSU
	.size	_Z10fx_ibt_r11v, .-_Z10fx_ibt_r11v
	.align	2
	.type	_Z10fx_ibt_r12v, %function
_Z10fx_ibt_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2321
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2321
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2321
	str	r2, [r3, #60]
	ldr	r3, .L2321
	ldr	r2, [r3, #472]
	ldr	r3, .L2321
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2321
	strb	r3, [r2, #109]
	ldr	r3, .L2321
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2321
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2321
	str	r2, [r3, #48]
	ldr	r3, .L2321
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2321
	str	r2, [r3, #72]
	ldr	r2, .L2321
	ldr	r3, .L2321
	str	r3, [r2, #104]
	ldr	r3, .L2321
	ldr	r2, [r3, #104]
	ldr	r3, .L2321
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2322:
	.align	2
.L2321:
	.word	GSU
	.size	_Z10fx_ibt_r12v, .-_Z10fx_ibt_r12v
	.align	2
	.type	_Z10fx_ibt_r13v, %function
_Z10fx_ibt_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2325
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2325
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2325
	str	r2, [r3, #60]
	ldr	r3, .L2325
	ldr	r2, [r3, #472]
	ldr	r3, .L2325
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2325
	strb	r3, [r2, #109]
	ldr	r3, .L2325
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2325
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2325
	str	r2, [r3, #52]
	ldr	r3, .L2325
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2325
	str	r2, [r3, #72]
	ldr	r2, .L2325
	ldr	r3, .L2325
	str	r3, [r2, #104]
	ldr	r3, .L2325
	ldr	r2, [r3, #104]
	ldr	r3, .L2325
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2326:
	.align	2
.L2325:
	.word	GSU
	.size	_Z10fx_ibt_r13v, .-_Z10fx_ibt_r13v
	.align	2
	.type	_Z10fx_ibt_r14v, %function
_Z10fx_ibt_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2329
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2329
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2329
	str	r2, [r3, #60]
	ldr	r3, .L2329
	ldr	r2, [r3, #472]
	ldr	r3, .L2329
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2329
	strb	r3, [r2, #109]
	ldr	r3, .L2329
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2329
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2329
	str	r2, [r3, #56]
	ldr	r3, .L2329
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2329
	str	r2, [r3, #72]
	ldr	r2, .L2329
	ldr	r3, .L2329
	str	r3, [r2, #104]
	ldr	r3, .L2329
	ldr	r2, [r3, #104]
	ldr	r3, .L2329
	str	r2, [r3, #100]
	ldr	r3, .L2329
	ldr	r2, [r3, #468]
	ldr	r3, .L2329
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2329
	strb	r3, [r2, #108]
	ldmib	sp, {fp, sp, pc}
.L2330:
	.align	2
.L2329:
	.word	GSU
	.size	_Z10fx_ibt_r14v, .-_Z10fx_ibt_r14v
	.align	2
	.type	_Z10fx_ibt_r15v, %function
_Z10fx_ibt_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2333
	ldrb	r3, [r3, #109]
	strb	r3, [fp, #-13]
	ldr	r3, .L2333
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2333
	str	r2, [r3, #60]
	ldr	r3, .L2333
	ldr	r2, [r3, #472]
	ldr	r3, .L2333
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2333
	strb	r3, [r2, #109]
	ldr	r3, .L2333
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2333
	str	r2, [r3, #60]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r2, r3, asr #24
	ldr	r3, .L2333
	str	r2, [r3, #60]
	ldr	r3, .L2333
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2333
	str	r2, [r3, #72]
	ldr	r2, .L2333
	ldr	r3, .L2333
	str	r3, [r2, #104]
	ldr	r3, .L2333
	ldr	r2, [r3, #104]
	ldr	r3, .L2333
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2334:
	.align	2
.L2333:
	.word	GSU
	.size	_Z10fx_ibt_r15v, .-_Z10fx_ibt_r15v
	.align	2
	.type	_Z9fx_lms_r0v, %function
_Z9fx_lms_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2337
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2337
	str	r2, [r3, #96]
	ldr	r3, .L2337
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2337
	str	r2, [r3, #60]
	ldr	r3, .L2337
	ldr	r2, [r3, #472]
	ldr	r3, .L2337
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2337
	strb	r3, [r2, #109]
	ldr	r3, .L2337
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2337
	str	r2, [r3, #60]
	ldr	r3, .L2337
	ldr	r2, [r3, #464]
	ldr	r3, .L2337
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2337
	str	r2, [r3, #0]
	ldr	r3, .L2337
	ldr	r1, [r3, #0]
	ldr	r3, .L2337
	ldr	r2, [r3, #464]
	ldr	r3, .L2337
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2337
	str	r2, [r3, #0]
	ldr	r3, .L2337
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2337
	str	r2, [r3, #72]
	ldr	r2, .L2337
	ldr	r3, .L2337
	str	r3, [r2, #104]
	ldr	r3, .L2337
	ldr	r2, [r3, #104]
	ldr	r3, .L2337
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2338:
	.align	2
.L2337:
	.word	GSU
	.size	_Z9fx_lms_r0v, .-_Z9fx_lms_r0v
	.align	2
	.type	_Z9fx_lms_r1v, %function
_Z9fx_lms_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2341
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2341
	str	r2, [r3, #96]
	ldr	r3, .L2341
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2341
	str	r2, [r3, #60]
	ldr	r3, .L2341
	ldr	r2, [r3, #472]
	ldr	r3, .L2341
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2341
	strb	r3, [r2, #109]
	ldr	r3, .L2341
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2341
	str	r2, [r3, #60]
	ldr	r3, .L2341
	ldr	r2, [r3, #464]
	ldr	r3, .L2341
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2341
	str	r2, [r3, #4]
	ldr	r3, .L2341
	ldr	r1, [r3, #4]
	ldr	r3, .L2341
	ldr	r2, [r3, #464]
	ldr	r3, .L2341
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2341
	str	r2, [r3, #4]
	ldr	r3, .L2341
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2341
	str	r2, [r3, #72]
	ldr	r2, .L2341
	ldr	r3, .L2341
	str	r3, [r2, #104]
	ldr	r3, .L2341
	ldr	r2, [r3, #104]
	ldr	r3, .L2341
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2342:
	.align	2
.L2341:
	.word	GSU
	.size	_Z9fx_lms_r1v, .-_Z9fx_lms_r1v
	.align	2
	.type	_Z9fx_lms_r2v, %function
_Z9fx_lms_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2345
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2345
	str	r2, [r3, #96]
	ldr	r3, .L2345
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2345
	str	r2, [r3, #60]
	ldr	r3, .L2345
	ldr	r2, [r3, #472]
	ldr	r3, .L2345
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2345
	strb	r3, [r2, #109]
	ldr	r3, .L2345
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2345
	str	r2, [r3, #60]
	ldr	r3, .L2345
	ldr	r2, [r3, #464]
	ldr	r3, .L2345
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2345
	str	r2, [r3, #8]
	ldr	r3, .L2345
	ldr	r1, [r3, #8]
	ldr	r3, .L2345
	ldr	r2, [r3, #464]
	ldr	r3, .L2345
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2345
	str	r2, [r3, #8]
	ldr	r3, .L2345
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2345
	str	r2, [r3, #72]
	ldr	r2, .L2345
	ldr	r3, .L2345
	str	r3, [r2, #104]
	ldr	r3, .L2345
	ldr	r2, [r3, #104]
	ldr	r3, .L2345
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2346:
	.align	2
.L2345:
	.word	GSU
	.size	_Z9fx_lms_r2v, .-_Z9fx_lms_r2v
	.align	2
	.type	_Z9fx_lms_r3v, %function
_Z9fx_lms_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2349
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2349
	str	r2, [r3, #96]
	ldr	r3, .L2349
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2349
	str	r2, [r3, #60]
	ldr	r3, .L2349
	ldr	r2, [r3, #472]
	ldr	r3, .L2349
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2349
	strb	r3, [r2, #109]
	ldr	r3, .L2349
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2349
	str	r2, [r3, #60]
	ldr	r3, .L2349
	ldr	r2, [r3, #464]
	ldr	r3, .L2349
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2349
	str	r2, [r3, #12]
	ldr	r3, .L2349
	ldr	r1, [r3, #12]
	ldr	r3, .L2349
	ldr	r2, [r3, #464]
	ldr	r3, .L2349
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2349
	str	r2, [r3, #12]
	ldr	r3, .L2349
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2349
	str	r2, [r3, #72]
	ldr	r2, .L2349
	ldr	r3, .L2349
	str	r3, [r2, #104]
	ldr	r3, .L2349
	ldr	r2, [r3, #104]
	ldr	r3, .L2349
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2350:
	.align	2
.L2349:
	.word	GSU
	.size	_Z9fx_lms_r3v, .-_Z9fx_lms_r3v
	.align	2
	.type	_Z9fx_lms_r4v, %function
_Z9fx_lms_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2353
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2353
	str	r2, [r3, #96]
	ldr	r3, .L2353
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2353
	str	r2, [r3, #60]
	ldr	r3, .L2353
	ldr	r2, [r3, #472]
	ldr	r3, .L2353
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2353
	strb	r3, [r2, #109]
	ldr	r3, .L2353
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2353
	str	r2, [r3, #60]
	ldr	r3, .L2353
	ldr	r2, [r3, #464]
	ldr	r3, .L2353
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2353
	str	r2, [r3, #16]
	ldr	r3, .L2353
	ldr	r1, [r3, #16]
	ldr	r3, .L2353
	ldr	r2, [r3, #464]
	ldr	r3, .L2353
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2353
	str	r2, [r3, #16]
	ldr	r3, .L2353
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2353
	str	r2, [r3, #72]
	ldr	r2, .L2353
	ldr	r3, .L2353
	str	r3, [r2, #104]
	ldr	r3, .L2353
	ldr	r2, [r3, #104]
	ldr	r3, .L2353
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2354:
	.align	2
.L2353:
	.word	GSU
	.size	_Z9fx_lms_r4v, .-_Z9fx_lms_r4v
	.align	2
	.type	_Z9fx_lms_r5v, %function
_Z9fx_lms_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2357
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2357
	str	r2, [r3, #96]
	ldr	r3, .L2357
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2357
	str	r2, [r3, #60]
	ldr	r3, .L2357
	ldr	r2, [r3, #472]
	ldr	r3, .L2357
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2357
	strb	r3, [r2, #109]
	ldr	r3, .L2357
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2357
	str	r2, [r3, #60]
	ldr	r3, .L2357
	ldr	r2, [r3, #464]
	ldr	r3, .L2357
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2357
	str	r2, [r3, #20]
	ldr	r3, .L2357
	ldr	r1, [r3, #20]
	ldr	r3, .L2357
	ldr	r2, [r3, #464]
	ldr	r3, .L2357
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2357
	str	r2, [r3, #20]
	ldr	r3, .L2357
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2357
	str	r2, [r3, #72]
	ldr	r2, .L2357
	ldr	r3, .L2357
	str	r3, [r2, #104]
	ldr	r3, .L2357
	ldr	r2, [r3, #104]
	ldr	r3, .L2357
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2358:
	.align	2
.L2357:
	.word	GSU
	.size	_Z9fx_lms_r5v, .-_Z9fx_lms_r5v
	.align	2
	.type	_Z9fx_lms_r6v, %function
_Z9fx_lms_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2361
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2361
	str	r2, [r3, #96]
	ldr	r3, .L2361
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2361
	str	r2, [r3, #60]
	ldr	r3, .L2361
	ldr	r2, [r3, #472]
	ldr	r3, .L2361
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2361
	strb	r3, [r2, #109]
	ldr	r3, .L2361
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2361
	str	r2, [r3, #60]
	ldr	r3, .L2361
	ldr	r2, [r3, #464]
	ldr	r3, .L2361
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2361
	str	r2, [r3, #24]
	ldr	r3, .L2361
	ldr	r1, [r3, #24]
	ldr	r3, .L2361
	ldr	r2, [r3, #464]
	ldr	r3, .L2361
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2361
	str	r2, [r3, #24]
	ldr	r3, .L2361
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2361
	str	r2, [r3, #72]
	ldr	r2, .L2361
	ldr	r3, .L2361
	str	r3, [r2, #104]
	ldr	r3, .L2361
	ldr	r2, [r3, #104]
	ldr	r3, .L2361
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2362:
	.align	2
.L2361:
	.word	GSU
	.size	_Z9fx_lms_r6v, .-_Z9fx_lms_r6v
	.align	2
	.type	_Z9fx_lms_r7v, %function
_Z9fx_lms_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2365
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2365
	str	r2, [r3, #96]
	ldr	r3, .L2365
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2365
	str	r2, [r3, #60]
	ldr	r3, .L2365
	ldr	r2, [r3, #472]
	ldr	r3, .L2365
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2365
	strb	r3, [r2, #109]
	ldr	r3, .L2365
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2365
	str	r2, [r3, #60]
	ldr	r3, .L2365
	ldr	r2, [r3, #464]
	ldr	r3, .L2365
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2365
	str	r2, [r3, #28]
	ldr	r3, .L2365
	ldr	r1, [r3, #28]
	ldr	r3, .L2365
	ldr	r2, [r3, #464]
	ldr	r3, .L2365
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2365
	str	r2, [r3, #28]
	ldr	r3, .L2365
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2365
	str	r2, [r3, #72]
	ldr	r2, .L2365
	ldr	r3, .L2365
	str	r3, [r2, #104]
	ldr	r3, .L2365
	ldr	r2, [r3, #104]
	ldr	r3, .L2365
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2366:
	.align	2
.L2365:
	.word	GSU
	.size	_Z9fx_lms_r7v, .-_Z9fx_lms_r7v
	.align	2
	.type	_Z9fx_lms_r8v, %function
_Z9fx_lms_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2369
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2369
	str	r2, [r3, #96]
	ldr	r3, .L2369
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2369
	str	r2, [r3, #60]
	ldr	r3, .L2369
	ldr	r2, [r3, #472]
	ldr	r3, .L2369
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2369
	strb	r3, [r2, #109]
	ldr	r3, .L2369
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2369
	str	r2, [r3, #60]
	ldr	r3, .L2369
	ldr	r2, [r3, #464]
	ldr	r3, .L2369
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2369
	str	r2, [r3, #32]
	ldr	r3, .L2369
	ldr	r1, [r3, #32]
	ldr	r3, .L2369
	ldr	r2, [r3, #464]
	ldr	r3, .L2369
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2369
	str	r2, [r3, #32]
	ldr	r3, .L2369
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2369
	str	r2, [r3, #72]
	ldr	r2, .L2369
	ldr	r3, .L2369
	str	r3, [r2, #104]
	ldr	r3, .L2369
	ldr	r2, [r3, #104]
	ldr	r3, .L2369
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2370:
	.align	2
.L2369:
	.word	GSU
	.size	_Z9fx_lms_r8v, .-_Z9fx_lms_r8v
	.align	2
	.type	_Z9fx_lms_r9v, %function
_Z9fx_lms_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2373
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2373
	str	r2, [r3, #96]
	ldr	r3, .L2373
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2373
	str	r2, [r3, #60]
	ldr	r3, .L2373
	ldr	r2, [r3, #472]
	ldr	r3, .L2373
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2373
	strb	r3, [r2, #109]
	ldr	r3, .L2373
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2373
	str	r2, [r3, #60]
	ldr	r3, .L2373
	ldr	r2, [r3, #464]
	ldr	r3, .L2373
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2373
	str	r2, [r3, #36]
	ldr	r3, .L2373
	ldr	r1, [r3, #36]
	ldr	r3, .L2373
	ldr	r2, [r3, #464]
	ldr	r3, .L2373
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2373
	str	r2, [r3, #36]
	ldr	r3, .L2373
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2373
	str	r2, [r3, #72]
	ldr	r2, .L2373
	ldr	r3, .L2373
	str	r3, [r2, #104]
	ldr	r3, .L2373
	ldr	r2, [r3, #104]
	ldr	r3, .L2373
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2374:
	.align	2
.L2373:
	.word	GSU
	.size	_Z9fx_lms_r9v, .-_Z9fx_lms_r9v
	.align	2
	.type	_Z10fx_lms_r10v, %function
_Z10fx_lms_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2377
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2377
	str	r2, [r3, #96]
	ldr	r3, .L2377
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2377
	str	r2, [r3, #60]
	ldr	r3, .L2377
	ldr	r2, [r3, #472]
	ldr	r3, .L2377
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2377
	strb	r3, [r2, #109]
	ldr	r3, .L2377
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2377
	str	r2, [r3, #60]
	ldr	r3, .L2377
	ldr	r2, [r3, #464]
	ldr	r3, .L2377
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2377
	str	r2, [r3, #40]
	ldr	r3, .L2377
	ldr	r1, [r3, #40]
	ldr	r3, .L2377
	ldr	r2, [r3, #464]
	ldr	r3, .L2377
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2377
	str	r2, [r3, #40]
	ldr	r3, .L2377
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2377
	str	r2, [r3, #72]
	ldr	r2, .L2377
	ldr	r3, .L2377
	str	r3, [r2, #104]
	ldr	r3, .L2377
	ldr	r2, [r3, #104]
	ldr	r3, .L2377
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2378:
	.align	2
.L2377:
	.word	GSU
	.size	_Z10fx_lms_r10v, .-_Z10fx_lms_r10v
	.align	2
	.type	_Z10fx_lms_r11v, %function
_Z10fx_lms_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2381
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2381
	str	r2, [r3, #96]
	ldr	r3, .L2381
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2381
	str	r2, [r3, #60]
	ldr	r3, .L2381
	ldr	r2, [r3, #472]
	ldr	r3, .L2381
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2381
	strb	r3, [r2, #109]
	ldr	r3, .L2381
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2381
	str	r2, [r3, #60]
	ldr	r3, .L2381
	ldr	r2, [r3, #464]
	ldr	r3, .L2381
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2381
	str	r2, [r3, #44]
	ldr	r3, .L2381
	ldr	r1, [r3, #44]
	ldr	r3, .L2381
	ldr	r2, [r3, #464]
	ldr	r3, .L2381
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2381
	str	r2, [r3, #44]
	ldr	r3, .L2381
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2381
	str	r2, [r3, #72]
	ldr	r2, .L2381
	ldr	r3, .L2381
	str	r3, [r2, #104]
	ldr	r3, .L2381
	ldr	r2, [r3, #104]
	ldr	r3, .L2381
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2382:
	.align	2
.L2381:
	.word	GSU
	.size	_Z10fx_lms_r11v, .-_Z10fx_lms_r11v
	.align	2
	.type	_Z10fx_lms_r12v, %function
_Z10fx_lms_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2385
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2385
	str	r2, [r3, #96]
	ldr	r3, .L2385
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2385
	str	r2, [r3, #60]
	ldr	r3, .L2385
	ldr	r2, [r3, #472]
	ldr	r3, .L2385
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2385
	strb	r3, [r2, #109]
	ldr	r3, .L2385
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2385
	str	r2, [r3, #60]
	ldr	r3, .L2385
	ldr	r2, [r3, #464]
	ldr	r3, .L2385
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2385
	str	r2, [r3, #48]
	ldr	r3, .L2385
	ldr	r1, [r3, #48]
	ldr	r3, .L2385
	ldr	r2, [r3, #464]
	ldr	r3, .L2385
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2385
	str	r2, [r3, #48]
	ldr	r3, .L2385
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2385
	str	r2, [r3, #72]
	ldr	r2, .L2385
	ldr	r3, .L2385
	str	r3, [r2, #104]
	ldr	r3, .L2385
	ldr	r2, [r3, #104]
	ldr	r3, .L2385
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2386:
	.align	2
.L2385:
	.word	GSU
	.size	_Z10fx_lms_r12v, .-_Z10fx_lms_r12v
	.align	2
	.type	_Z10fx_lms_r13v, %function
_Z10fx_lms_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2389
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2389
	str	r2, [r3, #96]
	ldr	r3, .L2389
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2389
	str	r2, [r3, #60]
	ldr	r3, .L2389
	ldr	r2, [r3, #472]
	ldr	r3, .L2389
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2389
	strb	r3, [r2, #109]
	ldr	r3, .L2389
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2389
	str	r2, [r3, #60]
	ldr	r3, .L2389
	ldr	r2, [r3, #464]
	ldr	r3, .L2389
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2389
	str	r2, [r3, #52]
	ldr	r3, .L2389
	ldr	r1, [r3, #52]
	ldr	r3, .L2389
	ldr	r2, [r3, #464]
	ldr	r3, .L2389
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2389
	str	r2, [r3, #52]
	ldr	r3, .L2389
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2389
	str	r2, [r3, #72]
	ldr	r2, .L2389
	ldr	r3, .L2389
	str	r3, [r2, #104]
	ldr	r3, .L2389
	ldr	r2, [r3, #104]
	ldr	r3, .L2389
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2390:
	.align	2
.L2389:
	.word	GSU
	.size	_Z10fx_lms_r13v, .-_Z10fx_lms_r13v
	.align	2
	.type	_Z10fx_lms_r14v, %function
_Z10fx_lms_r14v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2393
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2393
	str	r2, [r3, #96]
	ldr	r3, .L2393
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2393
	str	r2, [r3, #60]
	ldr	r3, .L2393
	ldr	r2, [r3, #472]
	ldr	r3, .L2393
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2393
	strb	r3, [r2, #109]
	ldr	r3, .L2393
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2393
	str	r2, [r3, #60]
	ldr	r3, .L2393
	ldr	r2, [r3, #464]
	ldr	r3, .L2393
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2393
	str	r2, [r3, #56]
	ldr	r3, .L2393
	ldr	r1, [r3, #56]
	ldr	r3, .L2393
	ldr	r2, [r3, #464]
	ldr	r3, .L2393
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2393
	str	r2, [r3, #56]
	ldr	r3, .L2393
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2393
	str	r2, [r3, #72]
	ldr	r2, .L2393
	ldr	r3, .L2393
	str	r3, [r2, #104]
	ldr	r3, .L2393
	ldr	r2, [r3, #104]
	ldr	r3, .L2393
	str	r2, [r3, #100]
	ldr	r3, .L2393
	ldr	r2, [r3, #468]
	ldr	r3, .L2393
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2393
	strb	r3, [r2, #108]
	ldmfd	sp, {fp, sp, pc}
.L2394:
	.align	2
.L2393:
	.word	GSU
	.size	_Z10fx_lms_r14v, .-_Z10fx_lms_r14v
	.align	2
	.type	_Z10fx_lms_r15v, %function
_Z10fx_lms_r15v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2397
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2397
	str	r2, [r3, #96]
	ldr	r3, .L2397
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2397
	str	r2, [r3, #60]
	ldr	r3, .L2397
	ldr	r2, [r3, #472]
	ldr	r3, .L2397
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2397
	strb	r3, [r2, #109]
	ldr	r3, .L2397
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2397
	str	r2, [r3, #60]
	ldr	r3, .L2397
	ldr	r2, [r3, #464]
	ldr	r3, .L2397
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L2397
	str	r2, [r3, #60]
	ldr	r3, .L2397
	ldr	r1, [r3, #60]
	ldr	r3, .L2397
	ldr	r2, [r3, #464]
	ldr	r3, .L2397
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L2397
	str	r2, [r3, #60]
	ldr	r3, .L2397
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2397
	str	r2, [r3, #72]
	ldr	r2, .L2397
	ldr	r3, .L2397
	str	r3, [r2, #104]
	ldr	r3, .L2397
	ldr	r2, [r3, #104]
	ldr	r3, .L2397
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L2398:
	.align	2
.L2397:
	.word	GSU
	.size	_Z10fx_lms_r15v, .-_Z10fx_lms_r15v
	.align	2
	.type	_Z9fx_sms_r0v, %function
_Z9fx_sms_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2401
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	ldr	r3, .L2401
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2401
	str	r2, [r3, #96]
	ldr	r3, .L2401
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2401
	str	r2, [r3, #60]
	ldr	r3, .L2401
	ldr	r2, [r3, #472]
	ldr	r3, .L2401
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2401
	strb	r3, [r2, #109]
	ldr	r3, .L2401
	ldr	r2, [r3, #464]
	ldr	r3, .L2401
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2401
	ldr	r2, [r3, #464]
	ldr	r3, .L2401
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2401
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2401
	str	r2, [r3, #72]
	ldr	r2, .L2401
	ldr	r3, .L2401
	str	r3, [r2, #104]
	ldr	r3, .L2401
	ldr	r2, [r3, #104]
	ldr	r3, .L2401
	str	r2, [r3, #100]
	ldr	r3, .L2401
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2401
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2402:
	.align	2
.L2401:
	.word	GSU
	.size	_Z9fx_sms_r0v, .-_Z9fx_sms_r0v
	.align	2
	.type	_Z9fx_sms_r1v, %function
_Z9fx_sms_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2405
	ldr	r3, [r3, #4]
	str	r3, [fp, #-16]
	ldr	r3, .L2405
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2405
	str	r2, [r3, #96]
	ldr	r3, .L2405
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2405
	str	r2, [r3, #60]
	ldr	r3, .L2405
	ldr	r2, [r3, #472]
	ldr	r3, .L2405
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2405
	strb	r3, [r2, #109]
	ldr	r3, .L2405
	ldr	r2, [r3, #464]
	ldr	r3, .L2405
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2405
	ldr	r2, [r3, #464]
	ldr	r3, .L2405
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2405
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2405
	str	r2, [r3, #72]
	ldr	r2, .L2405
	ldr	r3, .L2405
	str	r3, [r2, #104]
	ldr	r3, .L2405
	ldr	r2, [r3, #104]
	ldr	r3, .L2405
	str	r2, [r3, #100]
	ldr	r3, .L2405
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2405
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2406:
	.align	2
.L2405:
	.word	GSU
	.size	_Z9fx_sms_r1v, .-_Z9fx_sms_r1v
	.align	2
	.type	_Z9fx_sms_r2v, %function
_Z9fx_sms_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2409
	ldr	r3, [r3, #8]
	str	r3, [fp, #-16]
	ldr	r3, .L2409
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2409
	str	r2, [r3, #96]
	ldr	r3, .L2409
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2409
	str	r2, [r3, #60]
	ldr	r3, .L2409
	ldr	r2, [r3, #472]
	ldr	r3, .L2409
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2409
	strb	r3, [r2, #109]
	ldr	r3, .L2409
	ldr	r2, [r3, #464]
	ldr	r3, .L2409
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2409
	ldr	r2, [r3, #464]
	ldr	r3, .L2409
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2409
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2409
	str	r2, [r3, #72]
	ldr	r2, .L2409
	ldr	r3, .L2409
	str	r3, [r2, #104]
	ldr	r3, .L2409
	ldr	r2, [r3, #104]
	ldr	r3, .L2409
	str	r2, [r3, #100]
	ldr	r3, .L2409
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2409
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2410:
	.align	2
.L2409:
	.word	GSU
	.size	_Z9fx_sms_r2v, .-_Z9fx_sms_r2v
	.align	2
	.type	_Z9fx_sms_r3v, %function
_Z9fx_sms_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2413
	ldr	r3, [r3, #12]
	str	r3, [fp, #-16]
	ldr	r3, .L2413
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2413
	str	r2, [r3, #96]
	ldr	r3, .L2413
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2413
	str	r2, [r3, #60]
	ldr	r3, .L2413
	ldr	r2, [r3, #472]
	ldr	r3, .L2413
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2413
	strb	r3, [r2, #109]
	ldr	r3, .L2413
	ldr	r2, [r3, #464]
	ldr	r3, .L2413
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2413
	ldr	r2, [r3, #464]
	ldr	r3, .L2413
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2413
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2413
	str	r2, [r3, #72]
	ldr	r2, .L2413
	ldr	r3, .L2413
	str	r3, [r2, #104]
	ldr	r3, .L2413
	ldr	r2, [r3, #104]
	ldr	r3, .L2413
	str	r2, [r3, #100]
	ldr	r3, .L2413
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2413
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2414:
	.align	2
.L2413:
	.word	GSU
	.size	_Z9fx_sms_r3v, .-_Z9fx_sms_r3v
	.align	2
	.type	_Z9fx_sms_r4v, %function
_Z9fx_sms_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2417
	ldr	r3, [r3, #16]
	str	r3, [fp, #-16]
	ldr	r3, .L2417
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2417
	str	r2, [r3, #96]
	ldr	r3, .L2417
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2417
	str	r2, [r3, #60]
	ldr	r3, .L2417
	ldr	r2, [r3, #472]
	ldr	r3, .L2417
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2417
	strb	r3, [r2, #109]
	ldr	r3, .L2417
	ldr	r2, [r3, #464]
	ldr	r3, .L2417
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2417
	ldr	r2, [r3, #464]
	ldr	r3, .L2417
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2417
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2417
	str	r2, [r3, #72]
	ldr	r2, .L2417
	ldr	r3, .L2417
	str	r3, [r2, #104]
	ldr	r3, .L2417
	ldr	r2, [r3, #104]
	ldr	r3, .L2417
	str	r2, [r3, #100]
	ldr	r3, .L2417
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2417
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2418:
	.align	2
.L2417:
	.word	GSU
	.size	_Z9fx_sms_r4v, .-_Z9fx_sms_r4v
	.align	2
	.type	_Z9fx_sms_r5v, %function
_Z9fx_sms_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2421
	ldr	r3, [r3, #20]
	str	r3, [fp, #-16]
	ldr	r3, .L2421
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2421
	str	r2, [r3, #96]
	ldr	r3, .L2421
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2421
	str	r2, [r3, #60]
	ldr	r3, .L2421
	ldr	r2, [r3, #472]
	ldr	r3, .L2421
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2421
	strb	r3, [r2, #109]
	ldr	r3, .L2421
	ldr	r2, [r3, #464]
	ldr	r3, .L2421
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2421
	ldr	r2, [r3, #464]
	ldr	r3, .L2421
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2421
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2421
	str	r2, [r3, #72]
	ldr	r2, .L2421
	ldr	r3, .L2421
	str	r3, [r2, #104]
	ldr	r3, .L2421
	ldr	r2, [r3, #104]
	ldr	r3, .L2421
	str	r2, [r3, #100]
	ldr	r3, .L2421
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2421
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2422:
	.align	2
.L2421:
	.word	GSU
	.size	_Z9fx_sms_r5v, .-_Z9fx_sms_r5v
	.align	2
	.type	_Z9fx_sms_r6v, %function
_Z9fx_sms_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2425
	ldr	r3, [r3, #24]
	str	r3, [fp, #-16]
	ldr	r3, .L2425
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2425
	str	r2, [r3, #96]
	ldr	r3, .L2425
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2425
	str	r2, [r3, #60]
	ldr	r3, .L2425
	ldr	r2, [r3, #472]
	ldr	r3, .L2425
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2425
	strb	r3, [r2, #109]
	ldr	r3, .L2425
	ldr	r2, [r3, #464]
	ldr	r3, .L2425
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2425
	ldr	r2, [r3, #464]
	ldr	r3, .L2425
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2425
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2425
	str	r2, [r3, #72]
	ldr	r2, .L2425
	ldr	r3, .L2425
	str	r3, [r2, #104]
	ldr	r3, .L2425
	ldr	r2, [r3, #104]
	ldr	r3, .L2425
	str	r2, [r3, #100]
	ldr	r3, .L2425
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2425
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2426:
	.align	2
.L2425:
	.word	GSU
	.size	_Z9fx_sms_r6v, .-_Z9fx_sms_r6v
	.align	2
	.type	_Z9fx_sms_r7v, %function
_Z9fx_sms_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2429
	ldr	r3, [r3, #28]
	str	r3, [fp, #-16]
	ldr	r3, .L2429
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2429
	str	r2, [r3, #96]
	ldr	r3, .L2429
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2429
	str	r2, [r3, #60]
	ldr	r3, .L2429
	ldr	r2, [r3, #472]
	ldr	r3, .L2429
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2429
	strb	r3, [r2, #109]
	ldr	r3, .L2429
	ldr	r2, [r3, #464]
	ldr	r3, .L2429
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2429
	ldr	r2, [r3, #464]
	ldr	r3, .L2429
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2429
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2429
	str	r2, [r3, #72]
	ldr	r2, .L2429
	ldr	r3, .L2429
	str	r3, [r2, #104]
	ldr	r3, .L2429
	ldr	r2, [r3, #104]
	ldr	r3, .L2429
	str	r2, [r3, #100]
	ldr	r3, .L2429
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2429
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2430:
	.align	2
.L2429:
	.word	GSU
	.size	_Z9fx_sms_r7v, .-_Z9fx_sms_r7v
	.align	2
	.type	_Z9fx_sms_r8v, %function
_Z9fx_sms_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2433
	ldr	r3, [r3, #32]
	str	r3, [fp, #-16]
	ldr	r3, .L2433
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2433
	str	r2, [r3, #96]
	ldr	r3, .L2433
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2433
	str	r2, [r3, #60]
	ldr	r3, .L2433
	ldr	r2, [r3, #472]
	ldr	r3, .L2433
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2433
	strb	r3, [r2, #109]
	ldr	r3, .L2433
	ldr	r2, [r3, #464]
	ldr	r3, .L2433
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2433
	ldr	r2, [r3, #464]
	ldr	r3, .L2433
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2433
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2433
	str	r2, [r3, #72]
	ldr	r2, .L2433
	ldr	r3, .L2433
	str	r3, [r2, #104]
	ldr	r3, .L2433
	ldr	r2, [r3, #104]
	ldr	r3, .L2433
	str	r2, [r3, #100]
	ldr	r3, .L2433
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2433
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2434:
	.align	2
.L2433:
	.word	GSU
	.size	_Z9fx_sms_r8v, .-_Z9fx_sms_r8v
	.align	2
	.type	_Z9fx_sms_r9v, %function
_Z9fx_sms_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2437
	ldr	r3, [r3, #36]
	str	r3, [fp, #-16]
	ldr	r3, .L2437
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2437
	str	r2, [r3, #96]
	ldr	r3, .L2437
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2437
	str	r2, [r3, #60]
	ldr	r3, .L2437
	ldr	r2, [r3, #472]
	ldr	r3, .L2437
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2437
	strb	r3, [r2, #109]
	ldr	r3, .L2437
	ldr	r2, [r3, #464]
	ldr	r3, .L2437
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2437
	ldr	r2, [r3, #464]
	ldr	r3, .L2437
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2437
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2437
	str	r2, [r3, #72]
	ldr	r2, .L2437
	ldr	r3, .L2437
	str	r3, [r2, #104]
	ldr	r3, .L2437
	ldr	r2, [r3, #104]
	ldr	r3, .L2437
	str	r2, [r3, #100]
	ldr	r3, .L2437
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2437
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2438:
	.align	2
.L2437:
	.word	GSU
	.size	_Z9fx_sms_r9v, .-_Z9fx_sms_r9v
	.align	2
	.type	_Z10fx_sms_r10v, %function
_Z10fx_sms_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2441
	ldr	r3, [r3, #40]
	str	r3, [fp, #-16]
	ldr	r3, .L2441
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2441
	str	r2, [r3, #96]
	ldr	r3, .L2441
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2441
	str	r2, [r3, #60]
	ldr	r3, .L2441
	ldr	r2, [r3, #472]
	ldr	r3, .L2441
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2441
	strb	r3, [r2, #109]
	ldr	r3, .L2441
	ldr	r2, [r3, #464]
	ldr	r3, .L2441
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2441
	ldr	r2, [r3, #464]
	ldr	r3, .L2441
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2441
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2441
	str	r2, [r3, #72]
	ldr	r2, .L2441
	ldr	r3, .L2441
	str	r3, [r2, #104]
	ldr	r3, .L2441
	ldr	r2, [r3, #104]
	ldr	r3, .L2441
	str	r2, [r3, #100]
	ldr	r3, .L2441
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2441
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2442:
	.align	2
.L2441:
	.word	GSU
	.size	_Z10fx_sms_r10v, .-_Z10fx_sms_r10v
	.align	2
	.type	_Z10fx_sms_r11v, %function
_Z10fx_sms_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2445
	ldr	r3, [r3, #44]
	str	r3, [fp, #-16]
	ldr	r3, .L2445
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2445
	str	r2, [r3, #96]
	ldr	r3, .L2445
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2445
	str	r2, [r3, #60]
	ldr	r3, .L2445
	ldr	r2, [r3, #472]
	ldr	r3, .L2445
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2445
	strb	r3, [r2, #109]
	ldr	r3, .L2445
	ldr	r2, [r3, #464]
	ldr	r3, .L2445
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2445
	ldr	r2, [r3, #464]
	ldr	r3, .L2445
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2445
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2445
	str	r2, [r3, #72]
	ldr	r2, .L2445
	ldr	r3, .L2445
	str	r3, [r2, #104]
	ldr	r3, .L2445
	ldr	r2, [r3, #104]
	ldr	r3, .L2445
	str	r2, [r3, #100]
	ldr	r3, .L2445
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2445
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2446:
	.align	2
.L2445:
	.word	GSU
	.size	_Z10fx_sms_r11v, .-_Z10fx_sms_r11v
	.align	2
	.type	_Z10fx_sms_r12v, %function
_Z10fx_sms_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2449
	ldr	r3, [r3, #48]
	str	r3, [fp, #-16]
	ldr	r3, .L2449
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2449
	str	r2, [r3, #96]
	ldr	r3, .L2449
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2449
	str	r2, [r3, #60]
	ldr	r3, .L2449
	ldr	r2, [r3, #472]
	ldr	r3, .L2449
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2449
	strb	r3, [r2, #109]
	ldr	r3, .L2449
	ldr	r2, [r3, #464]
	ldr	r3, .L2449
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2449
	ldr	r2, [r3, #464]
	ldr	r3, .L2449
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2449
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2449
	str	r2, [r3, #72]
	ldr	r2, .L2449
	ldr	r3, .L2449
	str	r3, [r2, #104]
	ldr	r3, .L2449
	ldr	r2, [r3, #104]
	ldr	r3, .L2449
	str	r2, [r3, #100]
	ldr	r3, .L2449
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2449
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2450:
	.align	2
.L2449:
	.word	GSU
	.size	_Z10fx_sms_r12v, .-_Z10fx_sms_r12v
	.align	2
	.type	_Z10fx_sms_r13v, %function
_Z10fx_sms_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2453
	ldr	r3, [r3, #52]
	str	r3, [fp, #-16]
	ldr	r3, .L2453
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2453
	str	r2, [r3, #96]
	ldr	r3, .L2453
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2453
	str	r2, [r3, #60]
	ldr	r3, .L2453
	ldr	r2, [r3, #472]
	ldr	r3, .L2453
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2453
	strb	r3, [r2, #109]
	ldr	r3, .L2453
	ldr	r2, [r3, #464]
	ldr	r3, .L2453
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2453
	ldr	r2, [r3, #464]
	ldr	r3, .L2453
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2453
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2453
	str	r2, [r3, #72]
	ldr	r2, .L2453
	ldr	r3, .L2453
	str	r3, [r2, #104]
	ldr	r3, .L2453
	ldr	r2, [r3, #104]
	ldr	r3, .L2453
	str	r2, [r3, #100]
	ldr	r3, .L2453
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2453
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2454:
	.align	2
.L2453:
	.word	GSU
	.size	_Z10fx_sms_r13v, .-_Z10fx_sms_r13v
	.align	2
	.type	_Z10fx_sms_r14v, %function
_Z10fx_sms_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2457
	ldr	r3, [r3, #56]
	str	r3, [fp, #-16]
	ldr	r3, .L2457
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2457
	str	r2, [r3, #96]
	ldr	r3, .L2457
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2457
	str	r2, [r3, #60]
	ldr	r3, .L2457
	ldr	r2, [r3, #472]
	ldr	r3, .L2457
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2457
	strb	r3, [r2, #109]
	ldr	r3, .L2457
	ldr	r2, [r3, #464]
	ldr	r3, .L2457
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2457
	ldr	r2, [r3, #464]
	ldr	r3, .L2457
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2457
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2457
	str	r2, [r3, #72]
	ldr	r2, .L2457
	ldr	r3, .L2457
	str	r3, [r2, #104]
	ldr	r3, .L2457
	ldr	r2, [r3, #104]
	ldr	r3, .L2457
	str	r2, [r3, #100]
	ldr	r3, .L2457
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2457
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2458:
	.align	2
.L2457:
	.word	GSU
	.size	_Z10fx_sms_r14v, .-_Z10fx_sms_r14v
	.align	2
	.type	_Z10fx_sms_r15v, %function
_Z10fx_sms_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2461
	ldr	r3, [r3, #60]
	str	r3, [fp, #-16]
	ldr	r3, .L2461
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #1
	ldr	r3, .L2461
	str	r2, [r3, #96]
	ldr	r3, .L2461
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2461
	str	r2, [r3, #60]
	ldr	r3, .L2461
	ldr	r2, [r3, #472]
	ldr	r3, .L2461
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2461
	strb	r3, [r2, #109]
	ldr	r3, .L2461
	ldr	r2, [r3, #464]
	ldr	r3, .L2461
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2461
	ldr	r2, [r3, #464]
	ldr	r3, .L2461
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L2461
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2461
	str	r2, [r3, #72]
	ldr	r2, .L2461
	ldr	r3, .L2461
	str	r3, [r2, #104]
	ldr	r3, .L2461
	ldr	r2, [r3, #104]
	ldr	r3, .L2461
	str	r2, [r3, #100]
	ldr	r3, .L2461
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2461
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L2462:
	.align	2
.L2461:
	.word	GSU
	.size	_Z10fx_sms_r15v, .-_Z10fx_sms_r15v
	.align	2
	.type	_Z10fx_from_r0v, %function
_Z10fx_from_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2470
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2464
	ldr	r3, .L2470
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	ldr	r3, .L2470
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2470
	str	r2, [r3, #60]
	ldr	r3, .L2470
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2470
	str	r2, [r3, #128]
	ldr	r2, .L2470
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2470
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2470
	ldr	r2, [r3, #100]
	ldr	r3, .L2470+4
	cmp	r2, r3
	bne	.L2466
	ldr	r3, .L2470
	ldr	r2, [r3, #468]
	ldr	r3, .L2470
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2470
	strb	r3, [r2, #108]
.L2466:
	ldr	r3, .L2470
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2470
	str	r2, [r3, #72]
	ldr	r2, .L2470
	ldr	r3, .L2470
	str	r3, [r2, #104]
	ldr	r3, .L2470
	ldr	r2, [r3, #104]
	ldr	r3, .L2470
	str	r2, [r3, #100]
	b	.L2469
.L2464:
	ldr	r2, .L2470
	ldr	r3, .L2470
	str	r3, [r2, #104]
	ldr	r3, .L2470
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2470
	str	r2, [r3, #60]
.L2469:
	ldmib	sp, {fp, sp, pc}
.L2471:
	.align	2
.L2470:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_from_r0v, .-_Z10fx_from_r0v
	.align	2
	.type	_Z10fx_from_r1v, %function
_Z10fx_from_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2479
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2473
	ldr	r3, .L2479
	ldr	r3, [r3, #4]
	str	r3, [fp, #-16]
	ldr	r3, .L2479
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2479
	str	r2, [r3, #60]
	ldr	r3, .L2479
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2479
	str	r2, [r3, #128]
	ldr	r2, .L2479
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2479
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2479
	ldr	r2, [r3, #100]
	ldr	r3, .L2479+4
	cmp	r2, r3
	bne	.L2475
	ldr	r3, .L2479
	ldr	r2, [r3, #468]
	ldr	r3, .L2479
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2479
	strb	r3, [r2, #108]
.L2475:
	ldr	r3, .L2479
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2479
	str	r2, [r3, #72]
	ldr	r2, .L2479
	ldr	r3, .L2479
	str	r3, [r2, #104]
	ldr	r3, .L2479
	ldr	r2, [r3, #104]
	ldr	r3, .L2479
	str	r2, [r3, #100]
	b	.L2478
.L2473:
	ldr	r2, .L2479
	ldr	r3, .L2479+8
	str	r3, [r2, #104]
	ldr	r3, .L2479
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2479
	str	r2, [r3, #60]
.L2478:
	ldmib	sp, {fp, sp, pc}
.L2480:
	.align	2
.L2479:
	.word	GSU
	.word	GSU+56
	.word	GSU+4
	.size	_Z10fx_from_r1v, .-_Z10fx_from_r1v
	.align	2
	.type	_Z10fx_from_r2v, %function
_Z10fx_from_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2488
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2482
	ldr	r3, .L2488
	ldr	r3, [r3, #8]
	str	r3, [fp, #-16]
	ldr	r3, .L2488
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2488
	str	r2, [r3, #60]
	ldr	r3, .L2488
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2488
	str	r2, [r3, #128]
	ldr	r2, .L2488
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2488
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2488
	ldr	r2, [r3, #100]
	ldr	r3, .L2488+4
	cmp	r2, r3
	bne	.L2484
	ldr	r3, .L2488
	ldr	r2, [r3, #468]
	ldr	r3, .L2488
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2488
	strb	r3, [r2, #108]
.L2484:
	ldr	r3, .L2488
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2488
	str	r2, [r3, #72]
	ldr	r2, .L2488
	ldr	r3, .L2488
	str	r3, [r2, #104]
	ldr	r3, .L2488
	ldr	r2, [r3, #104]
	ldr	r3, .L2488
	str	r2, [r3, #100]
	b	.L2487
.L2482:
	ldr	r2, .L2488
	ldr	r3, .L2488+8
	str	r3, [r2, #104]
	ldr	r3, .L2488
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2488
	str	r2, [r3, #60]
.L2487:
	ldmib	sp, {fp, sp, pc}
.L2489:
	.align	2
.L2488:
	.word	GSU
	.word	GSU+56
	.word	GSU+8
	.size	_Z10fx_from_r2v, .-_Z10fx_from_r2v
	.align	2
	.type	_Z10fx_from_r3v, %function
_Z10fx_from_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2497
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2491
	ldr	r3, .L2497
	ldr	r3, [r3, #12]
	str	r3, [fp, #-16]
	ldr	r3, .L2497
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2497
	str	r2, [r3, #60]
	ldr	r3, .L2497
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2497
	str	r2, [r3, #128]
	ldr	r2, .L2497
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2497
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2497
	ldr	r2, [r3, #100]
	ldr	r3, .L2497+4
	cmp	r2, r3
	bne	.L2493
	ldr	r3, .L2497
	ldr	r2, [r3, #468]
	ldr	r3, .L2497
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2497
	strb	r3, [r2, #108]
.L2493:
	ldr	r3, .L2497
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2497
	str	r2, [r3, #72]
	ldr	r2, .L2497
	ldr	r3, .L2497
	str	r3, [r2, #104]
	ldr	r3, .L2497
	ldr	r2, [r3, #104]
	ldr	r3, .L2497
	str	r2, [r3, #100]
	b	.L2496
.L2491:
	ldr	r2, .L2497
	ldr	r3, .L2497+8
	str	r3, [r2, #104]
	ldr	r3, .L2497
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2497
	str	r2, [r3, #60]
.L2496:
	ldmib	sp, {fp, sp, pc}
.L2498:
	.align	2
.L2497:
	.word	GSU
	.word	GSU+56
	.word	GSU+12
	.size	_Z10fx_from_r3v, .-_Z10fx_from_r3v
	.align	2
	.type	_Z10fx_from_r4v, %function
_Z10fx_from_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2506
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2500
	ldr	r3, .L2506
	ldr	r3, [r3, #16]
	str	r3, [fp, #-16]
	ldr	r3, .L2506
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2506
	str	r2, [r3, #60]
	ldr	r3, .L2506
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2506
	str	r2, [r3, #128]
	ldr	r2, .L2506
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2506
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2506
	ldr	r2, [r3, #100]
	ldr	r3, .L2506+4
	cmp	r2, r3
	bne	.L2502
	ldr	r3, .L2506
	ldr	r2, [r3, #468]
	ldr	r3, .L2506
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2506
	strb	r3, [r2, #108]
.L2502:
	ldr	r3, .L2506
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2506
	str	r2, [r3, #72]
	ldr	r2, .L2506
	ldr	r3, .L2506
	str	r3, [r2, #104]
	ldr	r3, .L2506
	ldr	r2, [r3, #104]
	ldr	r3, .L2506
	str	r2, [r3, #100]
	b	.L2505
.L2500:
	ldr	r2, .L2506
	ldr	r3, .L2506+8
	str	r3, [r2, #104]
	ldr	r3, .L2506
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2506
	str	r2, [r3, #60]
.L2505:
	ldmib	sp, {fp, sp, pc}
.L2507:
	.align	2
.L2506:
	.word	GSU
	.word	GSU+56
	.word	GSU+16
	.size	_Z10fx_from_r4v, .-_Z10fx_from_r4v
	.align	2
	.type	_Z10fx_from_r5v, %function
_Z10fx_from_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2515
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2509
	ldr	r3, .L2515
	ldr	r3, [r3, #20]
	str	r3, [fp, #-16]
	ldr	r3, .L2515
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2515
	str	r2, [r3, #60]
	ldr	r3, .L2515
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2515
	str	r2, [r3, #128]
	ldr	r2, .L2515
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2515
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2515
	ldr	r2, [r3, #100]
	ldr	r3, .L2515+4
	cmp	r2, r3
	bne	.L2511
	ldr	r3, .L2515
	ldr	r2, [r3, #468]
	ldr	r3, .L2515
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2515
	strb	r3, [r2, #108]
.L2511:
	ldr	r3, .L2515
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2515
	str	r2, [r3, #72]
	ldr	r2, .L2515
	ldr	r3, .L2515
	str	r3, [r2, #104]
	ldr	r3, .L2515
	ldr	r2, [r3, #104]
	ldr	r3, .L2515
	str	r2, [r3, #100]
	b	.L2514
.L2509:
	ldr	r2, .L2515
	ldr	r3, .L2515+8
	str	r3, [r2, #104]
	ldr	r3, .L2515
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2515
	str	r2, [r3, #60]
.L2514:
	ldmib	sp, {fp, sp, pc}
.L2516:
	.align	2
.L2515:
	.word	GSU
	.word	GSU+56
	.word	GSU+20
	.size	_Z10fx_from_r5v, .-_Z10fx_from_r5v
	.align	2
	.type	_Z10fx_from_r6v, %function
_Z10fx_from_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2524
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2518
	ldr	r3, .L2524
	ldr	r3, [r3, #24]
	str	r3, [fp, #-16]
	ldr	r3, .L2524
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2524
	str	r2, [r3, #60]
	ldr	r3, .L2524
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2524
	str	r2, [r3, #128]
	ldr	r2, .L2524
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2524
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2524
	ldr	r2, [r3, #100]
	ldr	r3, .L2524+4
	cmp	r2, r3
	bne	.L2520
	ldr	r3, .L2524
	ldr	r2, [r3, #468]
	ldr	r3, .L2524
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2524
	strb	r3, [r2, #108]
.L2520:
	ldr	r3, .L2524
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2524
	str	r2, [r3, #72]
	ldr	r2, .L2524
	ldr	r3, .L2524
	str	r3, [r2, #104]
	ldr	r3, .L2524
	ldr	r2, [r3, #104]
	ldr	r3, .L2524
	str	r2, [r3, #100]
	b	.L2523
.L2518:
	ldr	r2, .L2524
	ldr	r3, .L2524+8
	str	r3, [r2, #104]
	ldr	r3, .L2524
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2524
	str	r2, [r3, #60]
.L2523:
	ldmib	sp, {fp, sp, pc}
.L2525:
	.align	2
.L2524:
	.word	GSU
	.word	GSU+56
	.word	GSU+24
	.size	_Z10fx_from_r6v, .-_Z10fx_from_r6v
	.align	2
	.type	_Z10fx_from_r7v, %function
_Z10fx_from_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2533
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2527
	ldr	r3, .L2533
	ldr	r3, [r3, #28]
	str	r3, [fp, #-16]
	ldr	r3, .L2533
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2533
	str	r2, [r3, #60]
	ldr	r3, .L2533
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2533
	str	r2, [r3, #128]
	ldr	r2, .L2533
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2533
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2533
	ldr	r2, [r3, #100]
	ldr	r3, .L2533+4
	cmp	r2, r3
	bne	.L2529
	ldr	r3, .L2533
	ldr	r2, [r3, #468]
	ldr	r3, .L2533
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2533
	strb	r3, [r2, #108]
.L2529:
	ldr	r3, .L2533
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2533
	str	r2, [r3, #72]
	ldr	r2, .L2533
	ldr	r3, .L2533
	str	r3, [r2, #104]
	ldr	r3, .L2533
	ldr	r2, [r3, #104]
	ldr	r3, .L2533
	str	r2, [r3, #100]
	b	.L2532
.L2527:
	ldr	r2, .L2533
	ldr	r3, .L2533+8
	str	r3, [r2, #104]
	ldr	r3, .L2533
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2533
	str	r2, [r3, #60]
.L2532:
	ldmib	sp, {fp, sp, pc}
.L2534:
	.align	2
.L2533:
	.word	GSU
	.word	GSU+56
	.word	GSU+28
	.size	_Z10fx_from_r7v, .-_Z10fx_from_r7v
	.align	2
	.type	_Z10fx_from_r8v, %function
_Z10fx_from_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2542
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2536
	ldr	r3, .L2542
	ldr	r3, [r3, #32]
	str	r3, [fp, #-16]
	ldr	r3, .L2542
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2542
	str	r2, [r3, #60]
	ldr	r3, .L2542
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2542
	str	r2, [r3, #128]
	ldr	r2, .L2542
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2542
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2542
	ldr	r2, [r3, #100]
	ldr	r3, .L2542+4
	cmp	r2, r3
	bne	.L2538
	ldr	r3, .L2542
	ldr	r2, [r3, #468]
	ldr	r3, .L2542
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2542
	strb	r3, [r2, #108]
.L2538:
	ldr	r3, .L2542
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2542
	str	r2, [r3, #72]
	ldr	r2, .L2542
	ldr	r3, .L2542
	str	r3, [r2, #104]
	ldr	r3, .L2542
	ldr	r2, [r3, #104]
	ldr	r3, .L2542
	str	r2, [r3, #100]
	b	.L2541
.L2536:
	ldr	r2, .L2542
	ldr	r3, .L2542+8
	str	r3, [r2, #104]
	ldr	r3, .L2542
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2542
	str	r2, [r3, #60]
.L2541:
	ldmib	sp, {fp, sp, pc}
.L2543:
	.align	2
.L2542:
	.word	GSU
	.word	GSU+56
	.word	GSU+32
	.size	_Z10fx_from_r8v, .-_Z10fx_from_r8v
	.align	2
	.type	_Z10fx_from_r9v, %function
_Z10fx_from_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2551
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2545
	ldr	r3, .L2551
	ldr	r3, [r3, #36]
	str	r3, [fp, #-16]
	ldr	r3, .L2551
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2551
	str	r2, [r3, #60]
	ldr	r3, .L2551
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2551
	str	r2, [r3, #128]
	ldr	r2, .L2551
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2551
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2551
	ldr	r2, [r3, #100]
	ldr	r3, .L2551+4
	cmp	r2, r3
	bne	.L2547
	ldr	r3, .L2551
	ldr	r2, [r3, #468]
	ldr	r3, .L2551
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2551
	strb	r3, [r2, #108]
.L2547:
	ldr	r3, .L2551
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2551
	str	r2, [r3, #72]
	ldr	r2, .L2551
	ldr	r3, .L2551
	str	r3, [r2, #104]
	ldr	r3, .L2551
	ldr	r2, [r3, #104]
	ldr	r3, .L2551
	str	r2, [r3, #100]
	b	.L2550
.L2545:
	ldr	r2, .L2551
	ldr	r3, .L2551+8
	str	r3, [r2, #104]
	ldr	r3, .L2551
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2551
	str	r2, [r3, #60]
.L2550:
	ldmib	sp, {fp, sp, pc}
.L2552:
	.align	2
.L2551:
	.word	GSU
	.word	GSU+56
	.word	GSU+36
	.size	_Z10fx_from_r9v, .-_Z10fx_from_r9v
	.align	2
	.type	_Z11fx_from_r10v, %function
_Z11fx_from_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2560
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2554
	ldr	r3, .L2560
	ldr	r3, [r3, #40]
	str	r3, [fp, #-16]
	ldr	r3, .L2560
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2560
	str	r2, [r3, #60]
	ldr	r3, .L2560
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2560
	str	r2, [r3, #128]
	ldr	r2, .L2560
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2560
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2560
	ldr	r2, [r3, #100]
	ldr	r3, .L2560+4
	cmp	r2, r3
	bne	.L2556
	ldr	r3, .L2560
	ldr	r2, [r3, #468]
	ldr	r3, .L2560
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2560
	strb	r3, [r2, #108]
.L2556:
	ldr	r3, .L2560
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2560
	str	r2, [r3, #72]
	ldr	r2, .L2560
	ldr	r3, .L2560
	str	r3, [r2, #104]
	ldr	r3, .L2560
	ldr	r2, [r3, #104]
	ldr	r3, .L2560
	str	r2, [r3, #100]
	b	.L2559
.L2554:
	ldr	r2, .L2560
	ldr	r3, .L2560+8
	str	r3, [r2, #104]
	ldr	r3, .L2560
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2560
	str	r2, [r3, #60]
.L2559:
	ldmib	sp, {fp, sp, pc}
.L2561:
	.align	2
.L2560:
	.word	GSU
	.word	GSU+56
	.word	GSU+40
	.size	_Z11fx_from_r10v, .-_Z11fx_from_r10v
	.align	2
	.type	_Z11fx_from_r11v, %function
_Z11fx_from_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2569
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2563
	ldr	r3, .L2569
	ldr	r3, [r3, #44]
	str	r3, [fp, #-16]
	ldr	r3, .L2569
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2569
	str	r2, [r3, #60]
	ldr	r3, .L2569
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2569
	str	r2, [r3, #128]
	ldr	r2, .L2569
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2569
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2569
	ldr	r2, [r3, #100]
	ldr	r3, .L2569+4
	cmp	r2, r3
	bne	.L2565
	ldr	r3, .L2569
	ldr	r2, [r3, #468]
	ldr	r3, .L2569
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2569
	strb	r3, [r2, #108]
.L2565:
	ldr	r3, .L2569
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2569
	str	r2, [r3, #72]
	ldr	r2, .L2569
	ldr	r3, .L2569
	str	r3, [r2, #104]
	ldr	r3, .L2569
	ldr	r2, [r3, #104]
	ldr	r3, .L2569
	str	r2, [r3, #100]
	b	.L2568
.L2563:
	ldr	r2, .L2569
	ldr	r3, .L2569+8
	str	r3, [r2, #104]
	ldr	r3, .L2569
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2569
	str	r2, [r3, #60]
.L2568:
	ldmib	sp, {fp, sp, pc}
.L2570:
	.align	2
.L2569:
	.word	GSU
	.word	GSU+56
	.word	GSU+44
	.size	_Z11fx_from_r11v, .-_Z11fx_from_r11v
	.align	2
	.type	_Z11fx_from_r12v, %function
_Z11fx_from_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2578
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2572
	ldr	r3, .L2578
	ldr	r3, [r3, #48]
	str	r3, [fp, #-16]
	ldr	r3, .L2578
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2578
	str	r2, [r3, #60]
	ldr	r3, .L2578
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2578
	str	r2, [r3, #128]
	ldr	r2, .L2578
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2578
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2578
	ldr	r2, [r3, #100]
	ldr	r3, .L2578+4
	cmp	r2, r3
	bne	.L2574
	ldr	r3, .L2578
	ldr	r2, [r3, #468]
	ldr	r3, .L2578
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2578
	strb	r3, [r2, #108]
.L2574:
	ldr	r3, .L2578
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2578
	str	r2, [r3, #72]
	ldr	r2, .L2578
	ldr	r3, .L2578
	str	r3, [r2, #104]
	ldr	r3, .L2578
	ldr	r2, [r3, #104]
	ldr	r3, .L2578
	str	r2, [r3, #100]
	b	.L2577
.L2572:
	ldr	r2, .L2578
	ldr	r3, .L2578+8
	str	r3, [r2, #104]
	ldr	r3, .L2578
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2578
	str	r2, [r3, #60]
.L2577:
	ldmib	sp, {fp, sp, pc}
.L2579:
	.align	2
.L2578:
	.word	GSU
	.word	GSU+56
	.word	GSU+48
	.size	_Z11fx_from_r12v, .-_Z11fx_from_r12v
	.align	2
	.type	_Z11fx_from_r13v, %function
_Z11fx_from_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2587
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2581
	ldr	r3, .L2587
	ldr	r3, [r3, #52]
	str	r3, [fp, #-16]
	ldr	r3, .L2587
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2587
	str	r2, [r3, #60]
	ldr	r3, .L2587
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2587
	str	r2, [r3, #128]
	ldr	r2, .L2587
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2587
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2587
	ldr	r2, [r3, #100]
	ldr	r3, .L2587+4
	cmp	r2, r3
	bne	.L2583
	ldr	r3, .L2587
	ldr	r2, [r3, #468]
	ldr	r3, .L2587
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2587
	strb	r3, [r2, #108]
.L2583:
	ldr	r3, .L2587
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2587
	str	r2, [r3, #72]
	ldr	r2, .L2587
	ldr	r3, .L2587
	str	r3, [r2, #104]
	ldr	r3, .L2587
	ldr	r2, [r3, #104]
	ldr	r3, .L2587
	str	r2, [r3, #100]
	b	.L2586
.L2581:
	ldr	r2, .L2587
	ldr	r3, .L2587+8
	str	r3, [r2, #104]
	ldr	r3, .L2587
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2587
	str	r2, [r3, #60]
.L2586:
	ldmib	sp, {fp, sp, pc}
.L2588:
	.align	2
.L2587:
	.word	GSU
	.word	GSU+56
	.word	GSU+52
	.size	_Z11fx_from_r13v, .-_Z11fx_from_r13v
	.align	2
	.type	_Z11fx_from_r14v, %function
_Z11fx_from_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2596
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2590
	ldr	r3, .L2596
	ldr	r3, [r3, #56]
	str	r3, [fp, #-16]
	ldr	r3, .L2596
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2596
	str	r2, [r3, #60]
	ldr	r3, .L2596
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2596
	str	r2, [r3, #128]
	ldr	r2, .L2596
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2596
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2596
	ldr	r2, [r3, #100]
	ldr	r3, .L2596+4
	cmp	r2, r3
	bne	.L2592
	ldr	r3, .L2596
	ldr	r2, [r3, #468]
	ldr	r3, .L2596
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2596
	strb	r3, [r2, #108]
.L2592:
	ldr	r3, .L2596
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2596
	str	r2, [r3, #72]
	ldr	r2, .L2596
	ldr	r3, .L2596
	str	r3, [r2, #104]
	ldr	r3, .L2596
	ldr	r2, [r3, #104]
	ldr	r3, .L2596
	str	r2, [r3, #100]
	b	.L2595
.L2590:
	ldr	r2, .L2596
	ldr	r3, .L2596+4
	str	r3, [r2, #104]
	ldr	r3, .L2596
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2596
	str	r2, [r3, #60]
.L2595:
	ldmib	sp, {fp, sp, pc}
.L2597:
	.align	2
.L2596:
	.word	GSU
	.word	GSU+56
	.size	_Z11fx_from_r14v, .-_Z11fx_from_r14v
	.align	2
	.type	_Z11fx_from_r15v, %function
_Z11fx_from_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2605
	ldr	r3, [r3, #72]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L2599
	ldr	r3, .L2605
	ldr	r3, [r3, #60]
	str	r3, [fp, #-16]
	ldr	r3, .L2605
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2605
	str	r2, [r3, #60]
	ldr	r3, .L2605
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	and	r3, r3, #128
	mov	r3, r3, asl #16
	mov	r2, r3
	ldr	r3, .L2605
	str	r2, [r3, #128]
	ldr	r2, .L2605
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2605
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2605
	ldr	r2, [r3, #100]
	ldr	r3, .L2605+4
	cmp	r2, r3
	bne	.L2601
	ldr	r3, .L2605
	ldr	r2, [r3, #468]
	ldr	r3, .L2605
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2605
	strb	r3, [r2, #108]
.L2601:
	ldr	r3, .L2605
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2605
	str	r2, [r3, #72]
	ldr	r2, .L2605
	ldr	r3, .L2605
	str	r3, [r2, #104]
	ldr	r3, .L2605
	ldr	r2, [r3, #104]
	ldr	r3, .L2605
	str	r2, [r3, #100]
	b	.L2604
.L2599:
	ldr	r2, .L2605
	ldr	r3, .L2605+8
	str	r3, [r2, #104]
	ldr	r3, .L2605
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2605
	str	r2, [r3, #60]
.L2604:
	ldmib	sp, {fp, sp, pc}
.L2606:
	.align	2
.L2605:
	.word	GSU
	.word	GSU+56
	.word	GSU+60
	.size	_Z11fx_from_r15v, .-_Z11fx_from_r15v
	.align	2
	.type	_Z6fx_hibv, %function
_Z6fx_hibv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2611
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	str	r3, [fp, #-16]
	ldr	r3, .L2611
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2611
	str	r2, [r3, #60]
	ldr	r3, .L2611
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	mov	r2, r3, asl #8
	ldr	r3, .L2611
	str	r2, [r3, #116]
	ldr	r3, [fp, #-16]
	mov	r2, r3, asl #8
	ldr	r3, .L2611
	str	r2, [r3, #120]
	ldr	r3, .L2611
	ldr	r2, [r3, #100]
	ldr	r3, .L2611+4
	cmp	r2, r3
	bne	.L2608
	ldr	r3, .L2611
	ldr	r2, [r3, #468]
	ldr	r3, .L2611
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2611
	strb	r3, [r2, #108]
.L2608:
	ldr	r3, .L2611
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2611
	str	r2, [r3, #72]
	ldr	r2, .L2611
	ldr	r3, .L2611
	str	r3, [r2, #104]
	ldr	r3, .L2611
	ldr	r2, [r3, #104]
	ldr	r3, .L2611
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2612:
	.align	2
.L2611:
	.word	GSU
	.word	GSU+56
	.size	_Z6fx_hibv, .-_Z6fx_hibv
	.align	2
	.type	_Z8fx_or_r1v, %function
_Z8fx_or_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2617
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2617
	ldr	r3, [r3, #4]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2617
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2617
	str	r2, [r3, #60]
	ldr	r3, .L2617
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2617
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2617
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2617
	ldr	r2, [r3, #100]
	ldr	r3, .L2617+4
	cmp	r2, r3
	bne	.L2614
	ldr	r3, .L2617
	ldr	r2, [r3, #468]
	ldr	r3, .L2617
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2617
	strb	r3, [r2, #108]
.L2614:
	ldr	r3, .L2617
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2617
	str	r2, [r3, #72]
	ldr	r2, .L2617
	ldr	r3, .L2617
	str	r3, [r2, #104]
	ldr	r3, .L2617
	ldr	r2, [r3, #104]
	ldr	r3, .L2617
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2618:
	.align	2
.L2617:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r1v, .-_Z8fx_or_r1v
	.align	2
	.type	_Z8fx_or_r2v, %function
_Z8fx_or_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2623
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2623
	ldr	r3, [r3, #8]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2623
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2623
	str	r2, [r3, #60]
	ldr	r3, .L2623
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2623
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2623
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2623
	ldr	r2, [r3, #100]
	ldr	r3, .L2623+4
	cmp	r2, r3
	bne	.L2620
	ldr	r3, .L2623
	ldr	r2, [r3, #468]
	ldr	r3, .L2623
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2623
	strb	r3, [r2, #108]
.L2620:
	ldr	r3, .L2623
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2623
	str	r2, [r3, #72]
	ldr	r2, .L2623
	ldr	r3, .L2623
	str	r3, [r2, #104]
	ldr	r3, .L2623
	ldr	r2, [r3, #104]
	ldr	r3, .L2623
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2624:
	.align	2
.L2623:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r2v, .-_Z8fx_or_r2v
	.align	2
	.type	_Z8fx_or_r3v, %function
_Z8fx_or_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2629
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2629
	ldr	r3, [r3, #12]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2629
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2629
	str	r2, [r3, #60]
	ldr	r3, .L2629
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2629
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2629
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2629
	ldr	r2, [r3, #100]
	ldr	r3, .L2629+4
	cmp	r2, r3
	bne	.L2626
	ldr	r3, .L2629
	ldr	r2, [r3, #468]
	ldr	r3, .L2629
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2629
	strb	r3, [r2, #108]
.L2626:
	ldr	r3, .L2629
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2629
	str	r2, [r3, #72]
	ldr	r2, .L2629
	ldr	r3, .L2629
	str	r3, [r2, #104]
	ldr	r3, .L2629
	ldr	r2, [r3, #104]
	ldr	r3, .L2629
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2630:
	.align	2
.L2629:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r3v, .-_Z8fx_or_r3v
	.align	2
	.type	_Z8fx_or_r4v, %function
_Z8fx_or_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2635
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2635
	ldr	r3, [r3, #16]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2635
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2635
	str	r2, [r3, #60]
	ldr	r3, .L2635
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2635
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2635
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2635
	ldr	r2, [r3, #100]
	ldr	r3, .L2635+4
	cmp	r2, r3
	bne	.L2632
	ldr	r3, .L2635
	ldr	r2, [r3, #468]
	ldr	r3, .L2635
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2635
	strb	r3, [r2, #108]
.L2632:
	ldr	r3, .L2635
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2635
	str	r2, [r3, #72]
	ldr	r2, .L2635
	ldr	r3, .L2635
	str	r3, [r2, #104]
	ldr	r3, .L2635
	ldr	r2, [r3, #104]
	ldr	r3, .L2635
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2636:
	.align	2
.L2635:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r4v, .-_Z8fx_or_r4v
	.align	2
	.type	_Z8fx_or_r5v, %function
_Z8fx_or_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2641
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2641
	ldr	r3, [r3, #20]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2641
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2641
	str	r2, [r3, #60]
	ldr	r3, .L2641
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2641
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2641
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2641
	ldr	r2, [r3, #100]
	ldr	r3, .L2641+4
	cmp	r2, r3
	bne	.L2638
	ldr	r3, .L2641
	ldr	r2, [r3, #468]
	ldr	r3, .L2641
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2641
	strb	r3, [r2, #108]
.L2638:
	ldr	r3, .L2641
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2641
	str	r2, [r3, #72]
	ldr	r2, .L2641
	ldr	r3, .L2641
	str	r3, [r2, #104]
	ldr	r3, .L2641
	ldr	r2, [r3, #104]
	ldr	r3, .L2641
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2642:
	.align	2
.L2641:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r5v, .-_Z8fx_or_r5v
	.align	2
	.type	_Z8fx_or_r6v, %function
_Z8fx_or_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2647
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2647
	ldr	r3, [r3, #24]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2647
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2647
	str	r2, [r3, #60]
	ldr	r3, .L2647
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2647
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2647
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2647
	ldr	r2, [r3, #100]
	ldr	r3, .L2647+4
	cmp	r2, r3
	bne	.L2644
	ldr	r3, .L2647
	ldr	r2, [r3, #468]
	ldr	r3, .L2647
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2647
	strb	r3, [r2, #108]
.L2644:
	ldr	r3, .L2647
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2647
	str	r2, [r3, #72]
	ldr	r2, .L2647
	ldr	r3, .L2647
	str	r3, [r2, #104]
	ldr	r3, .L2647
	ldr	r2, [r3, #104]
	ldr	r3, .L2647
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2648:
	.align	2
.L2647:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r6v, .-_Z8fx_or_r6v
	.align	2
	.type	_Z8fx_or_r7v, %function
_Z8fx_or_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2653
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2653
	ldr	r3, [r3, #28]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2653
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2653
	str	r2, [r3, #60]
	ldr	r3, .L2653
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2653
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2653
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2653
	ldr	r2, [r3, #100]
	ldr	r3, .L2653+4
	cmp	r2, r3
	bne	.L2650
	ldr	r3, .L2653
	ldr	r2, [r3, #468]
	ldr	r3, .L2653
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2653
	strb	r3, [r2, #108]
.L2650:
	ldr	r3, .L2653
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2653
	str	r2, [r3, #72]
	ldr	r2, .L2653
	ldr	r3, .L2653
	str	r3, [r2, #104]
	ldr	r3, .L2653
	ldr	r2, [r3, #104]
	ldr	r3, .L2653
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2654:
	.align	2
.L2653:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r7v, .-_Z8fx_or_r7v
	.align	2
	.type	_Z8fx_or_r8v, %function
_Z8fx_or_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2659
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2659
	ldr	r3, [r3, #32]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2659
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2659
	str	r2, [r3, #60]
	ldr	r3, .L2659
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2659
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2659
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2659
	ldr	r2, [r3, #100]
	ldr	r3, .L2659+4
	cmp	r2, r3
	bne	.L2656
	ldr	r3, .L2659
	ldr	r2, [r3, #468]
	ldr	r3, .L2659
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2659
	strb	r3, [r2, #108]
.L2656:
	ldr	r3, .L2659
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2659
	str	r2, [r3, #72]
	ldr	r2, .L2659
	ldr	r3, .L2659
	str	r3, [r2, #104]
	ldr	r3, .L2659
	ldr	r2, [r3, #104]
	ldr	r3, .L2659
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2660:
	.align	2
.L2659:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r8v, .-_Z8fx_or_r8v
	.align	2
	.type	_Z8fx_or_r9v, %function
_Z8fx_or_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2665
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2665
	ldr	r3, [r3, #36]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2665
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2665
	str	r2, [r3, #60]
	ldr	r3, .L2665
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2665
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2665
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2665
	ldr	r2, [r3, #100]
	ldr	r3, .L2665+4
	cmp	r2, r3
	bne	.L2662
	ldr	r3, .L2665
	ldr	r2, [r3, #468]
	ldr	r3, .L2665
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2665
	strb	r3, [r2, #108]
.L2662:
	ldr	r3, .L2665
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2665
	str	r2, [r3, #72]
	ldr	r2, .L2665
	ldr	r3, .L2665
	str	r3, [r2, #104]
	ldr	r3, .L2665
	ldr	r2, [r3, #104]
	ldr	r3, .L2665
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2666:
	.align	2
.L2665:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_r9v, .-_Z8fx_or_r9v
	.align	2
	.type	_Z9fx_or_r10v, %function
_Z9fx_or_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2671
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2671
	ldr	r3, [r3, #40]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2671
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2671
	str	r2, [r3, #60]
	ldr	r3, .L2671
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2671
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2671
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2671
	ldr	r2, [r3, #100]
	ldr	r3, .L2671+4
	cmp	r2, r3
	bne	.L2668
	ldr	r3, .L2671
	ldr	r2, [r3, #468]
	ldr	r3, .L2671
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2671
	strb	r3, [r2, #108]
.L2668:
	ldr	r3, .L2671
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2671
	str	r2, [r3, #72]
	ldr	r2, .L2671
	ldr	r3, .L2671
	str	r3, [r2, #104]
	ldr	r3, .L2671
	ldr	r2, [r3, #104]
	ldr	r3, .L2671
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2672:
	.align	2
.L2671:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_r10v, .-_Z9fx_or_r10v
	.align	2
	.type	_Z9fx_or_r11v, %function
_Z9fx_or_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2677
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2677
	ldr	r3, [r3, #44]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2677
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2677
	str	r2, [r3, #60]
	ldr	r3, .L2677
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2677
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2677
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2677
	ldr	r2, [r3, #100]
	ldr	r3, .L2677+4
	cmp	r2, r3
	bne	.L2674
	ldr	r3, .L2677
	ldr	r2, [r3, #468]
	ldr	r3, .L2677
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2677
	strb	r3, [r2, #108]
.L2674:
	ldr	r3, .L2677
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2677
	str	r2, [r3, #72]
	ldr	r2, .L2677
	ldr	r3, .L2677
	str	r3, [r2, #104]
	ldr	r3, .L2677
	ldr	r2, [r3, #104]
	ldr	r3, .L2677
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2678:
	.align	2
.L2677:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_r11v, .-_Z9fx_or_r11v
	.align	2
	.type	_Z9fx_or_r12v, %function
_Z9fx_or_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2683
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2683
	ldr	r3, [r3, #48]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2683
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2683
	str	r2, [r3, #60]
	ldr	r3, .L2683
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2683
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2683
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2683
	ldr	r2, [r3, #100]
	ldr	r3, .L2683+4
	cmp	r2, r3
	bne	.L2680
	ldr	r3, .L2683
	ldr	r2, [r3, #468]
	ldr	r3, .L2683
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2683
	strb	r3, [r2, #108]
.L2680:
	ldr	r3, .L2683
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2683
	str	r2, [r3, #72]
	ldr	r2, .L2683
	ldr	r3, .L2683
	str	r3, [r2, #104]
	ldr	r3, .L2683
	ldr	r2, [r3, #104]
	ldr	r3, .L2683
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2684:
	.align	2
.L2683:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_r12v, .-_Z9fx_or_r12v
	.align	2
	.type	_Z9fx_or_r13v, %function
_Z9fx_or_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2689
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2689
	ldr	r3, [r3, #52]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2689
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2689
	str	r2, [r3, #60]
	ldr	r3, .L2689
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2689
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2689
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2689
	ldr	r2, [r3, #100]
	ldr	r3, .L2689+4
	cmp	r2, r3
	bne	.L2686
	ldr	r3, .L2689
	ldr	r2, [r3, #468]
	ldr	r3, .L2689
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2689
	strb	r3, [r2, #108]
.L2686:
	ldr	r3, .L2689
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2689
	str	r2, [r3, #72]
	ldr	r2, .L2689
	ldr	r3, .L2689
	str	r3, [r2, #104]
	ldr	r3, .L2689
	ldr	r2, [r3, #104]
	ldr	r3, .L2689
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2690:
	.align	2
.L2689:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_r13v, .-_Z9fx_or_r13v
	.align	2
	.type	_Z9fx_or_r14v, %function
_Z9fx_or_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2695
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2695
	ldr	r3, [r3, #56]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2695
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2695
	str	r2, [r3, #60]
	ldr	r3, .L2695
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2695
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2695
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2695
	ldr	r2, [r3, #100]
	ldr	r3, .L2695+4
	cmp	r2, r3
	bne	.L2692
	ldr	r3, .L2695
	ldr	r2, [r3, #468]
	ldr	r3, .L2695
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2695
	strb	r3, [r2, #108]
.L2692:
	ldr	r3, .L2695
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2695
	str	r2, [r3, #72]
	ldr	r2, .L2695
	ldr	r3, .L2695
	str	r3, [r2, #104]
	ldr	r3, .L2695
	ldr	r2, [r3, #104]
	ldr	r3, .L2695
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2696:
	.align	2
.L2695:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_r14v, .-_Z9fx_or_r14v
	.align	2
	.type	_Z9fx_or_r15v, %function
_Z9fx_or_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2701
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2701
	ldr	r3, [r3, #60]
	orr	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2701
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2701
	str	r2, [r3, #60]
	ldr	r3, .L2701
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2701
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2701
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2701
	ldr	r2, [r3, #100]
	ldr	r3, .L2701+4
	cmp	r2, r3
	bne	.L2698
	ldr	r3, .L2701
	ldr	r2, [r3, #468]
	ldr	r3, .L2701
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2701
	strb	r3, [r2, #108]
.L2698:
	ldr	r3, .L2701
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2701
	str	r2, [r3, #72]
	ldr	r2, .L2701
	ldr	r3, .L2701
	str	r3, [r2, #104]
	ldr	r3, .L2701
	ldr	r2, [r3, #104]
	ldr	r3, .L2701
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2702:
	.align	2
.L2701:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_r15v, .-_Z9fx_or_r15v
	.align	2
	.type	_Z9fx_xor_r1v, %function
_Z9fx_xor_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2707
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2707
	ldr	r3, [r3, #4]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2707
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2707
	str	r2, [r3, #60]
	ldr	r3, .L2707
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2707
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2707
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2707
	ldr	r2, [r3, #100]
	ldr	r3, .L2707+4
	cmp	r2, r3
	bne	.L2704
	ldr	r3, .L2707
	ldr	r2, [r3, #468]
	ldr	r3, .L2707
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2707
	strb	r3, [r2, #108]
.L2704:
	ldr	r3, .L2707
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2707
	str	r2, [r3, #72]
	ldr	r2, .L2707
	ldr	r3, .L2707
	str	r3, [r2, #104]
	ldr	r3, .L2707
	ldr	r2, [r3, #104]
	ldr	r3, .L2707
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2708:
	.align	2
.L2707:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r1v, .-_Z9fx_xor_r1v
	.align	2
	.type	_Z9fx_xor_r2v, %function
_Z9fx_xor_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2713
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2713
	ldr	r3, [r3, #8]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2713
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2713
	str	r2, [r3, #60]
	ldr	r3, .L2713
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2713
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2713
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2713
	ldr	r2, [r3, #100]
	ldr	r3, .L2713+4
	cmp	r2, r3
	bne	.L2710
	ldr	r3, .L2713
	ldr	r2, [r3, #468]
	ldr	r3, .L2713
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2713
	strb	r3, [r2, #108]
.L2710:
	ldr	r3, .L2713
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2713
	str	r2, [r3, #72]
	ldr	r2, .L2713
	ldr	r3, .L2713
	str	r3, [r2, #104]
	ldr	r3, .L2713
	ldr	r2, [r3, #104]
	ldr	r3, .L2713
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2714:
	.align	2
.L2713:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r2v, .-_Z9fx_xor_r2v
	.align	2
	.type	_Z9fx_xor_r3v, %function
_Z9fx_xor_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2719
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2719
	ldr	r3, [r3, #12]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2719
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2719
	str	r2, [r3, #60]
	ldr	r3, .L2719
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2719
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2719
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2719
	ldr	r2, [r3, #100]
	ldr	r3, .L2719+4
	cmp	r2, r3
	bne	.L2716
	ldr	r3, .L2719
	ldr	r2, [r3, #468]
	ldr	r3, .L2719
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2719
	strb	r3, [r2, #108]
.L2716:
	ldr	r3, .L2719
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2719
	str	r2, [r3, #72]
	ldr	r2, .L2719
	ldr	r3, .L2719
	str	r3, [r2, #104]
	ldr	r3, .L2719
	ldr	r2, [r3, #104]
	ldr	r3, .L2719
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2720:
	.align	2
.L2719:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r3v, .-_Z9fx_xor_r3v
	.align	2
	.type	_Z9fx_xor_r4v, %function
_Z9fx_xor_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2725
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2725
	ldr	r3, [r3, #16]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2725
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2725
	str	r2, [r3, #60]
	ldr	r3, .L2725
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2725
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2725
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2725
	ldr	r2, [r3, #100]
	ldr	r3, .L2725+4
	cmp	r2, r3
	bne	.L2722
	ldr	r3, .L2725
	ldr	r2, [r3, #468]
	ldr	r3, .L2725
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2725
	strb	r3, [r2, #108]
.L2722:
	ldr	r3, .L2725
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2725
	str	r2, [r3, #72]
	ldr	r2, .L2725
	ldr	r3, .L2725
	str	r3, [r2, #104]
	ldr	r3, .L2725
	ldr	r2, [r3, #104]
	ldr	r3, .L2725
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2726:
	.align	2
.L2725:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r4v, .-_Z9fx_xor_r4v
	.align	2
	.type	_Z9fx_xor_r5v, %function
_Z9fx_xor_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2731
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2731
	ldr	r3, [r3, #20]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2731
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2731
	str	r2, [r3, #60]
	ldr	r3, .L2731
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2731
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2731
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2731
	ldr	r2, [r3, #100]
	ldr	r3, .L2731+4
	cmp	r2, r3
	bne	.L2728
	ldr	r3, .L2731
	ldr	r2, [r3, #468]
	ldr	r3, .L2731
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2731
	strb	r3, [r2, #108]
.L2728:
	ldr	r3, .L2731
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2731
	str	r2, [r3, #72]
	ldr	r2, .L2731
	ldr	r3, .L2731
	str	r3, [r2, #104]
	ldr	r3, .L2731
	ldr	r2, [r3, #104]
	ldr	r3, .L2731
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2732:
	.align	2
.L2731:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r5v, .-_Z9fx_xor_r5v
	.align	2
	.type	_Z9fx_xor_r6v, %function
_Z9fx_xor_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2737
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2737
	ldr	r3, [r3, #24]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2737
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2737
	str	r2, [r3, #60]
	ldr	r3, .L2737
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2737
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2737
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2737
	ldr	r2, [r3, #100]
	ldr	r3, .L2737+4
	cmp	r2, r3
	bne	.L2734
	ldr	r3, .L2737
	ldr	r2, [r3, #468]
	ldr	r3, .L2737
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2737
	strb	r3, [r2, #108]
.L2734:
	ldr	r3, .L2737
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2737
	str	r2, [r3, #72]
	ldr	r2, .L2737
	ldr	r3, .L2737
	str	r3, [r2, #104]
	ldr	r3, .L2737
	ldr	r2, [r3, #104]
	ldr	r3, .L2737
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2738:
	.align	2
.L2737:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r6v, .-_Z9fx_xor_r6v
	.align	2
	.type	_Z9fx_xor_r7v, %function
_Z9fx_xor_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2743
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2743
	ldr	r3, [r3, #28]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2743
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2743
	str	r2, [r3, #60]
	ldr	r3, .L2743
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2743
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2743
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2743
	ldr	r2, [r3, #100]
	ldr	r3, .L2743+4
	cmp	r2, r3
	bne	.L2740
	ldr	r3, .L2743
	ldr	r2, [r3, #468]
	ldr	r3, .L2743
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2743
	strb	r3, [r2, #108]
.L2740:
	ldr	r3, .L2743
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2743
	str	r2, [r3, #72]
	ldr	r2, .L2743
	ldr	r3, .L2743
	str	r3, [r2, #104]
	ldr	r3, .L2743
	ldr	r2, [r3, #104]
	ldr	r3, .L2743
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2744:
	.align	2
.L2743:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r7v, .-_Z9fx_xor_r7v
	.align	2
	.type	_Z9fx_xor_r8v, %function
_Z9fx_xor_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2749
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2749
	ldr	r3, [r3, #32]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2749
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2749
	str	r2, [r3, #60]
	ldr	r3, .L2749
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2749
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2749
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2749
	ldr	r2, [r3, #100]
	ldr	r3, .L2749+4
	cmp	r2, r3
	bne	.L2746
	ldr	r3, .L2749
	ldr	r2, [r3, #468]
	ldr	r3, .L2749
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2749
	strb	r3, [r2, #108]
.L2746:
	ldr	r3, .L2749
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2749
	str	r2, [r3, #72]
	ldr	r2, .L2749
	ldr	r3, .L2749
	str	r3, [r2, #104]
	ldr	r3, .L2749
	ldr	r2, [r3, #104]
	ldr	r3, .L2749
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2750:
	.align	2
.L2749:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r8v, .-_Z9fx_xor_r8v
	.align	2
	.type	_Z9fx_xor_r9v, %function
_Z9fx_xor_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2755
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2755
	ldr	r3, [r3, #36]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2755
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2755
	str	r2, [r3, #60]
	ldr	r3, .L2755
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2755
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2755
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2755
	ldr	r2, [r3, #100]
	ldr	r3, .L2755+4
	cmp	r2, r3
	bne	.L2752
	ldr	r3, .L2755
	ldr	r2, [r3, #468]
	ldr	r3, .L2755
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2755
	strb	r3, [r2, #108]
.L2752:
	ldr	r3, .L2755
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2755
	str	r2, [r3, #72]
	ldr	r2, .L2755
	ldr	r3, .L2755
	str	r3, [r2, #104]
	ldr	r3, .L2755
	ldr	r2, [r3, #104]
	ldr	r3, .L2755
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2756:
	.align	2
.L2755:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_r9v, .-_Z9fx_xor_r9v
	.align	2
	.type	_Z10fx_xor_r10v, %function
_Z10fx_xor_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2761
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2761
	ldr	r3, [r3, #40]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2761
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2761
	str	r2, [r3, #60]
	ldr	r3, .L2761
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2761
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2761
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2761
	ldr	r2, [r3, #100]
	ldr	r3, .L2761+4
	cmp	r2, r3
	bne	.L2758
	ldr	r3, .L2761
	ldr	r2, [r3, #468]
	ldr	r3, .L2761
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2761
	strb	r3, [r2, #108]
.L2758:
	ldr	r3, .L2761
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2761
	str	r2, [r3, #72]
	ldr	r2, .L2761
	ldr	r3, .L2761
	str	r3, [r2, #104]
	ldr	r3, .L2761
	ldr	r2, [r3, #104]
	ldr	r3, .L2761
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2762:
	.align	2
.L2761:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_r10v, .-_Z10fx_xor_r10v
	.align	2
	.type	_Z10fx_xor_r11v, %function
_Z10fx_xor_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2767
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2767
	ldr	r3, [r3, #44]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2767
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2767
	str	r2, [r3, #60]
	ldr	r3, .L2767
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2767
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2767
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2767
	ldr	r2, [r3, #100]
	ldr	r3, .L2767+4
	cmp	r2, r3
	bne	.L2764
	ldr	r3, .L2767
	ldr	r2, [r3, #468]
	ldr	r3, .L2767
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2767
	strb	r3, [r2, #108]
.L2764:
	ldr	r3, .L2767
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2767
	str	r2, [r3, #72]
	ldr	r2, .L2767
	ldr	r3, .L2767
	str	r3, [r2, #104]
	ldr	r3, .L2767
	ldr	r2, [r3, #104]
	ldr	r3, .L2767
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2768:
	.align	2
.L2767:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_r11v, .-_Z10fx_xor_r11v
	.align	2
	.type	_Z10fx_xor_r12v, %function
_Z10fx_xor_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2773
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2773
	ldr	r3, [r3, #48]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2773
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2773
	str	r2, [r3, #60]
	ldr	r3, .L2773
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2773
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2773
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2773
	ldr	r2, [r3, #100]
	ldr	r3, .L2773+4
	cmp	r2, r3
	bne	.L2770
	ldr	r3, .L2773
	ldr	r2, [r3, #468]
	ldr	r3, .L2773
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2773
	strb	r3, [r2, #108]
.L2770:
	ldr	r3, .L2773
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2773
	str	r2, [r3, #72]
	ldr	r2, .L2773
	ldr	r3, .L2773
	str	r3, [r2, #104]
	ldr	r3, .L2773
	ldr	r2, [r3, #104]
	ldr	r3, .L2773
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2774:
	.align	2
.L2773:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_r12v, .-_Z10fx_xor_r12v
	.align	2
	.type	_Z10fx_xor_r13v, %function
_Z10fx_xor_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2779
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2779
	ldr	r3, [r3, #52]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2779
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2779
	str	r2, [r3, #60]
	ldr	r3, .L2779
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2779
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2779
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2779
	ldr	r2, [r3, #100]
	ldr	r3, .L2779+4
	cmp	r2, r3
	bne	.L2776
	ldr	r3, .L2779
	ldr	r2, [r3, #468]
	ldr	r3, .L2779
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2779
	strb	r3, [r2, #108]
.L2776:
	ldr	r3, .L2779
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2779
	str	r2, [r3, #72]
	ldr	r2, .L2779
	ldr	r3, .L2779
	str	r3, [r2, #104]
	ldr	r3, .L2779
	ldr	r2, [r3, #104]
	ldr	r3, .L2779
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2780:
	.align	2
.L2779:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_r13v, .-_Z10fx_xor_r13v
	.align	2
	.type	_Z10fx_xor_r14v, %function
_Z10fx_xor_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2785
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2785
	ldr	r3, [r3, #56]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2785
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2785
	str	r2, [r3, #60]
	ldr	r3, .L2785
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2785
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2785
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2785
	ldr	r2, [r3, #100]
	ldr	r3, .L2785+4
	cmp	r2, r3
	bne	.L2782
	ldr	r3, .L2785
	ldr	r2, [r3, #468]
	ldr	r3, .L2785
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2785
	strb	r3, [r2, #108]
.L2782:
	ldr	r3, .L2785
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2785
	str	r2, [r3, #72]
	ldr	r2, .L2785
	ldr	r3, .L2785
	str	r3, [r2, #104]
	ldr	r3, .L2785
	ldr	r2, [r3, #104]
	ldr	r3, .L2785
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2786:
	.align	2
.L2785:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_r14v, .-_Z10fx_xor_r14v
	.align	2
	.type	_Z10fx_xor_r15v, %function
_Z10fx_xor_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2791
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L2791
	ldr	r3, [r3, #60]
	eor	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L2791
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2791
	str	r2, [r3, #60]
	ldr	r3, .L2791
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2791
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2791
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2791
	ldr	r2, [r3, #100]
	ldr	r3, .L2791+4
	cmp	r2, r3
	bne	.L2788
	ldr	r3, .L2791
	ldr	r2, [r3, #468]
	ldr	r3, .L2791
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2791
	strb	r3, [r2, #108]
.L2788:
	ldr	r3, .L2791
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2791
	str	r2, [r3, #72]
	ldr	r2, .L2791
	ldr	r3, .L2791
	str	r3, [r2, #104]
	ldr	r3, .L2791
	ldr	r2, [r3, #104]
	ldr	r3, .L2791
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2792:
	.align	2
.L2791:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_r15v, .-_Z10fx_xor_r15v
	.align	2
	.type	_Z8fx_or_i1v, %function
_Z8fx_or_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2797
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, .L2797
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2797
	str	r2, [r3, #60]
	ldr	r3, .L2797
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2797
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2797
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2797
	ldr	r2, [r3, #100]
	ldr	r3, .L2797+4
	cmp	r2, r3
	bne	.L2794
	ldr	r3, .L2797
	ldr	r2, [r3, #468]
	ldr	r3, .L2797
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2797
	strb	r3, [r2, #108]
.L2794:
	ldr	r3, .L2797
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2797
	str	r2, [r3, #72]
	ldr	r2, .L2797
	ldr	r3, .L2797
	str	r3, [r2, #104]
	ldr	r3, .L2797
	ldr	r2, [r3, #104]
	ldr	r3, .L2797
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2798:
	.align	2
.L2797:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i1v, .-_Z8fx_or_i1v
	.align	2
	.type	_Z8fx_or_i2v, %function
_Z8fx_or_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2803
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r3, .L2803
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2803
	str	r2, [r3, #60]
	ldr	r3, .L2803
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2803
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2803
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2803
	ldr	r2, [r3, #100]
	ldr	r3, .L2803+4
	cmp	r2, r3
	bne	.L2800
	ldr	r3, .L2803
	ldr	r2, [r3, #468]
	ldr	r3, .L2803
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2803
	strb	r3, [r2, #108]
.L2800:
	ldr	r3, .L2803
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2803
	str	r2, [r3, #72]
	ldr	r2, .L2803
	ldr	r3, .L2803
	str	r3, [r2, #104]
	ldr	r3, .L2803
	ldr	r2, [r3, #104]
	ldr	r3, .L2803
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2804:
	.align	2
.L2803:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i2v, .-_Z8fx_or_i2v
	.align	2
	.type	_Z8fx_or_i3v, %function
_Z8fx_or_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2809
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #3
	str	r3, [fp, #-16]
	ldr	r3, .L2809
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2809
	str	r2, [r3, #60]
	ldr	r3, .L2809
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2809
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2809
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2809
	ldr	r2, [r3, #100]
	ldr	r3, .L2809+4
	cmp	r2, r3
	bne	.L2806
	ldr	r3, .L2809
	ldr	r2, [r3, #468]
	ldr	r3, .L2809
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2809
	strb	r3, [r2, #108]
.L2806:
	ldr	r3, .L2809
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2809
	str	r2, [r3, #72]
	ldr	r2, .L2809
	ldr	r3, .L2809
	str	r3, [r2, #104]
	ldr	r3, .L2809
	ldr	r2, [r3, #104]
	ldr	r3, .L2809
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2810:
	.align	2
.L2809:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i3v, .-_Z8fx_or_i3v
	.align	2
	.type	_Z8fx_or_i4v, %function
_Z8fx_or_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2815
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #4
	str	r3, [fp, #-16]
	ldr	r3, .L2815
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2815
	str	r2, [r3, #60]
	ldr	r3, .L2815
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2815
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2815
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2815
	ldr	r2, [r3, #100]
	ldr	r3, .L2815+4
	cmp	r2, r3
	bne	.L2812
	ldr	r3, .L2815
	ldr	r2, [r3, #468]
	ldr	r3, .L2815
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2815
	strb	r3, [r2, #108]
.L2812:
	ldr	r3, .L2815
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2815
	str	r2, [r3, #72]
	ldr	r2, .L2815
	ldr	r3, .L2815
	str	r3, [r2, #104]
	ldr	r3, .L2815
	ldr	r2, [r3, #104]
	ldr	r3, .L2815
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2816:
	.align	2
.L2815:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i4v, .-_Z8fx_or_i4v
	.align	2
	.type	_Z8fx_or_i5v, %function
_Z8fx_or_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2821
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #5
	str	r3, [fp, #-16]
	ldr	r3, .L2821
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2821
	str	r2, [r3, #60]
	ldr	r3, .L2821
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2821
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2821
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2821
	ldr	r2, [r3, #100]
	ldr	r3, .L2821+4
	cmp	r2, r3
	bne	.L2818
	ldr	r3, .L2821
	ldr	r2, [r3, #468]
	ldr	r3, .L2821
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2821
	strb	r3, [r2, #108]
.L2818:
	ldr	r3, .L2821
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2821
	str	r2, [r3, #72]
	ldr	r2, .L2821
	ldr	r3, .L2821
	str	r3, [r2, #104]
	ldr	r3, .L2821
	ldr	r2, [r3, #104]
	ldr	r3, .L2821
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2822:
	.align	2
.L2821:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i5v, .-_Z8fx_or_i5v
	.align	2
	.type	_Z8fx_or_i6v, %function
_Z8fx_or_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2827
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #6
	str	r3, [fp, #-16]
	ldr	r3, .L2827
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2827
	str	r2, [r3, #60]
	ldr	r3, .L2827
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2827
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2827
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2827
	ldr	r2, [r3, #100]
	ldr	r3, .L2827+4
	cmp	r2, r3
	bne	.L2824
	ldr	r3, .L2827
	ldr	r2, [r3, #468]
	ldr	r3, .L2827
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2827
	strb	r3, [r2, #108]
.L2824:
	ldr	r3, .L2827
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2827
	str	r2, [r3, #72]
	ldr	r2, .L2827
	ldr	r3, .L2827
	str	r3, [r2, #104]
	ldr	r3, .L2827
	ldr	r2, [r3, #104]
	ldr	r3, .L2827
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2828:
	.align	2
.L2827:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i6v, .-_Z8fx_or_i6v
	.align	2
	.type	_Z8fx_or_i7v, %function
_Z8fx_or_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2833
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #7
	str	r3, [fp, #-16]
	ldr	r3, .L2833
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2833
	str	r2, [r3, #60]
	ldr	r3, .L2833
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2833
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2833
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2833
	ldr	r2, [r3, #100]
	ldr	r3, .L2833+4
	cmp	r2, r3
	bne	.L2830
	ldr	r3, .L2833
	ldr	r2, [r3, #468]
	ldr	r3, .L2833
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2833
	strb	r3, [r2, #108]
.L2830:
	ldr	r3, .L2833
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2833
	str	r2, [r3, #72]
	ldr	r2, .L2833
	ldr	r3, .L2833
	str	r3, [r2, #104]
	ldr	r3, .L2833
	ldr	r2, [r3, #104]
	ldr	r3, .L2833
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2834:
	.align	2
.L2833:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i7v, .-_Z8fx_or_i7v
	.align	2
	.type	_Z8fx_or_i8v, %function
_Z8fx_or_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2839
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #8
	str	r3, [fp, #-16]
	ldr	r3, .L2839
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2839
	str	r2, [r3, #60]
	ldr	r3, .L2839
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2839
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2839
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2839
	ldr	r2, [r3, #100]
	ldr	r3, .L2839+4
	cmp	r2, r3
	bne	.L2836
	ldr	r3, .L2839
	ldr	r2, [r3, #468]
	ldr	r3, .L2839
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2839
	strb	r3, [r2, #108]
.L2836:
	ldr	r3, .L2839
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2839
	str	r2, [r3, #72]
	ldr	r2, .L2839
	ldr	r3, .L2839
	str	r3, [r2, #104]
	ldr	r3, .L2839
	ldr	r2, [r3, #104]
	ldr	r3, .L2839
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2840:
	.align	2
.L2839:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i8v, .-_Z8fx_or_i8v
	.align	2
	.type	_Z8fx_or_i9v, %function
_Z8fx_or_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2845
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #9
	str	r3, [fp, #-16]
	ldr	r3, .L2845
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2845
	str	r2, [r3, #60]
	ldr	r3, .L2845
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2845
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2845
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2845
	ldr	r2, [r3, #100]
	ldr	r3, .L2845+4
	cmp	r2, r3
	bne	.L2842
	ldr	r3, .L2845
	ldr	r2, [r3, #468]
	ldr	r3, .L2845
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2845
	strb	r3, [r2, #108]
.L2842:
	ldr	r3, .L2845
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2845
	str	r2, [r3, #72]
	ldr	r2, .L2845
	ldr	r3, .L2845
	str	r3, [r2, #104]
	ldr	r3, .L2845
	ldr	r2, [r3, #104]
	ldr	r3, .L2845
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2846:
	.align	2
.L2845:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_or_i9v, .-_Z8fx_or_i9v
	.align	2
	.type	_Z9fx_or_i10v, %function
_Z9fx_or_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2851
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #10
	str	r3, [fp, #-16]
	ldr	r3, .L2851
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2851
	str	r2, [r3, #60]
	ldr	r3, .L2851
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2851
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2851
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2851
	ldr	r2, [r3, #100]
	ldr	r3, .L2851+4
	cmp	r2, r3
	bne	.L2848
	ldr	r3, .L2851
	ldr	r2, [r3, #468]
	ldr	r3, .L2851
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2851
	strb	r3, [r2, #108]
.L2848:
	ldr	r3, .L2851
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2851
	str	r2, [r3, #72]
	ldr	r2, .L2851
	ldr	r3, .L2851
	str	r3, [r2, #104]
	ldr	r3, .L2851
	ldr	r2, [r3, #104]
	ldr	r3, .L2851
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2852:
	.align	2
.L2851:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_i10v, .-_Z9fx_or_i10v
	.align	2
	.type	_Z9fx_or_i11v, %function
_Z9fx_or_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2857
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #11
	str	r3, [fp, #-16]
	ldr	r3, .L2857
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2857
	str	r2, [r3, #60]
	ldr	r3, .L2857
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2857
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2857
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2857
	ldr	r2, [r3, #100]
	ldr	r3, .L2857+4
	cmp	r2, r3
	bne	.L2854
	ldr	r3, .L2857
	ldr	r2, [r3, #468]
	ldr	r3, .L2857
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2857
	strb	r3, [r2, #108]
.L2854:
	ldr	r3, .L2857
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2857
	str	r2, [r3, #72]
	ldr	r2, .L2857
	ldr	r3, .L2857
	str	r3, [r2, #104]
	ldr	r3, .L2857
	ldr	r2, [r3, #104]
	ldr	r3, .L2857
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2858:
	.align	2
.L2857:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_i11v, .-_Z9fx_or_i11v
	.align	2
	.type	_Z9fx_or_i12v, %function
_Z9fx_or_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2863
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #12
	str	r3, [fp, #-16]
	ldr	r3, .L2863
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2863
	str	r2, [r3, #60]
	ldr	r3, .L2863
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2863
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2863
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2863
	ldr	r2, [r3, #100]
	ldr	r3, .L2863+4
	cmp	r2, r3
	bne	.L2860
	ldr	r3, .L2863
	ldr	r2, [r3, #468]
	ldr	r3, .L2863
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2863
	strb	r3, [r2, #108]
.L2860:
	ldr	r3, .L2863
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2863
	str	r2, [r3, #72]
	ldr	r2, .L2863
	ldr	r3, .L2863
	str	r3, [r2, #104]
	ldr	r3, .L2863
	ldr	r2, [r3, #104]
	ldr	r3, .L2863
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2864:
	.align	2
.L2863:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_i12v, .-_Z9fx_or_i12v
	.align	2
	.type	_Z9fx_or_i13v, %function
_Z9fx_or_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2869
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #13
	str	r3, [fp, #-16]
	ldr	r3, .L2869
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2869
	str	r2, [r3, #60]
	ldr	r3, .L2869
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2869
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2869
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2869
	ldr	r2, [r3, #100]
	ldr	r3, .L2869+4
	cmp	r2, r3
	bne	.L2866
	ldr	r3, .L2869
	ldr	r2, [r3, #468]
	ldr	r3, .L2869
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2869
	strb	r3, [r2, #108]
.L2866:
	ldr	r3, .L2869
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2869
	str	r2, [r3, #72]
	ldr	r2, .L2869
	ldr	r3, .L2869
	str	r3, [r2, #104]
	ldr	r3, .L2869
	ldr	r2, [r3, #104]
	ldr	r3, .L2869
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2870:
	.align	2
.L2869:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_i13v, .-_Z9fx_or_i13v
	.align	2
	.type	_Z9fx_or_i14v, %function
_Z9fx_or_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2875
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #14
	str	r3, [fp, #-16]
	ldr	r3, .L2875
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2875
	str	r2, [r3, #60]
	ldr	r3, .L2875
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2875
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2875
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2875
	ldr	r2, [r3, #100]
	ldr	r3, .L2875+4
	cmp	r2, r3
	bne	.L2872
	ldr	r3, .L2875
	ldr	r2, [r3, #468]
	ldr	r3, .L2875
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2875
	strb	r3, [r2, #108]
.L2872:
	ldr	r3, .L2875
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2875
	str	r2, [r3, #72]
	ldr	r2, .L2875
	ldr	r3, .L2875
	str	r3, [r2, #104]
	ldr	r3, .L2875
	ldr	r2, [r3, #104]
	ldr	r3, .L2875
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2876:
	.align	2
.L2875:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_i14v, .-_Z9fx_or_i14v
	.align	2
	.type	_Z9fx_or_i15v, %function
_Z9fx_or_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2881
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	orr	r3, r3, #15
	str	r3, [fp, #-16]
	ldr	r3, .L2881
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2881
	str	r2, [r3, #60]
	ldr	r3, .L2881
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2881
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2881
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2881
	ldr	r2, [r3, #100]
	ldr	r3, .L2881+4
	cmp	r2, r3
	bne	.L2878
	ldr	r3, .L2881
	ldr	r2, [r3, #468]
	ldr	r3, .L2881
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2881
	strb	r3, [r2, #108]
.L2878:
	ldr	r3, .L2881
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2881
	str	r2, [r3, #72]
	ldr	r2, .L2881
	ldr	r3, .L2881
	str	r3, [r2, #104]
	ldr	r3, .L2881
	ldr	r2, [r3, #104]
	ldr	r3, .L2881
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2882:
	.align	2
.L2881:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_or_i15v, .-_Z9fx_or_i15v
	.align	2
	.type	_Z9fx_xor_i1v, %function
_Z9fx_xor_i1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2887
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, .L2887
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2887
	str	r2, [r3, #60]
	ldr	r3, .L2887
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2887
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2887
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2887
	ldr	r2, [r3, #100]
	ldr	r3, .L2887+4
	cmp	r2, r3
	bne	.L2884
	ldr	r3, .L2887
	ldr	r2, [r3, #468]
	ldr	r3, .L2887
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2887
	strb	r3, [r2, #108]
.L2884:
	ldr	r3, .L2887
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2887
	str	r2, [r3, #72]
	ldr	r2, .L2887
	ldr	r3, .L2887
	str	r3, [r2, #104]
	ldr	r3, .L2887
	ldr	r2, [r3, #104]
	ldr	r3, .L2887
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2888:
	.align	2
.L2887:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i1v, .-_Z9fx_xor_i1v
	.align	2
	.type	_Z9fx_xor_i2v, %function
_Z9fx_xor_i2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2893
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r3, .L2893
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2893
	str	r2, [r3, #60]
	ldr	r3, .L2893
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2893
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2893
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2893
	ldr	r2, [r3, #100]
	ldr	r3, .L2893+4
	cmp	r2, r3
	bne	.L2890
	ldr	r3, .L2893
	ldr	r2, [r3, #468]
	ldr	r3, .L2893
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2893
	strb	r3, [r2, #108]
.L2890:
	ldr	r3, .L2893
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2893
	str	r2, [r3, #72]
	ldr	r2, .L2893
	ldr	r3, .L2893
	str	r3, [r2, #104]
	ldr	r3, .L2893
	ldr	r2, [r3, #104]
	ldr	r3, .L2893
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2894:
	.align	2
.L2893:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i2v, .-_Z9fx_xor_i2v
	.align	2
	.type	_Z9fx_xor_i3v, %function
_Z9fx_xor_i3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2899
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #3
	str	r3, [fp, #-16]
	ldr	r3, .L2899
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2899
	str	r2, [r3, #60]
	ldr	r3, .L2899
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2899
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2899
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2899
	ldr	r2, [r3, #100]
	ldr	r3, .L2899+4
	cmp	r2, r3
	bne	.L2896
	ldr	r3, .L2899
	ldr	r2, [r3, #468]
	ldr	r3, .L2899
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2899
	strb	r3, [r2, #108]
.L2896:
	ldr	r3, .L2899
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2899
	str	r2, [r3, #72]
	ldr	r2, .L2899
	ldr	r3, .L2899
	str	r3, [r2, #104]
	ldr	r3, .L2899
	ldr	r2, [r3, #104]
	ldr	r3, .L2899
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2900:
	.align	2
.L2899:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i3v, .-_Z9fx_xor_i3v
	.align	2
	.type	_Z9fx_xor_i4v, %function
_Z9fx_xor_i4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2905
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #4
	str	r3, [fp, #-16]
	ldr	r3, .L2905
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2905
	str	r2, [r3, #60]
	ldr	r3, .L2905
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2905
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2905
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2905
	ldr	r2, [r3, #100]
	ldr	r3, .L2905+4
	cmp	r2, r3
	bne	.L2902
	ldr	r3, .L2905
	ldr	r2, [r3, #468]
	ldr	r3, .L2905
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2905
	strb	r3, [r2, #108]
.L2902:
	ldr	r3, .L2905
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2905
	str	r2, [r3, #72]
	ldr	r2, .L2905
	ldr	r3, .L2905
	str	r3, [r2, #104]
	ldr	r3, .L2905
	ldr	r2, [r3, #104]
	ldr	r3, .L2905
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2906:
	.align	2
.L2905:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i4v, .-_Z9fx_xor_i4v
	.align	2
	.type	_Z9fx_xor_i5v, %function
_Z9fx_xor_i5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2911
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #5
	str	r3, [fp, #-16]
	ldr	r3, .L2911
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2911
	str	r2, [r3, #60]
	ldr	r3, .L2911
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2911
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2911
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2911
	ldr	r2, [r3, #100]
	ldr	r3, .L2911+4
	cmp	r2, r3
	bne	.L2908
	ldr	r3, .L2911
	ldr	r2, [r3, #468]
	ldr	r3, .L2911
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2911
	strb	r3, [r2, #108]
.L2908:
	ldr	r3, .L2911
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2911
	str	r2, [r3, #72]
	ldr	r2, .L2911
	ldr	r3, .L2911
	str	r3, [r2, #104]
	ldr	r3, .L2911
	ldr	r2, [r3, #104]
	ldr	r3, .L2911
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2912:
	.align	2
.L2911:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i5v, .-_Z9fx_xor_i5v
	.align	2
	.type	_Z9fx_xor_i6v, %function
_Z9fx_xor_i6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2917
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #6
	str	r3, [fp, #-16]
	ldr	r3, .L2917
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2917
	str	r2, [r3, #60]
	ldr	r3, .L2917
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2917
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2917
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2917
	ldr	r2, [r3, #100]
	ldr	r3, .L2917+4
	cmp	r2, r3
	bne	.L2914
	ldr	r3, .L2917
	ldr	r2, [r3, #468]
	ldr	r3, .L2917
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2917
	strb	r3, [r2, #108]
.L2914:
	ldr	r3, .L2917
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2917
	str	r2, [r3, #72]
	ldr	r2, .L2917
	ldr	r3, .L2917
	str	r3, [r2, #104]
	ldr	r3, .L2917
	ldr	r2, [r3, #104]
	ldr	r3, .L2917
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2918:
	.align	2
.L2917:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i6v, .-_Z9fx_xor_i6v
	.align	2
	.type	_Z9fx_xor_i7v, %function
_Z9fx_xor_i7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2923
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #7
	str	r3, [fp, #-16]
	ldr	r3, .L2923
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2923
	str	r2, [r3, #60]
	ldr	r3, .L2923
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2923
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2923
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2923
	ldr	r2, [r3, #100]
	ldr	r3, .L2923+4
	cmp	r2, r3
	bne	.L2920
	ldr	r3, .L2923
	ldr	r2, [r3, #468]
	ldr	r3, .L2923
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2923
	strb	r3, [r2, #108]
.L2920:
	ldr	r3, .L2923
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2923
	str	r2, [r3, #72]
	ldr	r2, .L2923
	ldr	r3, .L2923
	str	r3, [r2, #104]
	ldr	r3, .L2923
	ldr	r2, [r3, #104]
	ldr	r3, .L2923
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2924:
	.align	2
.L2923:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i7v, .-_Z9fx_xor_i7v
	.align	2
	.type	_Z9fx_xor_i8v, %function
_Z9fx_xor_i8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2929
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #8
	str	r3, [fp, #-16]
	ldr	r3, .L2929
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2929
	str	r2, [r3, #60]
	ldr	r3, .L2929
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2929
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2929
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2929
	ldr	r2, [r3, #100]
	ldr	r3, .L2929+4
	cmp	r2, r3
	bne	.L2926
	ldr	r3, .L2929
	ldr	r2, [r3, #468]
	ldr	r3, .L2929
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2929
	strb	r3, [r2, #108]
.L2926:
	ldr	r3, .L2929
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2929
	str	r2, [r3, #72]
	ldr	r2, .L2929
	ldr	r3, .L2929
	str	r3, [r2, #104]
	ldr	r3, .L2929
	ldr	r2, [r3, #104]
	ldr	r3, .L2929
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2930:
	.align	2
.L2929:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i8v, .-_Z9fx_xor_i8v
	.align	2
	.type	_Z9fx_xor_i9v, %function
_Z9fx_xor_i9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2935
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #9
	str	r3, [fp, #-16]
	ldr	r3, .L2935
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2935
	str	r2, [r3, #60]
	ldr	r3, .L2935
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2935
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2935
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2935
	ldr	r2, [r3, #100]
	ldr	r3, .L2935+4
	cmp	r2, r3
	bne	.L2932
	ldr	r3, .L2935
	ldr	r2, [r3, #468]
	ldr	r3, .L2935
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2935
	strb	r3, [r2, #108]
.L2932:
	ldr	r3, .L2935
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2935
	str	r2, [r3, #72]
	ldr	r2, .L2935
	ldr	r3, .L2935
	str	r3, [r2, #104]
	ldr	r3, .L2935
	ldr	r2, [r3, #104]
	ldr	r3, .L2935
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2936:
	.align	2
.L2935:
	.word	GSU
	.word	GSU+56
	.size	_Z9fx_xor_i9v, .-_Z9fx_xor_i9v
	.align	2
	.type	_Z10fx_xor_i10v, %function
_Z10fx_xor_i10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2941
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #10
	str	r3, [fp, #-16]
	ldr	r3, .L2941
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2941
	str	r2, [r3, #60]
	ldr	r3, .L2941
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2941
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2941
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2941
	ldr	r2, [r3, #100]
	ldr	r3, .L2941+4
	cmp	r2, r3
	bne	.L2938
	ldr	r3, .L2941
	ldr	r2, [r3, #468]
	ldr	r3, .L2941
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2941
	strb	r3, [r2, #108]
.L2938:
	ldr	r3, .L2941
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2941
	str	r2, [r3, #72]
	ldr	r2, .L2941
	ldr	r3, .L2941
	str	r3, [r2, #104]
	ldr	r3, .L2941
	ldr	r2, [r3, #104]
	ldr	r3, .L2941
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2942:
	.align	2
.L2941:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_i10v, .-_Z10fx_xor_i10v
	.align	2
	.type	_Z10fx_xor_i11v, %function
_Z10fx_xor_i11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2947
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #11
	str	r3, [fp, #-16]
	ldr	r3, .L2947
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2947
	str	r2, [r3, #60]
	ldr	r3, .L2947
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2947
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2947
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2947
	ldr	r2, [r3, #100]
	ldr	r3, .L2947+4
	cmp	r2, r3
	bne	.L2944
	ldr	r3, .L2947
	ldr	r2, [r3, #468]
	ldr	r3, .L2947
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2947
	strb	r3, [r2, #108]
.L2944:
	ldr	r3, .L2947
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2947
	str	r2, [r3, #72]
	ldr	r2, .L2947
	ldr	r3, .L2947
	str	r3, [r2, #104]
	ldr	r3, .L2947
	ldr	r2, [r3, #104]
	ldr	r3, .L2947
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2948:
	.align	2
.L2947:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_i11v, .-_Z10fx_xor_i11v
	.align	2
	.type	_Z10fx_xor_i12v, %function
_Z10fx_xor_i12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2953
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #12
	str	r3, [fp, #-16]
	ldr	r3, .L2953
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2953
	str	r2, [r3, #60]
	ldr	r3, .L2953
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2953
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2953
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2953
	ldr	r2, [r3, #100]
	ldr	r3, .L2953+4
	cmp	r2, r3
	bne	.L2950
	ldr	r3, .L2953
	ldr	r2, [r3, #468]
	ldr	r3, .L2953
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2953
	strb	r3, [r2, #108]
.L2950:
	ldr	r3, .L2953
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2953
	str	r2, [r3, #72]
	ldr	r2, .L2953
	ldr	r3, .L2953
	str	r3, [r2, #104]
	ldr	r3, .L2953
	ldr	r2, [r3, #104]
	ldr	r3, .L2953
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2954:
	.align	2
.L2953:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_i12v, .-_Z10fx_xor_i12v
	.align	2
	.type	_Z10fx_xor_i13v, %function
_Z10fx_xor_i13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2959
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #13
	str	r3, [fp, #-16]
	ldr	r3, .L2959
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2959
	str	r2, [r3, #60]
	ldr	r3, .L2959
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2959
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2959
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2959
	ldr	r2, [r3, #100]
	ldr	r3, .L2959+4
	cmp	r2, r3
	bne	.L2956
	ldr	r3, .L2959
	ldr	r2, [r3, #468]
	ldr	r3, .L2959
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2959
	strb	r3, [r2, #108]
.L2956:
	ldr	r3, .L2959
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2959
	str	r2, [r3, #72]
	ldr	r2, .L2959
	ldr	r3, .L2959
	str	r3, [r2, #104]
	ldr	r3, .L2959
	ldr	r2, [r3, #104]
	ldr	r3, .L2959
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2960:
	.align	2
.L2959:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_i13v, .-_Z10fx_xor_i13v
	.align	2
	.type	_Z10fx_xor_i14v, %function
_Z10fx_xor_i14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2965
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #14
	str	r3, [fp, #-16]
	ldr	r3, .L2965
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2965
	str	r2, [r3, #60]
	ldr	r3, .L2965
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2965
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2965
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2965
	ldr	r2, [r3, #100]
	ldr	r3, .L2965+4
	cmp	r2, r3
	bne	.L2962
	ldr	r3, .L2965
	ldr	r2, [r3, #468]
	ldr	r3, .L2965
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2965
	strb	r3, [r2, #108]
.L2962:
	ldr	r3, .L2965
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2965
	str	r2, [r3, #72]
	ldr	r2, .L2965
	ldr	r3, .L2965
	str	r3, [r2, #104]
	ldr	r3, .L2965
	ldr	r2, [r3, #104]
	ldr	r3, .L2965
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2966:
	.align	2
.L2965:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_i14v, .-_Z10fx_xor_i14v
	.align	2
	.type	_Z10fx_xor_i15v, %function
_Z10fx_xor_i15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L2971
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	eor	r3, r3, #15
	str	r3, [fp, #-16]
	ldr	r3, .L2971
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2971
	str	r2, [r3, #60]
	ldr	r3, .L2971
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r2, .L2971
	ldr	r3, [fp, #-16]
	str	r3, [r2, #116]
	ldr	r2, .L2971
	ldr	r3, [fp, #-16]
	str	r3, [r2, #120]
	ldr	r3, .L2971
	ldr	r2, [r3, #100]
	ldr	r3, .L2971+4
	cmp	r2, r3
	bne	.L2968
	ldr	r3, .L2971
	ldr	r2, [r3, #468]
	ldr	r3, .L2971
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L2971
	strb	r3, [r2, #108]
.L2968:
	ldr	r3, .L2971
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2971
	str	r2, [r3, #72]
	ldr	r2, .L2971
	ldr	r3, .L2971
	str	r3, [r2, #104]
	ldr	r3, .L2971
	ldr	r2, [r3, #104]
	ldr	r3, .L2971
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L2972:
	.align	2
.L2971:
	.word	GSU
	.word	GSU+56
	.size	_Z10fx_xor_i15v, .-_Z10fx_xor_i15v
	.align	2
	.type	_Z9fx_inc_r0v, %function
_Z9fx_inc_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2975
	ldr	r3, [r3, #0]
	add	r2, r3, #1
	ldr	r3, .L2975
	str	r2, [r3, #0]
	ldr	r3, .L2975
	ldr	r2, [r3, #0]
	ldr	r3, .L2975
	str	r2, [r3, #116]
	ldr	r3, .L2975
	ldr	r2, [r3, #0]
	ldr	r3, .L2975
	str	r2, [r3, #120]
	ldr	r3, .L2975
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2975
	str	r2, [r3, #72]
	ldr	r2, .L2975
	ldr	r3, .L2975
	str	r3, [r2, #104]
	ldr	r3, .L2975
	ldr	r2, [r3, #104]
	ldr	r3, .L2975
	str	r2, [r3, #100]
	ldr	r3, .L2975
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2975
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2976:
	.align	2
.L2975:
	.word	GSU
	.size	_Z9fx_inc_r0v, .-_Z9fx_inc_r0v
	.align	2
	.type	_Z9fx_inc_r1v, %function
_Z9fx_inc_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2979
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, .L2979
	str	r2, [r3, #4]
	ldr	r3, .L2979
	ldr	r2, [r3, #4]
	ldr	r3, .L2979
	str	r2, [r3, #116]
	ldr	r3, .L2979
	ldr	r2, [r3, #4]
	ldr	r3, .L2979
	str	r2, [r3, #120]
	ldr	r3, .L2979
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2979
	str	r2, [r3, #72]
	ldr	r2, .L2979
	ldr	r3, .L2979
	str	r3, [r2, #104]
	ldr	r3, .L2979
	ldr	r2, [r3, #104]
	ldr	r3, .L2979
	str	r2, [r3, #100]
	ldr	r3, .L2979
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2979
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2980:
	.align	2
.L2979:
	.word	GSU
	.size	_Z9fx_inc_r1v, .-_Z9fx_inc_r1v
	.align	2
	.type	_Z9fx_inc_r2v, %function
_Z9fx_inc_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2983
	ldr	r3, [r3, #8]
	add	r2, r3, #1
	ldr	r3, .L2983
	str	r2, [r3, #8]
	ldr	r3, .L2983
	ldr	r2, [r3, #8]
	ldr	r3, .L2983
	str	r2, [r3, #116]
	ldr	r3, .L2983
	ldr	r2, [r3, #8]
	ldr	r3, .L2983
	str	r2, [r3, #120]
	ldr	r3, .L2983
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2983
	str	r2, [r3, #72]
	ldr	r2, .L2983
	ldr	r3, .L2983
	str	r3, [r2, #104]
	ldr	r3, .L2983
	ldr	r2, [r3, #104]
	ldr	r3, .L2983
	str	r2, [r3, #100]
	ldr	r3, .L2983
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2983
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2984:
	.align	2
.L2983:
	.word	GSU
	.size	_Z9fx_inc_r2v, .-_Z9fx_inc_r2v
	.align	2
	.type	_Z9fx_inc_r3v, %function
_Z9fx_inc_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2987
	ldr	r3, [r3, #12]
	add	r2, r3, #1
	ldr	r3, .L2987
	str	r2, [r3, #12]
	ldr	r3, .L2987
	ldr	r2, [r3, #12]
	ldr	r3, .L2987
	str	r2, [r3, #116]
	ldr	r3, .L2987
	ldr	r2, [r3, #12]
	ldr	r3, .L2987
	str	r2, [r3, #120]
	ldr	r3, .L2987
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2987
	str	r2, [r3, #72]
	ldr	r2, .L2987
	ldr	r3, .L2987
	str	r3, [r2, #104]
	ldr	r3, .L2987
	ldr	r2, [r3, #104]
	ldr	r3, .L2987
	str	r2, [r3, #100]
	ldr	r3, .L2987
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2987
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2988:
	.align	2
.L2987:
	.word	GSU
	.size	_Z9fx_inc_r3v, .-_Z9fx_inc_r3v
	.align	2
	.type	_Z9fx_inc_r4v, %function
_Z9fx_inc_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2991
	ldr	r3, [r3, #16]
	add	r2, r3, #1
	ldr	r3, .L2991
	str	r2, [r3, #16]
	ldr	r3, .L2991
	ldr	r2, [r3, #16]
	ldr	r3, .L2991
	str	r2, [r3, #116]
	ldr	r3, .L2991
	ldr	r2, [r3, #16]
	ldr	r3, .L2991
	str	r2, [r3, #120]
	ldr	r3, .L2991
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2991
	str	r2, [r3, #72]
	ldr	r2, .L2991
	ldr	r3, .L2991
	str	r3, [r2, #104]
	ldr	r3, .L2991
	ldr	r2, [r3, #104]
	ldr	r3, .L2991
	str	r2, [r3, #100]
	ldr	r3, .L2991
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2991
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2992:
	.align	2
.L2991:
	.word	GSU
	.size	_Z9fx_inc_r4v, .-_Z9fx_inc_r4v
	.align	2
	.type	_Z9fx_inc_r5v, %function
_Z9fx_inc_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2995
	ldr	r3, [r3, #20]
	add	r2, r3, #1
	ldr	r3, .L2995
	str	r2, [r3, #20]
	ldr	r3, .L2995
	ldr	r2, [r3, #20]
	ldr	r3, .L2995
	str	r2, [r3, #116]
	ldr	r3, .L2995
	ldr	r2, [r3, #20]
	ldr	r3, .L2995
	str	r2, [r3, #120]
	ldr	r3, .L2995
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2995
	str	r2, [r3, #72]
	ldr	r2, .L2995
	ldr	r3, .L2995
	str	r3, [r2, #104]
	ldr	r3, .L2995
	ldr	r2, [r3, #104]
	ldr	r3, .L2995
	str	r2, [r3, #100]
	ldr	r3, .L2995
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2995
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L2996:
	.align	2
.L2995:
	.word	GSU
	.size	_Z9fx_inc_r5v, .-_Z9fx_inc_r5v
	.align	2
	.type	_Z9fx_inc_r6v, %function
_Z9fx_inc_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L2999
	ldr	r3, [r3, #24]
	add	r2, r3, #1
	ldr	r3, .L2999
	str	r2, [r3, #24]
	ldr	r3, .L2999
	ldr	r2, [r3, #24]
	ldr	r3, .L2999
	str	r2, [r3, #116]
	ldr	r3, .L2999
	ldr	r2, [r3, #24]
	ldr	r3, .L2999
	str	r2, [r3, #120]
	ldr	r3, .L2999
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L2999
	str	r2, [r3, #72]
	ldr	r2, .L2999
	ldr	r3, .L2999
	str	r3, [r2, #104]
	ldr	r3, .L2999
	ldr	r2, [r3, #104]
	ldr	r3, .L2999
	str	r2, [r3, #100]
	ldr	r3, .L2999
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L2999
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3000:
	.align	2
.L2999:
	.word	GSU
	.size	_Z9fx_inc_r6v, .-_Z9fx_inc_r6v
	.align	2
	.type	_Z9fx_inc_r7v, %function
_Z9fx_inc_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3003
	ldr	r3, [r3, #28]
	add	r2, r3, #1
	ldr	r3, .L3003
	str	r2, [r3, #28]
	ldr	r3, .L3003
	ldr	r2, [r3, #28]
	ldr	r3, .L3003
	str	r2, [r3, #116]
	ldr	r3, .L3003
	ldr	r2, [r3, #28]
	ldr	r3, .L3003
	str	r2, [r3, #120]
	ldr	r3, .L3003
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3003
	str	r2, [r3, #72]
	ldr	r2, .L3003
	ldr	r3, .L3003
	str	r3, [r2, #104]
	ldr	r3, .L3003
	ldr	r2, [r3, #104]
	ldr	r3, .L3003
	str	r2, [r3, #100]
	ldr	r3, .L3003
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3003
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3004:
	.align	2
.L3003:
	.word	GSU
	.size	_Z9fx_inc_r7v, .-_Z9fx_inc_r7v
	.align	2
	.type	_Z9fx_inc_r8v, %function
_Z9fx_inc_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3007
	ldr	r3, [r3, #32]
	add	r2, r3, #1
	ldr	r3, .L3007
	str	r2, [r3, #32]
	ldr	r3, .L3007
	ldr	r2, [r3, #32]
	ldr	r3, .L3007
	str	r2, [r3, #116]
	ldr	r3, .L3007
	ldr	r2, [r3, #32]
	ldr	r3, .L3007
	str	r2, [r3, #120]
	ldr	r3, .L3007
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3007
	str	r2, [r3, #72]
	ldr	r2, .L3007
	ldr	r3, .L3007
	str	r3, [r2, #104]
	ldr	r3, .L3007
	ldr	r2, [r3, #104]
	ldr	r3, .L3007
	str	r2, [r3, #100]
	ldr	r3, .L3007
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3007
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3008:
	.align	2
.L3007:
	.word	GSU
	.size	_Z9fx_inc_r8v, .-_Z9fx_inc_r8v
	.align	2
	.type	_Z9fx_inc_r9v, %function
_Z9fx_inc_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3011
	ldr	r3, [r3, #36]
	add	r2, r3, #1
	ldr	r3, .L3011
	str	r2, [r3, #36]
	ldr	r3, .L3011
	ldr	r2, [r3, #36]
	ldr	r3, .L3011
	str	r2, [r3, #116]
	ldr	r3, .L3011
	ldr	r2, [r3, #36]
	ldr	r3, .L3011
	str	r2, [r3, #120]
	ldr	r3, .L3011
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3011
	str	r2, [r3, #72]
	ldr	r2, .L3011
	ldr	r3, .L3011
	str	r3, [r2, #104]
	ldr	r3, .L3011
	ldr	r2, [r3, #104]
	ldr	r3, .L3011
	str	r2, [r3, #100]
	ldr	r3, .L3011
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3011
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3012:
	.align	2
.L3011:
	.word	GSU
	.size	_Z9fx_inc_r9v, .-_Z9fx_inc_r9v
	.align	2
	.type	_Z10fx_inc_r10v, %function
_Z10fx_inc_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3015
	ldr	r3, [r3, #40]
	add	r2, r3, #1
	ldr	r3, .L3015
	str	r2, [r3, #40]
	ldr	r3, .L3015
	ldr	r2, [r3, #40]
	ldr	r3, .L3015
	str	r2, [r3, #116]
	ldr	r3, .L3015
	ldr	r2, [r3, #40]
	ldr	r3, .L3015
	str	r2, [r3, #120]
	ldr	r3, .L3015
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3015
	str	r2, [r3, #72]
	ldr	r2, .L3015
	ldr	r3, .L3015
	str	r3, [r2, #104]
	ldr	r3, .L3015
	ldr	r2, [r3, #104]
	ldr	r3, .L3015
	str	r2, [r3, #100]
	ldr	r3, .L3015
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3015
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3016:
	.align	2
.L3015:
	.word	GSU
	.size	_Z10fx_inc_r10v, .-_Z10fx_inc_r10v
	.align	2
	.type	_Z10fx_inc_r11v, %function
_Z10fx_inc_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3019
	ldr	r3, [r3, #44]
	add	r2, r3, #1
	ldr	r3, .L3019
	str	r2, [r3, #44]
	ldr	r3, .L3019
	ldr	r2, [r3, #44]
	ldr	r3, .L3019
	str	r2, [r3, #116]
	ldr	r3, .L3019
	ldr	r2, [r3, #44]
	ldr	r3, .L3019
	str	r2, [r3, #120]
	ldr	r3, .L3019
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3019
	str	r2, [r3, #72]
	ldr	r2, .L3019
	ldr	r3, .L3019
	str	r3, [r2, #104]
	ldr	r3, .L3019
	ldr	r2, [r3, #104]
	ldr	r3, .L3019
	str	r2, [r3, #100]
	ldr	r3, .L3019
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3019
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3020:
	.align	2
.L3019:
	.word	GSU
	.size	_Z10fx_inc_r11v, .-_Z10fx_inc_r11v
	.align	2
	.type	_Z10fx_inc_r12v, %function
_Z10fx_inc_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3023
	ldr	r3, [r3, #48]
	add	r2, r3, #1
	ldr	r3, .L3023
	str	r2, [r3, #48]
	ldr	r3, .L3023
	ldr	r2, [r3, #48]
	ldr	r3, .L3023
	str	r2, [r3, #116]
	ldr	r3, .L3023
	ldr	r2, [r3, #48]
	ldr	r3, .L3023
	str	r2, [r3, #120]
	ldr	r3, .L3023
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3023
	str	r2, [r3, #72]
	ldr	r2, .L3023
	ldr	r3, .L3023
	str	r3, [r2, #104]
	ldr	r3, .L3023
	ldr	r2, [r3, #104]
	ldr	r3, .L3023
	str	r2, [r3, #100]
	ldr	r3, .L3023
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3023
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3024:
	.align	2
.L3023:
	.word	GSU
	.size	_Z10fx_inc_r12v, .-_Z10fx_inc_r12v
	.align	2
	.type	_Z10fx_inc_r13v, %function
_Z10fx_inc_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3027
	ldr	r3, [r3, #52]
	add	r2, r3, #1
	ldr	r3, .L3027
	str	r2, [r3, #52]
	ldr	r3, .L3027
	ldr	r2, [r3, #52]
	ldr	r3, .L3027
	str	r2, [r3, #116]
	ldr	r3, .L3027
	ldr	r2, [r3, #52]
	ldr	r3, .L3027
	str	r2, [r3, #120]
	ldr	r3, .L3027
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3027
	str	r2, [r3, #72]
	ldr	r2, .L3027
	ldr	r3, .L3027
	str	r3, [r2, #104]
	ldr	r3, .L3027
	ldr	r2, [r3, #104]
	ldr	r3, .L3027
	str	r2, [r3, #100]
	ldr	r3, .L3027
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3027
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3028:
	.align	2
.L3027:
	.word	GSU
	.size	_Z10fx_inc_r13v, .-_Z10fx_inc_r13v
	.align	2
	.type	_Z10fx_inc_r14v, %function
_Z10fx_inc_r14v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3031
	ldr	r3, [r3, #56]
	add	r2, r3, #1
	ldr	r3, .L3031
	str	r2, [r3, #56]
	ldr	r3, .L3031
	ldr	r2, [r3, #56]
	ldr	r3, .L3031
	str	r2, [r3, #116]
	ldr	r3, .L3031
	ldr	r2, [r3, #56]
	ldr	r3, .L3031
	str	r2, [r3, #120]
	ldr	r3, .L3031
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3031
	str	r2, [r3, #72]
	ldr	r2, .L3031
	ldr	r3, .L3031
	str	r3, [r2, #104]
	ldr	r3, .L3031
	ldr	r2, [r3, #104]
	ldr	r3, .L3031
	str	r2, [r3, #100]
	ldr	r3, .L3031
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3031
	str	r2, [r3, #60]
	ldr	r3, .L3031
	ldr	r2, [r3, #468]
	ldr	r3, .L3031
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3031
	strb	r3, [r2, #108]
	ldmfd	sp, {fp, sp, pc}
.L3032:
	.align	2
.L3031:
	.word	GSU
	.size	_Z10fx_inc_r14v, .-_Z10fx_inc_r14v
	.align	2
	.type	_Z7fx_getcv, %function
_Z7fx_getcv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3040
	ldrb	r3, [r3, #108]
	strb	r3, [fp, #-13]
	ldr	r3, .L3040
	ldr	r3, [r3, #68]
	and	r3, r3, #4
	cmp	r3, #0
	beq	.L3034
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r2, r3, #255
	mov	r3, #240
	and	r2, r2, r3
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, lsr #4
	and	r3, r3, #255
	orr	r3, r2, r3
	and	r3, r3, #255
	strb	r3, [fp, #-13]
.L3034:
	ldr	r3, .L3040
	ldr	r3, [r3, #68]
	and	r3, r3, #8
	cmp	r3, #0
	beq	.L3036
	ldr	r3, .L3040
	ldr	r3, [r3, #64]
	and	r2, r3, #240
	ldr	r3, .L3040
	str	r2, [r3, #64]
	ldr	r3, .L3040
	ldr	r2, [r3, #64]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #15
	orr	r2, r2, r3
	ldr	r3, .L3040
	str	r2, [r3, #64]
	b	.L3038
.L3036:
	ldrb	r2, [fp, #-13]	@ zero_extendqisi2
	ldr	r3, .L3040
	str	r2, [r3, #64]
.L3038:
	ldr	r3, .L3040
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3040
	str	r2, [r3, #72]
	ldr	r2, .L3040
	ldr	r3, .L3040
	str	r3, [r2, #104]
	ldr	r3, .L3040
	ldr	r2, [r3, #104]
	ldr	r3, .L3040
	str	r2, [r3, #100]
	ldr	r3, .L3040
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3040
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3041:
	.align	2
.L3040:
	.word	GSU
	.size	_Z7fx_getcv, .-_Z7fx_getcv
	.align	2
	.type	_Z7fx_rambv, %function
_Z7fx_rambv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3044
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r2, r3, #3
	ldr	r3, .L3044
	str	r2, [r3, #84]
	ldr	r3, .L3044
	ldr	r3, [r3, #84]
	and	r3, r3, #3
	ldr	r2, .L3044
	mov	r1, #476
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3044
	str	r2, [r3, #464]
	ldr	r3, .L3044
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3044
	str	r2, [r3, #72]
	ldr	r2, .L3044
	ldr	r3, .L3044
	str	r3, [r2, #104]
	ldr	r3, .L3044
	ldr	r2, [r3, #104]
	ldr	r3, .L3044
	str	r2, [r3, #100]
	ldr	r3, .L3044
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3044
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3045:
	.align	2
.L3044:
	.word	GSU
	.size	_Z7fx_rambv, .-_Z7fx_rambv
	.align	2
	.type	_Z7fx_rombv, %function
_Z7fx_rombv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3048
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	and	r2, r3, #127
	ldr	r3, .L3048
	str	r2, [r3, #80]
	ldr	r3, .L3048
	ldr	r3, [r3, #80]
	ldr	r2, .L3048
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3048
	str	r2, [r3, #468]
	ldr	r3, .L3048
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3048
	str	r2, [r3, #72]
	ldr	r2, .L3048
	ldr	r3, .L3048
	str	r3, [r2, #104]
	ldr	r3, .L3048
	ldr	r2, [r3, #104]
	ldr	r3, .L3048
	str	r2, [r3, #100]
	ldr	r3, .L3048
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3048
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3049:
	.align	2
.L3048:
	.word	GSU
	.size	_Z7fx_rombv, .-_Z7fx_rombv
	.align	2
	.type	_Z9fx_dec_r0v, %function
_Z9fx_dec_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3052
	ldr	r3, [r3, #0]
	sub	r2, r3, #1
	ldr	r3, .L3052
	str	r2, [r3, #0]
	ldr	r3, .L3052
	ldr	r2, [r3, #0]
	ldr	r3, .L3052
	str	r2, [r3, #116]
	ldr	r3, .L3052
	ldr	r2, [r3, #0]
	ldr	r3, .L3052
	str	r2, [r3, #120]
	ldr	r3, .L3052
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3052
	str	r2, [r3, #72]
	ldr	r2, .L3052
	ldr	r3, .L3052
	str	r3, [r2, #104]
	ldr	r3, .L3052
	ldr	r2, [r3, #104]
	ldr	r3, .L3052
	str	r2, [r3, #100]
	ldr	r3, .L3052
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3052
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3053:
	.align	2
.L3052:
	.word	GSU
	.size	_Z9fx_dec_r0v, .-_Z9fx_dec_r0v
	.align	2
	.type	_Z9fx_dec_r1v, %function
_Z9fx_dec_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3056
	ldr	r3, [r3, #4]
	sub	r2, r3, #1
	ldr	r3, .L3056
	str	r2, [r3, #4]
	ldr	r3, .L3056
	ldr	r2, [r3, #4]
	ldr	r3, .L3056
	str	r2, [r3, #116]
	ldr	r3, .L3056
	ldr	r2, [r3, #4]
	ldr	r3, .L3056
	str	r2, [r3, #120]
	ldr	r3, .L3056
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3056
	str	r2, [r3, #72]
	ldr	r2, .L3056
	ldr	r3, .L3056
	str	r3, [r2, #104]
	ldr	r3, .L3056
	ldr	r2, [r3, #104]
	ldr	r3, .L3056
	str	r2, [r3, #100]
	ldr	r3, .L3056
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3056
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3057:
	.align	2
.L3056:
	.word	GSU
	.size	_Z9fx_dec_r1v, .-_Z9fx_dec_r1v
	.align	2
	.type	_Z9fx_dec_r2v, %function
_Z9fx_dec_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3060
	ldr	r3, [r3, #8]
	sub	r2, r3, #1
	ldr	r3, .L3060
	str	r2, [r3, #8]
	ldr	r3, .L3060
	ldr	r2, [r3, #8]
	ldr	r3, .L3060
	str	r2, [r3, #116]
	ldr	r3, .L3060
	ldr	r2, [r3, #8]
	ldr	r3, .L3060
	str	r2, [r3, #120]
	ldr	r3, .L3060
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3060
	str	r2, [r3, #72]
	ldr	r2, .L3060
	ldr	r3, .L3060
	str	r3, [r2, #104]
	ldr	r3, .L3060
	ldr	r2, [r3, #104]
	ldr	r3, .L3060
	str	r2, [r3, #100]
	ldr	r3, .L3060
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3060
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3061:
	.align	2
.L3060:
	.word	GSU
	.size	_Z9fx_dec_r2v, .-_Z9fx_dec_r2v
	.align	2
	.type	_Z9fx_dec_r3v, %function
_Z9fx_dec_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3064
	ldr	r3, [r3, #12]
	sub	r2, r3, #1
	ldr	r3, .L3064
	str	r2, [r3, #12]
	ldr	r3, .L3064
	ldr	r2, [r3, #12]
	ldr	r3, .L3064
	str	r2, [r3, #116]
	ldr	r3, .L3064
	ldr	r2, [r3, #12]
	ldr	r3, .L3064
	str	r2, [r3, #120]
	ldr	r3, .L3064
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3064
	str	r2, [r3, #72]
	ldr	r2, .L3064
	ldr	r3, .L3064
	str	r3, [r2, #104]
	ldr	r3, .L3064
	ldr	r2, [r3, #104]
	ldr	r3, .L3064
	str	r2, [r3, #100]
	ldr	r3, .L3064
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3064
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3065:
	.align	2
.L3064:
	.word	GSU
	.size	_Z9fx_dec_r3v, .-_Z9fx_dec_r3v
	.align	2
	.type	_Z9fx_dec_r4v, %function
_Z9fx_dec_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3068
	ldr	r3, [r3, #16]
	sub	r2, r3, #1
	ldr	r3, .L3068
	str	r2, [r3, #16]
	ldr	r3, .L3068
	ldr	r2, [r3, #16]
	ldr	r3, .L3068
	str	r2, [r3, #116]
	ldr	r3, .L3068
	ldr	r2, [r3, #16]
	ldr	r3, .L3068
	str	r2, [r3, #120]
	ldr	r3, .L3068
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3068
	str	r2, [r3, #72]
	ldr	r2, .L3068
	ldr	r3, .L3068
	str	r3, [r2, #104]
	ldr	r3, .L3068
	ldr	r2, [r3, #104]
	ldr	r3, .L3068
	str	r2, [r3, #100]
	ldr	r3, .L3068
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3068
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3069:
	.align	2
.L3068:
	.word	GSU
	.size	_Z9fx_dec_r4v, .-_Z9fx_dec_r4v
	.align	2
	.type	_Z9fx_dec_r5v, %function
_Z9fx_dec_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3072
	ldr	r3, [r3, #20]
	sub	r2, r3, #1
	ldr	r3, .L3072
	str	r2, [r3, #20]
	ldr	r3, .L3072
	ldr	r2, [r3, #20]
	ldr	r3, .L3072
	str	r2, [r3, #116]
	ldr	r3, .L3072
	ldr	r2, [r3, #20]
	ldr	r3, .L3072
	str	r2, [r3, #120]
	ldr	r3, .L3072
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3072
	str	r2, [r3, #72]
	ldr	r2, .L3072
	ldr	r3, .L3072
	str	r3, [r2, #104]
	ldr	r3, .L3072
	ldr	r2, [r3, #104]
	ldr	r3, .L3072
	str	r2, [r3, #100]
	ldr	r3, .L3072
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3072
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3073:
	.align	2
.L3072:
	.word	GSU
	.size	_Z9fx_dec_r5v, .-_Z9fx_dec_r5v
	.align	2
	.type	_Z9fx_dec_r6v, %function
_Z9fx_dec_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3076
	ldr	r3, [r3, #24]
	sub	r2, r3, #1
	ldr	r3, .L3076
	str	r2, [r3, #24]
	ldr	r3, .L3076
	ldr	r2, [r3, #24]
	ldr	r3, .L3076
	str	r2, [r3, #116]
	ldr	r3, .L3076
	ldr	r2, [r3, #24]
	ldr	r3, .L3076
	str	r2, [r3, #120]
	ldr	r3, .L3076
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3076
	str	r2, [r3, #72]
	ldr	r2, .L3076
	ldr	r3, .L3076
	str	r3, [r2, #104]
	ldr	r3, .L3076
	ldr	r2, [r3, #104]
	ldr	r3, .L3076
	str	r2, [r3, #100]
	ldr	r3, .L3076
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3076
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3077:
	.align	2
.L3076:
	.word	GSU
	.size	_Z9fx_dec_r6v, .-_Z9fx_dec_r6v
	.align	2
	.type	_Z9fx_dec_r7v, %function
_Z9fx_dec_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3080
	ldr	r3, [r3, #28]
	sub	r2, r3, #1
	ldr	r3, .L3080
	str	r2, [r3, #28]
	ldr	r3, .L3080
	ldr	r2, [r3, #28]
	ldr	r3, .L3080
	str	r2, [r3, #116]
	ldr	r3, .L3080
	ldr	r2, [r3, #28]
	ldr	r3, .L3080
	str	r2, [r3, #120]
	ldr	r3, .L3080
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3080
	str	r2, [r3, #72]
	ldr	r2, .L3080
	ldr	r3, .L3080
	str	r3, [r2, #104]
	ldr	r3, .L3080
	ldr	r2, [r3, #104]
	ldr	r3, .L3080
	str	r2, [r3, #100]
	ldr	r3, .L3080
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3080
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3081:
	.align	2
.L3080:
	.word	GSU
	.size	_Z9fx_dec_r7v, .-_Z9fx_dec_r7v
	.align	2
	.type	_Z9fx_dec_r8v, %function
_Z9fx_dec_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3084
	ldr	r3, [r3, #32]
	sub	r2, r3, #1
	ldr	r3, .L3084
	str	r2, [r3, #32]
	ldr	r3, .L3084
	ldr	r2, [r3, #32]
	ldr	r3, .L3084
	str	r2, [r3, #116]
	ldr	r3, .L3084
	ldr	r2, [r3, #32]
	ldr	r3, .L3084
	str	r2, [r3, #120]
	ldr	r3, .L3084
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3084
	str	r2, [r3, #72]
	ldr	r2, .L3084
	ldr	r3, .L3084
	str	r3, [r2, #104]
	ldr	r3, .L3084
	ldr	r2, [r3, #104]
	ldr	r3, .L3084
	str	r2, [r3, #100]
	ldr	r3, .L3084
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3084
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3085:
	.align	2
.L3084:
	.word	GSU
	.size	_Z9fx_dec_r8v, .-_Z9fx_dec_r8v
	.align	2
	.type	_Z9fx_dec_r9v, %function
_Z9fx_dec_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3088
	ldr	r3, [r3, #36]
	sub	r2, r3, #1
	ldr	r3, .L3088
	str	r2, [r3, #36]
	ldr	r3, .L3088
	ldr	r2, [r3, #36]
	ldr	r3, .L3088
	str	r2, [r3, #116]
	ldr	r3, .L3088
	ldr	r2, [r3, #36]
	ldr	r3, .L3088
	str	r2, [r3, #120]
	ldr	r3, .L3088
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3088
	str	r2, [r3, #72]
	ldr	r2, .L3088
	ldr	r3, .L3088
	str	r3, [r2, #104]
	ldr	r3, .L3088
	ldr	r2, [r3, #104]
	ldr	r3, .L3088
	str	r2, [r3, #100]
	ldr	r3, .L3088
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3088
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3089:
	.align	2
.L3088:
	.word	GSU
	.size	_Z9fx_dec_r9v, .-_Z9fx_dec_r9v
	.align	2
	.type	_Z10fx_dec_r10v, %function
_Z10fx_dec_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3092
	ldr	r3, [r3, #40]
	sub	r2, r3, #1
	ldr	r3, .L3092
	str	r2, [r3, #40]
	ldr	r3, .L3092
	ldr	r2, [r3, #40]
	ldr	r3, .L3092
	str	r2, [r3, #116]
	ldr	r3, .L3092
	ldr	r2, [r3, #40]
	ldr	r3, .L3092
	str	r2, [r3, #120]
	ldr	r3, .L3092
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3092
	str	r2, [r3, #72]
	ldr	r2, .L3092
	ldr	r3, .L3092
	str	r3, [r2, #104]
	ldr	r3, .L3092
	ldr	r2, [r3, #104]
	ldr	r3, .L3092
	str	r2, [r3, #100]
	ldr	r3, .L3092
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3092
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3093:
	.align	2
.L3092:
	.word	GSU
	.size	_Z10fx_dec_r10v, .-_Z10fx_dec_r10v
	.align	2
	.type	_Z10fx_dec_r11v, %function
_Z10fx_dec_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3096
	ldr	r3, [r3, #44]
	sub	r2, r3, #1
	ldr	r3, .L3096
	str	r2, [r3, #44]
	ldr	r3, .L3096
	ldr	r2, [r3, #44]
	ldr	r3, .L3096
	str	r2, [r3, #116]
	ldr	r3, .L3096
	ldr	r2, [r3, #44]
	ldr	r3, .L3096
	str	r2, [r3, #120]
	ldr	r3, .L3096
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3096
	str	r2, [r3, #72]
	ldr	r2, .L3096
	ldr	r3, .L3096
	str	r3, [r2, #104]
	ldr	r3, .L3096
	ldr	r2, [r3, #104]
	ldr	r3, .L3096
	str	r2, [r3, #100]
	ldr	r3, .L3096
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3096
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3097:
	.align	2
.L3096:
	.word	GSU
	.size	_Z10fx_dec_r11v, .-_Z10fx_dec_r11v
	.align	2
	.type	_Z10fx_dec_r12v, %function
_Z10fx_dec_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3100
	ldr	r3, [r3, #48]
	sub	r2, r3, #1
	ldr	r3, .L3100
	str	r2, [r3, #48]
	ldr	r3, .L3100
	ldr	r2, [r3, #48]
	ldr	r3, .L3100
	str	r2, [r3, #116]
	ldr	r3, .L3100
	ldr	r2, [r3, #48]
	ldr	r3, .L3100
	str	r2, [r3, #120]
	ldr	r3, .L3100
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3100
	str	r2, [r3, #72]
	ldr	r2, .L3100
	ldr	r3, .L3100
	str	r3, [r2, #104]
	ldr	r3, .L3100
	ldr	r2, [r3, #104]
	ldr	r3, .L3100
	str	r2, [r3, #100]
	ldr	r3, .L3100
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3100
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3101:
	.align	2
.L3100:
	.word	GSU
	.size	_Z10fx_dec_r12v, .-_Z10fx_dec_r12v
	.align	2
	.type	_Z10fx_dec_r13v, %function
_Z10fx_dec_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3104
	ldr	r3, [r3, #52]
	sub	r2, r3, #1
	ldr	r3, .L3104
	str	r2, [r3, #52]
	ldr	r3, .L3104
	ldr	r2, [r3, #52]
	ldr	r3, .L3104
	str	r2, [r3, #116]
	ldr	r3, .L3104
	ldr	r2, [r3, #52]
	ldr	r3, .L3104
	str	r2, [r3, #120]
	ldr	r3, .L3104
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3104
	str	r2, [r3, #72]
	ldr	r2, .L3104
	ldr	r3, .L3104
	str	r3, [r2, #104]
	ldr	r3, .L3104
	ldr	r2, [r3, #104]
	ldr	r3, .L3104
	str	r2, [r3, #100]
	ldr	r3, .L3104
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3104
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3105:
	.align	2
.L3104:
	.word	GSU
	.size	_Z10fx_dec_r13v, .-_Z10fx_dec_r13v
	.align	2
	.type	_Z10fx_dec_r14v, %function
_Z10fx_dec_r14v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3108
	ldr	r3, [r3, #56]
	sub	r2, r3, #1
	ldr	r3, .L3108
	str	r2, [r3, #56]
	ldr	r3, .L3108
	ldr	r2, [r3, #56]
	ldr	r3, .L3108
	str	r2, [r3, #116]
	ldr	r3, .L3108
	ldr	r2, [r3, #56]
	ldr	r3, .L3108
	str	r2, [r3, #120]
	ldr	r3, .L3108
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3108
	str	r2, [r3, #72]
	ldr	r2, .L3108
	ldr	r3, .L3108
	str	r3, [r2, #104]
	ldr	r3, .L3108
	ldr	r2, [r3, #104]
	ldr	r3, .L3108
	str	r2, [r3, #100]
	ldr	r3, .L3108
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3108
	str	r2, [r3, #60]
	ldr	r3, .L3108
	ldr	r2, [r3, #468]
	ldr	r3, .L3108
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3108
	strb	r3, [r2, #108]
	ldmfd	sp, {fp, sp, pc}
.L3109:
	.align	2
.L3108:
	.word	GSU
	.size	_Z10fx_dec_r14v, .-_Z10fx_dec_r14v
	.align	2
	.type	_Z7fx_getbv, %function
_Z7fx_getbv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3114
	ldrb	r3, [r3, #108]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3114
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3114
	str	r2, [r3, #60]
	ldr	r3, .L3114
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L3114
	ldr	r2, [r3, #100]
	ldr	r3, .L3114+4
	cmp	r2, r3
	bne	.L3111
	ldr	r3, .L3114
	ldr	r2, [r3, #468]
	ldr	r3, .L3114
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3114
	strb	r3, [r2, #108]
.L3111:
	ldr	r3, .L3114
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3114
	str	r2, [r3, #72]
	ldr	r2, .L3114
	ldr	r3, .L3114
	str	r3, [r2, #104]
	ldr	r3, .L3114
	ldr	r2, [r3, #104]
	ldr	r3, .L3114
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3115:
	.align	2
.L3114:
	.word	GSU
	.word	GSU+56
	.size	_Z7fx_getbv, .-_Z7fx_getbv
	.align	2
	.type	_Z8fx_getbhv, %function
_Z8fx_getbhv:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	ldr	r3, .L3120
	ldrb	r3, [r3, #108]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3120
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	mov	r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, .L3120
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3120
	str	r2, [r3, #60]
	ldr	r3, .L3120
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r3, .L3120
	ldr	r2, [r3, #100]
	ldr	r3, .L3120+4
	cmp	r2, r3
	bne	.L3117
	ldr	r3, .L3120
	ldr	r2, [r3, #468]
	ldr	r3, .L3120
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3120
	strb	r3, [r2, #108]
.L3117:
	ldr	r3, .L3120
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3120
	str	r2, [r3, #72]
	ldr	r2, .L3120
	ldr	r3, .L3120
	str	r3, [r2, #104]
	ldr	r3, .L3120
	ldr	r2, [r3, #104]
	ldr	r3, .L3120
	str	r2, [r3, #100]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L3121:
	.align	2
.L3120:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_getbhv, .-_Z8fx_getbhv
	.align	2
	.type	_Z8fx_getblv, %function
_Z8fx_getblv:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	ldr	r3, .L3126
	ldrb	r3, [r3, #108]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3126
	ldr	r3, [r3, #104]
	ldr	r3, [r3, #0]
	and	r2, r3, #65280
	ldr	r3, [fp, #-16]
	orr	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, .L3126
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3126
	str	r2, [r3, #60]
	ldr	r3, .L3126
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-20]
	str	r3, [r2, #0]
	ldr	r3, .L3126
	ldr	r2, [r3, #100]
	ldr	r3, .L3126+4
	cmp	r2, r3
	bne	.L3123
	ldr	r3, .L3126
	ldr	r2, [r3, #468]
	ldr	r3, .L3126
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3126
	strb	r3, [r2, #108]
.L3123:
	ldr	r3, .L3126
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3126
	str	r2, [r3, #72]
	ldr	r2, .L3126
	ldr	r3, .L3126
	str	r3, [r2, #104]
	ldr	r3, .L3126
	ldr	r2, [r3, #104]
	ldr	r3, .L3126
	str	r2, [r3, #100]
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L3127:
	.align	2
.L3126:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_getblv, .-_Z8fx_getblv
	.align	2
	.type	_Z8fx_getbsv, %function
_Z8fx_getbsv:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3132
	ldrb	r3, [r3, #108]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	str	r3, [fp, #-16]
	ldr	r3, .L3132
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3132
	str	r2, [r3, #60]
	ldr	r3, .L3132
	ldr	r2, [r3, #100]
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L3132
	ldr	r2, [r3, #100]
	ldr	r3, .L3132+4
	cmp	r2, r3
	bne	.L3129
	ldr	r3, .L3132
	ldr	r2, [r3, #468]
	ldr	r3, .L3132
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3132
	strb	r3, [r2, #108]
.L3129:
	ldr	r3, .L3132
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3132
	str	r2, [r3, #72]
	ldr	r2, .L3132
	ldr	r3, .L3132
	str	r3, [r2, #104]
	ldr	r3, .L3132
	ldr	r2, [r3, #104]
	ldr	r3, .L3132
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3133:
	.align	2
.L3132:
	.word	GSU
	.word	GSU+56
	.size	_Z8fx_getbsv, .-_Z8fx_getbsv
	.align	2
	.type	_Z9fx_iwt_r0v, %function
_Z9fx_iwt_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3136
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3136
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3136
	str	r2, [r3, #60]
	ldr	r3, .L3136
	ldr	r2, [r3, #472]
	ldr	r3, .L3136
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3136
	strb	r3, [r2, #109]
	ldr	r3, .L3136
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3136
	str	r2, [r3, #60]
	ldr	r3, .L3136
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3136
	ldr	r2, [r3, #472]
	ldr	r3, .L3136
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3136
	strb	r3, [r2, #109]
	ldr	r3, .L3136
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3136
	str	r2, [r3, #60]
	ldr	r2, .L3136
	ldr	r3, [fp, #-16]
	str	r3, [r2, #0]
	ldr	r3, .L3136
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3136
	str	r2, [r3, #72]
	ldr	r2, .L3136
	ldr	r3, .L3136
	str	r3, [r2, #104]
	ldr	r3, .L3136
	ldr	r2, [r3, #104]
	ldr	r3, .L3136
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3137:
	.align	2
.L3136:
	.word	GSU
	.size	_Z9fx_iwt_r0v, .-_Z9fx_iwt_r0v
	.align	2
	.type	_Z9fx_iwt_r1v, %function
_Z9fx_iwt_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3140
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3140
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3140
	str	r2, [r3, #60]
	ldr	r3, .L3140
	ldr	r2, [r3, #472]
	ldr	r3, .L3140
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3140
	strb	r3, [r2, #109]
	ldr	r3, .L3140
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3140
	str	r2, [r3, #60]
	ldr	r3, .L3140
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3140
	ldr	r2, [r3, #472]
	ldr	r3, .L3140
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3140
	strb	r3, [r2, #109]
	ldr	r3, .L3140
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3140
	str	r2, [r3, #60]
	ldr	r2, .L3140
	ldr	r3, [fp, #-16]
	str	r3, [r2, #4]
	ldr	r3, .L3140
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3140
	str	r2, [r3, #72]
	ldr	r2, .L3140
	ldr	r3, .L3140
	str	r3, [r2, #104]
	ldr	r3, .L3140
	ldr	r2, [r3, #104]
	ldr	r3, .L3140
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3141:
	.align	2
.L3140:
	.word	GSU
	.size	_Z9fx_iwt_r1v, .-_Z9fx_iwt_r1v
	.align	2
	.type	_Z9fx_iwt_r2v, %function
_Z9fx_iwt_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3144
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3144
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3144
	str	r2, [r3, #60]
	ldr	r3, .L3144
	ldr	r2, [r3, #472]
	ldr	r3, .L3144
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3144
	strb	r3, [r2, #109]
	ldr	r3, .L3144
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3144
	str	r2, [r3, #60]
	ldr	r3, .L3144
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3144
	ldr	r2, [r3, #472]
	ldr	r3, .L3144
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3144
	strb	r3, [r2, #109]
	ldr	r3, .L3144
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3144
	str	r2, [r3, #60]
	ldr	r2, .L3144
	ldr	r3, [fp, #-16]
	str	r3, [r2, #8]
	ldr	r3, .L3144
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3144
	str	r2, [r3, #72]
	ldr	r2, .L3144
	ldr	r3, .L3144
	str	r3, [r2, #104]
	ldr	r3, .L3144
	ldr	r2, [r3, #104]
	ldr	r3, .L3144
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3145:
	.align	2
.L3144:
	.word	GSU
	.size	_Z9fx_iwt_r2v, .-_Z9fx_iwt_r2v
	.align	2
	.type	_Z9fx_iwt_r3v, %function
_Z9fx_iwt_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3148
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3148
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3148
	str	r2, [r3, #60]
	ldr	r3, .L3148
	ldr	r2, [r3, #472]
	ldr	r3, .L3148
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3148
	strb	r3, [r2, #109]
	ldr	r3, .L3148
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3148
	str	r2, [r3, #60]
	ldr	r3, .L3148
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3148
	ldr	r2, [r3, #472]
	ldr	r3, .L3148
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3148
	strb	r3, [r2, #109]
	ldr	r3, .L3148
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3148
	str	r2, [r3, #60]
	ldr	r2, .L3148
	ldr	r3, [fp, #-16]
	str	r3, [r2, #12]
	ldr	r3, .L3148
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3148
	str	r2, [r3, #72]
	ldr	r2, .L3148
	ldr	r3, .L3148
	str	r3, [r2, #104]
	ldr	r3, .L3148
	ldr	r2, [r3, #104]
	ldr	r3, .L3148
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3149:
	.align	2
.L3148:
	.word	GSU
	.size	_Z9fx_iwt_r3v, .-_Z9fx_iwt_r3v
	.align	2
	.type	_Z9fx_iwt_r4v, %function
_Z9fx_iwt_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3152
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3152
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3152
	str	r2, [r3, #60]
	ldr	r3, .L3152
	ldr	r2, [r3, #472]
	ldr	r3, .L3152
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3152
	strb	r3, [r2, #109]
	ldr	r3, .L3152
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3152
	str	r2, [r3, #60]
	ldr	r3, .L3152
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3152
	ldr	r2, [r3, #472]
	ldr	r3, .L3152
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3152
	strb	r3, [r2, #109]
	ldr	r3, .L3152
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3152
	str	r2, [r3, #60]
	ldr	r2, .L3152
	ldr	r3, [fp, #-16]
	str	r3, [r2, #16]
	ldr	r3, .L3152
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3152
	str	r2, [r3, #72]
	ldr	r2, .L3152
	ldr	r3, .L3152
	str	r3, [r2, #104]
	ldr	r3, .L3152
	ldr	r2, [r3, #104]
	ldr	r3, .L3152
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3153:
	.align	2
.L3152:
	.word	GSU
	.size	_Z9fx_iwt_r4v, .-_Z9fx_iwt_r4v
	.align	2
	.type	_Z9fx_iwt_r5v, %function
_Z9fx_iwt_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3156
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3156
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3156
	str	r2, [r3, #60]
	ldr	r3, .L3156
	ldr	r2, [r3, #472]
	ldr	r3, .L3156
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3156
	strb	r3, [r2, #109]
	ldr	r3, .L3156
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3156
	str	r2, [r3, #60]
	ldr	r3, .L3156
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3156
	ldr	r2, [r3, #472]
	ldr	r3, .L3156
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3156
	strb	r3, [r2, #109]
	ldr	r3, .L3156
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3156
	str	r2, [r3, #60]
	ldr	r2, .L3156
	ldr	r3, [fp, #-16]
	str	r3, [r2, #20]
	ldr	r3, .L3156
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3156
	str	r2, [r3, #72]
	ldr	r2, .L3156
	ldr	r3, .L3156
	str	r3, [r2, #104]
	ldr	r3, .L3156
	ldr	r2, [r3, #104]
	ldr	r3, .L3156
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3157:
	.align	2
.L3156:
	.word	GSU
	.size	_Z9fx_iwt_r5v, .-_Z9fx_iwt_r5v
	.align	2
	.type	_Z9fx_iwt_r6v, %function
_Z9fx_iwt_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3160
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3160
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3160
	str	r2, [r3, #60]
	ldr	r3, .L3160
	ldr	r2, [r3, #472]
	ldr	r3, .L3160
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3160
	strb	r3, [r2, #109]
	ldr	r3, .L3160
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3160
	str	r2, [r3, #60]
	ldr	r3, .L3160
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3160
	ldr	r2, [r3, #472]
	ldr	r3, .L3160
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3160
	strb	r3, [r2, #109]
	ldr	r3, .L3160
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3160
	str	r2, [r3, #60]
	ldr	r2, .L3160
	ldr	r3, [fp, #-16]
	str	r3, [r2, #24]
	ldr	r3, .L3160
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3160
	str	r2, [r3, #72]
	ldr	r2, .L3160
	ldr	r3, .L3160
	str	r3, [r2, #104]
	ldr	r3, .L3160
	ldr	r2, [r3, #104]
	ldr	r3, .L3160
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3161:
	.align	2
.L3160:
	.word	GSU
	.size	_Z9fx_iwt_r6v, .-_Z9fx_iwt_r6v
	.align	2
	.type	_Z9fx_iwt_r7v, %function
_Z9fx_iwt_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3164
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3164
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3164
	str	r2, [r3, #60]
	ldr	r3, .L3164
	ldr	r2, [r3, #472]
	ldr	r3, .L3164
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3164
	strb	r3, [r2, #109]
	ldr	r3, .L3164
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3164
	str	r2, [r3, #60]
	ldr	r3, .L3164
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3164
	ldr	r2, [r3, #472]
	ldr	r3, .L3164
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3164
	strb	r3, [r2, #109]
	ldr	r3, .L3164
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3164
	str	r2, [r3, #60]
	ldr	r2, .L3164
	ldr	r3, [fp, #-16]
	str	r3, [r2, #28]
	ldr	r3, .L3164
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3164
	str	r2, [r3, #72]
	ldr	r2, .L3164
	ldr	r3, .L3164
	str	r3, [r2, #104]
	ldr	r3, .L3164
	ldr	r2, [r3, #104]
	ldr	r3, .L3164
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3165:
	.align	2
.L3164:
	.word	GSU
	.size	_Z9fx_iwt_r7v, .-_Z9fx_iwt_r7v
	.align	2
	.type	_Z9fx_iwt_r8v, %function
_Z9fx_iwt_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3168
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3168
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3168
	str	r2, [r3, #60]
	ldr	r3, .L3168
	ldr	r2, [r3, #472]
	ldr	r3, .L3168
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3168
	strb	r3, [r2, #109]
	ldr	r3, .L3168
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3168
	str	r2, [r3, #60]
	ldr	r3, .L3168
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3168
	ldr	r2, [r3, #472]
	ldr	r3, .L3168
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3168
	strb	r3, [r2, #109]
	ldr	r3, .L3168
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3168
	str	r2, [r3, #60]
	ldr	r2, .L3168
	ldr	r3, [fp, #-16]
	str	r3, [r2, #32]
	ldr	r3, .L3168
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3168
	str	r2, [r3, #72]
	ldr	r2, .L3168
	ldr	r3, .L3168
	str	r3, [r2, #104]
	ldr	r3, .L3168
	ldr	r2, [r3, #104]
	ldr	r3, .L3168
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3169:
	.align	2
.L3168:
	.word	GSU
	.size	_Z9fx_iwt_r8v, .-_Z9fx_iwt_r8v
	.align	2
	.type	_Z9fx_iwt_r9v, %function
_Z9fx_iwt_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3172
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3172
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3172
	str	r2, [r3, #60]
	ldr	r3, .L3172
	ldr	r2, [r3, #472]
	ldr	r3, .L3172
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3172
	strb	r3, [r2, #109]
	ldr	r3, .L3172
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3172
	str	r2, [r3, #60]
	ldr	r3, .L3172
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3172
	ldr	r2, [r3, #472]
	ldr	r3, .L3172
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3172
	strb	r3, [r2, #109]
	ldr	r3, .L3172
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3172
	str	r2, [r3, #60]
	ldr	r2, .L3172
	ldr	r3, [fp, #-16]
	str	r3, [r2, #36]
	ldr	r3, .L3172
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3172
	str	r2, [r3, #72]
	ldr	r2, .L3172
	ldr	r3, .L3172
	str	r3, [r2, #104]
	ldr	r3, .L3172
	ldr	r2, [r3, #104]
	ldr	r3, .L3172
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3173:
	.align	2
.L3172:
	.word	GSU
	.size	_Z9fx_iwt_r9v, .-_Z9fx_iwt_r9v
	.align	2
	.type	_Z10fx_iwt_r10v, %function
_Z10fx_iwt_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3176
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3176
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3176
	str	r2, [r3, #60]
	ldr	r3, .L3176
	ldr	r2, [r3, #472]
	ldr	r3, .L3176
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3176
	strb	r3, [r2, #109]
	ldr	r3, .L3176
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3176
	str	r2, [r3, #60]
	ldr	r3, .L3176
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3176
	ldr	r2, [r3, #472]
	ldr	r3, .L3176
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3176
	strb	r3, [r2, #109]
	ldr	r3, .L3176
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3176
	str	r2, [r3, #60]
	ldr	r2, .L3176
	ldr	r3, [fp, #-16]
	str	r3, [r2, #40]
	ldr	r3, .L3176
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3176
	str	r2, [r3, #72]
	ldr	r2, .L3176
	ldr	r3, .L3176
	str	r3, [r2, #104]
	ldr	r3, .L3176
	ldr	r2, [r3, #104]
	ldr	r3, .L3176
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3177:
	.align	2
.L3176:
	.word	GSU
	.size	_Z10fx_iwt_r10v, .-_Z10fx_iwt_r10v
	.align	2
	.type	_Z10fx_iwt_r11v, %function
_Z10fx_iwt_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3180
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3180
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3180
	str	r2, [r3, #60]
	ldr	r3, .L3180
	ldr	r2, [r3, #472]
	ldr	r3, .L3180
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3180
	strb	r3, [r2, #109]
	ldr	r3, .L3180
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3180
	str	r2, [r3, #60]
	ldr	r3, .L3180
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3180
	ldr	r2, [r3, #472]
	ldr	r3, .L3180
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3180
	strb	r3, [r2, #109]
	ldr	r3, .L3180
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3180
	str	r2, [r3, #60]
	ldr	r2, .L3180
	ldr	r3, [fp, #-16]
	str	r3, [r2, #44]
	ldr	r3, .L3180
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3180
	str	r2, [r3, #72]
	ldr	r2, .L3180
	ldr	r3, .L3180
	str	r3, [r2, #104]
	ldr	r3, .L3180
	ldr	r2, [r3, #104]
	ldr	r3, .L3180
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3181:
	.align	2
.L3180:
	.word	GSU
	.size	_Z10fx_iwt_r11v, .-_Z10fx_iwt_r11v
	.align	2
	.type	_Z10fx_iwt_r12v, %function
_Z10fx_iwt_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3184
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3184
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3184
	str	r2, [r3, #60]
	ldr	r3, .L3184
	ldr	r2, [r3, #472]
	ldr	r3, .L3184
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3184
	strb	r3, [r2, #109]
	ldr	r3, .L3184
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3184
	str	r2, [r3, #60]
	ldr	r3, .L3184
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3184
	ldr	r2, [r3, #472]
	ldr	r3, .L3184
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3184
	strb	r3, [r2, #109]
	ldr	r3, .L3184
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3184
	str	r2, [r3, #60]
	ldr	r2, .L3184
	ldr	r3, [fp, #-16]
	str	r3, [r2, #48]
	ldr	r3, .L3184
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3184
	str	r2, [r3, #72]
	ldr	r2, .L3184
	ldr	r3, .L3184
	str	r3, [r2, #104]
	ldr	r3, .L3184
	ldr	r2, [r3, #104]
	ldr	r3, .L3184
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3185:
	.align	2
.L3184:
	.word	GSU
	.size	_Z10fx_iwt_r12v, .-_Z10fx_iwt_r12v
	.align	2
	.type	_Z10fx_iwt_r13v, %function
_Z10fx_iwt_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3188
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3188
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3188
	str	r2, [r3, #60]
	ldr	r3, .L3188
	ldr	r2, [r3, #472]
	ldr	r3, .L3188
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3188
	strb	r3, [r2, #109]
	ldr	r3, .L3188
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3188
	str	r2, [r3, #60]
	ldr	r3, .L3188
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3188
	ldr	r2, [r3, #472]
	ldr	r3, .L3188
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3188
	strb	r3, [r2, #109]
	ldr	r3, .L3188
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3188
	str	r2, [r3, #60]
	ldr	r2, .L3188
	ldr	r3, [fp, #-16]
	str	r3, [r2, #52]
	ldr	r3, .L3188
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3188
	str	r2, [r3, #72]
	ldr	r2, .L3188
	ldr	r3, .L3188
	str	r3, [r2, #104]
	ldr	r3, .L3188
	ldr	r2, [r3, #104]
	ldr	r3, .L3188
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3189:
	.align	2
.L3188:
	.word	GSU
	.size	_Z10fx_iwt_r13v, .-_Z10fx_iwt_r13v
	.align	2
	.type	_Z10fx_iwt_r14v, %function
_Z10fx_iwt_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3192
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3192
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3192
	str	r2, [r3, #60]
	ldr	r3, .L3192
	ldr	r2, [r3, #472]
	ldr	r3, .L3192
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3192
	strb	r3, [r2, #109]
	ldr	r3, .L3192
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3192
	str	r2, [r3, #60]
	ldr	r3, .L3192
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3192
	ldr	r2, [r3, #472]
	ldr	r3, .L3192
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3192
	strb	r3, [r2, #109]
	ldr	r3, .L3192
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3192
	str	r2, [r3, #60]
	ldr	r2, .L3192
	ldr	r3, [fp, #-16]
	str	r3, [r2, #56]
	ldr	r3, .L3192
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3192
	str	r2, [r3, #72]
	ldr	r2, .L3192
	ldr	r3, .L3192
	str	r3, [r2, #104]
	ldr	r3, .L3192
	ldr	r2, [r3, #104]
	ldr	r3, .L3192
	str	r2, [r3, #100]
	ldr	r3, .L3192
	ldr	r2, [r3, #468]
	ldr	r3, .L3192
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3192
	strb	r3, [r2, #108]
	ldmib	sp, {fp, sp, pc}
.L3193:
	.align	2
.L3192:
	.word	GSU
	.size	_Z10fx_iwt_r14v, .-_Z10fx_iwt_r14v
	.align	2
	.type	_Z10fx_iwt_r15v, %function
_Z10fx_iwt_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3196
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3196
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3196
	str	r2, [r3, #60]
	ldr	r3, .L3196
	ldr	r2, [r3, #472]
	ldr	r3, .L3196
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3196
	strb	r3, [r2, #109]
	ldr	r3, .L3196
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3196
	str	r2, [r3, #60]
	ldr	r3, .L3196
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3, asl #8
	ldr	r3, [fp, #-16]
	orr	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, .L3196
	ldr	r2, [r3, #472]
	ldr	r3, .L3196
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3196
	strb	r3, [r2, #109]
	ldr	r3, .L3196
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3196
	str	r2, [r3, #60]
	ldr	r2, .L3196
	ldr	r3, [fp, #-16]
	str	r3, [r2, #60]
	ldr	r3, .L3196
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3196
	str	r2, [r3, #72]
	ldr	r2, .L3196
	ldr	r3, .L3196
	str	r3, [r2, #104]
	ldr	r3, .L3196
	ldr	r2, [r3, #104]
	ldr	r3, .L3196
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3197:
	.align	2
.L3196:
	.word	GSU
	.size	_Z10fx_iwt_r15v, .-_Z10fx_iwt_r15v
	.align	2
	.type	_Z8fx_lm_r0v, %function
_Z8fx_lm_r0v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3200
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3200
	str	r2, [r3, #96]
	ldr	r3, .L3200
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3200
	str	r2, [r3, #60]
	ldr	r3, .L3200
	ldr	r2, [r3, #472]
	ldr	r3, .L3200
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3200
	strb	r3, [r2, #109]
	ldr	r3, .L3200
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3200
	str	r2, [r3, #60]
	ldr	r3, .L3200
	ldr	r2, [r3, #96]
	ldr	r3, .L3200
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3200
	str	r2, [r3, #96]
	ldr	r3, .L3200
	ldr	r2, [r3, #472]
	ldr	r3, .L3200
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3200
	strb	r3, [r2, #109]
	ldr	r3, .L3200
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3200
	str	r2, [r3, #60]
	ldr	r3, .L3200
	ldr	r2, [r3, #464]
	ldr	r3, .L3200
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3200
	str	r2, [r3, #0]
	ldr	r3, .L3200
	ldr	r1, [r3, #0]
	ldr	r3, .L3200
	ldr	r2, [r3, #464]
	ldr	r3, .L3200
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3200
	str	r2, [r3, #0]
	ldr	r3, .L3200
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3200
	str	r2, [r3, #72]
	ldr	r2, .L3200
	ldr	r3, .L3200
	str	r3, [r2, #104]
	ldr	r3, .L3200
	ldr	r2, [r3, #104]
	ldr	r3, .L3200
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3201:
	.align	2
.L3200:
	.word	GSU
	.size	_Z8fx_lm_r0v, .-_Z8fx_lm_r0v
	.align	2
	.type	_Z8fx_lm_r1v, %function
_Z8fx_lm_r1v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3204
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3204
	str	r2, [r3, #96]
	ldr	r3, .L3204
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3204
	str	r2, [r3, #60]
	ldr	r3, .L3204
	ldr	r2, [r3, #472]
	ldr	r3, .L3204
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3204
	strb	r3, [r2, #109]
	ldr	r3, .L3204
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3204
	str	r2, [r3, #60]
	ldr	r3, .L3204
	ldr	r2, [r3, #96]
	ldr	r3, .L3204
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3204
	str	r2, [r3, #96]
	ldr	r3, .L3204
	ldr	r2, [r3, #472]
	ldr	r3, .L3204
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3204
	strb	r3, [r2, #109]
	ldr	r3, .L3204
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3204
	str	r2, [r3, #60]
	ldr	r3, .L3204
	ldr	r2, [r3, #464]
	ldr	r3, .L3204
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3204
	str	r2, [r3, #4]
	ldr	r3, .L3204
	ldr	r1, [r3, #4]
	ldr	r3, .L3204
	ldr	r2, [r3, #464]
	ldr	r3, .L3204
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3204
	str	r2, [r3, #4]
	ldr	r3, .L3204
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3204
	str	r2, [r3, #72]
	ldr	r2, .L3204
	ldr	r3, .L3204
	str	r3, [r2, #104]
	ldr	r3, .L3204
	ldr	r2, [r3, #104]
	ldr	r3, .L3204
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3205:
	.align	2
.L3204:
	.word	GSU
	.size	_Z8fx_lm_r1v, .-_Z8fx_lm_r1v
	.align	2
	.type	_Z8fx_lm_r2v, %function
_Z8fx_lm_r2v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3208
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3208
	str	r2, [r3, #96]
	ldr	r3, .L3208
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3208
	str	r2, [r3, #60]
	ldr	r3, .L3208
	ldr	r2, [r3, #472]
	ldr	r3, .L3208
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3208
	strb	r3, [r2, #109]
	ldr	r3, .L3208
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3208
	str	r2, [r3, #60]
	ldr	r3, .L3208
	ldr	r2, [r3, #96]
	ldr	r3, .L3208
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3208
	str	r2, [r3, #96]
	ldr	r3, .L3208
	ldr	r2, [r3, #472]
	ldr	r3, .L3208
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3208
	strb	r3, [r2, #109]
	ldr	r3, .L3208
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3208
	str	r2, [r3, #60]
	ldr	r3, .L3208
	ldr	r2, [r3, #464]
	ldr	r3, .L3208
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3208
	str	r2, [r3, #8]
	ldr	r3, .L3208
	ldr	r1, [r3, #8]
	ldr	r3, .L3208
	ldr	r2, [r3, #464]
	ldr	r3, .L3208
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3208
	str	r2, [r3, #8]
	ldr	r3, .L3208
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3208
	str	r2, [r3, #72]
	ldr	r2, .L3208
	ldr	r3, .L3208
	str	r3, [r2, #104]
	ldr	r3, .L3208
	ldr	r2, [r3, #104]
	ldr	r3, .L3208
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3209:
	.align	2
.L3208:
	.word	GSU
	.size	_Z8fx_lm_r2v, .-_Z8fx_lm_r2v
	.align	2
	.type	_Z8fx_lm_r3v, %function
_Z8fx_lm_r3v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3212
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3212
	str	r2, [r3, #96]
	ldr	r3, .L3212
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3212
	str	r2, [r3, #60]
	ldr	r3, .L3212
	ldr	r2, [r3, #472]
	ldr	r3, .L3212
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3212
	strb	r3, [r2, #109]
	ldr	r3, .L3212
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3212
	str	r2, [r3, #60]
	ldr	r3, .L3212
	ldr	r2, [r3, #96]
	ldr	r3, .L3212
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3212
	str	r2, [r3, #96]
	ldr	r3, .L3212
	ldr	r2, [r3, #472]
	ldr	r3, .L3212
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3212
	strb	r3, [r2, #109]
	ldr	r3, .L3212
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3212
	str	r2, [r3, #60]
	ldr	r3, .L3212
	ldr	r2, [r3, #464]
	ldr	r3, .L3212
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3212
	str	r2, [r3, #12]
	ldr	r3, .L3212
	ldr	r1, [r3, #12]
	ldr	r3, .L3212
	ldr	r2, [r3, #464]
	ldr	r3, .L3212
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3212
	str	r2, [r3, #12]
	ldr	r3, .L3212
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3212
	str	r2, [r3, #72]
	ldr	r2, .L3212
	ldr	r3, .L3212
	str	r3, [r2, #104]
	ldr	r3, .L3212
	ldr	r2, [r3, #104]
	ldr	r3, .L3212
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3213:
	.align	2
.L3212:
	.word	GSU
	.size	_Z8fx_lm_r3v, .-_Z8fx_lm_r3v
	.align	2
	.type	_Z8fx_lm_r4v, %function
_Z8fx_lm_r4v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3216
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3216
	str	r2, [r3, #96]
	ldr	r3, .L3216
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3216
	str	r2, [r3, #60]
	ldr	r3, .L3216
	ldr	r2, [r3, #472]
	ldr	r3, .L3216
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3216
	strb	r3, [r2, #109]
	ldr	r3, .L3216
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3216
	str	r2, [r3, #60]
	ldr	r3, .L3216
	ldr	r2, [r3, #96]
	ldr	r3, .L3216
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3216
	str	r2, [r3, #96]
	ldr	r3, .L3216
	ldr	r2, [r3, #472]
	ldr	r3, .L3216
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3216
	strb	r3, [r2, #109]
	ldr	r3, .L3216
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3216
	str	r2, [r3, #60]
	ldr	r3, .L3216
	ldr	r2, [r3, #464]
	ldr	r3, .L3216
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3216
	str	r2, [r3, #16]
	ldr	r3, .L3216
	ldr	r1, [r3, #16]
	ldr	r3, .L3216
	ldr	r2, [r3, #464]
	ldr	r3, .L3216
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3216
	str	r2, [r3, #16]
	ldr	r3, .L3216
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3216
	str	r2, [r3, #72]
	ldr	r2, .L3216
	ldr	r3, .L3216
	str	r3, [r2, #104]
	ldr	r3, .L3216
	ldr	r2, [r3, #104]
	ldr	r3, .L3216
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3217:
	.align	2
.L3216:
	.word	GSU
	.size	_Z8fx_lm_r4v, .-_Z8fx_lm_r4v
	.align	2
	.type	_Z8fx_lm_r5v, %function
_Z8fx_lm_r5v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3220
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3220
	str	r2, [r3, #96]
	ldr	r3, .L3220
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3220
	str	r2, [r3, #60]
	ldr	r3, .L3220
	ldr	r2, [r3, #472]
	ldr	r3, .L3220
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3220
	strb	r3, [r2, #109]
	ldr	r3, .L3220
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3220
	str	r2, [r3, #60]
	ldr	r3, .L3220
	ldr	r2, [r3, #96]
	ldr	r3, .L3220
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3220
	str	r2, [r3, #96]
	ldr	r3, .L3220
	ldr	r2, [r3, #472]
	ldr	r3, .L3220
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3220
	strb	r3, [r2, #109]
	ldr	r3, .L3220
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3220
	str	r2, [r3, #60]
	ldr	r3, .L3220
	ldr	r2, [r3, #464]
	ldr	r3, .L3220
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3220
	str	r2, [r3, #20]
	ldr	r3, .L3220
	ldr	r1, [r3, #20]
	ldr	r3, .L3220
	ldr	r2, [r3, #464]
	ldr	r3, .L3220
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3220
	str	r2, [r3, #20]
	ldr	r3, .L3220
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3220
	str	r2, [r3, #72]
	ldr	r2, .L3220
	ldr	r3, .L3220
	str	r3, [r2, #104]
	ldr	r3, .L3220
	ldr	r2, [r3, #104]
	ldr	r3, .L3220
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3221:
	.align	2
.L3220:
	.word	GSU
	.size	_Z8fx_lm_r5v, .-_Z8fx_lm_r5v
	.align	2
	.type	_Z8fx_lm_r6v, %function
_Z8fx_lm_r6v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3224
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3224
	str	r2, [r3, #96]
	ldr	r3, .L3224
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3224
	str	r2, [r3, #60]
	ldr	r3, .L3224
	ldr	r2, [r3, #472]
	ldr	r3, .L3224
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3224
	strb	r3, [r2, #109]
	ldr	r3, .L3224
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3224
	str	r2, [r3, #60]
	ldr	r3, .L3224
	ldr	r2, [r3, #96]
	ldr	r3, .L3224
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3224
	str	r2, [r3, #96]
	ldr	r3, .L3224
	ldr	r2, [r3, #472]
	ldr	r3, .L3224
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3224
	strb	r3, [r2, #109]
	ldr	r3, .L3224
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3224
	str	r2, [r3, #60]
	ldr	r3, .L3224
	ldr	r2, [r3, #464]
	ldr	r3, .L3224
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3224
	str	r2, [r3, #24]
	ldr	r3, .L3224
	ldr	r1, [r3, #24]
	ldr	r3, .L3224
	ldr	r2, [r3, #464]
	ldr	r3, .L3224
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3224
	str	r2, [r3, #24]
	ldr	r3, .L3224
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3224
	str	r2, [r3, #72]
	ldr	r2, .L3224
	ldr	r3, .L3224
	str	r3, [r2, #104]
	ldr	r3, .L3224
	ldr	r2, [r3, #104]
	ldr	r3, .L3224
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3225:
	.align	2
.L3224:
	.word	GSU
	.size	_Z8fx_lm_r6v, .-_Z8fx_lm_r6v
	.align	2
	.type	_Z8fx_lm_r7v, %function
_Z8fx_lm_r7v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3228
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3228
	str	r2, [r3, #96]
	ldr	r3, .L3228
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3228
	str	r2, [r3, #60]
	ldr	r3, .L3228
	ldr	r2, [r3, #472]
	ldr	r3, .L3228
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3228
	strb	r3, [r2, #109]
	ldr	r3, .L3228
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3228
	str	r2, [r3, #60]
	ldr	r3, .L3228
	ldr	r2, [r3, #96]
	ldr	r3, .L3228
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3228
	str	r2, [r3, #96]
	ldr	r3, .L3228
	ldr	r2, [r3, #472]
	ldr	r3, .L3228
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3228
	strb	r3, [r2, #109]
	ldr	r3, .L3228
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3228
	str	r2, [r3, #60]
	ldr	r3, .L3228
	ldr	r2, [r3, #464]
	ldr	r3, .L3228
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3228
	str	r2, [r3, #28]
	ldr	r3, .L3228
	ldr	r1, [r3, #28]
	ldr	r3, .L3228
	ldr	r2, [r3, #464]
	ldr	r3, .L3228
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3228
	str	r2, [r3, #28]
	ldr	r3, .L3228
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3228
	str	r2, [r3, #72]
	ldr	r2, .L3228
	ldr	r3, .L3228
	str	r3, [r2, #104]
	ldr	r3, .L3228
	ldr	r2, [r3, #104]
	ldr	r3, .L3228
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3229:
	.align	2
.L3228:
	.word	GSU
	.size	_Z8fx_lm_r7v, .-_Z8fx_lm_r7v
	.align	2
	.type	_Z8fx_lm_r8v, %function
_Z8fx_lm_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3232
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3232
	str	r2, [r3, #96]
	ldr	r3, .L3232
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3232
	str	r2, [r3, #60]
	ldr	r3, .L3232
	ldr	r2, [r3, #472]
	ldr	r3, .L3232
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3232
	strb	r3, [r2, #109]
	ldr	r3, .L3232
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3232
	str	r2, [r3, #60]
	ldr	r3, .L3232
	ldr	r2, [r3, #96]
	ldr	r3, .L3232
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3232
	str	r2, [r3, #96]
	ldr	r3, .L3232
	ldr	r2, [r3, #472]
	ldr	r3, .L3232
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3232
	strb	r3, [r2, #109]
	ldr	r3, .L3232
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3232
	str	r2, [r3, #60]
	ldr	r3, .L3232
	ldr	r2, [r3, #464]
	ldr	r3, .L3232
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3232
	str	r2, [r3, #32]
	ldr	r3, .L3232
	ldr	r1, [r3, #32]
	ldr	r3, .L3232
	ldr	r2, [r3, #464]
	ldr	r3, .L3232
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3232
	str	r2, [r3, #32]
	ldr	r3, .L3232
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3232
	str	r2, [r3, #72]
	ldr	r2, .L3232
	ldr	r3, .L3232
	str	r3, [r2, #104]
	ldr	r3, .L3232
	ldr	r2, [r3, #104]
	ldr	r3, .L3232
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3233:
	.align	2
.L3232:
	.word	GSU
	.size	_Z8fx_lm_r8v, .-_Z8fx_lm_r8v
	.align	2
	.type	_Z8fx_lm_r9v, %function
_Z8fx_lm_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3236
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3236
	str	r2, [r3, #96]
	ldr	r3, .L3236
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3236
	str	r2, [r3, #60]
	ldr	r3, .L3236
	ldr	r2, [r3, #472]
	ldr	r3, .L3236
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3236
	strb	r3, [r2, #109]
	ldr	r3, .L3236
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3236
	str	r2, [r3, #60]
	ldr	r3, .L3236
	ldr	r2, [r3, #96]
	ldr	r3, .L3236
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3236
	str	r2, [r3, #96]
	ldr	r3, .L3236
	ldr	r2, [r3, #472]
	ldr	r3, .L3236
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3236
	strb	r3, [r2, #109]
	ldr	r3, .L3236
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3236
	str	r2, [r3, #60]
	ldr	r3, .L3236
	ldr	r2, [r3, #464]
	ldr	r3, .L3236
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3236
	str	r2, [r3, #36]
	ldr	r3, .L3236
	ldr	r1, [r3, #36]
	ldr	r3, .L3236
	ldr	r2, [r3, #464]
	ldr	r3, .L3236
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3236
	str	r2, [r3, #36]
	ldr	r3, .L3236
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3236
	str	r2, [r3, #72]
	ldr	r2, .L3236
	ldr	r3, .L3236
	str	r3, [r2, #104]
	ldr	r3, .L3236
	ldr	r2, [r3, #104]
	ldr	r3, .L3236
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3237:
	.align	2
.L3236:
	.word	GSU
	.size	_Z8fx_lm_r9v, .-_Z8fx_lm_r9v
	.align	2
	.type	_Z9fx_lm_r10v, %function
_Z9fx_lm_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3240
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3240
	str	r2, [r3, #96]
	ldr	r3, .L3240
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3240
	str	r2, [r3, #60]
	ldr	r3, .L3240
	ldr	r2, [r3, #472]
	ldr	r3, .L3240
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3240
	strb	r3, [r2, #109]
	ldr	r3, .L3240
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3240
	str	r2, [r3, #60]
	ldr	r3, .L3240
	ldr	r2, [r3, #96]
	ldr	r3, .L3240
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3240
	str	r2, [r3, #96]
	ldr	r3, .L3240
	ldr	r2, [r3, #472]
	ldr	r3, .L3240
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3240
	strb	r3, [r2, #109]
	ldr	r3, .L3240
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3240
	str	r2, [r3, #60]
	ldr	r3, .L3240
	ldr	r2, [r3, #464]
	ldr	r3, .L3240
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3240
	str	r2, [r3, #40]
	ldr	r3, .L3240
	ldr	r1, [r3, #40]
	ldr	r3, .L3240
	ldr	r2, [r3, #464]
	ldr	r3, .L3240
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3240
	str	r2, [r3, #40]
	ldr	r3, .L3240
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3240
	str	r2, [r3, #72]
	ldr	r2, .L3240
	ldr	r3, .L3240
	str	r3, [r2, #104]
	ldr	r3, .L3240
	ldr	r2, [r3, #104]
	ldr	r3, .L3240
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3241:
	.align	2
.L3240:
	.word	GSU
	.size	_Z9fx_lm_r10v, .-_Z9fx_lm_r10v
	.align	2
	.type	_Z9fx_lm_r11v, %function
_Z9fx_lm_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3244
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3244
	str	r2, [r3, #96]
	ldr	r3, .L3244
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3244
	str	r2, [r3, #60]
	ldr	r3, .L3244
	ldr	r2, [r3, #472]
	ldr	r3, .L3244
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3244
	strb	r3, [r2, #109]
	ldr	r3, .L3244
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3244
	str	r2, [r3, #60]
	ldr	r3, .L3244
	ldr	r2, [r3, #96]
	ldr	r3, .L3244
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3244
	str	r2, [r3, #96]
	ldr	r3, .L3244
	ldr	r2, [r3, #472]
	ldr	r3, .L3244
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3244
	strb	r3, [r2, #109]
	ldr	r3, .L3244
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3244
	str	r2, [r3, #60]
	ldr	r3, .L3244
	ldr	r2, [r3, #464]
	ldr	r3, .L3244
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3244
	str	r2, [r3, #44]
	ldr	r3, .L3244
	ldr	r1, [r3, #44]
	ldr	r3, .L3244
	ldr	r2, [r3, #464]
	ldr	r3, .L3244
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3244
	str	r2, [r3, #44]
	ldr	r3, .L3244
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3244
	str	r2, [r3, #72]
	ldr	r2, .L3244
	ldr	r3, .L3244
	str	r3, [r2, #104]
	ldr	r3, .L3244
	ldr	r2, [r3, #104]
	ldr	r3, .L3244
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3245:
	.align	2
.L3244:
	.word	GSU
	.size	_Z9fx_lm_r11v, .-_Z9fx_lm_r11v
	.align	2
	.type	_Z9fx_lm_r12v, %function
_Z9fx_lm_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3248
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3248
	str	r2, [r3, #96]
	ldr	r3, .L3248
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3248
	str	r2, [r3, #60]
	ldr	r3, .L3248
	ldr	r2, [r3, #472]
	ldr	r3, .L3248
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3248
	strb	r3, [r2, #109]
	ldr	r3, .L3248
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3248
	str	r2, [r3, #60]
	ldr	r3, .L3248
	ldr	r2, [r3, #96]
	ldr	r3, .L3248
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3248
	str	r2, [r3, #96]
	ldr	r3, .L3248
	ldr	r2, [r3, #472]
	ldr	r3, .L3248
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3248
	strb	r3, [r2, #109]
	ldr	r3, .L3248
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3248
	str	r2, [r3, #60]
	ldr	r3, .L3248
	ldr	r2, [r3, #464]
	ldr	r3, .L3248
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3248
	str	r2, [r3, #48]
	ldr	r3, .L3248
	ldr	r1, [r3, #48]
	ldr	r3, .L3248
	ldr	r2, [r3, #464]
	ldr	r3, .L3248
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3248
	str	r2, [r3, #48]
	ldr	r3, .L3248
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3248
	str	r2, [r3, #72]
	ldr	r2, .L3248
	ldr	r3, .L3248
	str	r3, [r2, #104]
	ldr	r3, .L3248
	ldr	r2, [r3, #104]
	ldr	r3, .L3248
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3249:
	.align	2
.L3248:
	.word	GSU
	.size	_Z9fx_lm_r12v, .-_Z9fx_lm_r12v
	.align	2
	.type	_Z9fx_lm_r13v, %function
_Z9fx_lm_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3252
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3252
	str	r2, [r3, #96]
	ldr	r3, .L3252
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3252
	str	r2, [r3, #60]
	ldr	r3, .L3252
	ldr	r2, [r3, #472]
	ldr	r3, .L3252
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3252
	strb	r3, [r2, #109]
	ldr	r3, .L3252
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3252
	str	r2, [r3, #60]
	ldr	r3, .L3252
	ldr	r2, [r3, #96]
	ldr	r3, .L3252
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3252
	str	r2, [r3, #96]
	ldr	r3, .L3252
	ldr	r2, [r3, #472]
	ldr	r3, .L3252
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3252
	strb	r3, [r2, #109]
	ldr	r3, .L3252
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3252
	str	r2, [r3, #60]
	ldr	r3, .L3252
	ldr	r2, [r3, #464]
	ldr	r3, .L3252
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3252
	str	r2, [r3, #52]
	ldr	r3, .L3252
	ldr	r1, [r3, #52]
	ldr	r3, .L3252
	ldr	r2, [r3, #464]
	ldr	r3, .L3252
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3252
	str	r2, [r3, #52]
	ldr	r3, .L3252
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3252
	str	r2, [r3, #72]
	ldr	r2, .L3252
	ldr	r3, .L3252
	str	r3, [r2, #104]
	ldr	r3, .L3252
	ldr	r2, [r3, #104]
	ldr	r3, .L3252
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3253:
	.align	2
.L3252:
	.word	GSU
	.size	_Z9fx_lm_r13v, .-_Z9fx_lm_r13v
	.align	2
	.type	_Z9fx_lm_r14v, %function
_Z9fx_lm_r14v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3256
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3256
	str	r2, [r3, #96]
	ldr	r3, .L3256
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3256
	str	r2, [r3, #60]
	ldr	r3, .L3256
	ldr	r2, [r3, #472]
	ldr	r3, .L3256
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3256
	strb	r3, [r2, #109]
	ldr	r3, .L3256
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3256
	str	r2, [r3, #60]
	ldr	r3, .L3256
	ldr	r2, [r3, #96]
	ldr	r3, .L3256
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3256
	str	r2, [r3, #96]
	ldr	r3, .L3256
	ldr	r2, [r3, #472]
	ldr	r3, .L3256
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3256
	strb	r3, [r2, #109]
	ldr	r3, .L3256
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3256
	str	r2, [r3, #60]
	ldr	r3, .L3256
	ldr	r2, [r3, #464]
	ldr	r3, .L3256
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3256
	str	r2, [r3, #56]
	ldr	r3, .L3256
	ldr	r1, [r3, #56]
	ldr	r3, .L3256
	ldr	r2, [r3, #464]
	ldr	r3, .L3256
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3256
	str	r2, [r3, #56]
	ldr	r3, .L3256
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3256
	str	r2, [r3, #72]
	ldr	r2, .L3256
	ldr	r3, .L3256
	str	r3, [r2, #104]
	ldr	r3, .L3256
	ldr	r2, [r3, #104]
	ldr	r3, .L3256
	str	r2, [r3, #100]
	ldr	r3, .L3256
	ldr	r2, [r3, #468]
	ldr	r3, .L3256
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3256
	strb	r3, [r2, #108]
	ldmfd	sp, {fp, sp, pc}
.L3257:
	.align	2
.L3256:
	.word	GSU
	.size	_Z9fx_lm_r14v, .-_Z9fx_lm_r14v
	.align	2
	.type	_Z9fx_lm_r15v, %function
_Z9fx_lm_r15v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3260
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3260
	str	r2, [r3, #96]
	ldr	r3, .L3260
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3260
	str	r2, [r3, #60]
	ldr	r3, .L3260
	ldr	r2, [r3, #472]
	ldr	r3, .L3260
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3260
	strb	r3, [r2, #109]
	ldr	r3, .L3260
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3260
	str	r2, [r3, #60]
	ldr	r3, .L3260
	ldr	r2, [r3, #96]
	ldr	r3, .L3260
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3260
	str	r2, [r3, #96]
	ldr	r3, .L3260
	ldr	r2, [r3, #472]
	ldr	r3, .L3260
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3260
	strb	r3, [r2, #109]
	ldr	r3, .L3260
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3260
	str	r2, [r3, #60]
	ldr	r3, .L3260
	ldr	r2, [r3, #464]
	ldr	r3, .L3260
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3260
	str	r2, [r3, #60]
	ldr	r3, .L3260
	ldr	r1, [r3, #60]
	ldr	r3, .L3260
	ldr	r2, [r3, #464]
	ldr	r3, .L3260
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r1, r3
	ldr	r3, .L3260
	str	r2, [r3, #60]
	ldr	r3, .L3260
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3260
	str	r2, [r3, #72]
	ldr	r2, .L3260
	ldr	r3, .L3260
	str	r3, [r2, #104]
	ldr	r3, .L3260
	ldr	r2, [r3, #104]
	ldr	r3, .L3260
	str	r2, [r3, #100]
	ldmfd	sp, {fp, sp, pc}
.L3261:
	.align	2
.L3260:
	.word	GSU
	.size	_Z9fx_lm_r15v, .-_Z9fx_lm_r15v
	.align	2
	.type	_Z8fx_sm_r0v, %function
_Z8fx_sm_r0v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3264
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	ldr	r3, .L3264
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3264
	str	r2, [r3, #96]
	ldr	r3, .L3264
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3264
	str	r2, [r3, #60]
	ldr	r3, .L3264
	ldr	r2, [r3, #472]
	ldr	r3, .L3264
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3264
	strb	r3, [r2, #109]
	ldr	r3, .L3264
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3264
	str	r2, [r3, #60]
	ldr	r3, .L3264
	ldr	r2, [r3, #96]
	ldr	r3, .L3264
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3264
	str	r2, [r3, #96]
	ldr	r3, .L3264
	ldr	r2, [r3, #472]
	ldr	r3, .L3264
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3264
	strb	r3, [r2, #109]
	ldr	r3, .L3264
	ldr	r2, [r3, #464]
	ldr	r3, .L3264
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3264
	ldr	r2, [r3, #464]
	ldr	r3, .L3264
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3264
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3264
	str	r2, [r3, #72]
	ldr	r2, .L3264
	ldr	r3, .L3264
	str	r3, [r2, #104]
	ldr	r3, .L3264
	ldr	r2, [r3, #104]
	ldr	r3, .L3264
	str	r2, [r3, #100]
	ldr	r3, .L3264
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3264
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3265:
	.align	2
.L3264:
	.word	GSU
	.size	_Z8fx_sm_r0v, .-_Z8fx_sm_r0v
	.align	2
	.type	_Z8fx_sm_r1v, %function
_Z8fx_sm_r1v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3268
	ldr	r3, [r3, #4]
	str	r3, [fp, #-16]
	ldr	r3, .L3268
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3268
	str	r2, [r3, #96]
	ldr	r3, .L3268
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3268
	str	r2, [r3, #60]
	ldr	r3, .L3268
	ldr	r2, [r3, #472]
	ldr	r3, .L3268
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3268
	strb	r3, [r2, #109]
	ldr	r3, .L3268
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3268
	str	r2, [r3, #60]
	ldr	r3, .L3268
	ldr	r2, [r3, #96]
	ldr	r3, .L3268
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3268
	str	r2, [r3, #96]
	ldr	r3, .L3268
	ldr	r2, [r3, #472]
	ldr	r3, .L3268
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3268
	strb	r3, [r2, #109]
	ldr	r3, .L3268
	ldr	r2, [r3, #464]
	ldr	r3, .L3268
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3268
	ldr	r2, [r3, #464]
	ldr	r3, .L3268
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3268
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3268
	str	r2, [r3, #72]
	ldr	r2, .L3268
	ldr	r3, .L3268
	str	r3, [r2, #104]
	ldr	r3, .L3268
	ldr	r2, [r3, #104]
	ldr	r3, .L3268
	str	r2, [r3, #100]
	ldr	r3, .L3268
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3268
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3269:
	.align	2
.L3268:
	.word	GSU
	.size	_Z8fx_sm_r1v, .-_Z8fx_sm_r1v
	.align	2
	.type	_Z8fx_sm_r2v, %function
_Z8fx_sm_r2v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3272
	ldr	r3, [r3, #8]
	str	r3, [fp, #-16]
	ldr	r3, .L3272
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3272
	str	r2, [r3, #96]
	ldr	r3, .L3272
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3272
	str	r2, [r3, #60]
	ldr	r3, .L3272
	ldr	r2, [r3, #472]
	ldr	r3, .L3272
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3272
	strb	r3, [r2, #109]
	ldr	r3, .L3272
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3272
	str	r2, [r3, #60]
	ldr	r3, .L3272
	ldr	r2, [r3, #96]
	ldr	r3, .L3272
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3272
	str	r2, [r3, #96]
	ldr	r3, .L3272
	ldr	r2, [r3, #472]
	ldr	r3, .L3272
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3272
	strb	r3, [r2, #109]
	ldr	r3, .L3272
	ldr	r2, [r3, #464]
	ldr	r3, .L3272
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3272
	ldr	r2, [r3, #464]
	ldr	r3, .L3272
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3272
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3272
	str	r2, [r3, #72]
	ldr	r2, .L3272
	ldr	r3, .L3272
	str	r3, [r2, #104]
	ldr	r3, .L3272
	ldr	r2, [r3, #104]
	ldr	r3, .L3272
	str	r2, [r3, #100]
	ldr	r3, .L3272
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3272
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3273:
	.align	2
.L3272:
	.word	GSU
	.size	_Z8fx_sm_r2v, .-_Z8fx_sm_r2v
	.align	2
	.type	_Z8fx_sm_r3v, %function
_Z8fx_sm_r3v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3276
	ldr	r3, [r3, #12]
	str	r3, [fp, #-16]
	ldr	r3, .L3276
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3276
	str	r2, [r3, #96]
	ldr	r3, .L3276
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3276
	str	r2, [r3, #60]
	ldr	r3, .L3276
	ldr	r2, [r3, #472]
	ldr	r3, .L3276
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3276
	strb	r3, [r2, #109]
	ldr	r3, .L3276
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3276
	str	r2, [r3, #60]
	ldr	r3, .L3276
	ldr	r2, [r3, #96]
	ldr	r3, .L3276
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3276
	str	r2, [r3, #96]
	ldr	r3, .L3276
	ldr	r2, [r3, #472]
	ldr	r3, .L3276
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3276
	strb	r3, [r2, #109]
	ldr	r3, .L3276
	ldr	r2, [r3, #464]
	ldr	r3, .L3276
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3276
	ldr	r2, [r3, #464]
	ldr	r3, .L3276
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3276
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3276
	str	r2, [r3, #72]
	ldr	r2, .L3276
	ldr	r3, .L3276
	str	r3, [r2, #104]
	ldr	r3, .L3276
	ldr	r2, [r3, #104]
	ldr	r3, .L3276
	str	r2, [r3, #100]
	ldr	r3, .L3276
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3276
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3277:
	.align	2
.L3276:
	.word	GSU
	.size	_Z8fx_sm_r3v, .-_Z8fx_sm_r3v
	.align	2
	.type	_Z8fx_sm_r4v, %function
_Z8fx_sm_r4v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3280
	ldr	r3, [r3, #16]
	str	r3, [fp, #-16]
	ldr	r3, .L3280
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3280
	str	r2, [r3, #96]
	ldr	r3, .L3280
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3280
	str	r2, [r3, #60]
	ldr	r3, .L3280
	ldr	r2, [r3, #472]
	ldr	r3, .L3280
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3280
	strb	r3, [r2, #109]
	ldr	r3, .L3280
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3280
	str	r2, [r3, #60]
	ldr	r3, .L3280
	ldr	r2, [r3, #96]
	ldr	r3, .L3280
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3280
	str	r2, [r3, #96]
	ldr	r3, .L3280
	ldr	r2, [r3, #472]
	ldr	r3, .L3280
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3280
	strb	r3, [r2, #109]
	ldr	r3, .L3280
	ldr	r2, [r3, #464]
	ldr	r3, .L3280
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3280
	ldr	r2, [r3, #464]
	ldr	r3, .L3280
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3280
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3280
	str	r2, [r3, #72]
	ldr	r2, .L3280
	ldr	r3, .L3280
	str	r3, [r2, #104]
	ldr	r3, .L3280
	ldr	r2, [r3, #104]
	ldr	r3, .L3280
	str	r2, [r3, #100]
	ldr	r3, .L3280
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3280
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3281:
	.align	2
.L3280:
	.word	GSU
	.size	_Z8fx_sm_r4v, .-_Z8fx_sm_r4v
	.align	2
	.type	_Z8fx_sm_r5v, %function
_Z8fx_sm_r5v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3284
	ldr	r3, [r3, #20]
	str	r3, [fp, #-16]
	ldr	r3, .L3284
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3284
	str	r2, [r3, #96]
	ldr	r3, .L3284
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3284
	str	r2, [r3, #60]
	ldr	r3, .L3284
	ldr	r2, [r3, #472]
	ldr	r3, .L3284
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3284
	strb	r3, [r2, #109]
	ldr	r3, .L3284
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3284
	str	r2, [r3, #60]
	ldr	r3, .L3284
	ldr	r2, [r3, #96]
	ldr	r3, .L3284
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3284
	str	r2, [r3, #96]
	ldr	r3, .L3284
	ldr	r2, [r3, #472]
	ldr	r3, .L3284
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3284
	strb	r3, [r2, #109]
	ldr	r3, .L3284
	ldr	r2, [r3, #464]
	ldr	r3, .L3284
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3284
	ldr	r2, [r3, #464]
	ldr	r3, .L3284
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3284
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3284
	str	r2, [r3, #72]
	ldr	r2, .L3284
	ldr	r3, .L3284
	str	r3, [r2, #104]
	ldr	r3, .L3284
	ldr	r2, [r3, #104]
	ldr	r3, .L3284
	str	r2, [r3, #100]
	ldr	r3, .L3284
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3284
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3285:
	.align	2
.L3284:
	.word	GSU
	.size	_Z8fx_sm_r5v, .-_Z8fx_sm_r5v
	.align	2
	.type	_Z8fx_sm_r6v, %function
_Z8fx_sm_r6v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3288
	ldr	r3, [r3, #24]
	str	r3, [fp, #-16]
	ldr	r3, .L3288
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3288
	str	r2, [r3, #96]
	ldr	r3, .L3288
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3288
	str	r2, [r3, #60]
	ldr	r3, .L3288
	ldr	r2, [r3, #472]
	ldr	r3, .L3288
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3288
	strb	r3, [r2, #109]
	ldr	r3, .L3288
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3288
	str	r2, [r3, #60]
	ldr	r3, .L3288
	ldr	r2, [r3, #96]
	ldr	r3, .L3288
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3288
	str	r2, [r3, #96]
	ldr	r3, .L3288
	ldr	r2, [r3, #472]
	ldr	r3, .L3288
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3288
	strb	r3, [r2, #109]
	ldr	r3, .L3288
	ldr	r2, [r3, #464]
	ldr	r3, .L3288
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3288
	ldr	r2, [r3, #464]
	ldr	r3, .L3288
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3288
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3288
	str	r2, [r3, #72]
	ldr	r2, .L3288
	ldr	r3, .L3288
	str	r3, [r2, #104]
	ldr	r3, .L3288
	ldr	r2, [r3, #104]
	ldr	r3, .L3288
	str	r2, [r3, #100]
	ldr	r3, .L3288
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3288
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3289:
	.align	2
.L3288:
	.word	GSU
	.size	_Z8fx_sm_r6v, .-_Z8fx_sm_r6v
	.align	2
	.type	_Z8fx_sm_r7v, %function
_Z8fx_sm_r7v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3292
	ldr	r3, [r3, #28]
	str	r3, [fp, #-16]
	ldr	r3, .L3292
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3292
	str	r2, [r3, #96]
	ldr	r3, .L3292
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3292
	str	r2, [r3, #60]
	ldr	r3, .L3292
	ldr	r2, [r3, #472]
	ldr	r3, .L3292
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3292
	strb	r3, [r2, #109]
	ldr	r3, .L3292
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3292
	str	r2, [r3, #60]
	ldr	r3, .L3292
	ldr	r2, [r3, #96]
	ldr	r3, .L3292
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3292
	str	r2, [r3, #96]
	ldr	r3, .L3292
	ldr	r2, [r3, #472]
	ldr	r3, .L3292
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3292
	strb	r3, [r2, #109]
	ldr	r3, .L3292
	ldr	r2, [r3, #464]
	ldr	r3, .L3292
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3292
	ldr	r2, [r3, #464]
	ldr	r3, .L3292
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3292
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3292
	str	r2, [r3, #72]
	ldr	r2, .L3292
	ldr	r3, .L3292
	str	r3, [r2, #104]
	ldr	r3, .L3292
	ldr	r2, [r3, #104]
	ldr	r3, .L3292
	str	r2, [r3, #100]
	ldr	r3, .L3292
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3292
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3293:
	.align	2
.L3292:
	.word	GSU
	.size	_Z8fx_sm_r7v, .-_Z8fx_sm_r7v
	.align	2
	.type	_Z8fx_sm_r8v, %function
_Z8fx_sm_r8v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3296
	ldr	r3, [r3, #32]
	str	r3, [fp, #-16]
	ldr	r3, .L3296
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3296
	str	r2, [r3, #96]
	ldr	r3, .L3296
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3296
	str	r2, [r3, #60]
	ldr	r3, .L3296
	ldr	r2, [r3, #472]
	ldr	r3, .L3296
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3296
	strb	r3, [r2, #109]
	ldr	r3, .L3296
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3296
	str	r2, [r3, #60]
	ldr	r3, .L3296
	ldr	r2, [r3, #96]
	ldr	r3, .L3296
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3296
	str	r2, [r3, #96]
	ldr	r3, .L3296
	ldr	r2, [r3, #472]
	ldr	r3, .L3296
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3296
	strb	r3, [r2, #109]
	ldr	r3, .L3296
	ldr	r2, [r3, #464]
	ldr	r3, .L3296
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3296
	ldr	r2, [r3, #464]
	ldr	r3, .L3296
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3296
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3296
	str	r2, [r3, #72]
	ldr	r2, .L3296
	ldr	r3, .L3296
	str	r3, [r2, #104]
	ldr	r3, .L3296
	ldr	r2, [r3, #104]
	ldr	r3, .L3296
	str	r2, [r3, #100]
	ldr	r3, .L3296
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3296
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3297:
	.align	2
.L3296:
	.word	GSU
	.size	_Z8fx_sm_r8v, .-_Z8fx_sm_r8v
	.align	2
	.type	_Z8fx_sm_r9v, %function
_Z8fx_sm_r9v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3300
	ldr	r3, [r3, #36]
	str	r3, [fp, #-16]
	ldr	r3, .L3300
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3300
	str	r2, [r3, #96]
	ldr	r3, .L3300
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3300
	str	r2, [r3, #60]
	ldr	r3, .L3300
	ldr	r2, [r3, #472]
	ldr	r3, .L3300
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3300
	strb	r3, [r2, #109]
	ldr	r3, .L3300
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3300
	str	r2, [r3, #60]
	ldr	r3, .L3300
	ldr	r2, [r3, #96]
	ldr	r3, .L3300
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3300
	str	r2, [r3, #96]
	ldr	r3, .L3300
	ldr	r2, [r3, #472]
	ldr	r3, .L3300
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3300
	strb	r3, [r2, #109]
	ldr	r3, .L3300
	ldr	r2, [r3, #464]
	ldr	r3, .L3300
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3300
	ldr	r2, [r3, #464]
	ldr	r3, .L3300
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3300
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3300
	str	r2, [r3, #72]
	ldr	r2, .L3300
	ldr	r3, .L3300
	str	r3, [r2, #104]
	ldr	r3, .L3300
	ldr	r2, [r3, #104]
	ldr	r3, .L3300
	str	r2, [r3, #100]
	ldr	r3, .L3300
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3300
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3301:
	.align	2
.L3300:
	.word	GSU
	.size	_Z8fx_sm_r9v, .-_Z8fx_sm_r9v
	.align	2
	.type	_Z9fx_sm_r10v, %function
_Z9fx_sm_r10v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3304
	ldr	r3, [r3, #40]
	str	r3, [fp, #-16]
	ldr	r3, .L3304
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3304
	str	r2, [r3, #96]
	ldr	r3, .L3304
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3304
	str	r2, [r3, #60]
	ldr	r3, .L3304
	ldr	r2, [r3, #472]
	ldr	r3, .L3304
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3304
	strb	r3, [r2, #109]
	ldr	r3, .L3304
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3304
	str	r2, [r3, #60]
	ldr	r3, .L3304
	ldr	r2, [r3, #96]
	ldr	r3, .L3304
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3304
	str	r2, [r3, #96]
	ldr	r3, .L3304
	ldr	r2, [r3, #472]
	ldr	r3, .L3304
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3304
	strb	r3, [r2, #109]
	ldr	r3, .L3304
	ldr	r2, [r3, #464]
	ldr	r3, .L3304
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3304
	ldr	r2, [r3, #464]
	ldr	r3, .L3304
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3304
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3304
	str	r2, [r3, #72]
	ldr	r2, .L3304
	ldr	r3, .L3304
	str	r3, [r2, #104]
	ldr	r3, .L3304
	ldr	r2, [r3, #104]
	ldr	r3, .L3304
	str	r2, [r3, #100]
	ldr	r3, .L3304
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3304
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3305:
	.align	2
.L3304:
	.word	GSU
	.size	_Z9fx_sm_r10v, .-_Z9fx_sm_r10v
	.align	2
	.type	_Z9fx_sm_r11v, %function
_Z9fx_sm_r11v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3308
	ldr	r3, [r3, #44]
	str	r3, [fp, #-16]
	ldr	r3, .L3308
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3308
	str	r2, [r3, #96]
	ldr	r3, .L3308
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3308
	str	r2, [r3, #60]
	ldr	r3, .L3308
	ldr	r2, [r3, #472]
	ldr	r3, .L3308
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3308
	strb	r3, [r2, #109]
	ldr	r3, .L3308
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3308
	str	r2, [r3, #60]
	ldr	r3, .L3308
	ldr	r2, [r3, #96]
	ldr	r3, .L3308
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3308
	str	r2, [r3, #96]
	ldr	r3, .L3308
	ldr	r2, [r3, #472]
	ldr	r3, .L3308
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3308
	strb	r3, [r2, #109]
	ldr	r3, .L3308
	ldr	r2, [r3, #464]
	ldr	r3, .L3308
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3308
	ldr	r2, [r3, #464]
	ldr	r3, .L3308
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3308
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3308
	str	r2, [r3, #72]
	ldr	r2, .L3308
	ldr	r3, .L3308
	str	r3, [r2, #104]
	ldr	r3, .L3308
	ldr	r2, [r3, #104]
	ldr	r3, .L3308
	str	r2, [r3, #100]
	ldr	r3, .L3308
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3308
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3309:
	.align	2
.L3308:
	.word	GSU
	.size	_Z9fx_sm_r11v, .-_Z9fx_sm_r11v
	.align	2
	.type	_Z9fx_sm_r12v, %function
_Z9fx_sm_r12v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3312
	ldr	r3, [r3, #48]
	str	r3, [fp, #-16]
	ldr	r3, .L3312
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3312
	str	r2, [r3, #96]
	ldr	r3, .L3312
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3312
	str	r2, [r3, #60]
	ldr	r3, .L3312
	ldr	r2, [r3, #472]
	ldr	r3, .L3312
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3312
	strb	r3, [r2, #109]
	ldr	r3, .L3312
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3312
	str	r2, [r3, #60]
	ldr	r3, .L3312
	ldr	r2, [r3, #96]
	ldr	r3, .L3312
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3312
	str	r2, [r3, #96]
	ldr	r3, .L3312
	ldr	r2, [r3, #472]
	ldr	r3, .L3312
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3312
	strb	r3, [r2, #109]
	ldr	r3, .L3312
	ldr	r2, [r3, #464]
	ldr	r3, .L3312
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3312
	ldr	r2, [r3, #464]
	ldr	r3, .L3312
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3312
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3312
	str	r2, [r3, #72]
	ldr	r2, .L3312
	ldr	r3, .L3312
	str	r3, [r2, #104]
	ldr	r3, .L3312
	ldr	r2, [r3, #104]
	ldr	r3, .L3312
	str	r2, [r3, #100]
	ldr	r3, .L3312
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3312
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3313:
	.align	2
.L3312:
	.word	GSU
	.size	_Z9fx_sm_r12v, .-_Z9fx_sm_r12v
	.align	2
	.type	_Z9fx_sm_r13v, %function
_Z9fx_sm_r13v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3316
	ldr	r3, [r3, #52]
	str	r3, [fp, #-16]
	ldr	r3, .L3316
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3316
	str	r2, [r3, #96]
	ldr	r3, .L3316
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3316
	str	r2, [r3, #60]
	ldr	r3, .L3316
	ldr	r2, [r3, #472]
	ldr	r3, .L3316
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3316
	strb	r3, [r2, #109]
	ldr	r3, .L3316
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3316
	str	r2, [r3, #60]
	ldr	r3, .L3316
	ldr	r2, [r3, #96]
	ldr	r3, .L3316
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3316
	str	r2, [r3, #96]
	ldr	r3, .L3316
	ldr	r2, [r3, #472]
	ldr	r3, .L3316
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3316
	strb	r3, [r2, #109]
	ldr	r3, .L3316
	ldr	r2, [r3, #464]
	ldr	r3, .L3316
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3316
	ldr	r2, [r3, #464]
	ldr	r3, .L3316
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3316
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3316
	str	r2, [r3, #72]
	ldr	r2, .L3316
	ldr	r3, .L3316
	str	r3, [r2, #104]
	ldr	r3, .L3316
	ldr	r2, [r3, #104]
	ldr	r3, .L3316
	str	r2, [r3, #100]
	ldr	r3, .L3316
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3316
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3317:
	.align	2
.L3316:
	.word	GSU
	.size	_Z9fx_sm_r13v, .-_Z9fx_sm_r13v
	.align	2
	.type	_Z9fx_sm_r14v, %function
_Z9fx_sm_r14v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3320
	ldr	r3, [r3, #56]
	str	r3, [fp, #-16]
	ldr	r3, .L3320
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3320
	str	r2, [r3, #96]
	ldr	r3, .L3320
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3320
	str	r2, [r3, #60]
	ldr	r3, .L3320
	ldr	r2, [r3, #472]
	ldr	r3, .L3320
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3320
	strb	r3, [r2, #109]
	ldr	r3, .L3320
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3320
	str	r2, [r3, #60]
	ldr	r3, .L3320
	ldr	r2, [r3, #96]
	ldr	r3, .L3320
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3320
	str	r2, [r3, #96]
	ldr	r3, .L3320
	ldr	r2, [r3, #472]
	ldr	r3, .L3320
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3320
	strb	r3, [r2, #109]
	ldr	r3, .L3320
	ldr	r2, [r3, #464]
	ldr	r3, .L3320
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3320
	ldr	r2, [r3, #464]
	ldr	r3, .L3320
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3320
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3320
	str	r2, [r3, #72]
	ldr	r2, .L3320
	ldr	r3, .L3320
	str	r3, [r2, #104]
	ldr	r3, .L3320
	ldr	r2, [r3, #104]
	ldr	r3, .L3320
	str	r2, [r3, #100]
	ldr	r3, .L3320
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3320
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3321:
	.align	2
.L3320:
	.word	GSU
	.size	_Z9fx_sm_r14v, .-_Z9fx_sm_r14v
	.align	2
	.type	_Z9fx_sm_r15v, %function
_Z9fx_sm_r15v:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3324
	ldr	r3, [r3, #60]
	str	r3, [fp, #-16]
	ldr	r3, .L3324
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L3324
	str	r2, [r3, #96]
	ldr	r3, .L3324
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3324
	str	r2, [r3, #60]
	ldr	r3, .L3324
	ldr	r2, [r3, #472]
	ldr	r3, .L3324
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3324
	strb	r3, [r2, #109]
	ldr	r3, .L3324
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3324
	str	r2, [r3, #60]
	ldr	r3, .L3324
	ldr	r2, [r3, #96]
	ldr	r3, .L3324
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L3324
	str	r2, [r3, #96]
	ldr	r3, .L3324
	ldr	r2, [r3, #472]
	ldr	r3, .L3324
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3324
	strb	r3, [r2, #109]
	ldr	r3, .L3324
	ldr	r2, [r3, #464]
	ldr	r3, .L3324
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3324
	ldr	r2, [r3, #464]
	ldr	r3, .L3324
	ldr	r3, [r3, #96]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	eor	r3, r3, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, .L3324
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3324
	str	r2, [r3, #72]
	ldr	r2, .L3324
	ldr	r3, .L3324
	str	r3, [r2, #104]
	ldr	r3, .L3324
	ldr	r2, [r3, #104]
	ldr	r3, .L3324
	str	r2, [r3, #100]
	ldr	r3, .L3324
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3324
	str	r2, [r3, #60]
	ldmib	sp, {fp, sp, pc}
.L3325:
	.align	2
.L3324:
	.word	GSU
	.size	_Z9fx_sm_r15v, .-_Z9fx_sm_r15v
	.align	2
	.type	_Z6fx_runj, %function
_Z6fx_runj:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-20]
	ldr	r2, .L3335
	ldr	r3, [fp, #-20]
	str	r3, [r2, #2036]
	ldr	r3, .L3335
	ldr	r2, [r3, #468]
	ldr	r3, .L3335
	ldr	r3, [r3, #56]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3335
	strb	r3, [r2, #108]
	b	.L3327
.L3328:
	ldr	r3, .L3335
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3335
	ldr	r2, [r3, #472]
	ldr	r3, .L3335
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3335
	strb	r3, [r2, #109]
	ldr	r3, .L3335
	ldr	r3, [r3, #72]
	and	r2, r3, #768
	ldr	r3, [fp, #-16]
	orr	r3, r2, r3
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L3335+4
	ldr	r3, [r3, #0]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	blx	r3
.L3327:
	ldr	r3, .L3335
	ldr	r3, [r3, #72]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L3329
	ldr	r3, .L3335
	ldr	r3, [r3, #2036]
	sub	r2, r3, #1
	ldr	r3, .L3335
	str	r2, [r3, #2036]
	ldr	r3, .L3335
	ldr	r3, [r3, #2036]
	cmn	r3, #1
	beq	.L3329
	mov	r3, #1
	str	r3, [fp, #-24]
	b	.L3332
.L3329:
	mov	r3, #0
	str	r3, [fp, #-24]
.L3332:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L3328
	ldr	r3, .L3335
	ldr	r2, [r3, #2040]
	ldr	r3, [fp, #-20]
	rsb	r3, r2, r3
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L3336:
	.align	2
.L3335:
	.word	GSU
	.word	fx_ppfOpcodeTable
	.size	_Z6fx_runj, .-_Z6fx_runj
	.align	2
	.type	_Z20fx_run_to_breakpointj, %function
_Z20fx_run_to_breakpointj:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L3338
.L3339:
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
	ldr	r3, .L3344
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3344
	ldr	r2, [r3, #472]
	ldr	r3, .L3344
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3344
	strb	r3, [r2, #109]
	ldr	r3, .L3344
	ldr	r3, [r3, #72]
	and	r2, r3, #768
	ldr	r3, [fp, #-16]
	orr	r3, r2, r3
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L3344+4
	ldr	r3, [r3, #0]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	blx	r3
	ldr	r3, .L3344
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L3344
	ldr	r3, [r3, #144]
	cmp	r2, r3
	bne	.L3338
	ldr	r2, .L3344
	mvn	r3, #0
	str	r3, [r2, #132]
	b	.L3341
.L3338:
	ldr	r3, .L3344
	ldr	r3, [r3, #72]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L3341
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bcc	.L3339
.L3341:
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L3345:
	.align	2
.L3344:
	.word	GSU
	.word	fx_ppfOpcodeTable
	.size	_Z20fx_run_to_breakpointj, .-_Z20fx_run_to_breakpointj
	.align	2
	.type	_Z12fx_step_overj, %function
_Z12fx_step_overj:
	@ args = 0, pretend = 0, frame = 12
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	str	r0, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L3347
.L3348:
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
	ldr	r3, .L3354
	ldrb	r3, [r3, #109]	@ zero_extendqisi2
	str	r3, [fp, #-16]
	ldr	r3, .L3354
	ldr	r2, [r3, #472]
	ldr	r3, .L3354
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, .L3354
	strb	r3, [r2, #109]
	ldr	r3, .L3354
	ldr	r3, [r3, #72]
	and	r2, r3, #768
	ldr	r3, [fp, #-16]
	orr	r3, r2, r3
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L3354+4
	ldr	r3, [r3, #0]
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	blx	r3
	ldr	r3, .L3354
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L3354
	ldr	r3, [r3, #144]
	cmp	r2, r3
	bne	.L3349
	ldr	r2, .L3354
	mvn	r3, #0
	str	r3, [r2, #132]
	b	.L3351
.L3349:
	ldr	r3, .L3354
	ldr	r3, [r3, #60]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r3
	ldr	r3, .L3354
	ldr	r3, [r3, #148]
	cmp	r2, r3
	beq	.L3351
.L3347:
	ldr	r3, .L3354
	ldr	r3, [r3, #72]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L3351
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bcc	.L3348
.L3351:
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp, {fp, sp, pc}
.L3355:
	.align	2
.L3354:
	.word	GSU
	.word	fx_ppfOpcodeTable
	.size	_Z12fx_step_overj, .-_Z12fx_step_overj
	.align	2
	.type	_Z8fx_cmodev, %function
_Z8fx_cmodev:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3361
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3361
	str	r2, [r3, #68]
	ldr	r3, .L3361
	ldr	r3, [r3, #68]
	and	r3, r3, #16
	cmp	r3, #0
	beq	.L3357
	ldr	r2, .L3361
	mov	r3, #256
	str	r3, [r2, #440]
	b	.L3359
.L3357:
	ldr	r3, .L3361
	ldr	r2, [r3, #444]
	ldr	r3, .L3361
	str	r2, [r3, #440]
.L3359:
	bl	_Z24fx_computeScreenPointersv
	ldr	r3, .L3361
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3361
	str	r2, [r3, #72]
	ldr	r2, .L3361
	ldr	r3, .L3361
	str	r3, [r2, #104]
	ldr	r3, .L3361
	ldr	r2, [r3, #104]
	ldr	r3, .L3361
	str	r2, [r3, #100]
	ldr	r3, .L3361
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3361
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3362:
	.align	2
.L3361:
	.word	GSU
	.size	_Z8fx_cmodev, .-_Z8fx_cmodev
	.align	2
	.type	_Z8fx_cachev, %function
_Z8fx_cachev:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	ldr	r3, .L3368
	ldr	r2, [r3, #60]
	ldr	r3, .L3368+4
	and	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, .L3368
	ldr	r2, [r3, #88]
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bne	.L3364
	ldr	r3, .L3368
	ldrb	r3, [r3, #1516]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3366
.L3364:
	bl	_Z13fx_flushCachev
	ldr	r2, .L3368
	ldr	r3, [fp, #-16]
	str	r3, [r2, #88]
	ldr	r2, .L3368
	mov	r3, #1
	strb	r3, [r2, #1516]
.L3366:
	ldr	r3, .L3368
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, .L3368
	str	r2, [r3, #60]
	ldr	r3, .L3368
	ldr	r3, [r3, #72]
	bic	r2, r3, #4864
	ldr	r3, .L3368
	str	r2, [r3, #72]
	ldr	r2, .L3368
	ldr	r3, .L3368
	str	r3, [r2, #104]
	ldr	r3, .L3368
	ldr	r2, [r3, #104]
	ldr	r3, .L3368
	str	r2, [r3, #100]
	ldmib	sp, {fp, sp, pc}
.L3369:
	.align	2
.L3368:
	.word	GSU
	.word	65520
	.size	_Z8fx_cachev, .-_Z8fx_cachev
	.align	2
	.type	_Z11fx_ljmp_r13v, %function
_Z11fx_ljmp_r13v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3372
	ldr	r3, [r3, #52]
	and	r2, r3, #127
	ldr	r3, .L3372
	str	r2, [r3, #76]
	ldr	r3, .L3372
	ldr	r3, [r3, #76]
	ldr	r2, .L3372
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3372
	str	r2, [r3, #472]
	ldr	r3, .L3372
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3372
	str	r2, [r3, #60]
	ldr	r2, .L3372
	mov	r3, #0
	strb	r3, [r2, #1516]
	bl	_Z8fx_cachev
	ldr	r3, .L3372
	ldr	r3, [r3, #60]
	sub	r2, r3, #1
	ldr	r3, .L3372
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3373:
	.align	2
.L3372:
	.word	GSU
	.size	_Z11fx_ljmp_r13v, .-_Z11fx_ljmp_r13v
	.align	2
	.type	_Z11fx_ljmp_r12v, %function
_Z11fx_ljmp_r12v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3376
	ldr	r3, [r3, #48]
	and	r2, r3, #127
	ldr	r3, .L3376
	str	r2, [r3, #76]
	ldr	r3, .L3376
	ldr	r3, [r3, #76]
	ldr	r2, .L3376
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3376
	str	r2, [r3, #472]
	ldr	r3, .L3376
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3376
	str	r2, [r3, #60]
	ldr	r2, .L3376
	mov	r3, #0
	strb	r3, [r2, #1516]
	bl	_Z8fx_cachev
	ldr	r3, .L3376
	ldr	r3, [r3, #60]
	sub	r2, r3, #1
	ldr	r3, .L3376
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3377:
	.align	2
.L3376:
	.word	GSU
	.size	_Z11fx_ljmp_r12v, .-_Z11fx_ljmp_r12v
	.align	2
	.type	_Z11fx_ljmp_r11v, %function
_Z11fx_ljmp_r11v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3380
	ldr	r3, [r3, #44]
	and	r2, r3, #127
	ldr	r3, .L3380
	str	r2, [r3, #76]
	ldr	r3, .L3380
	ldr	r3, [r3, #76]
	ldr	r2, .L3380
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3380
	str	r2, [r3, #472]
	ldr	r3, .L3380
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3380
	str	r2, [r3, #60]
	ldr	r2, .L3380
	mov	r3, #0
	strb	r3, [r2, #1516]
	bl	_Z8fx_cachev
	ldr	r3, .L3380
	ldr	r3, [r3, #60]
	sub	r2, r3, #1
	ldr	r3, .L3380
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3381:
	.align	2
.L3380:
	.word	GSU
	.size	_Z11fx_ljmp_r11v, .-_Z11fx_ljmp_r11v
	.align	2
	.type	_Z11fx_ljmp_r10v, %function
_Z11fx_ljmp_r10v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3384
	ldr	r3, [r3, #40]
	and	r2, r3, #127
	ldr	r3, .L3384
	str	r2, [r3, #76]
	ldr	r3, .L3384
	ldr	r3, [r3, #76]
	ldr	r2, .L3384
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3384
	str	r2, [r3, #472]
	ldr	r3, .L3384
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3384
	str	r2, [r3, #60]
	ldr	r2, .L3384
	mov	r3, #0
	strb	r3, [r2, #1516]
	bl	_Z8fx_cachev
	ldr	r3, .L3384
	ldr	r3, [r3, #60]
	sub	r2, r3, #1
	ldr	r3, .L3384
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3385:
	.align	2
.L3384:
	.word	GSU
	.size	_Z11fx_ljmp_r10v, .-_Z11fx_ljmp_r10v
	.align	2
	.type	_Z10fx_ljmp_r9v, %function
_Z10fx_ljmp_r9v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3388
	ldr	r3, [r3, #36]
	and	r2, r3, #127
	ldr	r3, .L3388
	str	r2, [r3, #76]
	ldr	r3, .L3388
	ldr	r3, [r3, #76]
	ldr	r2, .L3388
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3388
	str	r2, [r3, #472]
	ldr	r3, .L3388
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3388
	str	r2, [r3, #60]
	ldr	r2, .L3388
	mov	r3, #0
	strb	r3, [r2, #1516]
	bl	_Z8fx_cachev
	ldr	r3, .L3388
	ldr	r3, [r3, #60]
	sub	r2, r3, #1
	ldr	r3, .L3388
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3389:
	.align	2
.L3388:
	.word	GSU
	.size	_Z10fx_ljmp_r9v, .-_Z10fx_ljmp_r9v
	.align	2
	.type	_Z10fx_ljmp_r8v, %function
_Z10fx_ljmp_r8v:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r3, .L3392
	ldr	r3, [r3, #32]
	and	r2, r3, #127
	ldr	r3, .L3392
	str	r2, [r3, #76]
	ldr	r3, .L3392
	ldr	r3, [r3, #76]
	ldr	r2, .L3392
	mov	r1, #492
	mov	r3, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r2, [r3, #0]
	ldr	r3, .L3392
	str	r2, [r3, #472]
	ldr	r3, .L3392
	ldr	r3, [r3, #104]
	ldr	r2, [r3, #0]
	ldr	r3, .L3392
	str	r2, [r3, #60]
	ldr	r2, .L3392
	mov	r3, #0
	strb	r3, [r2, #1516]
	bl	_Z8fx_cachev
	ldr	r3, .L3392
	ldr	r3, [r3, #60]
	sub	r2, r3, #1
	ldr	r3, .L3392
	str	r2, [r3, #60]
	ldmfd	sp, {fp, sp, pc}
.L3393:
	.align	2
.L3392:
	.word	GSU
	.size	_Z10fx_ljmp_r8v, .-_Z10fx_ljmp_r8v
	.section	.rodata
	.align	2
.LC0:
	.ascii	"ERROR fx_rpix_obj called\000"
	.text
	.align	2
	.type	_Z11fx_rpix_objv, %function
_Z11fx_rpix_objv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r0, .L3396
	bl	puts
	ldmfd	sp, {fp, sp, pc}
.L3397:
	.align	2
.L3396:
	.word	.LC0
	.size	_Z11fx_rpix_objv, .-_Z11fx_rpix_objv
	.section	.rodata
	.align	2
.LC1:
	.ascii	"ERROR fx_plot_obj called\000"
	.text
	.align	2
	.type	_Z11fx_plot_objv, %function
_Z11fx_plot_objv:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	ldr	r0, .L3400
	bl	puts
	ldmfd	sp, {fp, sp, pc}
.L3401:
	.align	2
.L3400:
	.word	.LC1
	.size	_Z11fx_plot_objv, .-_Z11fx_plot_objv
	.global	gsu_bank
	.bss
	.align	2
	.type	gsu_bank, %object
	.size	gsu_bank, 2048
gsu_bank:
	.space	2048
	.global	fx_apfFunctionTable
	.data
	.align	2
	.type	fx_apfFunctionTable, %object
	.size	fx_apfFunctionTable, 12
fx_apfFunctionTable:
	.word	_Z6fx_runj
	.word	_Z20fx_run_to_breakpointj
	.word	_Z12fx_step_overj
	.global	fx_apfPlotTable
	.align	2
	.type	fx_apfPlotTable, %object
	.size	fx_apfPlotTable, 40
fx_apfPlotTable:
	.word	_Z12fx_plot_2bitv
	.word	_Z12fx_plot_4bitv
	.word	_Z12fx_plot_4bitv
	.word	_Z12fx_plot_8bitv
	.word	_Z11fx_plot_objv
	.word	_Z12fx_rpix_2bitv
	.word	_Z12fx_rpix_4bitv
	.word	_Z12fx_rpix_4bitv
	.word	_Z12fx_rpix_8bitv
	.word	_Z11fx_rpix_objv
	.global	fx_apfOpcodeTable
	.align	2
	.type	fx_apfOpcodeTable, %object
	.size	fx_apfOpcodeTable, 4096
fx_apfOpcodeTable:
	.word	_Z7fx_stopv
	.word	_Z6fx_nopv
	.word	_Z8fx_cachev
	.word	_Z6fx_lsrv
	.word	_Z6fx_rolv
	.word	_Z6fx_brav
	.word	_Z6fx_bgev
	.word	_Z6fx_bltv
	.word	_Z6fx_bnev
	.word	_Z6fx_beqv
	.word	_Z6fx_bplv
	.word	_Z6fx_bmiv
	.word	_Z6fx_bccv
	.word	_Z6fx_bcsv
	.word	_Z6fx_bvcv
	.word	_Z6fx_bvsv
	.word	_Z8fx_to_r0v
	.word	_Z8fx_to_r1v
	.word	_Z8fx_to_r2v
	.word	_Z8fx_to_r3v
	.word	_Z8fx_to_r4v
	.word	_Z8fx_to_r5v
	.word	_Z8fx_to_r6v
	.word	_Z8fx_to_r7v
	.word	_Z8fx_to_r8v
	.word	_Z8fx_to_r9v
	.word	_Z9fx_to_r10v
	.word	_Z9fx_to_r11v
	.word	_Z9fx_to_r12v
	.word	_Z9fx_to_r13v
	.word	_Z9fx_to_r14v
	.word	_Z9fx_to_r15v
	.word	_Z10fx_with_r0v
	.word	_Z10fx_with_r1v
	.word	_Z10fx_with_r2v
	.word	_Z10fx_with_r3v
	.word	_Z10fx_with_r4v
	.word	_Z10fx_with_r5v
	.word	_Z10fx_with_r6v
	.word	_Z10fx_with_r7v
	.word	_Z10fx_with_r8v
	.word	_Z10fx_with_r9v
	.word	_Z11fx_with_r10v
	.word	_Z11fx_with_r11v
	.word	_Z11fx_with_r12v
	.word	_Z11fx_with_r13v
	.word	_Z11fx_with_r14v
	.word	_Z11fx_with_r15v
	.word	_Z9fx_stw_r0v
	.word	_Z9fx_stw_r1v
	.word	_Z9fx_stw_r2v
	.word	_Z9fx_stw_r3v
	.word	_Z9fx_stw_r4v
	.word	_Z9fx_stw_r5v
	.word	_Z9fx_stw_r6v
	.word	_Z9fx_stw_r7v
	.word	_Z9fx_stw_r8v
	.word	_Z9fx_stw_r9v
	.word	_Z10fx_stw_r10v
	.word	_Z10fx_stw_r11v
	.word	_Z7fx_loopv
	.word	_Z7fx_alt1v
	.word	_Z7fx_alt2v
	.word	_Z7fx_alt3v
	.word	_Z9fx_ldw_r0v
	.word	_Z9fx_ldw_r1v
	.word	_Z9fx_ldw_r2v
	.word	_Z9fx_ldw_r3v
	.word	_Z9fx_ldw_r4v
	.word	_Z9fx_ldw_r5v
	.word	_Z9fx_ldw_r6v
	.word	_Z9fx_ldw_r7v
	.word	_Z9fx_ldw_r8v
	.word	_Z9fx_ldw_r9v
	.word	_Z10fx_ldw_r10v
	.word	_Z10fx_ldw_r11v
	.word	_Z12fx_plot_2bitv
	.word	_Z7fx_swapv
	.word	_Z8fx_colorv
	.word	_Z6fx_notv
	.word	_Z9fx_add_r0v
	.word	_Z9fx_add_r1v
	.word	_Z9fx_add_r2v
	.word	_Z9fx_add_r3v
	.word	_Z9fx_add_r4v
	.word	_Z9fx_add_r5v
	.word	_Z9fx_add_r6v
	.word	_Z9fx_add_r7v
	.word	_Z9fx_add_r8v
	.word	_Z9fx_add_r9v
	.word	_Z10fx_add_r10v
	.word	_Z10fx_add_r11v
	.word	_Z10fx_add_r12v
	.word	_Z10fx_add_r13v
	.word	_Z10fx_add_r14v
	.word	_Z10fx_add_r15v
	.word	_Z9fx_sub_r0v
	.word	_Z9fx_sub_r1v
	.word	_Z9fx_sub_r2v
	.word	_Z9fx_sub_r3v
	.word	_Z9fx_sub_r4v
	.word	_Z9fx_sub_r5v
	.word	_Z9fx_sub_r6v
	.word	_Z9fx_sub_r7v
	.word	_Z9fx_sub_r8v
	.word	_Z9fx_sub_r9v
	.word	_Z10fx_sub_r10v
	.word	_Z10fx_sub_r11v
	.word	_Z10fx_sub_r12v
	.word	_Z10fx_sub_r13v
	.word	_Z10fx_sub_r14v
	.word	_Z10fx_sub_r15v
	.word	_Z8fx_mergev
	.word	_Z9fx_and_r1v
	.word	_Z9fx_and_r2v
	.word	_Z9fx_and_r3v
	.word	_Z9fx_and_r4v
	.word	_Z9fx_and_r5v
	.word	_Z9fx_and_r6v
	.word	_Z9fx_and_r7v
	.word	_Z9fx_and_r8v
	.word	_Z9fx_and_r9v
	.word	_Z10fx_and_r10v
	.word	_Z10fx_and_r11v
	.word	_Z10fx_and_r12v
	.word	_Z10fx_and_r13v
	.word	_Z10fx_and_r14v
	.word	_Z10fx_and_r15v
	.word	_Z10fx_mult_r0v
	.word	_Z10fx_mult_r1v
	.word	_Z10fx_mult_r2v
	.word	_Z10fx_mult_r3v
	.word	_Z10fx_mult_r4v
	.word	_Z10fx_mult_r5v
	.word	_Z10fx_mult_r6v
	.word	_Z10fx_mult_r7v
	.word	_Z10fx_mult_r8v
	.word	_Z10fx_mult_r9v
	.word	_Z11fx_mult_r10v
	.word	_Z11fx_mult_r11v
	.word	_Z11fx_mult_r12v
	.word	_Z11fx_mult_r13v
	.word	_Z11fx_mult_r14v
	.word	_Z11fx_mult_r15v
	.word	_Z6fx_sbkv
	.word	_Z10fx_link_i1v
	.word	_Z10fx_link_i2v
	.word	_Z10fx_link_i3v
	.word	_Z10fx_link_i4v
	.word	_Z6fx_sexv
	.word	_Z6fx_asrv
	.word	_Z6fx_rorv
	.word	_Z9fx_jmp_r8v
	.word	_Z9fx_jmp_r9v
	.word	_Z10fx_jmp_r10v
	.word	_Z10fx_jmp_r11v
	.word	_Z10fx_jmp_r12v
	.word	_Z10fx_jmp_r13v
	.word	_Z6fx_lobv
	.word	_Z8fx_fmultv
	.word	_Z9fx_ibt_r0v
	.word	_Z9fx_ibt_r1v
	.word	_Z9fx_ibt_r2v
	.word	_Z9fx_ibt_r3v
	.word	_Z9fx_ibt_r4v
	.word	_Z9fx_ibt_r5v
	.word	_Z9fx_ibt_r6v
	.word	_Z9fx_ibt_r7v
	.word	_Z9fx_ibt_r8v
	.word	_Z9fx_ibt_r9v
	.word	_Z10fx_ibt_r10v
	.word	_Z10fx_ibt_r11v
	.word	_Z10fx_ibt_r12v
	.word	_Z10fx_ibt_r13v
	.word	_Z10fx_ibt_r14v
	.word	_Z10fx_ibt_r15v
	.word	_Z10fx_from_r0v
	.word	_Z10fx_from_r1v
	.word	_Z10fx_from_r2v
	.word	_Z10fx_from_r3v
	.word	_Z10fx_from_r4v
	.word	_Z10fx_from_r5v
	.word	_Z10fx_from_r6v
	.word	_Z10fx_from_r7v
	.word	_Z10fx_from_r8v
	.word	_Z10fx_from_r9v
	.word	_Z11fx_from_r10v
	.word	_Z11fx_from_r11v
	.word	_Z11fx_from_r12v
	.word	_Z11fx_from_r13v
	.word	_Z11fx_from_r14v
	.word	_Z11fx_from_r15v
	.word	_Z6fx_hibv
	.word	_Z8fx_or_r1v
	.word	_Z8fx_or_r2v
	.word	_Z8fx_or_r3v
	.word	_Z8fx_or_r4v
	.word	_Z8fx_or_r5v
	.word	_Z8fx_or_r6v
	.word	_Z8fx_or_r7v
	.word	_Z8fx_or_r8v
	.word	_Z8fx_or_r9v
	.word	_Z9fx_or_r10v
	.word	_Z9fx_or_r11v
	.word	_Z9fx_or_r12v
	.word	_Z9fx_or_r13v
	.word	_Z9fx_or_r14v
	.word	_Z9fx_or_r15v
	.word	_Z9fx_inc_r0v
	.word	_Z9fx_inc_r1v
	.word	_Z9fx_inc_r2v
	.word	_Z9fx_inc_r3v
	.word	_Z9fx_inc_r4v
	.word	_Z9fx_inc_r5v
	.word	_Z9fx_inc_r6v
	.word	_Z9fx_inc_r7v
	.word	_Z9fx_inc_r8v
	.word	_Z9fx_inc_r9v
	.word	_Z10fx_inc_r10v
	.word	_Z10fx_inc_r11v
	.word	_Z10fx_inc_r12v
	.word	_Z10fx_inc_r13v
	.word	_Z10fx_inc_r14v
	.word	_Z7fx_getcv
	.word	_Z9fx_dec_r0v
	.word	_Z9fx_dec_r1v
	.word	_Z9fx_dec_r2v
	.word	_Z9fx_dec_r3v
	.word	_Z9fx_dec_r4v
	.word	_Z9fx_dec_r5v
	.word	_Z9fx_dec_r6v
	.word	_Z9fx_dec_r7v
	.word	_Z9fx_dec_r8v
	.word	_Z9fx_dec_r9v
	.word	_Z10fx_dec_r10v
	.word	_Z10fx_dec_r11v
	.word	_Z10fx_dec_r12v
	.word	_Z10fx_dec_r13v
	.word	_Z10fx_dec_r14v
	.word	_Z7fx_getbv
	.word	_Z9fx_iwt_r0v
	.word	_Z9fx_iwt_r1v
	.word	_Z9fx_iwt_r2v
	.word	_Z9fx_iwt_r3v
	.word	_Z9fx_iwt_r4v
	.word	_Z9fx_iwt_r5v
	.word	_Z9fx_iwt_r6v
	.word	_Z9fx_iwt_r7v
	.word	_Z9fx_iwt_r8v
	.word	_Z9fx_iwt_r9v
	.word	_Z10fx_iwt_r10v
	.word	_Z10fx_iwt_r11v
	.word	_Z10fx_iwt_r12v
	.word	_Z10fx_iwt_r13v
	.word	_Z10fx_iwt_r14v
	.word	_Z10fx_iwt_r15v
	.word	_Z7fx_stopv
	.word	_Z6fx_nopv
	.word	_Z8fx_cachev
	.word	_Z6fx_lsrv
	.word	_Z6fx_rolv
	.word	_Z6fx_brav
	.word	_Z6fx_bgev
	.word	_Z6fx_bltv
	.word	_Z6fx_bnev
	.word	_Z6fx_beqv
	.word	_Z6fx_bplv
	.word	_Z6fx_bmiv
	.word	_Z6fx_bccv
	.word	_Z6fx_bcsv
	.word	_Z6fx_bvcv
	.word	_Z6fx_bvsv
	.word	_Z8fx_to_r0v
	.word	_Z8fx_to_r1v
	.word	_Z8fx_to_r2v
	.word	_Z8fx_to_r3v
	.word	_Z8fx_to_r4v
	.word	_Z8fx_to_r5v
	.word	_Z8fx_to_r6v
	.word	_Z8fx_to_r7v
	.word	_Z8fx_to_r8v
	.word	_Z8fx_to_r9v
	.word	_Z9fx_to_r10v
	.word	_Z9fx_to_r11v
	.word	_Z9fx_to_r12v
	.word	_Z9fx_to_r13v
	.word	_Z9fx_to_r14v
	.word	_Z9fx_to_r15v
	.word	_Z10fx_with_r0v
	.word	_Z10fx_with_r1v
	.word	_Z10fx_with_r2v
	.word	_Z10fx_with_r3v
	.word	_Z10fx_with_r4v
	.word	_Z10fx_with_r5v
	.word	_Z10fx_with_r6v
	.word	_Z10fx_with_r7v
	.word	_Z10fx_with_r8v
	.word	_Z10fx_with_r9v
	.word	_Z11fx_with_r10v
	.word	_Z11fx_with_r11v
	.word	_Z11fx_with_r12v
	.word	_Z11fx_with_r13v
	.word	_Z11fx_with_r14v
	.word	_Z11fx_with_r15v
	.word	_Z9fx_stb_r0v
	.word	_Z9fx_stb_r1v
	.word	_Z9fx_stb_r2v
	.word	_Z9fx_stb_r3v
	.word	_Z9fx_stb_r4v
	.word	_Z9fx_stb_r5v
	.word	_Z9fx_stb_r6v
	.word	_Z9fx_stb_r7v
	.word	_Z9fx_stb_r8v
	.word	_Z9fx_stb_r9v
	.word	_Z10fx_stb_r10v
	.word	_Z10fx_stb_r11v
	.word	_Z7fx_loopv
	.word	_Z7fx_alt1v
	.word	_Z7fx_alt2v
	.word	_Z7fx_alt3v
	.word	_Z9fx_ldb_r0v
	.word	_Z9fx_ldb_r1v
	.word	_Z9fx_ldb_r2v
	.word	_Z9fx_ldb_r3v
	.word	_Z9fx_ldb_r4v
	.word	_Z9fx_ldb_r5v
	.word	_Z9fx_ldb_r6v
	.word	_Z9fx_ldb_r7v
	.word	_Z9fx_ldb_r8v
	.word	_Z9fx_ldb_r9v
	.word	_Z10fx_ldb_r10v
	.word	_Z10fx_ldb_r11v
	.word	_Z12fx_rpix_2bitv
	.word	_Z7fx_swapv
	.word	_Z8fx_cmodev
	.word	_Z6fx_notv
	.word	_Z9fx_adc_r0v
	.word	_Z9fx_adc_r1v
	.word	_Z9fx_adc_r2v
	.word	_Z9fx_adc_r3v
	.word	_Z9fx_adc_r4v
	.word	_Z9fx_adc_r5v
	.word	_Z9fx_adc_r6v
	.word	_Z9fx_adc_r7v
	.word	_Z9fx_adc_r8v
	.word	_Z9fx_adc_r9v
	.word	_Z10fx_adc_r10v
	.word	_Z10fx_adc_r11v
	.word	_Z10fx_adc_r12v
	.word	_Z10fx_adc_r13v
	.word	_Z10fx_adc_r14v
	.word	_Z10fx_adc_r15v
	.word	_Z9fx_sbc_r0v
	.word	_Z9fx_sbc_r1v
	.word	_Z9fx_sbc_r2v
	.word	_Z9fx_sbc_r3v
	.word	_Z9fx_sbc_r4v
	.word	_Z9fx_sbc_r5v
	.word	_Z9fx_sbc_r6v
	.word	_Z9fx_sbc_r7v
	.word	_Z9fx_sbc_r8v
	.word	_Z9fx_sbc_r9v
	.word	_Z10fx_sbc_r10v
	.word	_Z10fx_sbc_r11v
	.word	_Z10fx_sbc_r12v
	.word	_Z10fx_sbc_r13v
	.word	_Z10fx_sbc_r14v
	.word	_Z10fx_sbc_r15v
	.word	_Z8fx_mergev
	.word	_Z9fx_bic_r1v
	.word	_Z9fx_bic_r2v
	.word	_Z9fx_bic_r3v
	.word	_Z9fx_bic_r4v
	.word	_Z9fx_bic_r5v
	.word	_Z9fx_bic_r6v
	.word	_Z9fx_bic_r7v
	.word	_Z9fx_bic_r8v
	.word	_Z9fx_bic_r9v
	.word	_Z10fx_bic_r10v
	.word	_Z10fx_bic_r11v
	.word	_Z10fx_bic_r12v
	.word	_Z10fx_bic_r13v
	.word	_Z10fx_bic_r14v
	.word	_Z10fx_bic_r15v
	.word	_Z11fx_umult_r0v
	.word	_Z11fx_umult_r1v
	.word	_Z11fx_umult_r2v
	.word	_Z11fx_umult_r3v
	.word	_Z11fx_umult_r4v
	.word	_Z11fx_umult_r5v
	.word	_Z11fx_umult_r6v
	.word	_Z11fx_umult_r7v
	.word	_Z11fx_umult_r8v
	.word	_Z11fx_umult_r9v
	.word	_Z12fx_umult_r10v
	.word	_Z12fx_umult_r11v
	.word	_Z12fx_umult_r12v
	.word	_Z12fx_umult_r13v
	.word	_Z12fx_umult_r14v
	.word	_Z12fx_umult_r15v
	.word	_Z6fx_sbkv
	.word	_Z10fx_link_i1v
	.word	_Z10fx_link_i2v
	.word	_Z10fx_link_i3v
	.word	_Z10fx_link_i4v
	.word	_Z6fx_sexv
	.word	_Z7fx_div2v
	.word	_Z6fx_rorv
	.word	_Z10fx_ljmp_r8v
	.word	_Z10fx_ljmp_r9v
	.word	_Z11fx_ljmp_r10v
	.word	_Z11fx_ljmp_r11v
	.word	_Z11fx_ljmp_r12v
	.word	_Z11fx_ljmp_r13v
	.word	_Z6fx_lobv
	.word	_Z8fx_lmultv
	.word	_Z9fx_lms_r0v
	.word	_Z9fx_lms_r1v
	.word	_Z9fx_lms_r2v
	.word	_Z9fx_lms_r3v
	.word	_Z9fx_lms_r4v
	.word	_Z9fx_lms_r5v
	.word	_Z9fx_lms_r6v
	.word	_Z9fx_lms_r7v
	.word	_Z9fx_lms_r8v
	.word	_Z9fx_lms_r9v
	.word	_Z10fx_lms_r10v
	.word	_Z10fx_lms_r11v
	.word	_Z10fx_lms_r12v
	.word	_Z10fx_lms_r13v
	.word	_Z10fx_lms_r14v
	.word	_Z10fx_lms_r15v
	.word	_Z10fx_from_r0v
	.word	_Z10fx_from_r1v
	.word	_Z10fx_from_r2v
	.word	_Z10fx_from_r3v
	.word	_Z10fx_from_r4v
	.word	_Z10fx_from_r5v
	.word	_Z10fx_from_r6v
	.word	_Z10fx_from_r7v
	.word	_Z10fx_from_r8v
	.word	_Z10fx_from_r9v
	.word	_Z11fx_from_r10v
	.word	_Z11fx_from_r11v
	.word	_Z11fx_from_r12v
	.word	_Z11fx_from_r13v
	.word	_Z11fx_from_r14v
	.word	_Z11fx_from_r15v
	.word	_Z6fx_hibv
	.word	_Z9fx_xor_r1v
	.word	_Z9fx_xor_r2v
	.word	_Z9fx_xor_r3v
	.word	_Z9fx_xor_r4v
	.word	_Z9fx_xor_r5v
	.word	_Z9fx_xor_r6v
	.word	_Z9fx_xor_r7v
	.word	_Z9fx_xor_r8v
	.word	_Z9fx_xor_r9v
	.word	_Z10fx_xor_r10v
	.word	_Z10fx_xor_r11v
	.word	_Z10fx_xor_r12v
	.word	_Z10fx_xor_r13v
	.word	_Z10fx_xor_r14v
	.word	_Z10fx_xor_r15v
	.word	_Z9fx_inc_r0v
	.word	_Z9fx_inc_r1v
	.word	_Z9fx_inc_r2v
	.word	_Z9fx_inc_r3v
	.word	_Z9fx_inc_r4v
	.word	_Z9fx_inc_r5v
	.word	_Z9fx_inc_r6v
	.word	_Z9fx_inc_r7v
	.word	_Z9fx_inc_r8v
	.word	_Z9fx_inc_r9v
	.word	_Z10fx_inc_r10v
	.word	_Z10fx_inc_r11v
	.word	_Z10fx_inc_r12v
	.word	_Z10fx_inc_r13v
	.word	_Z10fx_inc_r14v
	.word	_Z7fx_getcv
	.word	_Z9fx_dec_r0v
	.word	_Z9fx_dec_r1v
	.word	_Z9fx_dec_r2v
	.word	_Z9fx_dec_r3v
	.word	_Z9fx_dec_r4v
	.word	_Z9fx_dec_r5v
	.word	_Z9fx_dec_r6v
	.word	_Z9fx_dec_r7v
	.word	_Z9fx_dec_r8v
	.word	_Z9fx_dec_r9v
	.word	_Z10fx_dec_r10v
	.word	_Z10fx_dec_r11v
	.word	_Z10fx_dec_r12v
	.word	_Z10fx_dec_r13v
	.word	_Z10fx_dec_r14v
	.word	_Z8fx_getbhv
	.word	_Z8fx_lm_r0v
	.word	_Z8fx_lm_r1v
	.word	_Z8fx_lm_r2v
	.word	_Z8fx_lm_r3v
	.word	_Z8fx_lm_r4v
	.word	_Z8fx_lm_r5v
	.word	_Z8fx_lm_r6v
	.word	_Z8fx_lm_r7v
	.word	_Z8fx_lm_r8v
	.word	_Z8fx_lm_r9v
	.word	_Z9fx_lm_r10v
	.word	_Z9fx_lm_r11v
	.word	_Z9fx_lm_r12v
	.word	_Z9fx_lm_r13v
	.word	_Z9fx_lm_r14v
	.word	_Z9fx_lm_r15v
	.word	_Z7fx_stopv
	.word	_Z6fx_nopv
	.word	_Z8fx_cachev
	.word	_Z6fx_lsrv
	.word	_Z6fx_rolv
	.word	_Z6fx_brav
	.word	_Z6fx_bgev
	.word	_Z6fx_bltv
	.word	_Z6fx_bnev
	.word	_Z6fx_beqv
	.word	_Z6fx_bplv
	.word	_Z6fx_bmiv
	.word	_Z6fx_bccv
	.word	_Z6fx_bcsv
	.word	_Z6fx_bvcv
	.word	_Z6fx_bvsv
	.word	_Z8fx_to_r0v
	.word	_Z8fx_to_r1v
	.word	_Z8fx_to_r2v
	.word	_Z8fx_to_r3v
	.word	_Z8fx_to_r4v
	.word	_Z8fx_to_r5v
	.word	_Z8fx_to_r6v
	.word	_Z8fx_to_r7v
	.word	_Z8fx_to_r8v
	.word	_Z8fx_to_r9v
	.word	_Z9fx_to_r10v
	.word	_Z9fx_to_r11v
	.word	_Z9fx_to_r12v
	.word	_Z9fx_to_r13v
	.word	_Z9fx_to_r14v
	.word	_Z9fx_to_r15v
	.word	_Z10fx_with_r0v
	.word	_Z10fx_with_r1v
	.word	_Z10fx_with_r2v
	.word	_Z10fx_with_r3v
	.word	_Z10fx_with_r4v
	.word	_Z10fx_with_r5v
	.word	_Z10fx_with_r6v
	.word	_Z10fx_with_r7v
	.word	_Z10fx_with_r8v
	.word	_Z10fx_with_r9v
	.word	_Z11fx_with_r10v
	.word	_Z11fx_with_r11v
	.word	_Z11fx_with_r12v
	.word	_Z11fx_with_r13v
	.word	_Z11fx_with_r14v
	.word	_Z11fx_with_r15v
	.word	_Z9fx_stw_r0v
	.word	_Z9fx_stw_r1v
	.word	_Z9fx_stw_r2v
	.word	_Z9fx_stw_r3v
	.word	_Z9fx_stw_r4v
	.word	_Z9fx_stw_r5v
	.word	_Z9fx_stw_r6v
	.word	_Z9fx_stw_r7v
	.word	_Z9fx_stw_r8v
	.word	_Z9fx_stw_r9v
	.word	_Z10fx_stw_r10v
	.word	_Z10fx_stw_r11v
	.word	_Z7fx_loopv
	.word	_Z7fx_alt1v
	.word	_Z7fx_alt2v
	.word	_Z7fx_alt3v
	.word	_Z9fx_ldw_r0v
	.word	_Z9fx_ldw_r1v
	.word	_Z9fx_ldw_r2v
	.word	_Z9fx_ldw_r3v
	.word	_Z9fx_ldw_r4v
	.word	_Z9fx_ldw_r5v
	.word	_Z9fx_ldw_r6v
	.word	_Z9fx_ldw_r7v
	.word	_Z9fx_ldw_r8v
	.word	_Z9fx_ldw_r9v
	.word	_Z10fx_ldw_r10v
	.word	_Z10fx_ldw_r11v
	.word	_Z12fx_plot_2bitv
	.word	_Z7fx_swapv
	.word	_Z8fx_colorv
	.word	_Z6fx_notv
	.word	_Z9fx_add_i0v
	.word	_Z9fx_add_i1v
	.word	_Z9fx_add_i2v
	.word	_Z9fx_add_i3v
	.word	_Z9fx_add_i4v
	.word	_Z9fx_add_i5v
	.word	_Z9fx_add_i6v
	.word	_Z9fx_add_i7v
	.word	_Z9fx_add_i8v
	.word	_Z9fx_add_i9v
	.word	_Z10fx_add_i10v
	.word	_Z10fx_add_i11v
	.word	_Z10fx_add_i12v
	.word	_Z10fx_add_i13v
	.word	_Z10fx_add_i14v
	.word	_Z10fx_add_i15v
	.word	_Z9fx_sub_i0v
	.word	_Z9fx_sub_i1v
	.word	_Z9fx_sub_i2v
	.word	_Z9fx_sub_i3v
	.word	_Z9fx_sub_i4v
	.word	_Z9fx_sub_i5v
	.word	_Z9fx_sub_i6v
	.word	_Z9fx_sub_i7v
	.word	_Z9fx_sub_i8v
	.word	_Z9fx_sub_i9v
	.word	_Z10fx_sub_i10v
	.word	_Z10fx_sub_i11v
	.word	_Z10fx_sub_i12v
	.word	_Z10fx_sub_i13v
	.word	_Z10fx_sub_i14v
	.word	_Z10fx_sub_i15v
	.word	_Z8fx_mergev
	.word	_Z9fx_and_i1v
	.word	_Z9fx_and_i2v
	.word	_Z9fx_and_i3v
	.word	_Z9fx_and_i4v
	.word	_Z9fx_and_i5v
	.word	_Z9fx_and_i6v
	.word	_Z9fx_and_i7v
	.word	_Z9fx_and_i8v
	.word	_Z9fx_and_i9v
	.word	_Z10fx_and_i10v
	.word	_Z10fx_and_i11v
	.word	_Z10fx_and_i12v
	.word	_Z10fx_and_i13v
	.word	_Z10fx_and_i14v
	.word	_Z10fx_and_i15v
	.word	_Z10fx_mult_i0v
	.word	_Z10fx_mult_i1v
	.word	_Z10fx_mult_i2v
	.word	_Z10fx_mult_i3v
	.word	_Z10fx_mult_i4v
	.word	_Z10fx_mult_i5v
	.word	_Z10fx_mult_i6v
	.word	_Z10fx_mult_i7v
	.word	_Z10fx_mult_i8v
	.word	_Z10fx_mult_i9v
	.word	_Z11fx_mult_i10v
	.word	_Z11fx_mult_i11v
	.word	_Z11fx_mult_i12v
	.word	_Z11fx_mult_i13v
	.word	_Z11fx_mult_i14v
	.word	_Z11fx_mult_i15v
	.word	_Z6fx_sbkv
	.word	_Z10fx_link_i1v
	.word	_Z10fx_link_i2v
	.word	_Z10fx_link_i3v
	.word	_Z10fx_link_i4v
	.word	_Z6fx_sexv
	.word	_Z6fx_asrv
	.word	_Z6fx_rorv
	.word	_Z9fx_jmp_r8v
	.word	_Z9fx_jmp_r9v
	.word	_Z10fx_jmp_r10v
	.word	_Z10fx_jmp_r11v
	.word	_Z10fx_jmp_r12v
	.word	_Z10fx_jmp_r13v
	.word	_Z6fx_lobv
	.word	_Z8fx_fmultv
	.word	_Z9fx_sms_r0v
	.word	_Z9fx_sms_r1v
	.word	_Z9fx_sms_r2v
	.word	_Z9fx_sms_r3v
	.word	_Z9fx_sms_r4v
	.word	_Z9fx_sms_r5v
	.word	_Z9fx_sms_r6v
	.word	_Z9fx_sms_r7v
	.word	_Z9fx_sms_r8v
	.word	_Z9fx_sms_r9v
	.word	_Z10fx_sms_r10v
	.word	_Z10fx_sms_r11v
	.word	_Z10fx_sms_r12v
	.word	_Z10fx_sms_r13v
	.word	_Z10fx_sms_r14v
	.word	_Z10fx_sms_r15v
	.word	_Z10fx_from_r0v
	.word	_Z10fx_from_r1v
	.word	_Z10fx_from_r2v
	.word	_Z10fx_from_r3v
	.word	_Z10fx_from_r4v
	.word	_Z10fx_from_r5v
	.word	_Z10fx_from_r6v
	.word	_Z10fx_from_r7v
	.word	_Z10fx_from_r8v
	.word	_Z10fx_from_r9v
	.word	_Z11fx_from_r10v
	.word	_Z11fx_from_r11v
	.word	_Z11fx_from_r12v
	.word	_Z11fx_from_r13v
	.word	_Z11fx_from_r14v
	.word	_Z11fx_from_r15v
	.word	_Z6fx_hibv
	.word	_Z8fx_or_i1v
	.word	_Z8fx_or_i2v
	.word	_Z8fx_or_i3v
	.word	_Z8fx_or_i4v
	.word	_Z8fx_or_i5v
	.word	_Z8fx_or_i6v
	.word	_Z8fx_or_i7v
	.word	_Z8fx_or_i8v
	.word	_Z8fx_or_i9v
	.word	_Z9fx_or_i10v
	.word	_Z9fx_or_i11v
	.word	_Z9fx_or_i12v
	.word	_Z9fx_or_i13v
	.word	_Z9fx_or_i14v
	.word	_Z9fx_or_i15v
	.word	_Z9fx_inc_r0v
	.word	_Z9fx_inc_r1v
	.word	_Z9fx_inc_r2v
	.word	_Z9fx_inc_r3v
	.word	_Z9fx_inc_r4v
	.word	_Z9fx_inc_r5v
	.word	_Z9fx_inc_r6v
	.word	_Z9fx_inc_r7v
	.word	_Z9fx_inc_r8v
	.word	_Z9fx_inc_r9v
	.word	_Z10fx_inc_r10v
	.word	_Z10fx_inc_r11v
	.word	_Z10fx_inc_r12v
	.word	_Z10fx_inc_r13v
	.word	_Z10fx_inc_r14v
	.word	_Z7fx_rambv
	.word	_Z9fx_dec_r0v
	.word	_Z9fx_dec_r1v
	.word	_Z9fx_dec_r2v
	.word	_Z9fx_dec_r3v
	.word	_Z9fx_dec_r4v
	.word	_Z9fx_dec_r5v
	.word	_Z9fx_dec_r6v
	.word	_Z9fx_dec_r7v
	.word	_Z9fx_dec_r8v
	.word	_Z9fx_dec_r9v
	.word	_Z10fx_dec_r10v
	.word	_Z10fx_dec_r11v
	.word	_Z10fx_dec_r12v
	.word	_Z10fx_dec_r13v
	.word	_Z10fx_dec_r14v
	.word	_Z8fx_getblv
	.word	_Z8fx_sm_r0v
	.word	_Z8fx_sm_r1v
	.word	_Z8fx_sm_r2v
	.word	_Z8fx_sm_r3v
	.word	_Z8fx_sm_r4v
	.word	_Z8fx_sm_r5v
	.word	_Z8fx_sm_r6v
	.word	_Z8fx_sm_r7v
	.word	_Z8fx_sm_r8v
	.word	_Z8fx_sm_r9v
	.word	_Z9fx_sm_r10v
	.word	_Z9fx_sm_r11v
	.word	_Z9fx_sm_r12v
	.word	_Z9fx_sm_r13v
	.word	_Z9fx_sm_r14v
	.word	_Z9fx_sm_r15v
	.word	_Z7fx_stopv
	.word	_Z6fx_nopv
	.word	_Z8fx_cachev
	.word	_Z6fx_lsrv
	.word	_Z6fx_rolv
	.word	_Z6fx_brav
	.word	_Z6fx_bgev
	.word	_Z6fx_bltv
	.word	_Z6fx_bnev
	.word	_Z6fx_beqv
	.word	_Z6fx_bplv
	.word	_Z6fx_bmiv
	.word	_Z6fx_bccv
	.word	_Z6fx_bcsv
	.word	_Z6fx_bvcv
	.word	_Z6fx_bvsv
	.word	_Z8fx_to_r0v
	.word	_Z8fx_to_r1v
	.word	_Z8fx_to_r2v
	.word	_Z8fx_to_r3v
	.word	_Z8fx_to_r4v
	.word	_Z8fx_to_r5v
	.word	_Z8fx_to_r6v
	.word	_Z8fx_to_r7v
	.word	_Z8fx_to_r8v
	.word	_Z8fx_to_r9v
	.word	_Z9fx_to_r10v
	.word	_Z9fx_to_r11v
	.word	_Z9fx_to_r12v
	.word	_Z9fx_to_r13v
	.word	_Z9fx_to_r14v
	.word	_Z9fx_to_r15v
	.word	_Z10fx_with_r0v
	.word	_Z10fx_with_r1v
	.word	_Z10fx_with_r2v
	.word	_Z10fx_with_r3v
	.word	_Z10fx_with_r4v
	.word	_Z10fx_with_r5v
	.word	_Z10fx_with_r6v
	.word	_Z10fx_with_r7v
	.word	_Z10fx_with_r8v
	.word	_Z10fx_with_r9v
	.word	_Z11fx_with_r10v
	.word	_Z11fx_with_r11v
	.word	_Z11fx_with_r12v
	.word	_Z11fx_with_r13v
	.word	_Z11fx_with_r14v
	.word	_Z11fx_with_r15v
	.word	_Z9fx_stb_r0v
	.word	_Z9fx_stb_r1v
	.word	_Z9fx_stb_r2v
	.word	_Z9fx_stb_r3v
	.word	_Z9fx_stb_r4v
	.word	_Z9fx_stb_r5v
	.word	_Z9fx_stb_r6v
	.word	_Z9fx_stb_r7v
	.word	_Z9fx_stb_r8v
	.word	_Z9fx_stb_r9v
	.word	_Z10fx_stb_r10v
	.word	_Z10fx_stb_r11v
	.word	_Z7fx_loopv
	.word	_Z7fx_alt1v
	.word	_Z7fx_alt2v
	.word	_Z7fx_alt3v
	.word	_Z9fx_ldb_r0v
	.word	_Z9fx_ldb_r1v
	.word	_Z9fx_ldb_r2v
	.word	_Z9fx_ldb_r3v
	.word	_Z9fx_ldb_r4v
	.word	_Z9fx_ldb_r5v
	.word	_Z9fx_ldb_r6v
	.word	_Z9fx_ldb_r7v
	.word	_Z9fx_ldb_r8v
	.word	_Z9fx_ldb_r9v
	.word	_Z10fx_ldb_r10v
	.word	_Z10fx_ldb_r11v
	.word	_Z12fx_rpix_2bitv
	.word	_Z7fx_swapv
	.word	_Z8fx_cmodev
	.word	_Z6fx_notv
	.word	_Z9fx_adc_i0v
	.word	_Z9fx_adc_i1v
	.word	_Z9fx_adc_i2v
	.word	_Z9fx_adc_i3v
	.word	_Z9fx_adc_i4v
	.word	_Z9fx_adc_i5v
	.word	_Z9fx_adc_i6v
	.word	_Z9fx_adc_i7v
	.word	_Z9fx_adc_i8v
	.word	_Z9fx_adc_i9v
	.word	_Z10fx_adc_i10v
	.word	_Z10fx_adc_i11v
	.word	_Z10fx_adc_i12v
	.word	_Z10fx_adc_i13v
	.word	_Z10fx_adc_i14v
	.word	_Z10fx_adc_i15v
	.word	_Z9fx_cmp_r0v
	.word	_Z9fx_cmp_r1v
	.word	_Z9fx_cmp_r2v
	.word	_Z9fx_cmp_r3v
	.word	_Z9fx_cmp_r4v
	.word	_Z9fx_cmp_r5v
	.word	_Z9fx_cmp_r6v
	.word	_Z9fx_cmp_r7v
	.word	_Z9fx_cmp_r8v
	.word	_Z9fx_cmp_r9v
	.word	_Z10fx_cmp_r10v
	.word	_Z10fx_cmp_r11v
	.word	_Z10fx_cmp_r12v
	.word	_Z10fx_cmp_r13v
	.word	_Z10fx_cmp_r14v
	.word	_Z10fx_cmp_r15v
	.word	_Z8fx_mergev
	.word	_Z9fx_bic_i1v
	.word	_Z9fx_bic_i2v
	.word	_Z9fx_bic_i3v
	.word	_Z9fx_bic_i4v
	.word	_Z9fx_bic_i5v
	.word	_Z9fx_bic_i6v
	.word	_Z9fx_bic_i7v
	.word	_Z9fx_bic_i8v
	.word	_Z9fx_bic_i9v
	.word	_Z10fx_bic_i10v
	.word	_Z10fx_bic_i11v
	.word	_Z10fx_bic_i12v
	.word	_Z10fx_bic_i13v
	.word	_Z10fx_bic_i14v
	.word	_Z10fx_bic_i15v
	.word	_Z11fx_umult_i0v
	.word	_Z11fx_umult_i1v
	.word	_Z11fx_umult_i2v
	.word	_Z11fx_umult_i3v
	.word	_Z11fx_umult_i4v
	.word	_Z11fx_umult_i5v
	.word	_Z11fx_umult_i6v
	.word	_Z11fx_umult_i7v
	.word	_Z11fx_umult_i8v
	.word	_Z11fx_umult_i9v
	.word	_Z12fx_umult_i10v
	.word	_Z12fx_umult_i11v
	.word	_Z12fx_umult_i12v
	.word	_Z12fx_umult_i13v
	.word	_Z12fx_umult_i14v
	.word	_Z12fx_umult_i15v
	.word	_Z6fx_sbkv
	.word	_Z10fx_link_i1v
	.word	_Z10fx_link_i2v
	.word	_Z10fx_link_i3v
	.word	_Z10fx_link_i4v
	.word	_Z6fx_sexv
	.word	_Z7fx_div2v
	.word	_Z6fx_rorv
	.word	_Z10fx_ljmp_r8v
	.word	_Z10fx_ljmp_r9v
	.word	_Z11fx_ljmp_r10v
	.word	_Z11fx_ljmp_r11v
	.word	_Z11fx_ljmp_r12v
	.word	_Z11fx_ljmp_r13v
	.word	_Z6fx_lobv
	.word	_Z8fx_lmultv
	.word	_Z9fx_lms_r0v
	.word	_Z9fx_lms_r1v
	.word	_Z9fx_lms_r2v
	.word	_Z9fx_lms_r3v
	.word	_Z9fx_lms_r4v
	.word	_Z9fx_lms_r5v
	.word	_Z9fx_lms_r6v
	.word	_Z9fx_lms_r7v
	.word	_Z9fx_lms_r8v
	.word	_Z9fx_lms_r9v
	.word	_Z10fx_lms_r10v
	.word	_Z10fx_lms_r11v
	.word	_Z10fx_lms_r12v
	.word	_Z10fx_lms_r13v
	.word	_Z10fx_lms_r14v
	.word	_Z10fx_lms_r15v
	.word	_Z10fx_from_r0v
	.word	_Z10fx_from_r1v
	.word	_Z10fx_from_r2v
	.word	_Z10fx_from_r3v
	.word	_Z10fx_from_r4v
	.word	_Z10fx_from_r5v
	.word	_Z10fx_from_r6v
	.word	_Z10fx_from_r7v
	.word	_Z10fx_from_r8v
	.word	_Z10fx_from_r9v
	.word	_Z11fx_from_r10v
	.word	_Z11fx_from_r11v
	.word	_Z11fx_from_r12v
	.word	_Z11fx_from_r13v
	.word	_Z11fx_from_r14v
	.word	_Z11fx_from_r15v
	.word	_Z6fx_hibv
	.word	_Z9fx_xor_i1v
	.word	_Z9fx_xor_i2v
	.word	_Z9fx_xor_i3v
	.word	_Z9fx_xor_i4v
	.word	_Z9fx_xor_i5v
	.word	_Z9fx_xor_i6v
	.word	_Z9fx_xor_i7v
	.word	_Z9fx_xor_i8v
	.word	_Z9fx_xor_i9v
	.word	_Z10fx_xor_i10v
	.word	_Z10fx_xor_i11v
	.word	_Z10fx_xor_i12v
	.word	_Z10fx_xor_i13v
	.word	_Z10fx_xor_i14v
	.word	_Z10fx_xor_i15v
	.word	_Z9fx_inc_r0v
	.word	_Z9fx_inc_r1v
	.word	_Z9fx_inc_r2v
	.word	_Z9fx_inc_r3v
	.word	_Z9fx_inc_r4v
	.word	_Z9fx_inc_r5v
	.word	_Z9fx_inc_r6v
	.word	_Z9fx_inc_r7v
	.word	_Z9fx_inc_r8v
	.word	_Z9fx_inc_r9v
	.word	_Z10fx_inc_r10v
	.word	_Z10fx_inc_r11v
	.word	_Z10fx_inc_r12v
	.word	_Z10fx_inc_r13v
	.word	_Z10fx_inc_r14v
	.word	_Z7fx_rombv
	.word	_Z9fx_dec_r0v
	.word	_Z9fx_dec_r1v
	.word	_Z9fx_dec_r2v
	.word	_Z9fx_dec_r3v
	.word	_Z9fx_dec_r4v
	.word	_Z9fx_dec_r5v
	.word	_Z9fx_dec_r6v
	.word	_Z9fx_dec_r7v
	.word	_Z9fx_dec_r8v
	.word	_Z9fx_dec_r9v
	.word	_Z10fx_dec_r10v
	.word	_Z10fx_dec_r11v
	.word	_Z10fx_dec_r12v
	.word	_Z10fx_dec_r13v
	.word	_Z10fx_dec_r14v
	.word	_Z8fx_getbsv
	.word	_Z8fx_lm_r0v
	.word	_Z8fx_lm_r1v
	.word	_Z8fx_lm_r2v
	.word	_Z8fx_lm_r3v
	.word	_Z8fx_lm_r4v
	.word	_Z8fx_lm_r5v
	.word	_Z8fx_lm_r6v
	.word	_Z8fx_lm_r7v
	.word	_Z8fx_lm_r8v
	.word	_Z8fx_lm_r9v
	.word	_Z9fx_lm_r10v
	.word	_Z9fx_lm_r11v
	.word	_Z9fx_lm_r12v
	.word	_Z9fx_lm_r13v
	.word	_Z9fx_lm_r14v
	.word	_Z9fx_lm_r15v
	.ident	"GCC: (GNU) 4.2.4"
