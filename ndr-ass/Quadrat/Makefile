ASM=vasmm68k_mot.exe

quadrat.bin: quadrat.68k
	$(ASM) -Fbin $^ -o $@

.PHONY: clean

clean:
	rm -f *.bin 
