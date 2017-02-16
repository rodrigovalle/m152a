module counter(
    input clk,
    input rst,
    output reg [3:0] count_ones,
    output reg [3:0] count_tens,
    output reg c_out
);

    wire c_out_ones;

    // ****** Seconds ******
    dec_counter ones_place (
        .clk(clk),
        .rst(rst),
        .count(count_ones),
        .c_out(c_out_ones)
    )

    assign rst_tens = rst || (count_tens == 6);

    dec_counter tens_place (
        .clk(c_out_ones),
        .rst(rst_tens),
        .count(count_tens),
        .c_out(c_out)
    )

endmodule
