	.text
	.global start
start:
	mov	r0,	#5
	mov	r1,	#4
	add	r2,	r0,	r1
stop:
	b	stop
        