`timescale 1ns / 1ps

module history_tb;
    reg clk;
    reg mode;
    reg reset;
    reg up;
    reg down;
    reg select;
    reg [2:0] guess[3:0];
    wire [2:0] selection[3:0];
    wire [2:0] selected_turn;
    wire end_game;

    integer cnt = 0;

    initial begin
        clk    = 0;
        mode   = 0;
        up     = 0;
        down   = 0;
        select = 0;
        #40 $finish;
    end

    always begin
        #1 clk = ~clk;
    end

    always @(posedge clk) begin
        // try to go down in history before there's any history
        if (cnt == 0) begin
            mode <= 1;
            down <= 1;
        end

        if (cnt == 1) begin
            mode <= 0;
            guess[0] <= 'b001;
            guess[1] <= 'b001;
            guess[2] <= 'b001;
            guess[3] <= 'b001;
            select <= 1;
        end

        if (cnt == 2) begin
            mode <= 1;
        end

        $display("----\n",
                 "Selection: %d-%d-%d-%d\n", selection[0], selection[1], selection[2], selection[3],
                 "Selected Turn: %d\n", selected_turn,
                 "End Game: %d  Cnt: %0d", end_game, cnt);

        cnt = cnt + 1;
    end

    history history_test(
        // inputs
        .clk(clk),
        .mode(mode),
        .reset(reset),
        .btn_up(up),
        .btn_down(down),
        .btn_select(select),
        .guess0(guess[0]),
        .guess1(guess[1]),
        .guess2(guess[2]),
        .guess3(guess[3]),

        // outputs
        .selection0(selection[0]),
        .selection1(selection[1]),
        .selection2(selection[2]),
        .selection3(selection[3]),
        .selected_turn(selected_turn),
        .end_game(end_game)
    );

endmodule
