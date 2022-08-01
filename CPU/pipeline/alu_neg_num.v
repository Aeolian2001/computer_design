`timescale 1ns / 1ps

module alu_neg_num(
    input       [31:0]  imm_i,
    output      [31:0]  n_imm_o
    );

    wire [31:0] imm_pos;
    wire [31:0] imm_neg;

    assign imm_pos = ~imm_i + 1;

    wire [31:0] imm_n1;
    assign imm_n1 = {imm_i[31], ~imm_i[30:0]} + 1;
    assign imm_neg = {~imm_n1[31], imm_n1[30:0]};

    assign n_imm_o = imm_i[31] ? imm_neg : imm_pos;
endmodule
