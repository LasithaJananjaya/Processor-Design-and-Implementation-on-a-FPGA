`timescale 1ns / 1ps

module divide_clock(
    input clk_in, //125MHz
    output reg clk_out
    );
    
    parameter divider = 32'd1000000;
    reg[31:0] count = 32'd0;
    
    always @(posedge clk_in)
    begin
        count <= count + 32'd1;
        if(count >= (divider-1))
            count <= 32'd0;
        clk_out <= (count < divider / 2)?1'b1:1'b0; //125Hz
    end
endmodule