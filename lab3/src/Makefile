SRC = $(wildcard *.v)

a.out: $(SRC)
	iverilog -Wall $(SRC)

clean:
	rm -rf a.out dump.txt

dump.txt: a.out
	./a.out > dump.txt

less: dump.txt
	cat dump.txt | less

.PHONY: clean
