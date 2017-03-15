module test_tb;
    reg clk;
    reg sw;
    reg btnS;
    reg btnR;
    reg btnL;
    reg btnU;
    reg btnD;
    wire [7:0] seg;
    wire [3:0] an;
    wire [2:0] rgb0_out;
    wire [2:0] rgb1_out;
    wire [2:0] rgb2_out;
    wire [2:0] rgb3_out;
    wire [7:0] sw_led;

    // prng
    wire [2:0] code0, code1, code2, code3;
    
    // guess
    wire [2:0] guess0, guess1, guess2, guess3;
    
    // history
    wire [2:0] history0, history1, history2, history3;
    wire [1:0] sel_led;

    // feedback
    wire [1:0] feedback0, feedback1, feedback2, feedback3;
    wire game_over;

    // ssd_converter
    wire [7:0] ssd0, ssd1, ssd2, ssd3;

    initial begin
        clk = 0;
        sw = 0;
        btnS = 0;
        btnR = 0;
        btnL = 0;
        btnU = 0;
        btnD = 0;
        #134 $finish;
    end

    integer cnt = 0;

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin

        $display("----\n",
                 "RGBs:         %d-%d-%d-%d\n", rgb0_out, rgb1_out, rgb2_out, rgb3_out,
                 "Hidden code:  %d-%d-%d-%d\n", code0, code1, code2, code3,
                 "SSD:          %b-%b-%b-%b\n", ssd0, ssd1, ssd2, ssd3,
                 "SW_Led:       %b\n", sw_led,
                 "Game over: %b\n", game_over,
                 "Cnt:  %0d", cnt);

        // Increase index 0 guess by 2 (=2), then shift selection bit right (=1)
        if (cnt == 7)
            btnU <= 1;
        if (cnt == 9)  begin
            btnU <= 0;
            btnR <= 1;
        end
        if (cnt == 10)
            btnR <= 0;

        // Increase index 1 guess by 1 (= 1)
        if (cnt == 12)
            btnU <= 1;
        if (cnt == 13)
            btnU <= 0;

        // Increase index 1 guess by 1 (= 2)
        if (cnt == 15)
            btnU <= 1;
        if (cnt == 16)
            btnU <= 0;

        // Save guess (2-2-0-0) into history[0]
        if (cnt == 18)
            btnS <= 1;
        if (cnt == 19)
            btnS <= 0;

        // Increase index 1 guess by 1 (= 3)
        if (cnt == 22)
            btnU <= 1;
        if (cnt == 23)
            btnU <= 0;

        // Increase index 1 guess by 1 (= 4)
        if (cnt == 25)
            btnU <= 1;
        if (cnt == 26)
            btnU <= 0;

        // Save guess (2-4-0-0) into history[1]
        if (cnt == 28)
            btnS <= 1;
        if (cnt == 29)
            btnS <= 0;

        // Switch into history mode, RGBs should show history[1] (2-4-0-0)
        if (cnt == 33)
            sw <= 1;

        // Move down in history, show history[0] (2-2-0-0)
        if (cnt == 36)
            btnD <= 1;
        if (cnt == 37)
            btnD <= 0;

        // Switch into guess mode, RGBs should show (2-4-0-0)
        if (cnt == 40)
            sw <= 0;

        // Shift selection bit right (=2)
        if (cnt == 41)
            btnR <= 1;
        if (cnt == 42)
            btnR <= 0;

        // Increase index 2 guess by 2 (=2), then shift selection bit right (=3)
        if (cnt == 44)
            btnU <= 1;
        if (cnt == 46)  begin
            btnU <= 0;
            btnR <= 1;
        end
        if (cnt == 47)
            btnR <= 0;

        // Increase index 3 guess by 5 (=5), then shift selection bit right (=0)
        if (cnt == 50)
            btnU <= 1;
        if (cnt == 55) begin
            btnU <= 0;
            btnR <= 1;
        end
        if (cnt == 56)
            btnR <= 0;

        // Decrease index 0 guess by 2 (=0)
        if (cnt == 58)
            btnD <= 1;
        if (cnt == 60)
            btnD <= 0;

        // Make final "correct" guess
        if (cnt == 62)
            btnS <= 1;
        if (cnt == 63)
            btnS <=0;

        cnt = cnt + 1;

    end

    led_driver led_dr(
        .clk(clk),
        .blink_enable(!sw),
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

    wire [2:0] sel_turn;
    wire last_turn;

    history hist(
        // inputs
        .clk(clk),
        .mode(sw),
        .reset(1'b0),
        .btn_up(btnU),
        .btn_down(btnD),
        .btn_select(btnS),
        .guess0(guess0),
        .guess1(guess1),
        .guess2(guess2),
        .guess3(guess3),

        // outputs
        .selection0(history0),
        .selection1(history1),
        .selection2(history2),
        .selection3(history3),
        .selected_turn(sel_turn),
        .last_turn(last_turn)
    );

    guess guess_test(
        .clk(clk),
        .enable(!sw),
        .left(btnL),
        .right(btnR),
        .up(btnU),
        .down(btnD),
        .led_zero(guess0),
        .led_one(guess1),
        .led_two(guess2),
        .led_three(guess3),
        .sel_led(sel_led)
    );

    prng code_gen(
        .clk(clk),
        .rst(game_over),
        .code0(code0),
        .code1(code1),
        .code2(code2),
        .code3(code3)
    );

    feedback results(
        .clk(clk),
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

    ssd_converter two_hundred_converter(
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

    turn my_turn(
        .turn_count(sel_turn),
        .sw_led(sw_led)
    );



endmodule