`timescale 1ns / 1ps

module tb;
    reg clk = 0;
    reg seg
    initial begin
        #10 clk = ~clk; // 100 MHz master clock
        #10000 $finish;
    end

    initial begin
        $monitor("At time %-10t", $time,
                 "D = %-3b (%0d)  |      ",  D, D,
                 "S = %-3b    "           ,  S,
                 "E = %-3b (%0d)     "    ,  E, E,
                 "F = %-3b (%0d)     "    ,  F, F);

        //#1000 $finish;
    end

    // Instantiate the Unit Under Test (UUT)
    stopwatch uut (
        .clk(),
        .sw(),
        .btnS(),
        .btnR(),

        .seg(),
        .an()
    )

endmodule

