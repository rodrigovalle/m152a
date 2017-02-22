`timescale 1ns / 1ps

/* ssd_driver
 *
 * takes an array of four digits and four corresponding anodes and cycles
 * through the four digits in a round robin fashion, displaying one at a time by
 * bringing the anode signal up
 */
module ssd_driver(
    input wire clk,
    input wire [7:0] digit1, // in order from right to left
    input wire [7:0] digit2,
    input wire [7:0] digit3,
    input wire [7:0] digit4,
    output reg [7:0] cathode,
    output reg [3:0] anode
);

    integer i = 0;
    integer i_last = 3;
    integer j;

    initial begin
        for (j = 0; j < 4; j++)
            anode[j] = 1;
    end

    always @(posedge clk) begin
        anode[i_last] <= 1;
        anode[i] <= 0;

        case (i)
            'd 0: cathode <= digit1;
            'd 1: cathode <= digit2;
            'd 2: cathode <= digit3;
            'd 3: cathode <= digit4;
        endcase

        i_last <= i;
        i = (i + 1) % 4;
    end

endmodule
