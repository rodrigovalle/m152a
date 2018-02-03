`timescale 1ns / 1ps

module debouncer(
    input wire clk,
    input wire btn_in,
    output reg btn_state = 0
);

    reg [15:0] btn_cnt = 0;
    reg sync0;
    reg sync1;

    wire idle = (btn_state == sync1);
    wire cnt_max = (btn_cnt == 16'hfff);

    always @(posedge clk) begin
        sync0 <= btn_in;
        sync1 <= sync0;

        if (idle)
            btn_cnt <= 0;
        else begin
            btn_cnt <= btn_cnt + 1;
            if (cnt_max)
                btn_state <= ~btn_state;
        end
    end

endmodule
