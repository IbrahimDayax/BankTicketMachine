# Bank Ticket Machine

## Overview

This project implements a Bank Ticket Machine using Verilog. The system is designed to manage a ticketing process in a bank environment where multiple officers serve customers. The project simulates a Finite State Machine (FSM) that dispenses tickets, updates display units for both the ticket number and officer information, and tracks the number of waiting customers.

## Project Structure

The project is organized into the following modules:

- **BankTicketMachine**: The top-level module that integrates the FSM and 7-segment display modules.
- **fsm**: The Finite State Machine responsible for ticket dispensing and state management.
- **seven_segment_display**: This module handles the 7-segment display encoding for ticket numbers, officer numbers, service types, and the number of waiting customers.

## Features

- **FSM Implementation**: The FSM has three states: `IDLE`, `DISPENSE_TICKET`, and `UPDATE_DISPLAY`. It manages the ticket dispensing process based on the officer's input.
- **7-Segment Display Encoding**: Four 7-segment displays show the ticket number, officer number, service type, and waiting customers. 
- **Verilog Testbench**: A comprehensive testbench is provided to simulate and verify the functionality of the system.

## Simulation

The project includes a testbench (`tb_bank_ticket_machine`) that simulates the behavior of the Bank Ticket Machine. It tests different scenarios such as:

- No button pressed
- Pressing each officer's button one at a time

The simulation outputs the state of the 7-segment displays after each action.

## Usage

### Prerequisites

- A Verilog simulator like ModelSim or any compatible tool.
- A basic understanding of Verilog and FSM design.

### Running the Simulation

1. Clone this repository:
   ```bash
   git clone https://github.com/ibrahimdayax/BankTicketMachine.git
   cd BankTicketMachine

2. Open the project in your Verilog simulation environment.

3. Compile the Verilog files:
   `BankTicketMachine.v`
   `tb_bank_ticket_machine.v`

4. Run the Modelsim RTL simulation using the testbench file tb_bank_ticket_machine.v.

5. Observe the simulation results and verify the outputs on the 7-segment displays.  
