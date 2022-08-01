`timescale 1ns / 1ps
`include "param.vh"

module stop(
    input               clk_cpu,
    input               rst_n_i,
    input        [31:0] inst_i,
    output  reg         have_inst_o,
    output  reg         pipline_stop
    );
    wire clk_cpu_n;
    assign clk_cpu_n = ~clk_cpu;
    wire [6:0] opcode;
    assign opcode = inst_i[6:0];

    reg [5:0] stop_cnt;
    
    //find jump op
    wire opcode_jal;
    wire opcode_inst_b;
    wire opcode_jalr;
    assign opcode_jal =     (opcode == `OPCODE_INST_J_JAL);
    assign opcode_inst_b =  (opcode == `OPCODE_INST_B);
    assign opcode_jalr =    (opcode == `OPCODE_INST_I_JALR);
    
    reg jump_flag;
    always @ (posedge clk_cpu_n or negedge rst_n_i) begin
        if (~rst_n_i)                               jump_flag <= 1'b0;
        else if (have_inst_o && (opcode_jal || opcode_inst_b || opcode_jalr)) begin
            jump_flag <= 1'b1;
        end
        else                                        jump_flag <= 1'b0;
    end
    
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                               have_inst_o <= 1'b0;
        else if (have_inst_o && jump_flag)          have_inst_o <= 1'b0;
        else if (pipline_stop)                      have_inst_o <= 1'b0;
        else                                        have_inst_o <= 1'b1;
    end
    
    
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                                                   stop_cnt <= 6'h0;
        else if (jump_flag & (~pipline_stop))                           stop_cnt <= 6'b111111;
        else if (stop_cnt == 6'h0)                                      stop_cnt <= 6'h0;
        else                                                            stop_cnt <= stop_cnt + 6'h1;
    end
    
    always @ (posedge clk_cpu_n or negedge rst_n_i) begin
        if (~rst_n_i)                   pipline_stop <= 1'b0;
        else if (stop_cnt != 6'h0)      pipline_stop <= 1'b1;
        else                            pipline_stop <= 1'b0;
    end
endmodule
