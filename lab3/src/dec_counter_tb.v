`timescale 1ns / 1ps

module dec_counter_tb;
    reg clk;
    reg rst;
    wire       c_out;
    wire [3:0] count;

    initial begin
        clk = 0;
        rst = 0;
        #20 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin
        $display("----\n",
                 "count: %d\n", count,
                 "c_out: %b\n", c_out);
    end

    dec_counter counter(
        .clk(clk),
        .rst(rst),
        .count(count),
        .c_out(c_out)
    );

endmodule
