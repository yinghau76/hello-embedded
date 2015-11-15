CPU := arm926ej-s

all: test.bin
clean:
	rm -f *.o *.elf *.bin

debug:
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin -s -S

%.o: %.s
	arm-none-eabi-as -mcpu=$(CPU) -g $< -o $@

%.o: %.c
	arm-none-eabi-gcc -c -mcpu=$(CPU) -g $< -o $@

test.elf: test.ld test.o startup.o
	arm-none-eabi-ld -T $? -o $@

%.bin: %.elf
	arm-none-eabi-objcopy -O binary $< $@
