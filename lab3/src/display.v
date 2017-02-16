module display(
);

	reg 	[3:0] SSD;

	reg [6:0] cathodes;
	assign seg = cathodes
	assign seg[7] = 1;

	// Binary to SSD conversion
	always @(posedge clk or posedge btnR) begin
		if (btnR) begin
			// reset
			cathodes <= 7'b0000001; // 0
		end
		else begin
			case (SSD)
				4'b0000: cathodes <= 7'b0000001; // 0
				4'b0001: cathodes <= 7'b1001111; // 1
				4'b0010: cathodes <= 7'b0010010; // 2
				4'b0011: cathodes <= 7'b0000001; // 3
				4'b0100: cathodes <= 7'b0000110; // 4
				4'b0101: cathodes <= 7'b0100101; // 5
				4'b0110: cathodes <= 7'b0100000; // 6
				4'b0111: cathodes <= 7'b0001111; // 7
				4'b1000: cathodes <= 7'b0000000; // 8
				4'b1001: cathodes <= 7'b0000100; // 9
			endcase
		end
	end

