`timescale 1ns / 1ps

module processor #(
    data_width = 32)
    (input logic clk, reset,
    output logic [31:0] data_out);

logic [6:0] opcode;
logic [3:0] ALU_operation;
logic [6:0] Funct7;
logic [2:0] Funct3;

control_unit control_unit();

datapath datapath();

endmodule