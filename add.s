	.text
	.global start
start:
	mov	r0,	#5
	mov	r1,	#4
	add	r2,	r0,	r1
        ldr     r3,     =word
        str     r2,     [r3]
        
stop:
	b	stop
word:
        .word   0xdeadbeef
        