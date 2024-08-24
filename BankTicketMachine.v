// Top-level module for the Bank Ticket Machine
module BankTicketMachine (
    input clk,                   // Clock input
    input reset,                 // Reset input
    input [3:0] officer_button,  // Input buttons for officers
    output [6:0] seg_ticket,     // 7-segment display output for ticket number
    output [6:0] seg_officer,    // 7-segment display output for officer number
    output [6:0] seg_service,    // 7-segment display output for service type
    output [6:0] seg_waiting     // 7-segment display output for waiting customers
);

    wire [6:0] ticket_number;        // Wire to carry ticket number
    wire [1:0] officer_number;       // Wire to carry officer number
    wire [3:0] waiting_customers;    // Wire to carry waiting customers count
    wire [1:0] service_type;         // Wire to carry service type

    // Instantiate FSM module
    fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .officer_button(officer_button),
        .ticket_number(ticket_number),
        .officer_number(officer_number),
        .waiting_customers(waiting_customers),
        .service_type(service_type)  // Connect service type
    );

    // Instantiate 7-segment display module
    seven_segment_display display_inst (
        .ticket_number(ticket_number),
        .officer_number(officer_number),
        .service_type(service_type),    // Connect service type
        .waiting_customers(waiting_customers),  // Connect waiting customers
        .seg_ticket(seg_ticket),
        .seg_officer(seg_officer),
        .seg_service(seg_service),      // Connect service type display
        .seg_waiting(seg_waiting)       // Connect waiting customers display
    );

endmodule


// FSM (Finite State Machine) module to handle state transitions
module fsm (
    input clk,                    // Clock input
    input reset,                  // Reset input
    input [3:0] officer_button,   // Input buttons for officers
    output reg [6:0] ticket_number,      // Output register for ticket number
    output reg [1:0] officer_number,     // Output register for officer number
    output reg [3:0] waiting_customers,  // Output register for waiting customers
    output reg [1:0] service_type        // Output register for service type
);

    // State encoding using parameters
    parameter IDLE = 2'b00, DISPENSE_TICKET = 2'b01, UPDATE_DISPLAY = 2'b10;
    
    reg [1:0] current_state, next_state;  // Registers for current and next state

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;  // Reset state to IDLE
        else
            current_state <= next_state;  // Transition to next state
    end

    // Next state logic and outputs
    always @(*) begin
        next_state = current_state;  // Default to current state
        case (current_state)
            IDLE: begin
                if (officer_button != 4'b0000) begin
                    next_state = DISPENSE_TICKET;  // Move to DISPENSE_TICKET state if any button is pressed
                end else begin
                    next_state = IDLE;  // Remain in IDLE state if no button is pressed
                end
            end
            DISPENSE_TICKET: begin
                next_state = UPDATE_DISPLAY;  // Move to UPDATE_DISPLAY state after dispensing ticket
            end
            UPDATE_DISPLAY: begin
                next_state = IDLE;  // Move back to IDLE state after updating display
            end
            default: begin
                next_state = IDLE;  // Default state is IDLE
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ticket_number <= 7'b0000000;  // Reset ticket number
            waiting_customers <= 4'b0000;  // Reset waiting customers count
            officer_number <= 2'b00;  // Reset officer number
            service_type <= 2'b00;  // Default to Service A
        end else if (current_state == DISPENSE_TICKET) begin
            ticket_number <= ticket_number + 1;  // Increment ticket number
            waiting_customers <= waiting_customers + 1;  // Increment waiting customers count
            // Update officer number based on which button is pressed
            officer_number <= (officer_button[0]) ? 2'b00 :
                              (officer_button[1]) ? 2'b01 :
                              (officer_button[2]) ? 2'b10 :
                              (officer_button[3]) ? 2'b11 : officer_number;
            // Update service type based on which button is pressed
            service_type <= (officer_button[0]) ? 2'b00 :  // Service A
                            (officer_button[1]) ? 2'b01 :  // Service B
                            (officer_button[2]) ? 2'b10 :  // Service C
                            (officer_button[3]) ? 2'b11 : service_type;  // Service D
        end else begin
            // Retain current values when no state change
            ticket_number <= ticket_number;
            waiting_customers <= waiting_customers;
            officer_number <= officer_number;
            service_type <= service_type;
        end
    end

endmodule


// Module for 7-segment display logic
module seven_segment_display (
    input [6:0] ticket_number,      // Input ticket number
    input [1:0] officer_number,     // Input officer number
    input [1:0] service_type,       // Input service type
    input [3:0] waiting_customers,  // Input waiting customers count
    output reg [6:0] seg_ticket,    // Output for ticket number display
    output reg [6:0] seg_officer,   // Output for officer number display
    output reg [6:0] seg_service,   // Output for service type display
    output reg [6:0] seg_waiting    // Output for waiting customers display
);

    // 7-segment encoding for ticket number
    always @(*) begin
        case (ticket_number)
            7'b0000000: seg_ticket = 7'b1000000; // Display 0
            7'b0000001: seg_ticket = 7'b1111001; // Display 1
            7'b0000010: seg_ticket = 7'b0100100; // Display 2
            7'b0000011: seg_ticket = 7'b0110000; // Display 3
            7'b0000100: seg_ticket = 7'b0011001; // Display 4
            7'b0000101: seg_ticket = 7'b0010010; // Display 5
            7'b0000110: seg_ticket = 7'b0000010; // Display 6
            7'b0000111: seg_ticket = 7'b1111000; // Display 7
            default: seg_ticket = 7'b0000000;    // Default display is 0
        endcase
    end

    // 7-segment encoding for officer number
    always @(*) begin
        case (officer_number)
            2'b00: seg_officer = 7'b1000000; // Display 0
            2'b01: seg_officer = 7'b1111001; // Display 1
            2'b10: seg_officer = 7'b0100100; // Display 2
            2'b11: seg_officer = 7'b0110000; // Display 3
            default: seg_officer = 7'b0000000; // Default display is 0
        endcase
    end

    // 7-segment encoding for service type
    always @(*) begin
        case (service_type)
            2'b00: seg_service = 7'b1110111; // Display A
            2'b01: seg_service = 7'b0011100; // Display B
            2'b10: seg_service = 7'b0000110; // Display C
            2'b11: seg_service = 7'b0100001; // Display D
            default: seg_service = 7'b0000000; // Default display is 0
        endcase
    end

    // 7-segment encoding for waiting customers
    always @(*) begin
        case (waiting_customers)
            4'b0000: seg_waiting = 7'b1000000; // Display 0
            4'b0001: seg_waiting = 7'b1111001; // Display 1
            4'b0010: seg_waiting = 7'b0100100; // Display 2
            4'b0011: seg_waiting = 7'b0110000; // Display 3
            4'b0100: seg_waiting = 7'b0011001; // Display 4
            4'b0101: seg_waiting = 7'b0010010; // Display 5
            4'b0110: seg_waiting = 7'b0000010; // Display 6
            4'b0111: seg_waiting = 7'b1111000; // Display 7
            default: seg_waiting = 7'b0000000; // Default display is 0
        endcase
    end

endmodule
