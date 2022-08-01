`timescale 1ns / 1ps

module bus(
    input           clk,
    input           rst_n,
    input   [31:0]  dram_wdin,
    input           dram_we,
    input   [31:0]  dram_addr,
    output  [31:0]  bus_rdata,
    //data,address,enable are three signals to i/o
   //rdata
    input wire [31:0] rdata_dram_i,
    input wire [31:0] rdata_switch_i,
    input wire [31:0] rdata_led_i,
    input wire [31:0] rdata_digtube_i,
    //wdata
    output wire [31:0] cal_res_dig,   // for digtube to show number
    output wire [31:0] cal_res_led,   // for led to show number
    output wire [31:0] wdata_switch,
    output wire [31:0] wdata_dram,
    //address
    output wire [31:0] dram_addr_tmp,
    output wire [31:0] addr_switch,
    output wire [31:0] addr_digtube,
    output wire [31:0] addr_led,
    //enable
    output wire dram_ena,
    output wire digtube_ena,
    output wire led_ena,
    output wire switch_ena

);
    parameter SWITCH_ADDR = 32'hffff_f070;
    parameter DIGTUBE_ADDR = 32'hffff_f000;
    parameter LED_ADDR = 32'hffff_f060;
    
    assign dram_addr_tmp = dram_addr - 16'h4000;
    assign addr_switch = dram_addr;
    assign addr_led = dram_addr;
    assign addr_digtube = dram_addr;
    
    assign digtube_ena = (dram_addr == DIGTUBE_ADDR && dram_we);
    assign dram_ena = ((dram_addr[31:20] == 12'h000 || dram_addr[31:20] == 12'h001) && dram_we);
    assign led_ena = (dram_addr == LED_ADDR && dram_we);
    
    assign cal_res_dig = dram_wdin;
    assign cal_res_led = dram_wdin;
    assign wdata_dram = dram_wdin;
    //mux to choose read data
    assign bus_rdata = (dram_we == 1)? 32'b0:
                     ((dram_addr == SWITCH_ADDR)? rdata_switch_i:rdata_dram_i); 
    
endmodule
