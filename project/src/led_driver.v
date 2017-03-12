module led_driver(
    input wire clk,
    input wire blink_enable,
    input wire [1:0] blink_led,
    input wire [2:0] rgb1,
    input wire [2:0] rgb2,
    input wire [2:0] rgb3,
    input wire [2:0] rgb4,
    output reg [2:0] rgb1_out,
    output reg [2:0] rgb2_out,
    output reg [2:0] rgb3_out,
    output reg [2:0] rgb4_out
);

    reg show = 0;

    always @(posedge clk) begin
        show <= ~show;
        if (blink_enable && !show) begin
            if (blink_led == 0) begin
                rgb1_out <= 3'b000;
                rgb2_out <= rgb2;
                rgb3_out <= rgb3;
                rgb4_out <= rgb4;
            end
            if (blink_led == 1) begin
                rgb1_out <= rgb1;
                rgb2_out <= 3'b000;
                rgb3_out <= rgb3;
                rgb4_out <= rgb4;
            end
            if (blink_led == 2) begin
                rgb1_out <= rgb1;
                rgb2_out <= rgb2;
                rgb3_out <= 3'b000;
                rgb4_out <= rgb4;
            end
            if (blink_led == 3) begin
                rgb1_out <= rgb1;
                rgb2_out <= rgb2;
                rgb3_out <= rgb3;
                rgb4_out <= 3'b000;
            end
        end
        else begin          
            rgb1_out <= rgb1;
            rgb2_out <= rgb2;
            rgb3_out <= rgb3;
            rgb4_out <= rgb4;
        end
     end

endmodule
