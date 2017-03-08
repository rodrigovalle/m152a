`timescale 1ns / 1ps

module guess_tb;
    reg clk;
    reg enable;
    reg left;
    reg right;
    reg up;
    reg down;
    wire [2:0] led_zero;
    wire [2:0] led_one;
    wire [2:0] led_two;
    wire [2:0] led_three;
    wire [1:0] sel_led;

    integer cnt = 0;

    initial begin
        clk     = 0;
        enable  = 1;
        left    = 0;
        right   = 0;
        up      = 1;
        down    = 0;
        #40 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin

        cnt += 1;

        // Test right
        if (cnt == 6 || cnt == 12 || cnt == 18 || cnt == 24)
            right <= 1;
        else
            right <= 0;

        // Test left
        if (cnt == 30)
            left <= 1;
        else
            left <= 0;

        // Test down
        if (cnt == 10) begin 
            down    <= 1;
            up      <= 0;
        end
        else begin
            down    <= 0;
            up      <= 1;
        end

        // Test enable
        if (cnt == 35)
            enable <= 0;

        $display("----\n",
                 "LEDs: %d-%d-%d-%d\n", led_zero, led_one, led_two, led_three,
                 "Sel_led: %d  Cnt: %0d", sel_led, cnt);
    end

    guess guess_test(
        .clk(clk),
        .enable(enable),
        .left(left),
        .right(right),
        .up(up),
        .down(down),
        .led_zero(led_zero),
        .led_one(led_one),
        .led_two(led_two),
        .led_three(led_three),
        .sel_led(sel_led)
    );

endmodule
