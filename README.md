# Packet Adder - SystemVerilog OOP Testbench for learning purposes

This repository contains a simple RTL implementation of a pipelined packet adder and a complete Object-Oriented Programming (OOP) based testbench. This project was created primarily for **learning SystemVerilog OOP** concepts and modern verification methodologies.
## Learned concepts
Through building this testbench, the following SystemVerilog features and verification concepts were explored:
* **Object-Oriented Programming (OOP):** Building a modular testbench using classes (`env`, `test`, `driver`, `monitor`, `scoreboard`, `generator`).
* **Interfaces & Virtual Interfaces:** `packet_adder_if`.
* **Randomization & Constraints:** Generating constrained random stimulus using `rand` variables and `dist` constraints in the transaction item (`packet_adder_item`).
* **Inter-Process Communication:** Using `mailbox` to pass transaction objects between components.
* **Threads:** Utilizing `fork...join` blocks to run multiple verification components in parallel.
* **Verification Pipeline:** Constructing a standard verification architecture where data flows from Generator -> Driver -> DUT -> Monitor -> Scoreboard. (with a small exception needed for verification purposes - Driver -> Scoreboard)
## Project Structure
* `rtl/` - Contains the Design Under Test (DUT) and the interface.
  * `packet_adder.sv` - The pipelined adder module.
  * `packet_adder_if.sv` - interface with `modport` definition.
* `tb/` - Contains the OOP testbench components.
  * `tb_top.sv` - Top-level module instantiating the DUT, interface, and test.
  * `test.sv` / `env.sv` - Test and Environment setup.
  * `generator.sv` - Generates randomized transaction items, contains print method for debugging.
  * `driver.sv` - Drives transactions into the DUT via the virtual interface.
  * `monitor.sv` - Samples DUT signals and converts them back into transaction items.
  * `scoreboard.sv` - Compares expected results against actual DUT outputs.
  * `packet_adder_item.sv` - The transaction class with constraints.
## How to Run

To run this project, you will need a SystemVerilog-compatible simulator (I used Vivado 2017.4).
