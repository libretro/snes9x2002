.macro	blx	reg
	mov	lr, pc
	mov	pc, \reg 	
.endm

.include "os9x_65c816_global.s"
