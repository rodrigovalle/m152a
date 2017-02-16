module counter(
    input clk,
    input rst,
    output reg [5:0] minute,
    output reg [5:0] second
);

always @ (posedge clk) begin
		if (rst) begin
			minute <= 0;
			second <= 0;
		end
		else begin
			if (second == 6'b 111100) begin
				second <= 0;
				minute <= minute + 1;
			end
			else begin
				second <= second + 1;
			end
		end
	end

endmodule
