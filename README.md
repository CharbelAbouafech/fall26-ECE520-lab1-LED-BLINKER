# ECE 520/L – Lab 1: RGB LED Blinker
 
**Author:** Charbel Abouafech
 
## Overview
 
This lab blinks an RGB LED on the Zybo Z7 board using VHDL. A switch picks the color — red, green, or blue — and that color blinks once per second. The design was built in Vivado, checked in simulation, and then tested on the board.
 
## Design Summary
 
There are two VHDL modules. `blinking_led` is a clock divider that toggles its output once per second using the board's 125 MHz clock. `rgb_led_top` is the top-level module — it uses the switches to pick a color and turns that color's blink signal on or off.
 
`rgb_led_top` takes in the system clock, a reset button (BTN0), and three switches, and drives the three RGB output bits (red, green, blue). SW0 turns on red, SW1 turns on green, and SW2 turns on blue. If no switch is on, or more than one is on at the same time, the LED stays off. Pressing BTN0 resets the blink.
 
A testbench, `tb_rgb_led_top`, checks each switch, the no-switch case, the multiple-switch case, and the reset, all in simulation before testing on hardware.
 
## Verification and Results
 
Simulation confirmed each switch lights the right color, invalid switch combos keep the LED off, and reset works correctly. On the board, the LED blinked the right color at the right rate for each switch and stayed off otherwise. The design was demonstrated on the Zybo Z7 and checked off by the instructor.

<img width="2306" height="475" alt="image" src="https://github.com/user-attachments/assets/3bb2ad4d-edda-4060-887a-128fee5904fc" />
Fig 1: Blinking LED Test Case 1 & 2

<img width="2312" height="535" alt="image" src="https://github.com/user-attachments/assets/f4ed42ec-b531-4869-a5ce-26afca668c87" />
Fig 2: Blinking LED Test Case 3

<img width="2311" height="474" alt="image" src="https://github.com/user-attachments/assets/477bd950-b460-435b-bc00-c5c8f90ef803" />
Fig 3: Simulation results for RGB LED blinker design.

## Known Issues or Limitations
 
No known issues. The design works as intended on both simulation and hardware.
 
## References
 
Course lecture materials for ECE 520/L.
