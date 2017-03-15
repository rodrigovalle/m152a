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
    wire last_turn;

    integer i;
    integer cnt = 0;

    initial begin
        clk    = 0;
        mode   = 0;
        reset  = 0;
        up     = 0;
        down   = 0;
        select = 0;
        for (i = 0; i < 4; i = i+1)
            guess[i] = 'b000;
        #40 $finish;
    end

    always begin
        #0.5 clk = ~clk;
    end

    always @(posedge clk) begin
        if (cnt == 0) begin
            $display("making selection");
            // start in guess mode
            guess[0] <= 'b001;
            guess[1] <= 'b000;
            guess[2] <= 'b000;
            guess[3] <= 'b000;
        end

        if (cnt == 1) begin
            $display("confirming selection");
            select <= 1;
        end

        if (cnt == 2) begin
            $display("checking selection");
            select <= 0;
            // mode <= 1;
        end

        // if (cnt == 3) 
        //     mode <= 0;

        if (cnt == 6) begin
            $display("Another selection");
            guess[0] <= 'b000;
            guess[1] <= 'b001;
            guess[2] <= 'b000;
            guess[3] <= 'b000;
            select <= 1;
        end

        if (cnt == 7)
            select <= 0;

        if (cnt == 12) begin
            $display("History");
            mode <= 1;
        end

        if (cnt == 16) begin
            $display("Press down");
            down <= 1;
        end

        cnt = cnt + 1;
    end

    always @(negedge clk) begin
        
        $display("----\n",
                 "Selection: %d-%d-%d-%d\n", selection[0], selection[1], selection[2], selection[3],
                 "Selected Turn: %d\n", selected_turn,
                 "End Game: %d  Cnt: %0d\n\n", last_turn, cnt - 1);

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
        .last_turn(last_turn)
    );

endmodule
