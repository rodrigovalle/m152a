`timescale 1ns / 1ps

module counter_tb;
    reg clk;
    reg rst;
    wire [3:0] count_ones;
    wire [3:0] count_tens;
    wire c_out;

    initial begin
        clk = 0;
        rst = 0;
        #50 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin
        $display("----\n",
                 "count: %d%d\n", count_tens, count_ones,
                 "c_out: %b\n", c_out);
    end

    counter counter_inst(
        .clk(clk),
        .rst(rst),
        .count_ones(count_ones),
        .count_tens(count_tens),
        .c_out(c_out)
    );

endmodule
