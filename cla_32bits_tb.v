// Set the timescale for the simulation
`timescale 1ns/1ns

module cla_32bits_tb;

    // Use a parameter for the adder's width for flexibility
    parameter WIDTH = 32;

    // Testbench signals
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic             ci;
    logic [WIDTH-1:0] s;
    logic             co;

    // For verification: a golden model and error tracking
    logic [WIDTH:0]   expected_result;
    integer           error_count;
    integer           test_count;

    // Golden Model: Use Verilog's built-in addition for a correct reference
    assign expected_result = a + b + ci;

    // Instantiate the Device Under Test (DUT)
    // This assumes your CLA module is named 'cla_32bits'
    cla_32bits u_cla_32bits (
        .a(a),
        .b(b),
        .ci(ci),
        .s(s),
        .co(co)
    );

    // Main test sequence block
    initial begin
        $display("--------------------------------------------------");
        $display("Starting verification of %0d-bit Carry-Lookahead Adder...", WIDTH);
        $display("--------------------------------------------------");

        error_count = 0;
        test_count = 0;

        // --- Test Phase 1: Directed Corner Cases ---
        $display("\nRunning Directed Corner Case Tests...");
        // Test zeros
        check_adder(0, 0, 0);
        check_adder(0, 0, 1);

        // Test max values (all bits set to 1)
        check_adder('1, '1, 0);
        check_adder('1, '1, 1);

        // Test carry propagation (a long chain of carries)
        check_adder('1, 1, 0); // 0xFFFF_FFFF + 1 should be 0x0000_0000 with carry-out
        check_adder(32'hAAAAAAAA, 32'h55555555, 0); // Alternating bits, sum should be all 1s

        // --- Test Phase 2: Randomized Testing ---
        $display("\nRunning 1000 Randomized Tests...");
        repeat (1000) begin
            // Generate random values for all inputs
            check_adder($random(), $random(), $random & 1);
        end
        
        // --- Final Report ---
        $display("\n--------------------------------------------------");
        if (error_count == 0) begin
            $display("All %0d cases passed!", test_count);
        end else begin
            $display("FAILED: %0d error(s) found in %0d total cases.", error_count, test_count);
        end
        $display("--------------------------------------------------");
        
        $finish;
    end

    // Reusable task to apply stimulus and check the result
    task check_adder(input [WIDTH-1:0] test_a, input [WIDTH-1:0] test_b, input test_ci);
        // 1. Apply the test case inputs
        a = test_a;
        b = test_b;
        ci = test_ci;

        // 2. Wait a small amount of time for the combinational logic to settle
        #1; 

        // 3. Compare DUT output against the golden model
        test_count++;
        if (s !== expected_result[WIDTH-1:0] || co !== expected_result[WIDTH]) begin
            // Use $error to report failures, which also increments the simulator's error count
            $error("FAIL: a=%h, b=%h, ci=%b", test_a, test_b, test_ci);
            $error("      -> DUT Output:   s=%h, co=%b", s, co);
            $error("      -> Expected:     s=%h, co=%b", expected_result[WIDTH-1:0], expected_result[WIDTH]);
            error_count++;
        end
    endtask

endmodule
