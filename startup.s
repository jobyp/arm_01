	.section "vectors"

reset:	b 	start
undef:	b	undef
swi:	b 	swi
pabt:	b	pabt
dabt:	b	dabt
	nop
irq:	b	irq
fiq:	b	fiq


	.text
	.global	start

start:
	/* Copty data to RAM */
	ldr	r0,	=flash_sdata
	ldr	r1,	=ram_sdata
	ldr	r2,	=data_size

	cmp	r2,	#0
	beq	init_bss

copy:
	ldrb	r3,	[r0],	#1
	strb	r3,	[r1],	#1
	subs	r2,	r2,	#1
	bne	copy

	/* Initialize bss to 0 */
init_bss:	
	ldr	r0,	=sbss
	ldr	r1,	=ebss

	cmp	r0,	r1
	beq	init_stack

	mov	r2,	#0
	
zero:
	strb	r2,	[r0],	#1
	cmp	r0,	r1
	bne	zero

init_stack:
	ldr	sp,	=0xA4000000
	bl	main

stop:	b	stop
