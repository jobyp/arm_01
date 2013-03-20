AS=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-as
LD=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-ld
CC=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-gcc
OBJCOPY=/local/home/pcj/bin/arm-2012.09/bin/arm-none-eabi-objcopy

ifeq ($(shell uname -p),i686)
ASFLAGS=
LDFLAGS= -Ttext=0x0
else
ASFLAGS= -gstabs
LDFLAGS=
endif

.PHONY: all
all: $(patsubst %.s,%.bin,$(wildcard *.s))

.PRECIOUS: %.elf %.o

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
	dd if=/dev/zero of=flash.bin bs=4096 count=4096
	dd if=add.bin of=flash.bin bs=4096 conv=notrunc
	mv flash.bin $@

%.elf: %.o
	$(LD) -e start $(LDFLAGS) -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin *~
