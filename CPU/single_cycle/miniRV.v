`timescale 1ns / 1ps

module miniRV(
    input clk,
    input rst_n,
    input wire [31:0] inst,
    input wire [31:0] dram_rd,
    output wire [31:0] dram_addr,
    output wire [31:0] irom_addr,
    output wire [31:0] dram_wdin,
    output wire dram_we,
    output wire rf_we,
    output wire [31:0] wD,
    output wire [4:0] wR
    );
    wire [31:0] npc;//next program address
    wire [31:0] pc;//program address
    assign irom_addr = pc;
    //PC
    PC u_pc(
        .clk    (clk),
        .rst_n  (rst_n),
        .npc    (npc),
        .pc     (pc)
    );
    //NPC
    wire npc_branch;//npc branch control
    wire [31:0] ext;//immadiate number
    wire [1:0] npc_op;
    wire [31:0] alu_C;
    NPC u_npc(
        .branch (npc_branch),
        .op     (npc_op),
        .pc     (pc),
        .alu_c  (alu_C),
        .imm    (ext),
        .npc    (npc)
    );
    //sext
    wire [2:0] sext_sel;//sext control
    SEXT u_sext(
        .din    (inst[31:7]),
        .op     (sext_sel),
        .ext    (ext)
    );
    //Regfile
    wire [31:0] Data1;
    wire [31:0] Data2;
    assign wR = inst[11:7];
    assign dram_wdin = Data2;
    RF u_regfile(
        .clk    (clk),
        .we     (rf_we),
        .rD1    (inst[19:15]),
        .rD2    (inst[24:20]),
        .wR     (inst[11:7]),
        .wD     (wD),
        .Data1  (Data1),
        .Data2  (Data2)
    );
    //ALU
    wire [2:0] alu_op;//ALU control
    wire [31:0] alu_B;
    wire [1:0] zero;
    assign dram_addr = alu_C;
    ALU u_ALU(
        .op     (alu_op),
        .A      (Data1),
        .B      (alu_B),
        .C      (alu_C),
        .zero   (zero)
    );
    //Reg_wD_mux
    wire [1:0]wd_sel;
    wD_mux u_wD_mux(
        .wd_sel (wd_sel),
        .rd     (dram_rd),
        .c      (alu_C),
        .ext    (ext),
        .pc4    (pc),
        .wD     (wD)
    );
    //B_mux
    wire b_sel;
    B_mux u_B_mux(
        .b_sel  (b_sel),
        .Data2  (Data2),
        .ext    (ext),
        .B      (alu_B)
    );
    //branch_ctrl
    wire [2:0] branch;
    branch_ctrl u_branch_ctrl(
        .branch (branch),
        .zero   (zero),
        .op     (npc_branch)
    );
    //ctrl
    control u_ctrl(
        .opcode     (inst[6:0]),
        .fun3       (inst[14:12]),
        .fun7       (inst[31:25]),
        .dram_we    (dram_we),
        .branch     (branch),
        .b_sel      (b_sel),
        .alu_op     (alu_op),
        .rf_we      (rf_we),
        .wd_sel     (wd_sel),
        .sext_sel   (sext_sel),
        .npc_op     (npc_op)
    );
endmodule
