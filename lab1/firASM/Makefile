TARGET = fir

$(TARGET).objdump: $(TARGET)
	riscv64-unknown-elf-objdump -S -D $(TARGET) > $(TARGET).objdump

$(TARGET): fir.c fir.S Makefile
	riscv64-unknown-elf-gcc -o $(TARGET) -gdwarf-2 -O \
	  -march=rv64gc -mabi=lp64d -mcmodel=medany \
	  -nostdlib -static -lm -fno-tree-loop-distribute-patterns \
	  -T../common/test.ld -I../common \
	  fir.c fir.S ../common/crt.S ../common/syscalls.c

clean:
	rm -f $(TARGET) $(TARGET).objdump
