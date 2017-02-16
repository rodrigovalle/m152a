`timescale 1ns / 1ps

module stopwatch(
	input 			clk,
	input	[7:0] 	sw, 	// sw[0] = adj; sw[1] = sel;
	input 			btnS,	// pause
	input 			btnR, 	// rst
	output	[7:0]	seg,	// Seven segments + decimal
	output 	[3:0]	an		// Anodes for diplaying segments
	);

endmodule
