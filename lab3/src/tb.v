`timescale 1ns / 1ps

module tb;
    reg signed [11:0]  D;  // 12 bit reg to drive FPCVT
    wire               S;  // sign        (output from FPCVT)
    wire       [2:0]   E;  // exponent    (output from FPCVT)
    wire       [3:0]   F;  // significand (output from FPCVT)

    parameter INT_MIN = -2048; // 0xfff
    parameter INT_MAX = 2047;  // 0x7ff

    initial begin
        for (D = INT_MIN; D != INT_MAX; D = D + 1)
            #1;
        $finish;
    end

    initial begin
        $monitor("At time %-10t", $time,
                 "D = %-3b (%0d)  |      ",  D, D,
                 "S = %-3b    "           ,  S,
                 "E = %-3b (%0d)     "    ,  E, E,
                 "F = %-3b (%0d)     "    ,  F, F);

        //$dumpfile ("vars.vcd");
        //$dumpvars;
        //#1000 $finish;
    end

    // Instantiate the Unit Under Test (UUT)
    FPCVT uut (
        .D(D),
        .S(S),
        .E(E),
        .F(F)
    );
endmodule

