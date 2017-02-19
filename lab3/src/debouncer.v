`timescale 1ns / 1ps

module debouncer(
    input clk,
    input rst,
    input btn_in,
    output reg btn_vld
);
	
	reg [2:0] hist = 0;

	always @(posedge clk)
     if (rst) begin
     		hist <= 0;
        	btn_vld <= 1'b0;
        end
     else if (clk)
       begin
       		hist <= {hist[1:0], btn_in};
        	if (hist == 2)
        		btn_vld <= 1;
        	else
        		btn_vld <= 0;
       end

endmodule
