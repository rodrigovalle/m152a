module ssd_driver_tb;
    reg clk;
    wire [7:0] cathode;
    wire [3:0] anode;

    reg [1:0] i;
    reg [1:0] j;
    reg [1:0] k;
    reg [1:0] l;

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
        # 20 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin
        if (i == 0)
            i = 2;
    end

    ssd_converter i_converter(
        .n(i),       // input
        .ssd(i_ssd)  // output
    );

    ssd_converter j_converter(
        .n(j),       // input
        .ssd(j_ssd)  // output
    );
    ssd_converter k_converter(
        .n(k),       // input
        .ssd(k_ssd)  // output
    );

    ssd_converter l_converter(
        .n(l),       // input
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
