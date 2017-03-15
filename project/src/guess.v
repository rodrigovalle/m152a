`timescale 1ns / 1ps

module guess(
    input enable,
    input left,
    input right,
    input up,
    input down,
    output reg [2:0] led_zero,
    output reg [2:0] led_one,
    output reg [2:0] led_two,
    output reg [2:0] led_three,
    output reg [1:0] blink_led // which led should be blinking
);

    initial begin
        led_zero = 0;
        led_one = 0;
        led_two = 0;
        led_three = 0;
        blink_led = 0;
    end

    always @(enable or left or right or up or down) begin
        if (enable) begin 
            // Handle changing led
            if (left)
                blink_led = blink_led - 'b1;
            else if (right)
                blink_led = blink_led + 'b1;
            
            // Handle changing color
            if (up) begin
                if (blink_led == 0)
                    led_zero = led_zero + 'b1;
                else if (blink_led == 1)
                    led_one = led_one + 'b1;
                else if (blink_led == 2)
                    led_two = led_two + 'b1;
                else if (blink_led == 3)
                    led_three = led_three + 'b1;
            end

            else if (down) begin
                if (blink_led == 0)
                    led_zero = led_zero - 'b1;
                else if (blink_led == 1)
                    led_one = led_one - 'b1;
                else if (blink_led == 2)
                    led_two = led_two - 'b1;
                else if (blink_led == 3)
                    led_three = led_three - 'b1;
            end
        end
    end

endmodule
