`timescale 1ns / 1ps

module dec_counter(
    input wire       clk,
    input wire       rst,
    output reg [3:0] count,
    output reg       c_out
);

    always @(posedge clk) begin
        if (rst) begin
            count <= 4'b0000;
        end
        else begin
            if (count == 'd 9) begin
                count <= 4'b 0000;
                c_out <= 1;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(negedge clk) begin
        c_out <= 0;
    end

endmodule
