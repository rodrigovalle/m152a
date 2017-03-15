`timescale 1ns / 1ps

module debouncer(
    input wire clk,
    input wire btn_in,
    output reg btn_pressed = 0
);

    parameter DELAY = 65535;
    parameter BITS = 16;

    reg [BITS-1:0] btn_cnt = 0;
    reg sync;

    always @(posedge clk) begin
        sync <= btn_in;
        btn_pressed <= 0;

        if (sync == 0) begin
            btn_cnt <= 0;
        end
        else if (btn_cnt == DELAY) begin
            $display("%d", sync);
            btn_pressed <= sync;
        end
        else
            btn_cnt <= btn_cnt + 1;
    end

endmodule
