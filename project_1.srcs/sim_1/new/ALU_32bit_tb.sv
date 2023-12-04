module ALU_32bit_tb;

  logic clk;
  logic reset;

  logic [31:0] operandA;
  logic [31:0] operandB;
  logic [3:0] ALU_control;
  logic [31:0] result;

  ALU_32bit DUT (
    .operandA(operandA),
    .operandB(operandB),
    .ALU_control(ALU_control),
    .result(result)
  );

  initial begin
    clk = 0;
    reset = 1;
    #1 reset = 0;

    // Apply various test cases

    // ADD
    operandA = 32'h3210_0000;
    operandB = 32'h0001_0000;
    ALU_control = 4'b0000;
    #1 $display("ADD: %h + %h = %h", operandA, operandB, result);

    // SUB
    operandA = 32'h3210_0000;
    operandB = 32'h0001_0000;
    ALU_control = 4'b0001;
    #1 $display("SUB: %h - %h = %h", operandA, operandB, result);

    // AND
    operandA = 32'hFFFF_FFFF;
    operandB = 32'h0000_FFFF;
    ALU_control = 4'b0010;
    #1 $display("AND: %h & %h = %h", operandA, operandB, result);

    // OR
    operandA = 32'hFFFF_FFFF;
    operandB = 32'h0000_FFFF;
    ALU_control = 4'b0011;
    #1 $display("OR: %h | %h = %h", operandA, operandB, result);

    // XOR
    operandA = 32'hFFFF_FFFF;
    operandB = 32'h0000_FFFF;
    ALU_control = 4'b0100;
    #1 $display("XOR: %h ^ %h = %h", operandA, operandB, result);

    // SLL
    operandA = 32'h1234_5678;
    operandB = 32'h2;
    ALU_control = 4'b0101;
    #1 $display("SLL: %h << %h = %h", operandA, operandB, result);

    // SRL
    operandA = 32'h1234_5678;
    operandB = 32'h2;
    ALU_control = 4'b0110;
    #1 $display("SRL: %h >> %h = %h", operandA, operandB, result);

    // SLT
    operandA = 32'h1234_5678;
    operandB = 32'h9876_5432;
    ALU_control = 4'b0111;
    #1 $display("SLT: %h < %h = %h", operandA, operandB, result);

    $finish;
  end

  always #1 clk = ~clk;

endmodule