`timescale 1ns / 1ps

module guess_tb;
    reg enable;
    reg left;
    reg right;
    reg up;
    reg down;
    wire [2:0] led_zero;
    wire [2:0] led_one;
    wire [2:0] led_two;
    wire [2:0] led_three;
    wire [1:0] blink_led;

    initial begin
        enable  = 1;
        left    = 0;
        right   = 0;
        up      = 0;
        down    = 0;

        $monitor("----\n",
                 "LEDs: %d-%d-%d-%d\n", led_zero, led_one, led_two, led_three,
                 "Sel_led: %d, time %d\n", blink_led, $time);

        #1 right = 1;
        #1 right = 0;
        #1 up = 1;
        #1 up = 0;
        #1 right = 1;
        #1 right = 0;
        #1 right = 1;
        #1 right = 0;
        #1 up = 1;
        #1 up = 0;
        #1 right = 1;
        #1 right = 0;
        #1 right = 1;
        #1 right = 0;
        #1 $finish;
    end

    guess guess_test(
        .enable(enable),
        .left(left),
        .right(right),
        .up(up),
        .down(down),
        .led_zero(led_zero),
        .led_one(led_one),
        .led_two(led_two),
        .led_three(led_three),
        .blink_led(blink_led)
    );

endmodule
