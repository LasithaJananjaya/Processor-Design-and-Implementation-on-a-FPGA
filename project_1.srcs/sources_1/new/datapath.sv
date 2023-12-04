module datapath #(
    parameter PC_W = 9, // Width of the program counter
    parameter INS_W = 32, // Width of the instructions
    parameter RF_ADDRESS = 5, // Width of the register file address
    parameter DATA_W = 32, // Width of the data
    parameter DM_ADDRESS = 9, // Width of the data memory address
    parameter ALU_CC_W = 4 // Width of the ALU condition code
)(
    input logic clk, reset, RegWrite, MemtoReg, RegtoMem, ALUsrc, MemWrite, MemRead, // Input signals
    input logic [2:0] MemAcc, // Memory access
    input logic Con_beq, // Control signal for branch equal
    input logic Con_blt, // Control signal for branch less than
    input logic Con_Jalr, // Control signal for jump and link register
    input logic [ALU_CC_W - 1:0] ALU_CC, // ALU condition code
    output logic [6:0] opcode, // Output opcode
    output logic [6:0] Funct7, // Output Funct7
    output logic [2:0] Funct3, // Output Funct3
    output logic [31:0] ALU_Result // Output of the ALU result
);

    wire [8:0] PCPlus4; // Wire for the incremented program counter
    wire [8:0] PCPlus4_unsign_extend; // Wire for the unsigned extended program counter
    wire [31:0] pc; // Wire for the program counter

    // Instance of the program counter module
    program_counter #(
    .INS_ADDRESS(PC_W),
    .PC_WIDTH(32)
    ) program_counter (
        .clk(clk),
        .reset(reset),
        .next_pc(PCPlus4_unsign_extend),
        .branch(branch), // Branch signal
        .pc(pc) // Program counter
    );

    assign PCPlus4_unsign_extend = {23'b0, PCPlus4}; // Extending the program counter
    assign PCPlus4 = pc + 9'b100; // Incrementing the program counter

    logic [31:0] Instr; // Instruction variable
    instruction_memory instruction_memory (PC, Instr); // Accessing the instruction memory

    assign opcode = Instr[6:0]; // Extracting opcode from instruction
    assign Funct3 = Instr[14:12]; // Extracting Funct3 from instruction
    assign Funct7 = Instr[31:25]; // Extracting Funct7 from instruction

    data_interpreter data_store(Instr, Reg2, ST); // Interpreting data for store operation
    mux_2 #(32) resmux_store(Reg2, ST, RegtoMem, Store_data); // Multiplexer for store operation result

    register_file register_file(clk, reset, RegWrite, Instr[11:7], Instr[19:15], Instr[24:20], Result, Reg1, Reg2); // Register file instance

    mux_2 #(32) resmux(ALUResult, LD, MemtoReg, Read_Alu_Result); // Multiplexer for memory-to-register operation
    mux_2 #(32) resmux_jalr(Read_Alu_Result, {23'b0, PCPlus4}, (Jalr), Jal_test); // Multiplexer for jump-and-link operation

    immediate_generator Ext_Imm (Instr,ExtImm); // Generating immediate value

    mux_2 #(32) srcbmux(Reg2, ExtImm, (ALUsrc||Jalr), SrcB); // Multiplexer for source B selection
    ALU_32bit ALU_32bit(Reg1, SrcB, ALU_CC, ALUResult, zero); // 32-bit ALU operation

    assign ALU_Result = Result; // Assigning the ALU result

    data_interpreter data_load(Instr, ReadData, LD); // Interpreting data for load operation

    logic [31:0] temp_arr = ALUResult; // Temporary storage for ALU result
    data_memory data_memory(clk, MemRead, MemWrite, MemAcc, temp_arr[8:0], Store_data, ReadData); // Data memory operation

endmodule