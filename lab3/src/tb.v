`timescale 1ns / 1ps

module stopwatch_tb;
    reg clk = 0;
    reg [7:0] seg;

    initial begin
        #10000 $finish;
    end

    always begin
        #10 clk = ~clk; // 100 MHz master clock
    end

    initial begin
        $monitor("At time %-10t: seg(%b)", $time, seg);

        //#1000 $finish;
    end

    // Instantiate the Unit Under Test (UUT)
    stopwatch uut (
        .clk(clk),
        .sw(),
        .btnS(),
        .btnR(),

        .seg(seg),
        .an()
    );

endmodule
