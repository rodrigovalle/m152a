`timescale 1ns / 1ps

module ssd_converter(
    input  wire [2:0] n,
    output reg  [7:0] ssd
);

    // Binary to seven segment display conversion
    always @(n) begin
        case (n)          // HGFEDCBA
            4'h0: ssd <= ~8'b00000000; // blank
            4'h1: ssd <= ~8'b00111111; // 0
            4'h2: ssd <= ~8'b01011110; // H
        endcase
    end

endmodule
