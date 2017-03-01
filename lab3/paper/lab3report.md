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
  - blink.v: Blink logic was originally in ssd_converter module. This made it difficult to blink on and off at 4Hz while updating the seven segment display at 400Hz. As a result, our seven segment display wasn't blinking in adjust mode. Eventually we separated it out into its own module called blink.v which was placed as an intermediary between ssd_converter and ssd_driver. This allowed us to tell the ssd_drive to show nothing every 4Hz.

  - counter.v: Had an off by one error that caused our seconds and minutes to reset at 50 instead of 60. This was simply a comparison error in which we reset the tens spot once a positive clock edge hit and the tens digit became 5. This was fixed by changing this comparison to wait for 59 seconds/minutes before reseting to 0.

  - ssd_converter.v: Was converting all 6s to 5s so that our seven segment display counter up with the following sequence ...3,4,5,5,7,8... The bug was in the switch statement where we had accidentally routed binary 6 to the cathode display of 5. This was also a quick fix once we isolated this problem.

  - Reset: Pressing reset wouldn't reset the tens in minutes or seconds (the ones would get reset). This bug was in the counter.v module. We were only reseting the tens digit if the reset was being held down while the ones digit incremented from 9 -> 10 (overflow). Of course this never occured because when the reset button was pressed, the ones digit was set to 0 and could not increment. This was fixed by changing our if-else statements to allow reset to immediately reset both the ones and tens digits with the next clock cycle.


## Simulation Documentation
We tested all basic functionality of a stopwatch including couting up, reset, pause, adjust, and select (seconds & minutes). In doing so we kept an eye out for the following events and edge cases:
- adjust mode caused whichever set of digits (seconds/minutes) was selected to blink and increase at an elevated speed
- pause stopped the stopwatch from all increments until toggled back off
- the seven segment display showed all 10 possible digits correctly (0-9)
- the seven segment display rotated anodes quickly enough to appear to have a constant display to the human eye
- incrementing from 59 seconds to 1 minutes and also 59 minutes back to 0 minutes

We created testbenches for several individual modules. These test benches, along with the waveforms they produced are provided below.

counter.v
<TODO: counter waveform image here>
<TODO: counter_tb.v source code image here>

dec_counter.v
<TODO: dec_counter waveform image here>
<TODO: dec_counter_tb.v source code image here>

ssd_driver.v
<TODO: ssd_driver waveform image here>
<TODO: ssd_driver_tb.v source code image here>

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
