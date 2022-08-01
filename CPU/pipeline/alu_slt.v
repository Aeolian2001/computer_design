`timescale 1ns / 1ps

module alu_slt(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    input       [31:0]  c_sub,
    output      [31:0]  c_o
    );
    wire ab_10;
    wire ab_01;
    assign ab_10 = a_i[31] && (~b_i[31]);
    assign ab_01 = (~a_i[31]) && b_i[31];
    assign c_o   =    (ab_10)    ?    32'h1 : 
                    (ab_01)     ?   32'h0 : 
                                    {31'h0, c_sub[31]};
endmodule
