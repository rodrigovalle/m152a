`timescale 1ns / 1ps

module ssd_converter(
	input [3:0] n,
	output wire [7:0] ssd
);

	assign ssd[7] = 1;

	// Binary to SSD conversion
	always @(n) begin
        case (n)
            4'b0000: ssd <= 7'b0000001; // 0
            4'b0001: ssd <= 7'b1001111; // 1
            4'b0010: ssd <= 7'b0010010; // 2
            4'b0011: ssd <= 7'b0000001; // 3
            4'b0100: ssd <= 7'b0000110; // 4
            4'b0101: ssd <= 7'b0100101; // 5
            4'b0110: ssd <= 7'b0100000; // 6
            4'b0111: ssd <= 7'b0001111; // 7
            4'b1000: ssd <= 7'b0000000; // 8
            4'b1001: ssd <= 7'b0000100; // 9
        endcase
	end

endmodule
