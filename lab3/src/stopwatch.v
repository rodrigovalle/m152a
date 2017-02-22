`timescale 1ns / 1ps

module stopwatch(
    input           clk,
    input   [1:0]   sw,     // sw[0] = adj; sw[1] = sel;
    input           btnS,   // pause
    input           btnR,   // rst
    output  [7:0]   seg,    // Seven segments + decimal
    output  [3:0]   an      // Anodes for diplaying segments
    );

    wire one_hz, two_hz, four_hz, four_hundred_hz;
    wire rst, pause, adj, sel;

    debouncer rst_db(
        .clk(four_hundred_hz),
        .rst(),
        .btn_in(btnR),
        .btn_vld(rst)
    );

    debouncer pause_db(
        .clk(four_hundred_hz),
        .rst(),
        .btn_in(btnS),
        .btn_vld(pause)
    );

    debouncer adj_db(
        .clk(four_hundred_hz),
        .rst(),
        .btn_in(sw[0]),
        .btn_vld(adj)
    );

    debouncer sel_db(
        .clk(four_hundred_hz),
        .rst(),
        .btn_in(sw[1]),
        .btn_vld(sel)
    );

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

    // Logic to handle blinking during adj mode
    wire [0:0] ones_blink, mins_blink;
    assign ones_blink       = (adj && sel)  ? four_hz : 0;
    assign minutes_blink    = (adj && !sel) ? four_hz : 0;

    wire [7:0] digit1, digit2, digit3, digit4;

    ssd_converter sec_ones_convert(
        .n(ones_sec),
        //.blink(ones_blink),
        .ssd(digit1)
    );

    ssd_converter sec_tens_convert(
        .n(tens_sec),
        //.blink(ones_blink),
        .ssd(digit2)
    );

    ssd_converter min_ones_convert(
        .n(ones_min),
        //.blink(mins_blink),
        .ssd(digit3)
    );

    ssd_converter min_tens_convert(
        .n(tens_min),
        //.blink(mins_blink),
        .ssd(digit4)
    );

    ssd_driver driver(
        .clk(four_hundred_hz),
        .digit1(digit1),
        .digit2(digit2),
        .digit3(digit3),
        .digit4(digit4),
        .cathode(seg),
        .anode(an)
    );

endmodule
