`timescale 1ns / 1ps

module guess(
    input clk,
    input enable,
    input left,
    input right,
    input up,
    input down,
    output reg [2:0] led_zero   = 0,
    output reg [2:0] led_one    = 0,
    output reg [2:0] led_two    = 0,
    output reg [2:0] led_three  = 0,
    output reg [1:0] sel_led    = 0
);

    always @(posedge clk) begin

        if (enable) begin 

            // Handle changing led
            if (left)
                sel_led = sel_led - 1;
            else if (right)
                sel_led = sel_led + 1;
            
            // Hanlde changing color
            if (up) begin
                if (sel_led == 0)
                    led_zero = led_zero + 1;
                else if (sel_led == 1)
                    led_one = led_one + 1;
                else if (sel_led == 2)
                    led_two = led_two + 1;
                else if (sel_led == 3)
                    led_three = led_three + 1;
            end
            else if (down) begin
                if (sel_led == 0)
                    led_zero = led_zero - 1;
                else if (sel_led == 1)
                    led_one = led_one - 1;
                else if (sel_led == 2)
                    led_two = led_two - 1;
                else if (sel_led == 3)
                    led_three = led_three - 1;
            end
        end
    end

endmodule
