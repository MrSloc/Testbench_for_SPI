// I am trying to create a Verilog model for a sequence detector using a Mealy state machine. It must meet the following specifications:

// Module Definition:

// Verilog
//   module sequence_detector (
//     input         clk,
//     input         reset_n,
//     input  [2:0]  data,
//     output reg    sequence_found
// );
// Sequence to be Detected:
// The detector must recognize the following 8-term sequence of 3-bit inputs received on consecutive clock cycles:

// 0b001

// 0b101

// 0b110

// 0b000

// 0b110

// 0b110

// 0b011

// 0b101

// Output Timing Requirements:

// The sequence_found output must go high (1'b1) for exactly one clock cycle.

// This assertion must be coincident with the arrival of the final correct value in the sequence (0b101).

// After a complete sequence is detected, the detector should reset on the next clock cycle to begin searching for a new, non-overlapping sequence.

// How would I write a Verilog design that meets these precise specifications?

module sequence_detector (
    input         clk,
    input         reset_n,
    input  [2:0]  data,
    output reg    sequence_found
);
