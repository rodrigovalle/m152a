module counter(
);
    // count seconds for now, split into separate module and reuse for minutes
    wire 1Hz, 2Hz, 4Hz, 200Hz;
    wire [] count_ones;
    wire [] count_tens;
    wire c_out_ones, c_out_tens;

    clock_div cdiv(
        // inputs
        .clk(clk),
        .rst(btnR),
        .pause(btnS),

        // outputs
        .1Hz_clk(1Hz),
        .2Hz_clk(2Hz),
        .4Hz_clk(4Hz),
        .200Hz_clk(200Hz)
    )

    dec_counter ones_place (
        .clk(1Hz),
        .rst(btnR),
        .count(count_ones),
        .c_out(cout_ones)
    )
        
    assign rst_tens = btnR || (count_tens == 6);
    dec_counter tens_place (
        .clk(cout_ones),
        .rst(rst_tens),
    )

endmodule
