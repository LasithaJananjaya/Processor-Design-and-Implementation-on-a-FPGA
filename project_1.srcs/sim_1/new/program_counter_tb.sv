`timescale 1ns / 1ps

module program_counter_testbench;

  // Parameters
  parameter INS_ADDRESS = 9;
  parameter PC_WIDTH = 32;

  // Signals
  reg clk;
  reg reset;
  reg [INS_ADDRESS-1:0] next_pc;
  reg branch;
  wire [PC_WIDTH-1:0] pc;

  // Instantiate program_counter module
  program_counter #(
    .INS_ADDRESS(INS_ADDRESS),
    .PC_WIDTH(PC_WIDTH)
  ) dut(
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .branch(branch),
    .pc(pc)
  );

  // Generate clock signal
  always begin
    #5 clk <= ~clk;
  end

  // Test cases
  initial begin
    // Test 1: Reset
    clk <= 1'b0;
    reset <= 1'b1;
    next_pc <= 9'h0;
    branch <= 1'b0;

    #10 reset <= 1'b0;

    $display("Test 1: Reset");
    $display("Expected PC: 32'h0");
    $display("Actual PC: %h", pc);

    // Test 2: Unconditional branch
    clk <= 1'b0;
    reset <= 1'b0;
    next_pc <= 9'h100;
    branch <= 1'b1;

    #10 branch <= 1'b0;

    $display("Test 2: Unconditional branch");
    $display("Expected PC: 32'h100");
    $display("Actual PC: %h", pc);

    // Test 3: Conditional branch
    clk <= 1'b0;
    reset <= 1'b0;
    next_pc <= 9'h100;
    branch <= 1'b1;

    #10 branch <= 1'b1;

    $display("Test 3: Conditional branch");
    $display("Expected PC: 32'h100");
    $display("Actual PC: %h", pc);

    // Test 4: Sequential execution
    clk <= 1'b0;
    reset <= 1'b0;
    next_pc <= 9'h0;
    branch <= 1'b0;

    #10 next_pc <= 9'h4;

    #10 next_pc <= 9'h8;

    $display("Test 4: Sequential execution");
    $display("Expected PC: 32'h8");
    $display("Actual PC: %h", pc);

    // Finish test
    $finish;
  end

endmodule