`timescale 1ns / 1ps


module reg_mem_wb(
    input               clk_i,
    input               rst_n_i,
    input               mem_rf_we,
    input               mem_have_inst,
    input       [4:0]   mem_wr,
    input       [31:0]  mem_pc,
    input       [31:0]  mem_rf_wdata,
    
    output  reg [31:0]  wb_aluc,
    output  reg [31:0]  wb_dramrd,
    output  reg [31:0]  wb_pc4,
    output  reg [31:0]  wb_ext,
    output  reg         wb_rf_we,
    output  reg [2:0]   wb_wd_sel,
    output  reg         wb_have_inst,
    output  reg [4:0]   wb_wr,
    output  reg [31:0]  wb_pc,
    output  reg [31:0]  wb_rf_wdata
    );

    // wb_rf_we
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_rf_we <= 1'b0;
        else            wb_rf_we <= mem_rf_we;
    end

    // wb_have_inst
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_have_inst <= 1'b0;
        else            wb_have_inst <= mem_have_inst;
    end

    // wb_wr
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_wr <= 5'h0;
        else            wb_wr <= mem_wr;
    end

    // wb_pc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_pc <= 32'h0;
        else            wb_pc <= mem_pc;
    end
    
    // wb_rf_wdata
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_rf_wdata <= 32'h0;
        else            wb_rf_wdata <= mem_rf_wdata;
    end
endmodule
