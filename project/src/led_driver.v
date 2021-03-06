module led_driver(
    input wire blink_clk,
    input wire blink_enable,
    input wire [1:0] blink_led,
    input wire [2:0] guess_rgb0,
    input wire [2:0] guess_rgb1,
    input wire [2:0] guess_rgb2,
    input wire [2:0] guess_rgb3,
    input wire [2:0] history_rgb0,
    input wire [2:0] history_rgb1,
    input wire [2:0] history_rgb2,
    input wire [2:0] history_rgb3,
    output wire [2:0] rgb0_out,
    output wire [2:0] rgb1_out,
    output wire [2:0] rgb2_out,
    output wire [2:0] rgb3_out
);

    reg blink = 0;

    assign rgb0_out = (blink_enable) ? ((!blink && blink_led == 0) ? 3'b000 : guess_rgb0) : history_rgb0;
    assign rgb1_out = (blink_enable) ? ((!blink && blink_led == 1) ? 3'b000 : guess_rgb1) : history_rgb1;
    assign rgb2_out = (blink_enable) ? ((!blink && blink_led == 2) ? 3'b000 : guess_rgb2) : history_rgb2;
    assign rgb3_out = (blink_enable) ? ((!blink && blink_led == 3) ? 3'b000 : guess_rgb3) : history_rgb3;

    always @(posedge blink_clk) begin
        blink <= ~blink;
    end

endmodule
