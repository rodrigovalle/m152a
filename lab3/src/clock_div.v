`timescale 1ns / 1ps

module clock_div(
    input clk,
    input rst,
    output reg two_hz_clk,
    output reg one_hz_clk,
    output reg four_hundred_hz_clk,
    output reg four_hz_clk
);

integer two_hz_cnt, one_hz_cnt, four_hundred_hz_cnt, four_hz_cnt;

// clk is 100 MHz or 100,000,000
always @ (posedge clk) begin
    if (rst) begin
        two_hz_cnt  <= 0;
        one_hz_cnt  <= 0;
        four_hundred_hz_cnt <= 0;
        four_hz_cnt <= 0;

        two_hz_clk <= 0;
        one_hz_clk <= 0;
        four_hundred_hz_cnt <= 0;
        four_hz_clk <= 0;
    end
    else begin
        two_hz_cnt <= two_hz_cnt + 1;
        one_hz_cnt <= one_hz_cnt + 1;
        four_hundred_hz_cnt <= four_hundred_hz_cnt + 1;
        four_hz_cnt <= four_hz_cnt + 1;  // for minute/second blinking


        // Manage 2 Hz clk
        if (two_hz_cnt == 50000000 - 1) begin
            two_hz_clk <= 1;
            two_hz_cnt <= 0;
        end
        else begin
            two_hz_clk <= 0;
        end

        // Manage 1 Hz clk
        if (one_hz_cnt == 100000000 - 1) begin
            one_hz_clk <= 1;
            one_hz_cnt <= 0;
        end
        else begin
            one_hz_clk <= 0;
        end

        // Manage 400 Hz clk
        if (four_hundred_hz_cnt == 250000 - 1) begin
            four_hundred_hz_clk <= 1;
            four_hundred_hz_cnt <= 0;
        end
        else begin
            four_hundred_hz_clk <= 0;
        end

        // Manage 4 Hz clk
        if (four_hz_cnt == 25000000 - 1) begin
            four_hz_clk <= 1;
            four_hz_cnt <= 0;
        end
        else begin
            four_hz_clk <= 0;
        end
    end
 end

endmodule
