`timescale 1ns / 1ps
`include "param.vh"

module alu(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    input       [4:0]   alu_op,
    output              branch_o,
    output      [31:0]  c_o
    );

    wire [31:0] c_add;
    wire [31:0] c_sub;
    wire [31:0] c_and;
    wire [31:0] c_or;
    wire [31:0] c_xor;
    wire [31:0] c_sll;
    wire [31:0] c_srl;
    wire [31:0] c_sra;
    wire [31:0] c_slt;
    wire [31:0] c_sltu;

    wire branch_beq;
    wire branch_bne;
    wire branch_blt;
    wire branch_bge;
    wire branch_bltu;
    wire branch_bgeu;
    
    //add
    assign c_add = a_i + b_i;
    //sub
    alu_sub u_alu_sub(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sub)
    );
    
    // and
    assign c_and = a_i & b_i;
    
    // or
    assign c_or = a_i | b_i;
    
    // xor
    assign c_xor = a_i ^ b_i;
    
    // 逻辑左移
    alu_sll u_alu_sll(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sll)
    );
    
    // 逻辑右移
    alu_srl u_alu_srl(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_srl)
    );
    
    // 算术右移
    alu_sra u_alu_sra(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sra)
    );
    
    // slt
    alu_slt u_alu_slt(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_sub  (c_sub),
        .c_o    (c_slt)
    );
    
    // sltu
    assign c_sltu = (a_i < b_i);
    
    
    
    // beq
    assign branch_beq =     (a_i == b_i);
    
    // bne
    assign branch_bne =     ~branch_beq;
    
    // blt
    assign branch_blt =     c_sub[31];
    
    // bge
    assign branch_bge =     ~branch_blt;
    
    // bltu
    assign branch_bltu =    (a_i < b_i);
    
    // bgeu
    assign branch_bgeu =    ~branch_bltu;
    
    // 根据 alu_op 决定何种运算
    assign c_o =            (alu_op == `ALU_OP_ADD)     ?   c_add : 
                            (alu_op == `ALU_OP_SUB)     ?   c_sub : 
                            (alu_op == `ALU_OP_AND)     ?   c_and : 
                            (alu_op == `ALU_OP_OR)      ?   c_or : 
                            (alu_op == `ALU_OP_XOR)     ?   c_xor : 
                            (alu_op == `ALU_OP_SLL)     ?   c_sll : 
                            (alu_op == `ALU_OP_SRL)     ?   c_srl : 
                            (alu_op == `ALU_OP_SRA)     ?   c_sra : 
                            (alu_op == `ALU_OP_SLT)     ?   c_slt : 
                            (alu_op == `ALU_OP_SLTU)    ?   c_sltu : 
                                                            32'h0;
    
    assign branch_o =       (alu_op == `ALU_OP_BEQ)     ?   branch_beq : 
                            (alu_op == `ALU_OP_BNE)     ?   branch_bne : 
                            (alu_op == `ALU_OP_BLT)     ?   branch_blt : 
                            (alu_op == `ALU_OP_BGE)     ?   branch_bge : 
                            (alu_op == `ALU_OP_BLTU)    ?   branch_bltu : 
                            (alu_op == `ALU_OP_BGEU)    ?   branch_bgeu : 
                                                            1'b0;
endmodule
