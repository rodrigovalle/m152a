`timescale 1ns / 1ps

module debouncer(
    input wire clk,
    input wire btn_in,
    output reg btn_state
);

    reg [2:0] hist;

    initial
        btn_state = 0;

    always @(posedge clk) begin
        hist <= {hist[1:0], btn_in};
        if (hist == 3'b110)
            btn_state <= 1;
        else
            btn_state <= 0;
    end

endmodule
