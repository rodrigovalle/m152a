`timescale 1ns / 1ps

module stopwatch(
    input           clk,
    input   [1:0]   sw,     // sw[0] = adj; sw[1] = sel;
    input           btnS,   // pause
    input           btnR,   // rst
    output  [7:0]   seg,    // Seven segments + decimal
    output  [3:0]   an      // Anodes for diplaying segments
    );

    // clock outputs
    wire one_hz, two_hz, four_hz, four_hundred_hz;

    // debounced button outputs
    wire rst, pause;
	 assign rst = btnR;

    // switches
    wire adj = sw[0];
    wire sel = sw[1];

    clock_div cdiv(
        // inputs
        .clk(clk),
        .rst(rst),

        // outputs
        .one_hz_clk(one_hz),
        .two_hz_clk(two_hz),
        .four_hz_clk(four_hz),
        .four_hundred_hz_clk(four_hundred_hz)
    );

	 /*
    debouncer rst_db(
        .clk(four_hundred_hz),
        .btn_in(btnR),
        .btn_state(rst)
    );
	 */
	 
    debouncer pause_db(
        .clk(four_hundred_hz),
        .btn_in(btnS),
        .btn_state(pause)
    );

    wire [3:0] ones_sec, tens_sec, ones_min, tens_min;

    wire counter_clk, seconds_clk, minutes_clk, sec_overflow;
    assign counter_clk = (adj) ? two_hz : (pause ? 0 : one_hz);
    assign seconds_clk = (adj && !sel) ? 0 : counter_clk;
    assign minutes_clk = (adj && !sel) ? counter_clk : (adj ? 0 : sec_overflow);

    counter seconds(
        .clk(seconds_clk),
        .rst(rst),
        .count_ones(ones_sec),
        .count_tens(tens_sec),
        .c_out(sec_overflow)
    );

    counter minutes(
        .clk(minutes_clk),
        .rst(rst),
        .count_ones(ones_min),
        .count_tens(tens_min),
        .c_out()
    );


    wire [7:0] digit1, digit2, digit3, digit4;

    ssd_converter sec_ones_convert(
        .n(ones_sec),
        .ssd(digit1)
    );

    ssd_converter sec_tens_convert(
        .n(tens_sec),
        .ssd(digit2)
    );

    ssd_converter min_ones_convert(
        .n(ones_min),
        .ssd(digit3)
    );

    ssd_converter min_tens_convert(
        .n(tens_min),
        .ssd(digit4)
    );
	 
	 
    wire [7:0] digit1_blink, digit2_blink, digit3_blink, digit4_blink;
	 
	 blink secBlink(
	      .clk(four_hz),
			.enable(adj && sel),
			.digit1(digit1),
			.digit2(digit2),
			.digit1_out(digit1_blink),
			.digit2_out(digit2_blink)
	 );
	 
	 blink minBlink(
	      .clk(four_hz),
			.enable(adj && !sel),
			.digit1(digit3),
			.digit2(digit4),
			.digit1_out(digit3_blink),
			.digit2_out(digit4_blink)
	 );

    ssd_driver driver(
        .clk(four_hundred_hz),
        .digit1(digit1_blink),
        .digit2(digit2_blink),
        .digit3(digit3_blink),
        .digit4(digit4_blink),
        .cathode(seg),
        .anode(an)
    );

endmodule
