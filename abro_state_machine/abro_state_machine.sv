// Please write a Verilog module named abro_state_machine based on the following specifications. The module must be implemented to pass the logic checks in the provided testbench file.

// Module Ports:
// Define the module with the exact following port names, directions, and bit widths:

// input clk: Clock signal.

// input rst_n: Active-low asynchronous reset signal.

// input A: 1-bit data input.

// input B: 1-bit data input.

// output O: 1-bit data output. (注意：已将 output reg O 改为 output O)

// output reg [3:0] State: 4-bit output representing the current state of the machine.

// State Definitions:
// For readability, use parameter to define the states with their specific binary encodings:

// S_IDLE = 4'b0001

// S_A = 4'b0010

// S_B = 4'b0100

// Sequential Logic (State Transitions):
// The entire sequential logic for state transitions should be contained within a single always @(posedge clk or negedge rst_n) block.

// Reset Logic:
// On an active-low rst_n (asynchronous reset), the State register must be forced to S_IDLE (4'b0001).

// State Transition Logic:
// On the rising edge of clk, the next state is determined by a combination of the current State and the inputs A and B. Use a case (State) statement to implement the following logic:

// S_IDLE:

// If A is 1 and B is 0, the next state is S_A.

// If A is 1 and B is 1, the next state is S_B.

// For all other input combinations, the next state remains S_IDLE.

// S_A:

// If A is 1 and B is 0, the next state is S_A.

// If A is 0 and B is 1, the next state is S_IDLE.

// For all other input combinations (A=0,B=0 or A=1,B=1), the next state is S_B.

// S_B:

// If A is 1 and B is 0, the next state is S_A.

// If A is 0 and B is 1, the next state is S_IDLE.

// For all other input combinations (A=0,B=0 or A=1,B=1), the next state remains S_B.

// default:

// To prevent latches and ensure safety, if the state is ever an invalid value, the next state should be S_IDLE.

// Combinational Output Logic:
// The output O is determined purely by the combinational logic of inputs A and B, independent of the current state.

// The output O must be 1 if and only if both A and B are 1.

// This logic must be implemented outside the always block using a continuous assignment. The implementation should be: assign O = A & B;

module binary_to_bcd_converter (
    input wire [4:0] binary_input, // 5-bit binary input (0-31)
    output reg [7:0] bcd_output     // 8-bit BCD output (tens and ones digits)
);
// Insert Codes

endmodule
