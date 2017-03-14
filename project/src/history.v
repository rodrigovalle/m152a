`timescale 1ns / 1ps

module history(
    input wire clk,
    input wire mode,
    input wire reset,
    input wire btn_up,
    input wire btn_down,
    input wire btn_select,
    input wire [2:0] guess3, // what the current guess is
    input wire [2:0] guess2,
    input wire [2:0] guess1,
    input wire [2:0] guess0,
    output reg [2:0] selection3, // what to display
    output reg [2:0] selection2,
    output reg [2:0] selection1,
    output reg [2:0] selection0,
    output reg [2:0] selected_turn, // turn number to display
    output reg last_turn
);

    integer i;
    integer current_turn;

    reg first_turn;
    reg [3:0][2:0] history[7:0];

    initial begin
        current_turn = 0;
        last_turn = 0;
        first_turn = 1;
        selected_turn = 0;
    end

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 8; i = i + 1)
                history[i] = 'b000000000000;
            last_turn <= 0;
            current_turn = 0;
            selected_turn <= 0;
            first_turn <= 1;
        end

        else if (mode == 0) begin

            if (current_turn == 7)
                last_turn = 1;

            if (btn_select) begin // STORE GUESS
                history[current_turn] <= {guess3, guess2, guess1, guess0};
                selected_turn <= current_turn;
                current_turn <= current_turn + 1;
                first_turn <= 0;
            end
            else
                selected_turn <= current_turn - 1;
        end

        else if (mode == 1 && !first_turn) begin // HISTORY
            last_turn = 0;
            if (btn_up && selected_turn < current_turn)
                selected_turn <= selected_turn + 1;

            else if (btn_down && selected_turn > 0)
                selected_turn <= selected_turn - 1;
        end
    end

    always @(negedge clk) begin
        // guess mode: show most recent guess for the feedback module
        if (mode == 0) begin
            if (current_turn == 0) begin
                selection3 <= 0;
                selection2 <= 0;
                selection1 <= 0;
                selection0 <= 0;
            end
            else begin
                selection3 <= history[selected_turn][3];
                selection2 <= history[selected_turn][2];
                selection1 <= history[selected_turn][1];
                selection0 <= history[selected_turn][0];
            end
        end

        // history mode: show the currently selected mode if available
        else if (mode == 1) begin
            if (first_turn) begin
                selection3 <= 0;
                selection2 <= 0;
                selection1 <= 0;
                selection0 <= 0;
            end
            else begin
                selection3 <= history[selected_turn][3];
                selection2 <= history[selected_turn][2];
                selection1 <= history[selected_turn][1];
                selection0 <= history[selected_turn][0];
            end
        end
    end

endmodule
