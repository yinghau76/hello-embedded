CPU := arm926ej-s

ifdef LLVM
CC := clang-3.5
CFLAGS := -target arm-none-eabi -mcpu=$(CPU) -mfloat-abi=soft
else
CC := arm-none-eabi-gcc
CFLAGS := -mcpu=$(CPU)
endif

all: test.bin
clean:
	rm -f *.o *.elf *.bin

debug:
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin -s -S

%.o: %.s
	arm-none-eabi-as -mcpu=$(CPU) -g $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) -g $< -o $@

test.elf: test.ld test.o startup.o
	arm-none-eabi-ld -T $^ -o $@

%.bin: %.elf
	arm-none-eabi-objcopy -O binary $< $@
