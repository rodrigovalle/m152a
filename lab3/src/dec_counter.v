`timescale 1ns / 1ps

module dec_counter(
    input wire       clk,
    input wire       rst,
    output reg [3:0] count,
    output reg       c_out
);

    initial begin
        c_out = 0;
        count = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'b0000;
            c_out <= 0;
        end
        else begin
            if (count == 4'b 1001) begin
                count <= 4'b 0000;
                c_out <= 1;
            end
            else begin
                count <= count + 1;
                c_out <= 0;
            end
        end
    end

endmodule
