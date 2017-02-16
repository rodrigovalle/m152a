module clock_div(
	input clk,
	input rst,
	input pause,
	output reg 2Hz_clk,
	output reg 1Hz_clk,
	output reg 200Hz_clk,
	output reg 4Hz_clk
);

integer 2Hz_cnt, 1Hz_cnt, 200Hz_cnt, 4Hz_cnt;

// clk is 100 MHz or 100,000,000
always @ (posedge clk) begin
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
		if (2Hz_cnt == 50,000,000 - 1)	begin
			2Hz_clk <= 1;
			2Hz_cnt <= 0;
		end
		else begin
			2Hz_clk <= 0;
		end

		// Manage 1 Hz clk
		if (1Hz_cnt == 100,000,000 - 1)	begin
			1Hz_clk <= 1;
			1Hz_cnt <= 0;
		end
		else begin
			1Hz_clk <= 0;
		end

		// Manage 100 Hz clk
		if (100Hz_cnt == 1,000,000 - 1)	begin
			100Hz_clk <= 1;
			100Hz_cnt <= 0;
		end
		else begin
			100Hz_clk <= 0;
		end

		// Manage 4 Hz clk
		if (4Hz_cnt == 25,000,000 - 1)	begin
			4Hz_clk <= 1;
			4Hz_cnt <= 0;
		end
		else begin
			4Hz_clk <= 0;
		end
	end
 end

endmodule
