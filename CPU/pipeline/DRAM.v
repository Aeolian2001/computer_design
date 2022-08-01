`timescale 1ns / 1ps

module DRAM(
    input               clk_i,
    input       [31:0]  addr_i,
    input               we,
    input       [31:0]  wdata_i,
    output      [31:0]  rdata_o
    );
    wire [31:0] addr_tmp;
    wire ram_clk;
    assign ram_clk = ~clk_i;
    assign addr_tmp = addr_i - 16'h4000;
    // IP ºË
    dram dram (
        .clk    (ram_clk),
        .a      (addr_tmp[15:2]),
        .spo    (rdata_o),
        .we     (we),
        .d      (wdata_i)
    );
endmodule