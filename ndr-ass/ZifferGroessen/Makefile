ASM=vasmm68k_mot.exe

zifferGroessen.bin: zifferGroessen.68k
	$(ASM) -Fbin $^ -o $@

.PHONY: clean

clean:
	rm -f *.bin 
