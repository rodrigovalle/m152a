`timescale 1ns / 1ps

module debounce_tb;
    reg clk;
    reg btn_in;
    wire btn_state;
    wire btn_pressed;

    initial begin
        clk = 0;
        btn_in = 0;

        $monitor("---- %d \n", $time,
                 "btn_pressed: %d\n", btn_pressed);

        #1     btn_in = 1;
        #65536 ;
        #65536 btn_in = 0;
        #100     $finish;
    end

    always begin
        #0.5 clk <= ~clk;
    end

    debouncer debounce_uut(
        .clk(clk),
        .btn_in(btn_in),
        .btn_pressed(btn_pressed)
    );

endmodule
