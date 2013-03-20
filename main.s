        .text
        .global start
start:
        b       main
arr:
        .byte 10, 20, 30
arr_end:

        .align
main:
        ldr     r0,     =arr
        ldr     r1,     =arr_end
        bl      sum
stop:
        b       stop
