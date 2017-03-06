# Mastermind

## Modes
In each mode, the input controls and output LEDs behave differently.

### History
The inputs/outputs behave as follows:

 - up/down cycles through history
 - switch leds should display the number of the turn being viewed
 - SSD should display hit/miss of the turn being viewed

### Guess
The inputs/ouputs behave as follows:

 - up/down changes the color
 - left/right changes the led being edited
 - the current led being edited should blink
 - middle button will send the guess to be evaulated

## Modules:

### prng.v
This is a standalone module that randomly generates 4 3 bit numbers, and stores
them. It takes an input that, when high, will cause the PRNG to regenerate the
numbers. Outputs wires to its internal register storing the random code.

### ssd_driver.v
This module takes 4 4-bit integers as input and a high-speed clock, and will
display these integers on the seven segment display.

This module depends on:

 - ssd_converter

### led_driver.v
This module will provide an interface for selecting colors for the LEDs. It
takes a pair of 4 3-bit inputs (pair for each of history and guess outputs, 4
for the colors of four LEDs, and 3 bits to represent a color) and a blink
selector to choose an LED to blink when in guess mode, and a blink enable wire
to choose whether to blink at all. Also a selector to choose between guess and
history modes.

This module depends on:

 - led_blink: responsible for blinking an individual LED.

### history.v
This module takes an enable switch, button up, button down, a guess, and a
submit input. When the submit input goes high, it reads in a guess and stores
it into a register. If enable is set high, the button up/down inputs change
which guess the module is displaying (sends the guess to feedback module and
display). History also will update the current switch LED with the turn that
the player is taking.

### guess.v
This module takes left/right/up/down buttons, and an enable wire. It allows
the user to edit a register internal to guess with specific colors that they
wish to guess. It outputs the current state of the guess to the leds through
mode_selector.

### feedback.v
This module takes an input guess (from history) and a register containing the
hidden code and compares them to determine how many corresponding Xs and Os to
display on the SSD.

### debouncer.v
borrow from last time without toggle state

### clock_div.v
 - 4Hz clock for blinking
 - 400Hz clock for debouncing/display

### mastermind (top)
Contains all the other modules. Takes the buttons/switch as input, outputs to
the switch LEDs, GPIO pins, and seven segment display.
