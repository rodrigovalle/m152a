`timescale 1ns / 1ps

module mastermind(
    input           clk,
    input           sw,         // mode
    input           btnS,       // select
    input           btnR,       // right
    input           btnL,       // left
    input           btnU,       // up
    input           btnD,       // down
    output  [7:0]   seg,        // Seven segments + decimal
    output  [3:0]   an,         // Anodes for diplaying segments
    output  [2:0]   rgb0_out,   // led 0
    output  [2:0]   rgb1_out,   // led 1
    output  [2:0]   rgb2_out,   // led 2
    output  [2:0]   rgb3_out,   // led 3
    output  [7:0]   sw_led      // those leds above the switches
    );

    // clock outputs
    wire one_hz, two_hz, four_hz, four_hundred_hz;
    clock_div cdiv(
        // inputs
        .clk(clk),

        // outputs
        .one_hz_clk(one_hz),
        .two_hz_clk(two_hz),
        .four_hz_clk(four_hz),
        .four_hundred_hz_clk(four_hundred_hz)
    );

    // debounced button outputs
    wire select, right, left, up, down;
    debouncer select_db(
        .clk(four_hundred_hz),
        .btn_in(btnS),
        .btn_state(select)
    );
	 
    debouncer right_db(
        .clk(four_hundred_hz),
        .btn_in(btnR),
        .btn_state(right)
    );

    debouncer left_db(
        .clk(four_hundred_hz),
        .btn_in(btnL),
        .btn_state(left)
    );

    debouncer up_db(
        .clk(four_hundred_hz),
        .btn_in(btnU),
        .btn_state(up)
    );

    debouncer down_db(
        .clk(four_hundred_hz),
        .btn_in(btnD),
        .btn_state(down)
    );

    wire [2:0] guess0, guess1, guess2, guess3;
    wire [1:0] sel_led; // Which led is under selection (for blinking purposes)

    // Guess
    guess guess(
        .clk(four_hundred_hz),
        .enable(!mode),
        .left(left),
        .right(right),
        .up(up),
        .down(down),
        .led_zero(guess0),
        .led_one(guess1),
        .led_two(guess2),
        .led_three(guess3),
        .sel_led(sel_led)
    );

    // History
    wire [2:0] history0, history1, history2, history3;
    wire last_turn;
    wire game_over;

    history hist(
        .clk(clk),
        .mode(sw),
        .reset(game_over),
        .btn_up(up),
        .btn_down(down),
        .btn_select(select),
        .guess3(guess3),
        .guess2(guess2),
        .guess1(guess1),
        .guess0(guess0),
        .selection3(history3),
        .selection2(history2),
        .selection1(history1),
        .selection0(history0),
        .selected_turn(turn),
        .last_turn(last_turn)
    );

    turn turn_convert(
        .turn_count(turn),
        .sw_led(sw_led)
    );

    // Led Driver
    led_driver led_dr(
        .clk(four_hundred_hz),
        .blink_enable(!mode),
        .blink_led(sel_led),
        .guess_rgb0(guess0),
        .guess_rgb1(guess1),
        .guess_rgb2(guess2),
        .guess_rgb3(guess3),
        .history_rgb0(history0),
        .history_rgb1(history1),
        .history_rgb2(history2),
        .history_rgb3(history3),
        .rgb0_out(rgb0_out),
        .rgb1_out(rgb1_out),
        .rgb2_out(rgb2_out),
        .rgb3_out(rgb3_out)
    );

    // PRNG
    wire [2:0] code0, code1, code2, code3;
    prng code_creator(
        .clk(four_hundred_hz),
        .code0(code0),
        .code1(code1),
        .code2(code2),
        .code3(code3)
    );

    // Feedback
    wire [1:0] feedback0, feedback1, feedback2, feedback3;
    feedback feedback(
        .clk(one_hz_clk),
        .last_turn(last_turn),
        .code0(code0),
        .code1(code1),
        .code2(code2),
        .code3(code3),
        .history0(history0),
        .history1(history1),
        .history2(history2),
        .history3(history3),
        .ssd0(feedback0),
        .ssd1(feedback1),
        .ssd2(feedback2),
        .ssd3(feedback3),
        .game_over(game_over)
    );

    // Seven segment display
    wire [7:0] ssd0, ssd1, ssd2, ssd3;

    ssd_converter one_converter(
        .n(feedback0),
        .ssd(ssd0)
    );

    ssd_converter two_converter(
        .n(feedback1),
        .ssd(ssd1)
    );

    ssd_converter three_converter(
        .n(feedback2),
        .ssd(ssd2)
    );

    ssd_converter four_converter(
        .n(feedback3),
        .ssd(ssd3)
    );

    ssd_driver ssd_dr(
        .clk(four_hundred_hz),
        .digit1(ssd0),
        .digit2(ssd1),
        .digit3(ssd2),
        .digit4(ssd3),
        .cathode(seg),
        .anode(an)
    );

endmodule
