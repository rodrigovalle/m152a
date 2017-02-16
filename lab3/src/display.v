module display(
	input clk,
	input [3:0] ones_sec,
	input [3:0] tens_sec,
	input [3:0] ones_min,
	input [3:0] tens_min,
	output reg [7:0] cathodes,
	output reg	[3:0] anode
);

	reg [6:0] SSD;
	assign cathodes = SSD
	assign cathodes[7] = 1;

	// 4-counter to alternate anode
	// choose which input based on anode

	// Binary to SSD conversion
	always @(posedge clk or posedge btnR) begin
		if (btnR) begin
			// reset
			cathodes <= 7'b0000001; // 0
		end
		else begin
			case ()
				4'b0000: SSD <= 7'b0000001; // 0
				4'b0001: SSD <= 7'b1001111; // 1
				4'b0010: SSD <= 7'b0010010; // 2
				4'b0011: SSD <= 7'b0000001; // 3
				4'b0100: SSD <= 7'b0000110; // 4
				4'b0101: SSD <= 7'b0100101; // 5
				4'b0110: SSD <= 7'b0100000; // 6
				4'b0111: SSD <= 7'b0001111; // 7
				4'b1000: SSD <= 7'b0000000; // 8
				4'b1001: SSD <= 7'b0000100; // 9
			endcase
		end
	end

endmodule