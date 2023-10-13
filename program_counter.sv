module program_counter #(
  parameter INS_ADDRESS = 9,
  parameter PC_WIDTH = 32
) (
  input logic clk,
  input logic reset,
  input logic [INS_ADDRESS-1:0] next_pc,
  input logic branch,
  output logic [PC_WIDTH-1:0] pc
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pc <= 32'h0;
    end else begin
      if (branch) begin
        pc <= next_pc;
      end else begin
        pc <= pc + 4;
      end
    end
  end
endmodule