`timescale 1ns / 1ps
`include "param.vh"

module npc(
    input       [31:0]  pc_i,
    input       [31:0]  pc_pc_i,
    input       [31:0]  imm_i,
    input       [1:0]   npc_op,
    output      [31:0]  npc_o
    );

    assign npc_o =          (npc_op == `NPC_OP_PC_IMM_JALR)     ?   ((pc_i + imm_i) & 32'hFFFF_FFFE) : 
                            (npc_op == `NPC_OP_PC_ADD_IMM)      ?   (pc_i + imm_i) : 
                                                                        (pc_pc_i + 32'h4);
endmodule
