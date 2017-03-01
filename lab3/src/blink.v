module blink(
    input wire clk,
    input wire enable,
    input wire [7:0] digit1,
    input wire [7:0] digit2,
    output reg [7:0] digit1_out,
    output reg [7:0] digit2_out
);

    reg show = 0;

    always @(posedge clk) begin
        show <= ~show;
        if (enable && !show) begin
            digit1_out <= ~8'b00000000;
            digit2_out <= ~8'b00000000;
        end
        else begin          
            digit1_out <= digit1;
            digit2_out <= digit2;
        end
     end

endmodule
