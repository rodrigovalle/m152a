// using the fibonacci_lsfr technique from
// http://stackoverflow.com/questions/14497877
`timescale 1ns / 1ps

module prng(
    input clk,
    input rst,
    output reg [2:0] code0,
    output reg [2:0] code1,
    output reg [2:0] code2,
    output reg [2:0] code3
);
    integer code_generated = 0;

    // our seed value (shhh, don't tell anyone)
    initial begin
        code0 = 3'b101;
        code1 = 3'b111;
        code2 = 3'b100;
        code3 = 3'b000;
    end

    wire [11:0] code = {code3, code2, code1, code0};
    reg  [11:0] code_next;

    /* unroll the LFSR loop for 12 random bits
     * taps are 4, 10, 11, 12 (bits 3, 9, 10, 11)
     * provides 4095 random numbers before repeating
     * this is a maximal according to wikipedia's table */
    always @(posedge clk) begin
        if (rst)
            code_generated = 0;

        if (!code_generated) begin
            code_next[11] = code[3]  ^ code[9]  ^ code[10] ^ code[11];
            code_next[10] = code[2]  ^ code[8]  ^ code[9]  ^ code[10];
            code_next[9]  = code[1]  ^ code[7]  ^ code[8]  ^ code[9];
            code_next[8]  = code[0]  ^ code[6]  ^ code[7]  ^ code[8];
            code_next[7]  = code[11] ^ code[5]  ^ code[6]  ^ code[7];
            code_next[6]  = code[10] ^ code[4]  ^ code[5]  ^ code[6];
            code_next[5]  = code[9]  ^ code[3]  ^ code[4]  ^ code[5];
            code_next[4]  = code[8]  ^ code[2]  ^ code[3]  ^ code[4];
            code_next[3]  = code[7]  ^ code[1]  ^ code[2]  ^ code[3];
            code_next[2]  = code[6]  ^ code[0]  ^ code[1]  ^ code[2];
            code_next[1]  = code[5]  ^ code[11] ^ code[0]  ^ code[1];
            code_next[0]  = code[4]  ^ code[10] ^ code[11] ^ code[0];

            code0 <= code_next[2:0];
            code1 <= code_next[5:3];
            code2 <= code_next[8:6];
            code3 <= code_next[11:9];

            code_generated = 1;
        end
    end

endmodule
