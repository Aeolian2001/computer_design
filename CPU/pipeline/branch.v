`timescale 1ns / 1ps


module branch(
    input               ctrl_branch_i,
    input               alu_branch_i,
    input       [31:0]  ext_i,
    output      [31:0]  ext_o
    );
    wire branch_en;
    assign branch_en = ctrl_branch_i & alu_branch_i;
    assign ext_o = branch_en ? ext_i : 32'h0000_0004;
endmodule
