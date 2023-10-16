`timescale 1ns / 1ps

module mux_2
    #(parameter WIDTH = 9)
    (input logic [WIDTH-1:0] d0, d1,
    input logic select,
    output logic [WIDTH-1:0] outcome);

    assign outcome = select ? d1 : d0;

endmodule