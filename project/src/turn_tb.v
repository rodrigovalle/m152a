module turn_tb;
    reg [2:0] count;
    wire [7:0] leds;

    initial begin
        count = 'b011;
        #10 $display("%d: %b", count, leds);
    end

    turn turn_uut(
        .turn_count(count),
        .sw_led(leds)
    );
endmodule
