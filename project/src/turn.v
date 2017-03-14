module turn(
    input [2:0] turn_count,
    output reg [7:0] sw_led
);

    always @(turn_count) begin
       sw_led = 'b00000000;
       sw_led[turn_count] = 1;
    end
endmodule
