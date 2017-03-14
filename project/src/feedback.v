`timescale 1ns / 1ps

module feedback(
    input wire clk,
    input wire last_turn,

    input wire [2:0] code0,
    input wire [2:0] code1,
    input wire [2:0] code2,
    input wire [2:0] code3,
    input wire [2:0] history0,
    input wire [2:0] history1,
    input wire [2:0] history2,
    input wire [2:0] history3,
    output reg [1:0] ssd0,
    output reg [1:0] ssd1,
    output reg [1:0] ssd2,
    output reg [1:0] ssd3,

    output reg game_over
);
    integer end_game_cnt = 0;
    integer game_is_ending = 0;

    integer direct_matches = 0;
    integer indirect_matches = 0;
    integer no_matches = 0;

    integer code0_matched = 0;
    integer code1_matched = 0;
    integer code2_matched = 0;
    integer code3_matched = 0;

    integer history0_matched = 0;
    integer history1_matched = 0;
    integer history2_matched = 0;
    integer history3_matched = 0;

    always @(code0 or code1 or code2 or code3 or history0 or history1 or history2 or history3) begin
        
        if (!game_is_ending) begin
            direct_matches = 0;
            indirect_matches = 0;
            no_matches = 0;

            code0_matched = 0;
            code1_matched = 0;
            code2_matched = 0;
            code3_matched = 0;

            history0_matched = 0;
            history1_matched = 0;
            history2_matched = 0;
            history3_matched = 0;

            // Check for direct matches
            if (code0 == history0) begin
                code0_matched = 1;
                history0_matched = 1;
                direct_matches += 1;
            end
            if (code1 == history1) begin
                code1_matched = 1;
                history1_matched = 1;
                direct_matches += 1;
            end
            if (code2 == history2) begin
                code2_matched = 1;
                history2_matched = 1;
                direct_matches += 1;
            end
            if (code3 == history3) begin
                code3_matched = 1;
                history3_matched = 1;
                direct_matches += 1;
            end

            // Check for indirect matches with code0
            if (code0_matched == 0) begin
                if (code0 == history1 && history1_matched == 0) begin
                    code0_matched = 1;
                    history1_matched = 1;
                    indirect_matches += 1;
                end
                else if (code0 == history2 && history2_matched == 0) begin
                    code0_matched = 1;
                    history2_matched = 1;
                    indirect_matches += 1;
                end
                else if (code0 == history3 && history3_matched == 0) begin
                    code0_matched = 1;
                    history3_matched = 1;
                    indirect_matches += 1;
                end
            end

            // Check for indirect matches with code1
            if (code1_matched == 0) begin
                if (code1 == history0 && history0_matched == 0) begin
                    code1_matched = 1;
                    history0_matched = 1;
                    indirect_matches += 1;
                end
                else if (code1 == history2 && history2_matched == 0) begin
                    code1_matched = 1;
                    history2_matched = 1;
                    indirect_matches += 1;
                end
                else if (code1 == history3 && history3_matched == 0) begin
                    code1_matched = 1;
                    history3_matched = 1;
                    indirect_matches += 1;
                end
            end

            // Check for indirect matches with code2
            if (code2_matched == 0) begin
                if (code2 == history0 && history0_matched == 0) begin
                    code2_matched = 1;
                    history0_matched = 1;
                    indirect_matches += 1;
                end
                else if (code2 == history1 && history1_matched == 0) begin
                    code2_matched = 1;
                    history1_matched = 1;
                    indirect_matches += 1;
                end
                else if (code2 == history3 && history3_matched == 0) begin
                    code2_matched = 1;
                    history3_matched = 1;
                    indirect_matches += 1;
                end
            end

            // Check for indirect matches with code3
            if (code3_matched == 0) begin
                if (code3 == history0 && history0_matched == 0) begin
                    code3_matched = 1;
                    history0_matched = 1;
                    indirect_matches += 1;
                end
                else if (code3 == history1 && history1_matched == 0) begin
                    code3_matched = 1;
                    history1_matched = 1;
                    indirect_matches += 1;
                end
                else if (code3 == history2 && history2_matched == 0) begin
                    code3_matched = 1;
                    history2_matched = 1;
                    indirect_matches += 1;
                end
            end

            no_matches = 4 - direct_matches - indirect_matches;


            // Provide feedback for ssd0
            if (direct_matches >= 1)
                ssd0 <= 2;
            else if (indirect_matches + direct_matches >= 1)
                ssd0 <= 1;
            else
                ssd0 <= 0;

            // Provide feedback for ssd1
            if (direct_matches >= 2)
                ssd1 <= 2;
            else if (indirect_matches + direct_matches >= 2)
                ssd1 <= 1;
            else
                ssd1 <= 0;

            // Provide feedback for ssd2
            if (direct_matches >= 3)
                ssd2 <= 2;
            else if (indirect_matches + direct_matches >= 3)
                ssd2 <= 1;
            else
                ssd2 <= 0;

            // Provide feedback for ssd3
            if (direct_matches == 4)
                ssd3 <= 2;
            else if (indirect_matches + direct_matches == 4)
                ssd3 <= 1;
            else
                ssd3 <= 0;

            if (last_turn)  begin
                game_is_ending = 1;
            end
        end
    end

    always @(posedge clk)   begin
        if (game_is_ending)
            end_game_cnt = end_game_cnt + 1;

        if (end_game_cnt == 4)
            game_over <= 1;
    end

endmodule
