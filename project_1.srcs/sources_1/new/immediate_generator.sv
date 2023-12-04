`timescale 1ns / 1ps

module immediate_generator(
    input logic [31:0] inst_code, // Input instruction code
    output logic [31:0] Imm_out); // Output immediate value

    logic [4:0] srai; // Declaring srai variable for later use
    assign srai = inst_code[24:20]; // Assigning bits 24 to 20 of inst_code to srai

    always_comb
    case(inst_code[6:0]) // Checking the opcode bits of the instruction
        7'b0000011: // If opcode corresponds to '0000011'
        Imm_out = {inst_code[31]? {20{1'b1}}:20'b0 , inst_code[31:20]}; // Generate immediate value for load instructions
        7'b0010011: // If opcode corresponds to '0010011'
        begin
            if((inst_code[31:25]==7'b0100000&&inst_code[14:12]==3'b101)||(inst_code[14:12]==3'b001)||inst_code[14:12]==3'b101) // Checking for specific conditions
                Imm_out = {srai[4]? {27{1'b1}}:27'b0,srai}; // Generate immediate value for arithmetic right shift instructions
            else
                Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[31:20]}; // Generate immediate value for other instructions
        end
        7'b0100011: // If opcode corresponds to '0100011'
        Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[31:25], inst_code[11:7]}; // Generate immediate value for store instructions
        7'b1100011: // If opcode corresponds to '1100011'
        Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[7], inst_code[30:25],inst_code[11:8],1'b0}; // Generate immediate value for branch instructions
        7'b1100111: // If opcode corresponds to '1100111'
        Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[30:25], inst_code[24:21], inst_code[20]}; // Generate immediate value for jump and link instructions
        7'b0010111: // If opcode corresponds to '0010111'
        Imm_out = {inst_code[31]? 1'b1:1'b0 , inst_code[30:20], inst_code[19:12],12'b0}; // Generate immediate value for upper immediate instructions
        7'b0110111: // If opcode corresponds to '0110111'
        Imm_out = {inst_code[31:12], 12'b0}; // Generate immediate value for upper immediate instructions
        7'b0110111: // If opcode corresponds to '0110111'
        Imm_out = {inst_code[31:12], 12'b0}; // Generate immediate value for upper immediate instructions
        7'b1101111: // If opcode corresponds to '1101111'
        Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[19:12], inst_code[19:12],inst_code[20], inst_code[30:25],inst_code[24:21],1'b0}; // Generate immediate value for jump and link register instructions
        default                    :
        Imm_out = {32'b0}; // Default case, assign immediate value as 0
    endcase

endmodule