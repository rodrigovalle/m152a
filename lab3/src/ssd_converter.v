`timescale 1ns / 1ps

module ssd_converter(
	input  wire [3:0] n,
	output reg  [7:0] ssd
);

	// Binary to seven segment display conversion
	always @(n) begin
        case (n)          // HGFEDCBA
            4'h0: ssd <= ~7'b00111111; // 0
            4'h1: ssd <= ~7'b00000110; // 1
            4'h2: ssd <= ~7'b01011011; // 2
            4'h3: ssd <= ~7'b01001111; // 3
            4'h4: ssd <= ~7'b01100110; // 4
            4'h5: ssd <= ~7'b01101101; // 5
            4'h6: ssd <= ~7'b01101101; // 6
            4'h7: ssd <= ~7'b00000111; // 7
            4'h8: ssd <= ~7'b01111111; // 8
            4'h9: ssd <= ~7'b01101111; // 9
        endcase
	end

endmodule
