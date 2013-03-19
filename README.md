ARM programming using QEMU emulated Connex board
================================================

Programs are from the ARM assembly 
[tutorial](http://www.bravegnu.org/gnu-eprog/index.html)

For executing flash.bin using QEMU,
`qemu-system-arm -M connex -pflash flash.bin -nographic -serial /dev/null`