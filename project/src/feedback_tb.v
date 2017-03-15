module feedback_tb;
    reg clk;
    reg last_turn;
    reg [2:0] code0;
    reg [2:0] code1;
    reg [2:0] code2;
    reg [2:0] code3;
    reg [2:0] history0;
    reg [2:0] history1;
    reg [2:0] history2;
    reg [2:0] history3;
    wire [1:0] ssd0;
    wire [1:0] ssd1;
    wire [1:0] ssd2;
    wire [1:0] ssd3;
    wire game_over;

    integer cnt = 0;

    initial begin
        clk = 0;
        last_turn = 0;
        code0 = 0;
        code1 = 1;
        code2 = 2;
        code3 = 3;
        history0 = 0;
        history1 = 0;
        history2 = 0;
        history3 = 0;

        #10 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin
        
        $display("---------\n",
                 "SSD: %d-%d-%d-%d\n", ssd0, ssd1, ssd2, ssd3,
                 "Cnt: %0d", cnt);

        // Set history1 to correct
        if (cnt == 0)
            history1 = 1;

        // Set history2 to correct
        if (cnt == 1)
            history2 = 2;

        // Set history3 to correct
        if (cnt == 2)
            history3 = 3;

        cnt = cnt + 1;

    end

    
    feedback response(
        .clk(clk),
        .last_turn(last_turn),
        .code0(code0),
        .code1(code1),
        .code2(code2),
        .code3(code3),
        .history0(history0),
        .history1(history1),
        .history2(history2),
        .history3(history3),
        .ssd0(ssd0),
        .ssd1(ssd1),
        .ssd2(ssd2),
        .ssd3(ssd3),
        .game_over(game_over)
    );

endmodule