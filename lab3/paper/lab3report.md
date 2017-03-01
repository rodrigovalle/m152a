% M152A Lab 3: Stopwatch
% Ryan Stenberg; Rodrigo Valle
% February 28, 2017


## Introduction
The stopwatch we designed has a basic clock that has two two-digit fields:
minutes and seconds, which are displayed on a four digit seven segment display.
Additional features of the stopwatch include:

  - **Adjust Mode**: entered when switch zero is flipped. In adjust mode, the
    currently selected field will visibly blink as the numbers in that field
    begin increasing at 2Hz. All other fields of the stopwatch will not be
    updated in adjust mode.

  - **Select**: switch one allows a user to select which field they wish to
    adjust in adjust mode. 

  - **Reset**: when the reset button is pressed, the clock will begin counting
    from zero.

  - **Pause**: when the pause button is pressed, it toggles the stopwatch's
    pause mode. In pause mode, the stopwatch's clock will stop counting seconds.


## Design

### Modules
Our design was modularized into the following components:

  - **clock_div**: a clock divider that accepted the 200 MHz FPGA master clock
    as input and divided it into a 1 Hz clock for the stopwatch to count
    seconds, a 2 Hz clock which was used for the "fast increment" during
    adjustment mode, a 4 Hz clock which was used for the display blinking, and
    a 400 Hz clock which was used to multiplex digits across each of the 4
    seven segment displays.

  - **dec_counter**: a clocked counter that simply counts to ten and supports
    reset.

  - **counter**: created using two dec_counters, this counter represents a
    field on our stopwatch clock (e.g. the minutes or seconds field).
      - inputs: takes a clock input which decides how fast to count, and a
        reset input which will cause the counter to begin counting from zero.
      - outputs: a tens place count and a ones place count which together
        represent a number. Also outputs a c_out, which will be set high
        whenever the counter overflows.

  - **debouncer**: a simple state machine to detect the falling edge of a noisy
    signal. It takes a button as input and waits until it registers a steady
    state followed by a drop off, and then synchronizes the debounced output on
    a clock edge.

  - **ssd_converter**: a simple combinational logic circuit which accepts
    a number as input and outputs the correct segments to light up on the seven
    segment display.

  - **blink**: this module sits between ssd_converter and ssd_driver and blinks
    input digits from ssd_converter on and off with the frequency of a given clock
    if the enable input is set high. Digits will not blink and simply pass through
    the module if the enable input is low.

  - **ssd_driver**: this module is responsible for multiplexing four seven
    segment display input signals across the 4 seven segment displays

  - **stopwatch**: the top level module which glues together the other modules
    we've specified here. It handles taking input from the physical FPGA controls
    and giving this input to submodules that need it (along with some control
    logic).


Document the design aspects including the basic description of the design,
modular architecture, interactions among modules, and interface of each major
module. You should include schematics for the system architecture. You can also
include figures for state machines and Verilog code when needed.

### Bugs
  - blink: wasn't blinking in adjust mode until we separated it out into a
    separate module, tried to do blink logic in ssd_converter.

  - off-by-one in counter: reset at 50 seconds instead of a minute

  - ssd_converter converted 6s into 5s.

  - reset wouldn't reset the tens in minutes or seconds


## Simulation Documentation
Document all simulation efforts (what requirments are tested and test cases),
document bugs found during simulation, and provide simulation waveforms.
Include all simulation testbench code source files.


## Conclusion
Summary of the design, difficulties you encountered, and how you dealt with
them.


<!-- for ryan:
 - draw the debouncer state machine
 - draw the modular architecture
-->
