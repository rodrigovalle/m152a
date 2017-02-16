`timescale 1ns / 1ps

module stopwatch(
	input 			clk,
	input	[7:0] 	sw, 	// sw[0] = adj; sw[1] = sel;
	input 			btnS,	// pause
	input 			btnR, 	// rst
	output	[7:0]	seg,	// Seven segments + decimal
	output 	[3:0]	an		// Anodes for diplaying segments
	);

	wire 1Hz, 2Hz, 4Hz, 200Hz;

	clock_div cdiv(
        // inputs
        .clk(clk),
        .rst(btnR),
        .pause(btnS),

        // outputs
        .1Hz_clk(1Hz),
        .2Hz_clk(2Hz),
        .4Hz_clk(4Hz),
        .200Hz_clk(200Hz)
    	)

	reg [3:0] ones_sec, tens_sec, ones_min, tens_min;
	wire sec_overflow;

    counter seconds(
    	.clk(1Hz),
    	.rst(btnR),
    	.count_ones(ones_sec),
    	.count_tens(tens_sec),
    	.c_out(sec_overflow)
    	)

    counter minutes(
    	.clk(sec_overflow),
    	.rst(btnR),
    	.count_ones(ones_min),
    	.count_tens(tens_min),
    	.c_out()
    	)

    

endmodule