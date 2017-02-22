`timescale 1ns / 1ps

module counter(
    input clk,
    input rst,
    output wire [3:0] count_ones,
    output wire [3:0] count_tens,
    output wire c_out
);

    wire c_out_ones, rst_tens;

    assign rst_tens = rst || (count_tens == 6);

    dec_counter ones_place (
        .clk(clk),
        .rst(rst),
        .count(count_ones),
        .c_out(c_out_ones)
    );

    dec_counter tens_place (
        .clk(c_out_ones),
        .rst(rst_tens),
        .count(count_tens),
        .c_out(c_out)
    );

endmodule
