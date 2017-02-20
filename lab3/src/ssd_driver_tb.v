lsmodule ssd_driver_tb;
    reg clk;
    wire [7:0] cathode;
    wire [3:0] anode;

    reg [3:0] i;
    reg [3:0] j;
    reg [3:0] k;
    reg [3:0] l;

    wire [7:0] i_ssd;
    wire [7:0] j_ssd;
    wire [7:0] k_ssd;
    wire [7:0] l_ssd;

    initial begin
        clk = 0;
        i = 0;
        j = 0;
        k = 0;
        l = 0;
        $monitor("At time: %t\n", $time,
                 "cathode: %b\n", cathode,
                 "anode: %b", anode);
        # 10000 $finish;
    end

    always begin
        #5 clk = ~clk;
    end

    ssd_converter i_converter(
        .n(i),       // input
        .ssd(i_ssd)  // output
    );

    ssd_converter j_converter(
        .n(i),       // input
        .ssd(j_ssd)  // output
    );
    ssd_converter k_converter(
        .n(i),       // input
        .ssd(k_ssd)  // output
    );

    ssd_converter l_converter(
        .n(i),       // input
        .ssd(l_ssd)  // output
    );

    ssd_driver driver(
        .clk(clk),
        .digit1(i_ssd),
        .digit2(j_ssd),
        .digit3(k_ssd),
        .digit4(l_ssd),
        .cathode(cathode),
        .anode(anode)
    );

endmodule
