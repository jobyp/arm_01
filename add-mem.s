	.data
val1:	.4byte	10
val2:	.4byte 	30
result:	.4byte	0

	.text
	.global start
start:
	ldr	r0,	=flash_sdata
	ldr	r1,	=ram_sdata
	ldr	r2,	=data_size

copy:	cmp	r2,	#0
	ldrneb	r4,	[r0],	#1
	strneb	r4,	[r1], 	#1
	sub	r2,	r2,	#1
	bne	copy
	
	ldr	r0,	=val1
	ldr	r1,	=val2
	ldr	r2,	[r0]
	ldr	r3,	[r1]
	add	r4,	r3,	r2
	ldr	r0,	=result
	str	r4,	[r0]

stop:	b	stop
