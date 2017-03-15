`timescale 1ns / 1ps

module debouncer(
    input wire reset,
    input wire clk,
    input wire btn_in,
    output reg btn_pressed
);

    parameter DELAY = 16'hffff;
    parameter BITS = 16;

    reg [BITS-1:0] btn_cnt;
    reg sync;

    always @(posedge clk) begin
        if (reset) begin
            sync <= btn_in;
            btn_pressed <= btn_in;
            btn_cnt <= 0;
        end
        else if (btn_in != sync) begin
            sync <= btn_in;
            btn_cnt <= 0;
        end
        else if (btn_cnt == DELAY)
            btn_pressed <= sync;
        else
            btn_cnt <= btn_cnt + 1;
    end

endmodule
