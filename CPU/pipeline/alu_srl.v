`timescale 1ns / 1ps

module alu_srl(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    output      [31:0]  c_o
    );

    wire [31:0] c_0;
    wire [31:0] c_1;
    wire [31:0] c_2;
    wire [31:0] c_3;
    wire [31:0] c_4;

    assign c_0 = b_i[0] ? (a_i >> 32'h0000_0001) : a_i;
    assign c_1 = b_i[1] ? (c_0 >> 32'h0000_0002) : c_0;
    assign c_2 = b_i[2] ? (c_1 >> 32'h0000_0004) : c_1;
    assign c_3 = b_i[3] ? (c_2 >> 32'h0000_0008) : c_2;
    assign c_4 = b_i[4] ? (c_3 >> 32'h0000_0010) : c_3;
    assign c_o = c_4;
endmodule
