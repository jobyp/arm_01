        .data
arr:
        .byte 10, 20, 30
arr_end:

	.text
	.global	start
start:
        ldr     r0,     =arr
        ldr     r1,     =arr_end
        bl      sum
stop:
        b       stop
