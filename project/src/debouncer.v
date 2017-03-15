`timescale 1ns / 1ps

module debouncer(
    input wire clk,
    input wire btn_in,
    output reg btn_state,
    output reg btn_down,
    output reg btn_up
);

    reg btn_sync_0;
    reg btn_sync_1;

    always @(posedge clk) begin
        btn_sync_0 <= ~btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    reg [15:0] btn_count;

    wire btn_idle = (btn_state == btn_sync_1);
    wire btn_count_maxed = &btn_count;

    always @(posedge clk) begin
        if (btn_idle)
            btn_count <= 0;
        else begin
            btn_count <= btn_count + 16'd1;
            if(btn_count_maxed) btn_state <= ~btn_state;
        end

        btn_down = ~btn_idle & btn_count_maxed & ~btn_state;
        btn_up   = ~btn_idle & btn_count_maxed &  btn_state;
    end

endmodule
