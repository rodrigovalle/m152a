module prng_tb;
    reg clk;
    wire [2:0] code0;
    wire [2:0] code1;
    wire [2:0] code2;
    wire [2:0] code3;

    initial begin
        clk = 0;
        #10 $finish;
    end

    always begin
        #1 clk = ~clk;
        $display("code: %b %b %b %b\n", code0, code1, code2, code3);
    end

    prng prng_uut(
        .clk(clk),
        .code0(code0),
        .code1(code1),
        .code2(code2),
        .code3(code3)
    );
endmodule
