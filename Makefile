TARGETS := main add array strlen add-mem
ifeq ($(shell uname -p),i686)
	ASFLAGS=
	LDFLAGS= -Ttext=0x0
	AS=arm-none-eabi-as
	LD=arm-none-eabi-ld
	CC=arm-none-eabi-gcc
	OBJCOPY=arm-none-eabi-objcopy
	TARGETS:=$(patsubst %,%.bin,$(TARGETS))
else
	ASFLAGS= -gstabs
	LDFLAGS=
	AS=as
	LD=ld
	CC=gcc -Wall -fomit-frame-pointer -marm
	OBJCOPY=objcopy
	TARGETS:=$(patsubst %,%.elf,$(TARGETS))
endif

.PHONY: all 

all: $(TARGETS)

.PRECIOUS: %.elf %.o

main.elf: main.o sum-sub.o main.lds
	$(LD) -e start -T main.lds -o $@ $(filter %.o,$^)

add-mem.elf: add-mem.o add-mem.lds
	$(LD) -e start -T add-mem.lds -o $@ $(filter %.o,$^)

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
	dd if=/dev/zero of=flash.bin bs=4096 count=4096
	dd if=$@ of=flash.bin bs=4096 conv=notrunc
	mv flash.bin $@

%.elf: %.o
	$(LD) -e start $(LDFLAGS) -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin *~
