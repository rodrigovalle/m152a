SRC = $(wildcard *.v)

a.out: $(SRC)
	iverilog $(SRC)

mastermind_tb: $(SRC)
	iverilog mastermind.v mastermind_tb.v clock_div.v debouncer.v guess.v history.v turn.v prng.v feedback.v ssd_converter.v ssd_driver.v led_driver.v

clean:
	rm -rf a.out dump.txt

dump.txt: a.out
	./a.out > dump.txt

less: dump.txt
	cat dump.txt | less

.PHONY: clean debug
