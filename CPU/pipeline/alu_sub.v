`timescale 1ns / 1ps


module alu_sub(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    output      [31:0]  c_o
    );
    wire [31:0] b_n;

    alu_neg_num u_alu_neg_num (
        .imm_i      (b_i),
        .n_imm_o    (b_n)
    );
    assign c_o = a_i + b_n;
endmodule
