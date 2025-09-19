// I am trying to create a Verilog model for a simulated dice roller. It must be named dice_roller and meet the following precise specifications to ensure it passes a provided testbench.

// Module Definition:

// Module Name: dice_roller

// Inputs:

// clk: Clock signal.

// rst_n: Active-low reset.

// die_select (2-bits): A reg of size [1:0] to select the die type.

// roll: A signal to trigger a single dice roll.

// Outputs:

// rolled_number (8-bits): A wire of size [7:0] that holds the result of the last roll.

// Functional Requirements:

// Synchronous Logic: All state changes, including reset and roll operations, must be synchronous to the rising edge of the clk signal.

// Reset Behavior: When the rst_n input is low (active reset), the rolled_number output must be immediately and asynchronously reset to 0. When rst_n goes high, the module should be ready to operate.

// Roll Trigger: A new dice roll should be initiated only on the rising edge of the roll input signal. The calculated rolled_number should be updated on the next rising clock edge and then held stable until the next roll is triggered, regardless of whether the roll signal stays high or goes low.

// Die Selection Mapping: The die_select input must map to the number of sides on the die according to the following table:

// 2'b00: 4-sided die

// 2'b01: 6-sided die

// 2'b10: 8-sided die

// 2'b11: 20-sided die

// Random Number Generation: The value of rolled_number must be a pseudo-random integer within the inclusive range of [1, N], where N is the number of sides determined by die_select.

// For a 4-sided die, the range is [1, 4].

// For a 6-sided die, the range is [1, 6].

// For an 8-sided die, the range is [1, 8].

// For a 20-sided die, the range is [1, 20].

// To achieve this, the logic should use an expression equivalent to ($random % N) + 1..

// How would I write a design that meets these specifications?

module dice_roller (
    // Inputs
    input             clk,
    input             rst_n,
    input      [1:0]  die_select,
    input             roll,

    // Outputs
    output reg [7:0]  rolled_number
);

  //Insert Codes

endmodule
