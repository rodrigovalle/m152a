`timescale 1ns / 1ps

module stopwatch(
	input 			clk,
	input	[7:0] 	sw, 	// sw[0] = adj; sw[1] = sel;
	input 			btnS,	// pause
	input 			btnR, 	// rst
	output	[7:0]	seg,	// Seven segments + decimal
	output 	[3:0]	an		// Anodes for diplaying segments
	);


	// *********************
	// Counter module: BEGIN
	module counter(
		input clk,
		input rst,
		output reg [5:0] minute,
		output reg [5:0] second
		);

		always @ (posedge clk) begin
			if (rst) begin
				minute <= 0;
				second <= 0;
			end
			else begin
				if (second == 6'b 111100) begin
					second <= 0;
					minute <= minute + 1;
				end
				else begin
					second <= second + 1;
				end
			end
		end
	endmodule
	// Counter module: END
	// *********************


	// *******************
	// Clock module: BEGIN
	module clock(
		input clk,
		input rst,
		input pause,
		output reg 2Hz_clk,
		output reg 1Hz_clk,
		output reg 200Hz_clk,
		output reg 4Hz_clk
		);

		integer 2Hz_cnt, 1Hz_cnt, 200Hz_cnt;
		always @ (posedge clk) begin
			// clk is 100 MHz or 100,000,000

			if (rst) begin
				2Hz_cnt 	= 0;
				1Hz_cnt 	= 0;
				100Hz_cnt 	= 0;
				4Hz_cnt 	= 0;

				2Hz_clk 	<= 0;
				1Hz_clk 	<= 0;
				100Hz_clk 	<= 0;
				4Hz_clk 	<= 0;
			end
			else if (!pause) begin
				2Hz_cnt 	= 2Hz_cnt + 1;
				1Hz_cnt 	= 1Hz_cnt + 1;
				200Hz_cnt 	= 200Hz_cnt + 1;
				4Hz_cnt 	= 4Hz_cnt + 1;	// for minute/second blinking


				// Manage 2 Hz clk
				if (2Hz_cnt == 50,000,000)	begin
					2Hz_clk <= 1;
					2Hz_cnt <= 0;
				end
				else begin
					2Hz_clk <= 0;
				end

				// Manage 1 Hz clk
				if (1Hz_cnt == 100,000,000)	begin
					1Hz_clk <= 1;
					1Hz_cnt <= 0;
				end
				else begin
					1Hz_clk <= 0;
				end

				// Manage 100 Hz clk
				if (100Hz_cnt == 1,000,000)	begin
					100Hz_clk <= 1;
					100Hz_cnt <= 0;
				end
				else begin
					100Hz_clk <= 0;
				end

				// Manage 4 Hz clk
				if (4Hz_cnt == 25,000,000)	begin
					4Hz_clk <= 1;
					4Hz_cnt <= 0;
				end
				else begin
					4Hz_clk <= 0;
				end
			end

		 end
	endmodule
	// Clock module: END
	// *******************



	// ***********************
	// Debouncer module: BEGIN
	module debouncer(
		
		);
	endmodule
	// Debouncer module: END
	// ***********************


	reg 	[3:0] SSD;

	reg [6:0] cathodes;
	assign seg = cathodes
	assign seg[7] = 1;

	// Binary to SSD conversion
	always @(posedge clk or posedge btnR) begin
		if (btnR) begin
			// reset
			cathodes <= 7'b0000001; // 0
		end
		else begin
			case (SSD)
				4'b0000: cathodes <= 7'b0000001; // 0
				4'b0001: cathodes <= 7'b1001111; // 1
				4'b0010: cathodes <= 7'b0010010; // 2
				4'b0011: cathodes <= 7'b0000001; // 3
				4'b0100: cathodes <= 7'b0000110; // 4
				4'b0101: cathodes <= 7'b0100101; // 5
				4'b0110: cathodes <= 7'b0100000; // 6
				4'b0111: cathodes <= 7'b0001111; // 7
				4'b1000: cathodes <= 7'b0000000; // 8
				4'b1001: cathodes <= 7'b0000100; // 9
			endcase
		end
	end

endmodule


