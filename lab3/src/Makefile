SRC = $(wildcard *.v)

a.out: $(SRC)
	iverilog $(SRC)

ssd_driver_tb: $(SRC)
	iverilog ssd_converter.v ssd_driver.v ssd_driver_tb.v

clean:
	rm -rf a.out dump.txt

dump.txt: a.out
	./a.out > dump.txt

less: dump.txt
	cat dump.txt | less

.PHONY: clean debug
