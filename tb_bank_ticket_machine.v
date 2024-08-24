module tb_bank_ticket_machine;

    // Inputs
    reg clk; // Clock signal
    reg reset; // Reset signal
    reg [3:0] officer_button; // Input buttons for four officers

    // Outputs
    wire [6:0] seg_ticket; // 7-segment display output for ticket number
    wire [6:0] seg_officer; // 7-segment display output for officer number
    wire [6:0] seg_service; // 7-segment display output for service type
    wire [6:0] seg_waiting; // 7-segment display output for waiting customers

    // Instantiate the Unit Under Test (UUT)
    BankTicketMachine uut (
        .clk(clk), // Connect clock signal to UUT
        .reset(reset), // Connect reset signal to UUT
        .officer_button(officer_button), // Connect officer button input to UUT
        .seg_ticket(seg_ticket), // Connect ticket number display output from UUT
        .seg_officer(seg_officer), // Connect officer number display output from UUT
        .seg_service(seg_service), // Connect service type display output from UUT
        .seg_waiting(seg_waiting) // Connect waiting customers display output from UUT
    );

    initial begin
        // Initialize Inputs
        clk = 0; // Initialize clock to 0
        reset = 1; // Assert reset
        officer_button = 0; // Initialize officer button inputs to 0

        // Wait for global reset
        #20;
        reset = 0; // Deassert reset

        // Test No button pressed
        #50;
        // Display the current values of the 7-segment display outputs when no button is pressed
        $display("No button pressed: seg_ticket = %b, seg_officer = %b, seg_service = %b, seg_waiting = %b",
                 seg_ticket, seg_officer, seg_service, seg_waiting);

        // Test Officer 1 pressed
        #50;
        officer_button = 4'b0001; // Simulate pressing Officer 1 button
        #50;
        officer_button = 4'b0000; // Release Officer 1 button
        // Display the current values of the 7-segment display outputs after Officer 1 is pressed
        $display("Officer 1 pressed: seg_ticket = %b, seg_officer = %b, seg_service = %b, seg_waiting = %b",
                 seg_ticket, seg_officer, seg_service, seg_waiting);

        // Test Officer 2 pressed
        #50;
        officer_button = 4'b0010; // Simulate pressing Officer 2 button
        #50;
        officer_button = 4'b0000; // Release Officer 2 button
        // Display the current values of the 7-segment display outputs after Officer 2 is pressed
        $display("Officer 2 pressed: seg_ticket = %b, seg_officer = %b, seg_service = %b, seg_waiting = %b",
                 seg_ticket, seg_officer, seg_service, seg_waiting);

        // Test Officer 3 pressed
        #50;
        officer_button = 4'b0100; // Simulate pressing Officer 3 button
        #50;
        officer_button = 4'b0000; // Release Officer 3 button
        // Display the current values of the 7-segment display outputs after Officer 3 is pressed
        $display("Officer 3 pressed: seg_ticket = %b, seg_officer = %b, seg_service = %b, seg_waiting = %b",
                 seg_ticket, seg_officer, seg_service, seg_waiting);

        // Test Officer 4 pressed
        #50;
        officer_button = 4'b1000; // Simulate pressing Officer 4 button
        #50;
        officer_button = 4'b0000; // Release Officer 4 button
        // Display the current values of the 7-segment display outputs after Officer 4 is pressed
        $display("Officer 4 pressed: seg_ticket = %b, seg_officer = %b, seg_service = %b, seg_waiting = %b",
                 seg_ticket, seg_officer, seg_service, seg_waiting);

        // Finish simulation
        #50;
        $stop; // Stop the simulation
    end

    // Generate a 100MHz clock
    always #5 clk = ~clk; // Toggle clock signal every 5 time units to create a clock period of 10 time units (100MHz frequency)

endmodule
