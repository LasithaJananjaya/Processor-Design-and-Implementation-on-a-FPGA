`timescale 1ns / 1ps

module data_interpreter
    #(parameter WIDTH = 32)
    (input logic [WIDTH-1:0] inst, // Input instruction
    input logic [WIDTH-1:0] data, // Input data
    output logic [WIDTH-1:0] y); // Output data
    logic [31:0] Imm_out; // Intermediate variable for immediate values
    logic [15:0] s_bit; // Extracting lower bits of 'data' for manipulation
    logic [7:0] e_bit; // Extracting bits from 'data' for manipulation
    assign s_bit = data[15:0]; // Assigning lower bits of 'data' to 's_bit'
    assign e_bit = data[7:0]; // Assigning bits of 'data' to 'e_bit'

    // Combinational logic block to interpret data
    always_comb
    begin
        Imm_out = {inst[31]? {20{1'b1}}:{20{1'b0}}, inst[31:20]}; // Creating immediate values based on instruction
        if(inst[6:0] == 7'b0000011) // Checking for specific instruction type
            begin
                if(inst[14:12] == 3'b000) // Checking for specific function
                    y = {e_bit[7]? {24{1'b1}}:{24{1'b0}}, e_bit}; // Performing specific operation on 'e_bit'
                else if(inst[14:12] == 3'b001) // Checking for specific function
                    y = {s_bit[15]? {16{1'b1}}:{16{1'b0}}, s_bit}; // Performing specific operation on 's_bit'
                else if(inst[14:12] == 3'b100) // Checking for specific function
                    y = {24'b0, e_bit}; // Performing specific operation on 'e_bit'
                else if(inst[14:12] == 3'b101) // Checking for specific function
                    y = {16'b0, s_bit}; // Performing specific operation on 's_bit'
                else if(inst[14:12] == 3'b010) // Checking for specific function
                    y = data; // Directly assigning 'data' to 'y'
            end
        else if(inst[6:0] == 7'b0100011) // Checking for specific instruction type
        begin
            if(inst[14:12] == 3'b000) // Checking for specific function
                y = {e_bit[7]? {24{1'b1}}:{24{1'b0}}, e_bit}; // Performing specific operation on 'e_bit'
            else if(inst[14:12] == 3'b001) // Checking for specific function
                y = {s_bit[15]? {16{1'b1}}:{16{1'b0}}, s_bit}; // Performing specific operation on 's_bit'
            else if(inst[14:12] == 3'b010) // Checking for specific function
                y = data; // Directly assigning 'data' to 'y'
        end
    end
endmodule