ifeq ($(shell uname -p),i686)
	ASFLAGS=
	LDFLAGS= -Ttext=0x0
	AS=arm-none-eabi-as
	LD=arm-none-eabi-ld
	CC=arm-none-eabi-gcc
	OBJCOPY=arm-none-eabi-objcopy
	TARGETS=$(patsubst %.s,%.bin,$(wildcard *.s))
else
	ASFLAGS= -gstabs
	LDFLAGS=
	AS=as
	LD=ld
	CC=gcc -Wall -fomit-frame-pointer -marm
	OBJCOPY=objcopy
	TARGETS=$(patsubst %.s,%.elf,$(wildcard *.s))
endif

.PHONY: all
all: $(TARGETS)

.PRECIOUS: %.elf %.o

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
	dd if=/dev/zero of=flash.bin bs=4096 count=4096 &> /dev/null
	dd if=$@ of=flash.bin bs=4096 conv=notrunc &> /dev/null
	mv flash.bin $@

%.elf: %.o
	$(LD) -e start $(LDFLAGS) -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin *~
