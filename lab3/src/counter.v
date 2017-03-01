`timescale 1ns / 1ps

module counter(
    input clk,
    input rst,
    output wire [3:0] count_ones,
    output wire [3:0] count_tens,
    output reg c_out
);

    wire c_out_ones;
    reg rst_tens;

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
        .c_out()
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rst_tens <= 1;
            c_out <= 0;
        end
        else if (count_tens == 5 && count_ones == 9) begin
            rst_tens <= 1;
            c_out <= 1;
        end
        else begin
            c_out <= 0;
            rst_tens <= 0;
        end
    end

endmodule
