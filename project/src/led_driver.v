module led_driver(
    input wire clk,
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
    output reg [2:0] rgb0_out,
    output reg [2:0] rgb1_out,
    output reg [2:0] rgb2_out,
    output reg [2:0] rgb3_out
);

    initial begin
        rgb0_out <= 0;
        rgb1_out <= 0;
        rgb2_out <= 0;
        rgb3_out <= 0;
    end

    reg show = 0;

    always @(posedge clk) begin
        if (blink_enable == 1) begin // GUESS mode
            show <= ~show;
            if (!show) begin
                if (blink_led == 0) begin
                    rgb0_out <= 3'b000;
                    rgb1_out <= guess_rgb1;
                    rgb2_out <= guess_rgb2;
                    rgb3_out <= guess_rgb3;
                end
                if (blink_led == 1) begin
                    rgb0_out <= guess_rgb0;
                    rgb1_out <= 0;
                    rgb2_out <= guess_rgb2;
                    rgb3_out <= guess_rgb3;
                end
                if (blink_led == 2) begin
                    rgb0_out <= guess_rgb0;
                    rgb1_out <= guess_rgb1;
                    rgb2_out <= 3'b000;
                    rgb3_out <= guess_rgb3;
                end
                if (blink_led == 3) begin
                    rgb0_out <= guess_rgb0;
                    rgb1_out <= guess_rgb1;
                    rgb2_out <= guess_rgb2;
                    rgb3_out <= 3'b000;
                end
            end
            else begin          
                rgb0_out <= guess_rgb0;
                rgb1_out <= guess_rgb1;
                rgb2_out <= guess_rgb2;
                rgb3_out <= guess_rgb3;
            end
        end
        else begin // HISTORY mode
            rgb0_out <= history_rgb0;
            rgb1_out <= history_rgb1;
            rgb2_out <= history_rgb2;
            rgb3_out <= history_rgb3;
        end
     end

endmodule
