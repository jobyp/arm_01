AS=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-as
LD=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-ld
CC=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-gcc
OBJCOPY=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-objcopy

.PHONY: all
all: $(patsubst %.s,%.bin,$(wildcard *.s))

.PRECIOUS: %.elf %.o

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
	dd if=/dev/zero of=flash.bin bs=4096 count=4096
	dd if=add.bin of=flash.bin bs=4096 conv=notrunc
	mv flash.bin add.bin

%.elf: %.o
	$(LD) -e start -Ttext=0x0 -o $@ $<

%.o: %.s
	$(AS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin *~
