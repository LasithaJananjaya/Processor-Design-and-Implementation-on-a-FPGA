module register_file (
  input clk,
  input reset,
  input en,
  input [4:0] rs1, rs2, rd,
  input [31:0] wdata,
  output [31:0] rdata1, rdata2
);

  reg [31:0] regs [31:0];

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < 32; i++) begin
        regs[i] <= 32'h0;
      end
    end else if (en) begin
      if (rd != 0) begin
        regs[rd] <= wdata;
      end
    end
  end

  assign rdata1 = regs[rs1];
  assign rdata2 = regs[rs2];

endmodule