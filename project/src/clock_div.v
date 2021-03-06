`timescale 1ns / 1ps

module clock_div(
    input clk,
    output reg four_hz_clk,
    output reg one_hz_clk,
    output reg four_hundred_hz_clk,
    output reg two_hundred_hz_clk
);

integer four_hz_cnt, one_hz_cnt, four_hundred_hz_cnt, two_hundred_hz_cnt;

// clk is 100 MHz or 100,000,000
always @ (posedge clk) begin
    four_hz_cnt <= four_hz_cnt + 1;
    one_hz_cnt <= one_hz_cnt + 1;
    four_hundred_hz_cnt <= four_hundred_hz_cnt + 1;
    two_hundred_hz_cnt <= two_hundred_hz_cnt + 1;  // for minute/second blinking


    // Manage 2 Hz clk
    if (four_hz_cnt == 25000000 - 1) begin
        four_hz_clk <= 1;
        four_hz_cnt <= 0;
    end
    else begin
        four_hz_clk <= 0;
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

    // Manage 200 Hz clk
    if (two_hundred_hz_cnt == 500000 - 1) begin
        two_hundred_hz_clk <= 1;
        two_hundred_hz_cnt <= 0;
    end
    else begin
        two_hundred_hz_clk <= 0;
    end
 end

endmodule
