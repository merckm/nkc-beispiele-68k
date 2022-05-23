ASM=vasmm68k_mot.exe

ziffer1.bin: ziffer1.68k
	$(ASM) -Fbin $^ -o $@

.PHONY: clean

clean:
	rm -f *.bin 
