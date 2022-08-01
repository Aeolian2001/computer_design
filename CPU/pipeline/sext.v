`timescale 1ns / 1ps
`include "param.vh"

module sext(
    input       [24:0]  inst_i,     // inst[31:7]
    input       [2:0]   sext_op,
    output      [31:0]  ext_o
    );
    wire [31:0] ext_pos;
    wire [31:0] ext_neg;

    sext_pos u_sext_pos(
        .inst_i     (inst_i),
        .sext_op    (sext_op),
        .ext_o      (ext_pos)
    );

    sext_neg u_sext_neg(
        .inst_i     (inst_i),
        .sext_op    (sext_op),
        .ext_o      (ext_neg)
    );
    assign ext_o = inst_i[24] ? ext_neg : ext_pos;
endmodule
