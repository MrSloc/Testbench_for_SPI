module dice_roller (
    // Inputs
    input             clk,
    input             rst_n,
    input      [1:0]  die_select,
    input             roll,

    // Outputs
    output reg [7:0]  rolled_number
);

    // Internal register to hold the number of sides for the selected die.
    reg [7:0] num_sides;

    // Internal register to detect the rising edge of the 'roll' signal.
    reg roll_prev;

    // Combinational logic to map die_select to the number of sides (N).
    // This block is sensitive to any change in the die_select input.
    always @(*) begin
        case (die_select)
            2'b00:   num_sides = 4;   // 4-sided die
            2'b01:   num_sides = 6;   // 6-sided die
            2'b10:   num_sides = 8;   // 8-sided die
            2'b11:   num_sides = 20;  // 20-sided die
            default: num_sides = 4;   // Default to a 4-sided die
        endcase
    end

    // Main sequential logic for reset and roll operations.
    // This block is sensitive to the rising edge of the clock and the
    // falling edge of the reset signal (asynchronous reset).
    always @(posedge clk or negedge rst_n) begin
        // Asynchronous active-low reset
        if (!rst_n) begin
            rolled_number <= 8'b0;
            roll_prev     <= 1'b0;
        end
        // Synchronous logic executed on the rising edge of the clock
        else begin
            // Store the current value of 'roll' to detect its edge in the next cycle.
            roll_prev <= roll;

            // Check for a rising edge on the 'roll' signal (current is 1, previous was 0).
            // This ensures a single roll per trigger pulse.
            if (roll && !roll_prev) begin
                // On a trigger, generate a pseudo-random number in the range [1, N].
                // ($random % N) gives a value from 0 to N-1. Add 1 to shift the range.
                rolled_number <= ($random % num_sides) + 1;
            end
            // If there is no roll trigger, 'rolled_number' holds its previous value
            // due to the nature of registered logic.
        end
    end

endmodule
