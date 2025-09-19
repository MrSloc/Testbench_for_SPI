module binary_to_bcd_converter (
    input wire [4:0] binary_input, // 5-bit binary input (0-31)
    output reg [7:0] bcd_output     // 8-bit BCD output (tens and ones digits)
);

    // This is a purely combinational circuit. The output depends only on the
    // current input. The always @(*) block ensures that the code inside is
    // re-evaluated whenever 'binary_input' changes.
    always @(*) begin
        // Use a case statement to implement a lookup table. This is very
        // efficient for a small number of inputs like this.
        case (binary_input)
            // Values 0-9: Tens digit is 0
            5'd0:  bcd_output = 8'h00;
            5'd1:  bcd_output = 8'h01;
            5'd2:  bcd_output = 8'h02;
            5'd3:  bcd_output = 8'h03;
            5'd4:  bcd_output = 8'h04;
            5'd5:  bcd_output = 8'h05;
            5'd6:  bcd_output = 8'h06;
            5'd7:  bcd_output = 8'h07;
            5'd8:  bcd_output = 8'h08;
            5'd9:  bcd_output = 8'h09;

            // Values 10-19: Tens digit is 1
            5'd10: bcd_output = 8'h10;
            5'd11: bcd_output = 8'h11;
            5'd12: bcd_output = 8'h12;
            5'd13: bcd_output = 8'h13;
            5'd14: bcd_output = 8'h14;
            5'd15: bcd_output = 8'h15;
            5'd16: bcd_output = 8'h16;
            5'd17: bcd_output = 8'h17;
            5'd18: bcd_output = 8'h18;
            5'd19: bcd_output = 8'h19;

            // Values 20-29: Tens digit is 2
            5'd20: bcd_output = 8'h20;
            5'd21: bcd_output = 8'h21;
            5'd22: bcd_output = 8'h22;
            5'd23: bcd_output = 8'h23;
            5'd24: bcd_output = 8'h24;
            5'd25: bcd_output = 8'h25;
            5'd26: bcd_output = 8'h26;
            5'd27: bcd_output = 8'h27;
            5'd28: bcd_output = 8'h28;
            5'd29: bcd_output = 8'h29;

            // Values 30-31: Tens digit is 3
            5'd30: bcd_output = 8'h30;
            5'd31: bcd_output = 8'h31;

            // Although all 32 possible cases for a 5-bit input are covered,
            // it is good practice to include a default case. This prevents
            // the synthesis tool from inferring a latch if a case were missed.
            // Assigning 'x' helps catch unexpected behavior in simulation.
            default: bcd_output = 8'hXX;
        endcase
    end

endmodule
