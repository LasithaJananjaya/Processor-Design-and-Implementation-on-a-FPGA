module ALU_32bit(
    input [31:0] operandA,
    input [31:0] operandB,
    input [3:0] ALU_control,
    output reg [31:0] result,
    output reg zero_flag
);

    always @* begin
        case (ALU_control)
            4'b0000: result = operandA + operandB; // ADD
            4'b0001: result = operandA - operandB; // SUB
            4'b0010: result = operandA & operandB; // AND
            4'b0011: result = operandA | operandB; // OR
            4'b0100: result = operandA ^ operandB; // XOR
            4'b0101: result = operandA << operandB; // SLL
            4'b0110: result = operandA >> operandB; // SRL
            4'b0111: result = (operandA < operandB) ? 32'h1 : 32'h0; // SLT
            default: result = 32'h0;
        endcase

        // Calculate the zero_flag
        if (result == 32'h0) begin
            zero_flag = 1'b1;
        end else begin
            zero_flag = 1'b0;
        end
    end
endmodule