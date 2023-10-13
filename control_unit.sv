module control_unit (
    input logic [6:0] opcode,
    input logic [6:0] funct7,
    input logic [2:0] funct3,

    output logic [3:0] ALU_operation,
    output logic register_write

    //output logic Con_Jalr, Con_AUIPC, Con_LUI, Con_beq, Con_bnq, Con_blt, Con_bgt
    //output logic ALUSrc
    //output logic MemtoReg, RegtoMem
    //output logic MemRead
    //output logic MemWrite
);

    logic [6:0] R_type = 7'b0110011; // ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
    logic [6:0] I_type = 7'b0010011; // ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
    //logic [6:0] LW = 7'b0000011; // LB, LH, LW, LBU, LHU
    //logic [6:0] SW = 7'b0100011; // SB, SH, SW
    //logic [6:0] BR = 7'b1100011; // BEQ, BNE, BLT, BGE, BLTU, BGEU
    //logic [6:0] JALR = 7'b1100111;
    //logic [6:0] AUIPC = 7'b0010111;
    //logic [6:0] LUI = 7'b0110111;

    always_comb begin
        if (funct3==3'b000 && (opcode == R_type || opcode == I_type))
            ALU_operation = 4'b0000;
    end

endmodule