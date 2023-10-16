// Setting timescale for the module
`timescale 1ns / 1ps

// Defining the processor module with a parameter for data width
module processor #(
    data_width = 32) // Data width parameter set to 32 bits
    (
    input logic clk, // Clock input
    reset, // Reset signal input
    output logic [31:0] data_out // 32-bit data output
);

    // Internal signal declarations for various control signals
    logic [6:0] opcode; // 7-bit opcode signal
    logic [3:0] ALU_operation; // 4-bit ALU operation signal
    logic [6:0] Funct7; // 7-bit Funct7 signal
    logic [2:0] Funct3; // 3-bit Funct3 signal

    // Instantiating the control unit module
    control_unit control_unit(); // Control unit submodule

    // Instantiating the datapath module
    datapath datapath(); // Datapath submodule

endmodule