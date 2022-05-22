ASM=vasmm68k_mot.exe

quadrat.bin: quadrat.s
	$(ASM) -Fbin $^ -o $@

.PHONY: clean

clean:
	rm -f *.bin 
