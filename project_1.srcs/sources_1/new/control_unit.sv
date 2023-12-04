module control_unit (
    input logic [6:0] opcode, // Input opcode field
    input logic [6:0] funct7, // Input funct7 field
    input logic [2:0] funct3, // Input funct3 field

    output logic ALUSrc, // Output for ALU source selection
    output logic MemtoReg, RegtoMem, // Output flags for memory-to-register and register-to-memory
    output logic RegWrite, // Output for register write control
    output logic MemRead, MemWrite, // Output flags for memory read and write control

    output logic [3:0] ALUOp, // Output for ALU operation code
    output logic Con_Jalr, Con_beq, Con_blt // Output control signals for specific instructions
);

    logic [5:0] address; // 6-bit logic signal for address calculation
    logic [16:0] micro_instruction; // 17-bit logic signal for microinstruction

    logic [6:0] R_type = 7'b0110011; // Define opcode values for R-type instructions
    logic [6:0] I_type = 7'b0010011; // Define opcode values for I-type instructions
    logic [6:0] LW = 7'b0000011; // Define opcode values for LW-type instructions
    logic [6:0] SW = 7'b0100011; // Define opcode values for SW-type instructions
    logic [6:0] BR = 7'b1100011; // Define opcode values for branch instructions
    logic [6:0] JALR = 7'b1100111; // Define opcode values for JALR instruction
    logic [6:0] MEMCOPY = 7'b111110; // Define opcode values for MEMCOPY instruction

    always_comb begin
        if (funct3 == 3'b000 && (opcode == R_type || opcode == I_type))
            address = 6'd0; // Set address to 6'd0 for specific R-type and I-type instructions

        if (opcode == MEMCOPY)
            address = 6'd32; // Set address to 6'd32 for the MEMCOPY instruction
    end

    micro_instruction_memory micro_instruction_memory (.address(address), .data(micro_instruction));

    assign ALUSrc = micro_instruction[0]; // Set ALUSrc based on micro_instruction bit 0
    assign MemtoReg = micro_instruction[1]; // Set MemtoReg based on micro_instruction bit 1
    assign RegtoMem = micro_instruction[2]; // Set RegtoMem based on micro_instruction bit 2
    assign RegWrite = micro_instruction[3]; // Set RegWrite based on micro_instruction bit 3
    assign MemRead = micro_instruction[4]; // Set MemRead based on micro_instruction bit 4
    assign MemWrite = micro_instruction[5]; // Set MemWrite based on micro_instruction bit 5
    assign ALUOp = micro_instruction[9:6]; // Set ALUOp based on micro_instruction bits 9 to 6
    assign Con_Jalr = micro_instruction[10]; // Set Con_Jalr based on micro_instruction bit 10
    assign Con_beq = micro_instruction[11]; // Set Con_beq based on micro_instruction bit 11
    assign Con_blt = micro_instruction[12]; // Set Con_blt based on micro_instruction bit 12

endmodule