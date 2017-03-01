`timescale 1ns / 1ps

module clock_div_tb;
    reg clk;
    reg slow_clk;
    reg rst;
    wire two_hz;
    wire one_hz;
    wire four_hundred_hz;
    wire four_hz;

    initial begin
        clk = 0;
        slow_clk = 0;
        rst = 0;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always begin
        #100000000 slow_clk = ~slow_clk;
    end

    always @(posedge slow_clk) begin
        $display("---- time %t\n", $time,
                 "one_hz_clk: %d\n", one_hz);
        if (four_hundred_hz == 1)
            $finish;
    end

    clock_div clock_div_inst(
        .clk(clk),
        .rst(rst),
        .two_hz_clk(two_hz),
        .one_hz_clk(one_hz),
        .four_hundred_hz_clk(four_hundred_hz),
        .four_hz_clk(four_hz)
    );

endmodule
