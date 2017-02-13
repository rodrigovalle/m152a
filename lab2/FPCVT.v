`timescale 1ns / 1ps

module FPCVT(
        input  wire [11:0] D,
        output reg         S,
        output reg  [2:0]  E,
        output reg  [3:0]  F
    );

    integer i, j, lead_zeroes;

    reg [11:0] mag;
    reg round_up;

    always @D begin
        S = D[11];

        // get magnitude
        if (S)
            mag = ~D + 1;
        else
            mag = D;
            
        // count leading zeroes
        lead_zeroes = 0;
        for (i = 11; i >= 0 && !mag[i] ; i = i-1)
            lead_zeroes = lead_zeroes + 1;

        // convert to exponent
        // TODO: edge case for most negative number
        // convert to largest possible floating point representation
        if (lead_zeroes < 8)
            E = 8 - lead_zeroes;
        else
            E = 0;

        // get significand
        F = mag >> E;
        round_up = E > 0 ? mag >> (E-1) : 0; // if E == 0, don't round

        // round
        if (round_up && F == 4'b 1111) begin
            F = 4'b 1000;

            if (E == 3'b 111)
                F = 4'b 1111;
            else
                E = E + 1;
        end
        else
            F = F + round_up;

        // edge case for most negative number
        if (lead_zeroes == 0) begin
            E = 3'b 111;
            F = 4'b 1111;
        end
    end
endmodule
