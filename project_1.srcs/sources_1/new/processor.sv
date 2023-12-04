// Setting timescale for the module
`timescale 1ns / 1ps

// Defining the processor module with a parameter for data width
module processor #(
    data_width = 32,
    PC_W = 9,
    INS_W = 32,
    RF_ADDRESS = 5,
    DATA_W = 32,
    DM_ADDRESS = 9,
    ALU_CC_W = 4)
    (
    input logic clock, reset, // Clock input, Reset signal input
    output logic [31:0] data_out // 32-bit data output
);

    divide_clock divide_clock (
        .clk_in(clock),
        .clk_out(clk)
    );

    // Internal signal declarations for various control signals
    logic [6:0] opcode; // 7-bit opcode signal
    logic [3:0] ALU_operation; // 4-bit ALU operation signal
    logic [6:0] Funct7; // 7-bit Funct7 signal
    logic [2:0] Funct3; // 3-bit Funct3 signal


    // Instantiating the control unit module
    control_unit control_unit (
        .opcode(opcode),
        .ALUOp(ALU_operation),
        .funct3(Funct3),
        .ALUSrc(control_unit_ALUSrc),
        .MemtoReg(control_unit_MemtoReg),
        .RegtoMem(control_unit_RegtoMem),
        .RegWrite(control_unit_RegWrite),
        .MemRead(control_unit_MemRead),
        .MemWrite(control_unit_MemWrite),
        .Con_Jalr(control_unit_Con_Jalr),
        .Con_beq(control_unit_Con_beq),
        .Con_blt(control_unit_Con_blt)
    );


    // Instantiating the datapath module
    datapath #(
    .PC_W(PC_W),
    .INS_W(INS_W),
    .RF_ADDRESS(RF_ADDRESS),
    .DATA_W(DATA_W),
    .DM_ADDRESS(DM_ADDRESS),
    .ALU_CC_W(ALU_CC_W)
    ) datapath (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .RegtoMem(RegtoMem),
        .ALUsrc(ALUsrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemAcc(MemAcc),
        .Con_beq(Con_beq),
        .Con_blt(Con_blt),
        .Con_Jalr(Con_Jalr),
        .ALU_CC(ALU_CC),
        .opcode(datapath_inst_opcode),
        .Funct7(datapath_inst_Funct7),
        .Funct3(datapath_inst_Funct3),
        .ALU_Result(datapath_inst_ALU_Result)
    );


endmodule