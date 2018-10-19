;	H8/3664 Startup file

	.h8300h
	.section .text
	.global	_start
_start:
	mov.l	#__stack,sp

	mov.l	#___dtors_end,er0
	mov.l	#___data,er1
	mov.l	#_edata,er2
1:
	mov.w	@er0,r3
	mov.w	r3,@er1
	adds	#2,er0
	adds	#2,er1
	cmp.l	er2,er1
	blo	1b
1:
	jsr	@_main
	bra	1b

;	.section .stack
__stack:
