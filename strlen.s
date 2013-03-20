        .text
        .global start
start:
        b       strlen
str:
        .asciz  "Hello, World"
str_len = . - str

        .align
strlen:
        ldr     r1,     =str
        mov     r2,     #0
loop:
        ldrb    r0,     [r1],   #1
        cmp     r0,     #0
        addne   r2,     r2,     #1
        bne     loop

        mov     r0,     r2
        ldr     r1,     =str_len
stop:   b       stop
        