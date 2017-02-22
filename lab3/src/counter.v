`timescale 1ns / 1ps

module counter(
    input clk,
    input rst,
    output wire [3:0] count_ones,
    output wire [3:0] count_tens,
    output reg c_out
);

    wire c_out_ones;
    reg rst_tens = 0;

    dec_counter ones_place (
        .clk(clk),
        .rst(rst_all),
        .count(count_ones),
        .c_out(c_out_ones)
    );

    dec_counter tens_place (
        .clk(c_out_ones),
        .rst(rst_tens),
        .count(count_tens),
        .c_out()
    );

    always @(posedge clk) begin
        rst_tens <= 0;
        c_out <= 0;

        if (rst || count_tens == 5)
            rst_tens <= 1;
        if (count_tens == 5 && count_ones == 9)
            c_out <= 1;
    end

endmodule
