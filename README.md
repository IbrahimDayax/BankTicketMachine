# BankTicketMachine

## Overview
This project implements a digital ticketing system for a bank using Verilog HDL. The system is designed to manage and display ticket numbers, officer numbers, service types, and the number of waiting customers on seven-segment displays. The project was developed using Intel Quartus Prime for synthesis and ModelSim for simulation and verification.

## Table of Contents
- [Project Description](#project-description)
- [Design Modules](#design-modules)
- [Testbench](#testbench)
- [Simulation and Verification](#simulation-and-verification)
- [Tools Used](#tools-used)
- [Setup and Usage](#setup-and-usage)
- [Conclusion](#conclusion)

## Project Description
The Bank Ticket Machine project is a digital system that assigns tickets to customers and tracks service progress within a bank environment. It includes four primary components:
- **Ticket Number Display:** Displays the current ticket number.
- **Officer Number Display:** Shows the officer currently attending the customer.
- **Service Type Display:** Indicates the type of service the customer is receiving.
- **Waiting Customers Display:** Shows the number of customers waiting in the queue.

## Design Modules

### 1. `BankTicketMachine` (Top-Level Module)
This is the top-level module that integrates the entire system, including the FSM (Finite State Machine) and the seven-segment display modules. It handles the input signals from the officer buttons and controls the output to the seven-segment displays.

### 2. `fsm` (Finite State Machine Module)
The FSM controls the states of the system: IDLE, DISPENSE_TICKET, and UPDATE_DISPLAY. Based on the button pressed by an officer, the FSM transitions between states to update the ticket number, officer number, service type, and waiting customers count.

### 3. `seven_segment_display`
This module handles the conversion of binary values (ticket numbers, officer numbers, service types, and waiting customers) into the corresponding seven-segment display signals.

## Testbench
The testbench, `tb_bank_ticket_machine`, was developed to simulate and verify the functionality of the Bank Ticket Machine. It initializes the inputs, simulates button presses by officers, and checks the corresponding outputs on the seven-segment displays. The testbench verifies that the system correctly transitions through its states and updates the displays accordingly.

### Test Scenarios:
- **No Button Pressed:** The system remains in the IDLE state, with no changes to the display values.
- **Single Officer Button Pressed:** The FSM moves to DISPENSE_TICKET, increments the ticket number, updates the officer number, service type, and waiting customers.
- **Multiple Officer Buttons Pressed Sequentially:** The system is tested to ensure it correctly handles sequential button presses from different officers.

## Simulation and Verification
Simulation and verification were carried out using ModelSim. The steps involved were:

1. **Compilation:** 
   - The Verilog modules were compiled using Quartus Prime. The compilation log showed no errors and two warnings, which were investigated and confirmed to be non-critical.
   
2. **Simulation:**
   - The `tb_bank_ticket_machine` testbench was used to simulate the design. The simulation was run for 1000ns to observe the behavior of the system in response to various inputs.

3. **Waveform Analysis:**
   - Waveforms were generated in ModelSim to visually inspect the outputs (ticket number, officer number, service type, and waiting customers) in response to the simulated inputs. The waveforms confirmed that the FSM transitioned correctly through its states, and the outputs were as expected.

## Tools Used

### 1. **Intel Quartus Prime:**
   - Quartus Prime was used for synthesis and analysis of the Verilog HDL code. The project was synthesized to ensure that the design met the necessary hardware constraints and to generate a netlist for simulation.

### 2. **ModelSim:**
   - ModelSim was used for simulation and verification of the Verilog code. It provided a detailed analysis of the signals within the design, allowing for debugging and validation of the logic.

## Setup and Usage

### Prerequisites:
- **Intel Quartus Prime**
- **ModelSim**
- **Git** (optional, for version control)

### Steps to Run the Project:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/IbrahimDayax/BankTicketMachine.git
   cd BankTicketMachine
2. Open the Project in Quartus Prime:
   - Launch Quartus Prime.
   - Open the BankTicketMachine project file.
   - Compile the Design

3. Simulate in ModelSim:
   - Launch ModelSim.
   - Compile the design files.
   - Run the simulation using the testbench tb_bank_ticket_machine.
     
4. Analyze the waveforms to verify the correct operation.

## Conclusion
The Bank Ticket Machine project successfully demonstrates the use of Verilog HDL for implementing a digital ticketing system. Through the integration of a finite state machine and seven-segment displays, the system efficiently manages ticket dispensing and customer service tracking. The design was verified through simulation using ModelSim, ensuring that the system operates as intended under various test scenarios.
