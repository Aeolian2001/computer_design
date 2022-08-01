`timescale 1ns / 1ps

module top(
    input  wire       clk   ,
	input  wire       rst   ,
    input  wire [23:0]switch,
	output wire [23:0]led,
 	output wire [7:0] led_en,
	output wire       led_ca,
	output wire       led_cb,
    output wire       led_cc,
	output wire       led_cd,
	output wire       led_ce,
	output wire       led_cf,
	output wire       led_cg,
	output wire       led_dp 
    );
wire rst_n;
assign rst_n = ~rst;    
wire [31:0] inst;
wire [31:0] dram_rd;
wire [31:0] dram_addr;
wire [31:0] irom_addr;
wire [31:0] dram_wdin;
wire [31:0] debug_wb_pc;
wire debug_wb_have_inst;
wire debug_wb_ena;
wire debug_wb_value;
wire debug_wb_reg;
wire debug_we_we;
wire dram_we;
wire [31:0] rd_dram;
wire [31:0] rd_switch; 
wire clk_i;


miniRV u_miniRV(
    .clk        (clk_i),
    .rst_n      (rst_n),
    .inst       (inst),
    .dram_rd    (dram_rd),
    .dram_addr  (dram_addr),
    .irom_addr  (irom_addr),
    .dram_wdin  (dram_wdin),
    .dram_we    (dram_we),
    .rf_we      (debug_wb_ena),
    .wD         (debug_wb_value),
    .wR         (debug_wb_reg)
);
wire lock;
    cpuclk u_cpuclk(
        .clk_in1    (clk),
        .clk_out1   (clk_i),
        .locked     (lock)
    );
// 64KB IROM
    prgrom imem (
        .a      (irom_addr[15:2]),   // input wire [13:0] a
        .spo    (inst)   // output wire [31:0] spo
    );
    //bus bridge
    wire [31:0] cal_result_dig;
    wire [31:0] cal_result_led;
    wire [31:0] wdata_switch;//just wire
    wire [31:0] wdata_dram;
    
    wire [31:0] rdata_dram; //data read from dram
    wire [31:0] rdata_switch;   //data read from switch
    wire [31:0] rdata_led;
    wire [31:0] rdata_digtube;
    
    wire dram_ena;
    wire digtube_ena;
    wire led_ena;
    wire switch_ena;
    
    wire [31:0] addr_switch;
    wire [31:0] addr_led;
    wire [31:0] addr_digtube;
    wire [31:0] dram_addr_tmp;
    bus u_bus(
        .clk        (clk_i),
        .rst_n      (rst_n),
        .dram_wdin  (dram_wdin),
        .dram_we    (dram_we),
        .dram_addr  (dram_addr),
        .bus_rdata    (dram_rd),
        
        .rdata_dram_i  (rdata_dram),
        .rdata_switch_i(rdata_switch),
        .rdata_led_i   (rdata_led),
        .rdata_digtube_i(rdata_digtube),
        
        .dram_addr_tmp (dram_addr_tmp),
        .addr_led      (addr_led),
        .addr_digtube  (addr_digtube),
        .addr_switch    (addr_switch),
        
        .cal_res_dig    (cal_result_dig),    //digtube to show number
        .cal_res_led    (cal_result_led),
        .wdata_switch   (wdata_switch),
        .wdata_dram     (wdata_dram),
        
        .dram_ena       (dram_ena),
        .digtube_ena    (digtube_ena),
        .led_ena        (led_ena),
        .switch_ena     (switch_ena)
    );

////64KB DRAM
    dram dmem (
        .clk    (clk_i),            // input wire clka
        .a      (dram_addr_tmp[15:2]),     // input wire [13:0] addra
        .spo    (rdata_dram),        // output wire [31:0] douta
        .we     (dram_ena),          // input wire [0:0] wea
        .d      (wdata_dram)         // input wire [31:0] dina
    );

    //LED
    LED u_led(
        .clk        (clk_i),
        .rst_n      (rst_n),
        .addr_led   (addr_led[15:2]),
        .cal_result (cal_result_led),
        .led_ena    (led_ena),
        .led        (led)
    );

    //Digital tube
    Digtube digtube_soc(
        .clk        (clk_i),
        .rst_n      (rst_n),
        .addr_digtube(addr_digtube[15:2]),
        .digtube_ena(digtube_ena),
        .cal_result (cal_result_dig),
        .led_en      (led_en),
        .led_ca      (led_ca),
        .led_cb      (led_cb),
        .led_cc      (led_cc),
        .led_cd      (led_cd),
        .led_ce      (led_ce),
        .led_cf      (led_cf),
        .led_cg      (led_cg),
        .led_dp      (led_dp)
    );

    //switch
    Switch u_switch(
        .switch_i (switch),
        .addr_switch (addr_switch[15:2]),
        .wdata_switch (wdata_switch),
        .switch_ena   (switch_ena),
        .rdata_switch_o (rdata_switch)
    );
endmodule

