module mastermind_tb;
    reg clk;
    reg sw;
    reg btnS;
    reg btnR;
    reg btnL;
    reg btnU;
    reg btnD;
    wire [7:0] seg;
    wire [3:0] an;
    wire [2:0] rgb0_out;
    wire [2:0] rgb1_out;
    wire [2:0] rgb2_out;
    wire [2:0] rgb3_out;
    wire [7:0] sw_led;

    initial begin
        clk = 0;
        sw = 0;
        btnS = 0;
        btnR = 0;
        btnL = 0;
        btnU = 1;
        btnD = 0;
        # 20 $finish;
    end

    integer cnt = 0;

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin

        $display("----\n",
                 "RGBs: %d-%d-%d-%d\n", rgb0_out, rgb1_out, rgb2_out, rgb3_out,
                 "Selected Turn: %b\n", sw_led);
        
        if (cnt == 0)
            btnU <= 1;
        if (cnt == 4)
            btnU <= 0;

        // if (cnt == 1) begin
        //     btnU <=0;
        // end

        // if (cnt == 2) begin
        //     btnS <= 1;
        // end

        // if (cnt == 4) begin
        //     btnS <= 0;
        // end

        cnt = cnt + 1;
    end

    mastermind project(
        .clk(clk),
        .sw(sw),
        .btnS(btnS),
        .btnR(btnR),
        .btnL(btnL),
        .btnU(btnU),
        .btnD(btnD),
        .seg(seg),
        .an(an),
        .rgb0_out(rgb0_out),
        .rgb1_out(rgb1_out),
        .rgb2_out(rgb2_out),
        .rgb3_out(rgb3_out),
        .sw_led(sw_led)
    );

endmodule
