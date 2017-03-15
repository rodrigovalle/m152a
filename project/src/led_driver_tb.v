`timescale 1ns / 1ps

module led_driver_tb;
	reg clk;
    reg blink_enable;
    reg [1:0] blink_led;
    reg [2:0] guess_rgb0;
    reg [2:0] guess_rgb1;
    reg [2:0] guess_rgb2;
    reg [2:0] guess_rgb3;
    reg [2:0] history_rgb0;
    reg [2:0] history_rgb1;
    reg [2:0] history_rgb2;
    reg [2:0] history_rgb3;
    wire [2:0] rgb0_out;
    wire [2:0] rgb1_out;
    wire [2:0] rgb2_out;
   	wire [2:0] rgb3_out;

   	integer cnt = 0;

    initial begin
    	clk		= 0;
    	blink_enable = 0;
    	blink_led = 1;
    	guess_rgb0 = 1;
    	guess_rgb1 = 1;
    	guess_rgb2 = 1;
    	guess_rgb3 = 1;
    	history_rgb0 = 2;
    	history_rgb1 = 2;
    	history_rgb2 = 2;
    	history_rgb3 = 2;
    	#40 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin

        cnt += 1;

        $display("----\n",
                 "RGBs: %d-%d-%d-%d\n", rgb0_out, rgb1_out, rgb2_out, rgb3_out,
                 "Blink_enable: %d   Blink_led: %d  Cnt: %0d", blink_enable, blink_led, cnt);
	end

	led_driver led_dr(
		.clk(clk),
		.blink_enable(blink_enable),
		.blink_led(blink_led),
		.guess_rgb0(guess_rgb0),
		.guess_rgb1(guess_rgb1),
		.guess_rgb2(guess_rgb2),
		.guess_rgb3(guess_rgb3),
		.history_rgb0(history_rgb0),
		.history_rgb1(history_rgb1),
		.history_rgb2(history_rgb2),
		.history_rgb3(history_rgb3),
		.rgb0_out(rgb0_out),
		.rgb1_out(rgb1_out),
		.rgb2_out(rgb2_out),
		.rgb3_out(rgb3_out)
	);

endmodule