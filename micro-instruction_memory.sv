`timescale 1ns / 1ps

module micro_instruction_memory
#(parameter WIDTH = 16,
    parameter DEPTH = 6)
(
    input  logic [(DEPTH-1):0] address,
    output logic [(WIDTH-1):0] data
);

    logic [(WIDTH-1):0] mem [0:DEPTH-1];
    
//    ALUSrc[0],
//    MemtoReg[1],
//    RegtoMem[2],
//    RegWrite[3],
//    MemRead[4],
//    MemWrite[5],
//    ALUOp[9:6],
//    Con_Jalr[10],
//    Con_beq[11],
//    Con_blt[12],
//    MemAcc[15:13],
    
    //R_type
    assign mem[6'd0] = 16'b000_100_0000_000_000; //add
    assign mem[6'd1] = 16'b000_100_0001_000_000; //sub
    assign mem[6'd2] = 16'b000_100_0101_000_000; //sll
    assign mem[6'd3] = 16'b000_100_0111_000_000; //slt
    assign mem[6'd4] = 16'b000_100_1000_000_000; //sltu
    assign mem[6'd5] = 16'b000_100_0100_000_000; //xor
    assign mem[6'd6] = 16'b000_100_0110_000_000; //srl
    assign mem[6'd7] = 16'b000_100_1001_000_000; //sra
    assign mem[6'd8] = 16'b000_100_0011_000_000; //or
    assign mem[6'd9] = 16'b000_100_0010_000_000; //and
    
    //I_type
    assign mem[6'd10] = 16'b100_100_0000_000_000; //addi
    assign mem[6'd11] = 16'b100_100_0101_000_000; //slli
    assign mem[6'd12] = 16'b100_100_0111_000_000; //slti
    assign mem[6'd13] = 16'b100_100_1000_000_000; //sltiu
    assign mem[6'd14] = 16'b100_100_0100_000_000; //xori
    assign mem[6'd15] = 16'b100_100_0110_000_000; //srli
    assign mem[6'd16] = 16'b100_100_1001_000_000; //srai
    assign mem[6'd17] = 16'b100_100_0011_000_000; //ori
    assign mem[6'd18] = 16'b100_100_0010_000_000; //andi
    
    assign mem[6'd19] = 16'b110_110_0000_000_001; //lw
    assign mem[6'd20] = 16'b110_110_0000_000_010; //lh
    assign mem[6'd21] = 16'b110_110_0000_000_011; //lb
    assign mem[6'd22] = 16'b110_110_0000_000_100; //lhu
    assign mem[6'd23] = 16'b110_110_0000_000_101; //lbu
    
    //S_type
    assign mem[6'd24] = 16'b001_001_0000_000_001; //sw
    assign mem[6'd25] = 16'b001_001_0000_000_010; //sh
    assign mem[6'd26] = 16'b001_001_0000_000_011; //sb
    
    //B_type
    assign mem[6'd27] = 16'b000_000_1010_010_000; //beq
    assign mem[6'd28] = 16'b000_000_1010_010_000; //bnq
    assign mem[6'd29] = 16'b000_000_0111_001_000; //blt
    assign mem[6'd30] = 16'b000_000_0111_001_000; //bge
    assign mem[6'd30] = 16'b000_000_1000_001_000; //bltu
    assign mem[6'd30] = 16'b000_000_1000_001_000; //bgeu
    
    assign mem[6'd30] = 16'b000_100_0000_100_000; //jalr
    
    //MUL
    assign mem[6'd31] = 16'b000_100_1101_000_000;
    
    //MEMCOPY
    assign mem[6'd32] = 16'b000_011_0000_000_111;

    always_comb begin
        data = mem[address];
    end

endmodule