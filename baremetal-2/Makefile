CPU=cortex-a8

LIBS := /usr/lib/gcc/arm-none-eabi/4.8.2/libgcc.a

ifdef LLVM
CC := clang-3.5
CFLAGS := -nostdlib -ffreestanding -target arm-none-eabi -mcpu=$(CPU) -mfloat-abi=soft -I /usr/lib/arm-none-eabi/include
else
CC := arm-none-eabi-gcc
CFLAGS := -mcpu=$(CPU)
endif

all: test.bin
clean:
	rm -f *.o *.elf *.bin
debug:
	qemu-system-arm -M realview-pb-a8 -nographic -serial stdio -kernel test.elf -s -S

%.o: %.s
	arm-none-eabi-as -mcpu=$(CPU) -g $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) -g $< -o $@

test.elf: test.ld test.o startup.o syscalls.o /usr/lib/arm-none-eabi/lib/libc.a
	arm-none-eabi-ld -nostdlib -T $^ $(LIBS) -o $@

%.bin: %.elf
	arm-none-eabi-objcopy -O binary $< $@

