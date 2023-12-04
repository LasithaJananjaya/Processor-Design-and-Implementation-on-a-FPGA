module instruction_decoder (
    input [31:0] instruction,
    output reg [3:0] control_signals
);

    logic [6:0] R_TYPE, I_TYPE_LB, I_TYPE_ALU, S_TYPE, SB_TYPE;
    // R-type instructions
    assign R_TYPE = 7'b0110011; // e.g., add, sub, and, or, xor, sll, srl, sra, slt, sltu

    // I-type instructions
    assign I_TYPE_LB = 7'b0000011; // e.g., lb, lh, lw, lbu, lhu
    assign I_TYPE_ALU = 7'b0010011; // e.g., addi, slti, sltiu, xori, ori, andi, slli, srli, srai

    // S-type instructions
    assign S_TYPE = 7'b0100011; // e.g., sb, sh, sw

    // SB-type instructions
    assign SB_TYPE = 7'b1100011; // e.g., beq, bne, blt, bge, bltu, bgeu

    always @(instruction) begin
        case (instruction[6:0])
            R_TYPE: case({instruction[31:25],instruction[14:12]})
                10'b0000000000: control_signals = 4'b0000;
            endcase
        endcase
    end
endmodule