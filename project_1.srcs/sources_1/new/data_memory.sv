`timescale 1ns / 1ps

module data_memory#(
    parameter DM_ADDRESS = 9 ,
    parameter DATA_W = 32
)(
    input logic clk, // Clock signal
    input logic MemRead , // Signal from control unit for memory read
    input logic MemWrite , // Signal from control unit for memory write
    input logic [2:0] MemAcc, // Memory access signal
    input logic [DM_ADDRESS -1:0] a , // Read / Write address - 9 LSB bits of the ALU output
    input logic [DATA_W -1:0] wd , // Write Data
    output logic [DATA_W -1:0] rd // Read Data
);

    logic [DATA_W-1:0] mem [(2**DM_ADDRESS)-1:0]; // Memory array

    // Initialize mem to zero
    initial begin
        integer i;
        for (i = 0; i < (2**DM_ADDRESS); i = i + 1) begin
            mem[i] = 32'b0; // Assuming 32-bit wide data
        end
    end

    always_comb begin
        if(MemRead)
            case(MemAcc) // Memory access cases
                3'b001: rd = mem[a]; // Load word
                3'b010: rd = {mem[a][15] ? {16{1'b1}}: {16{1'b0}}, mem[a][15:0]}; // Load half word
                3'b011: rd = {mem[a][7] ? {24{1'b1}}: {24{1'b0}}, mem[a][7:0]}; // Load byte
                3'b100: rd = {16'b0, mem[a][15:0]}; // Load half word unsigned
                3'b101: rd = {24'b0, mem[a][7:0]}; // Load byte unsigned
            endcase
    end

    always @(posedge clk) begin
        if (MemWrite)
            case(MemAcc) // Memory access cases
                3'b001: mem[a] = wd; // Store word
                3'b010: mem[a] = {wd[15] ? {16{1'b1}}: {16{1'b0}}, wd[15:0]}; // Store half word
                3'b011: mem[a] = {wd[7] ? {24{1'b1}}: {24{1'b0}}, wd[7:0]}; // Store byte
            endcase
    end

endmodule