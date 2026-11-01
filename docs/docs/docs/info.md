# B02 - 8-to-3 Priority Encoder

## 1. Project Overview

This project implements an 8-to-3 priority encoder
with a valid output flag.

The circuit is a combinational logic design.
It does not require a clock signal.

## 2. Functional Description

The circuit receives 8 input signals (ui_in[7:0])
and generates a 3-bit encoded output.

Input ui_in[7] has the highest priority,
while ui_in[0] has the lowest priority.

When multiple inputs are active,
the output represents the highest-priority active input.

The valid flag indicates whether at least one input is active.

## 3. Input and Output

### Inputs

- ui_in[7:0]: 8 input signals.

### Outputs

- uo_out[2:0]: 3-bit encoded index.
- uo_out[3]: Valid flag.
- uo_out[7:4]: Always zero.

## 4. Operating Principle

If no input is active, the valid flag is 0
and the encoded output is 000.

If one or more inputs are active,
the valid flag is 1 and the output represents
the highest-priority active input.

## 5. Verification

The design is verified using simulation.

All 256 possible input combinations are tested
to check the priority encoding and valid flag.
