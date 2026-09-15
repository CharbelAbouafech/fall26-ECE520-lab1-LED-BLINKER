# ECE 520/L – Lab 1: RGB LED Blinker

**Author:** Charbel Abouafech

## Introduction

This lab implements a blinking RGB LED on the Zybo Z7 board using VHDL. A switch selects which color, red, green, or blue, blinks once per second. The design was built in Vivado, verified with a testbench in simulation, and then tested on the actual board.

## Design

The project has two main VHDL files. The first is `blinking_led`, a clock divider that toggles an output once per second using the 125 MHz system clock. The second is `rgb_led_top`, the top-level entity, which instantiates `blinking_led` and uses the switches to route the blink signal to one color.

The `rgb_led_top` entity has four ports. `sys_clk` is a 1-bit input carrying the 125 MHz system clock. `rst` is a 1-bit active-high input connected to BTN0 that synchronously resets the design. `sw` is a 3-bit input used to select the active color. `rgb_out` is a 3-bit output, where bit 0 drives red, bit 1 drives green, and bit 2 drives blue.

SW0 selects red, SW1 selects green, and SW2 selects blue. Only one switch may be active at a time. If no switch is active, or if more than one switch is active at the same time, the RGB LED stays off. Pressing BTN0 resets the blink counter.

A testbench, `tb_rgb_led_top`, was written to verify the design in simulation before moving to hardware. It tests each switch case individually (SW0, SW1, SW2), the no-switch-active case, the multiple-switches-active case, and the reset behavior.

## Results

Simulation waveforms confirmed that each switch correctly selected its color, that the LED turned off for invalid switch combinations, and that reset worked as expected. On hardware, the RGB LED blinked at the correct color and rate for each switch and stayed off otherwise. The design was demonstrated on the Zybo Z7 board and verified with the instructor.

<img width="2306" height="475" alt="image" src="https://github.com/user-attachments/assets/3bb2ad4d-edda-4060-887a-128fee5904fc" />
Fig 1: Blinking LED Test Case 1 & 2

<img width="2312" height="535" alt="image" src="https://github.com/user-attachments/assets/f4ed42ec-b531-4869-a5ce-26afca668c87" />
Fig 2: Blinking LED Test Case 3

<img width="2311" height="474" alt="image" src="https://github.com/user-attachments/assets/477bd950-b460-435b-bc00-c5c8f90ef803" />
Fig 3: Simulation results for RGB LED blinker design.

## Conclusion

This lab demonstrated how to build and verify a simple VHDL design that combines a reusable clock-divider module with switch-based control logic and the final result matched the expected behavior on the Zybo Z7 board.
