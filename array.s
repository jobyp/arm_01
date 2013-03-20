	.text
	.global start
start:	b sum

arr:	.byte	10, 20, 25
arr_end:

	.align

sum:
	ldr	r0, 	=arr_end
	ldr	r1,	=arr
	mov	r3,	#0
loop:	cmp	r0,	r1
	beq	loop_exit
	ldrb	r2,	[r1],	#1
	add	r3,	r3,	r2
	b 	loop
loop_exit:
	mov	r0,	r3
stop:	b 	stop
	
	