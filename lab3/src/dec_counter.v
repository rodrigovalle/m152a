module dec_counter(
    input clk,
    input rst,
    output reg [3:0] count,
    output reg       c_out,
);

count = 0;

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
    end
    else begin
        if (count == 'd 9) begin
            count <= 0;
            c_out <= 1;
        end
        else begin
            count <= count + 1;
        end
    end
end

always @(negedge clk) begin
    c_out <= 0
end

endmodule
