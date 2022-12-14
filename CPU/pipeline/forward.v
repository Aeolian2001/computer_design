`timescale 1ns / 1ps


module forward(
    input       [4:0]   id_ex_reg1,
    input       [4:0]   id_ex_reg2,
    input       [4:0]   rf_rr1,
    input       [4:0]   rf_rr2,
    input       [4:0]   ex_mem_rd,
    input               ex_mem_rf_we,
    input       [4:0]   mem_wb_rd,
    input               mem_wb_rf_we,
    input       [31:0]  mem_wb_rf_wdata_i,
    input       [31:0]  mem_wb_rf_wdata_o,
    
    output      [31:0]  id_ex_rd1_i,
    output      [31:0]  id_ex_rd2_i,
    output      [31:0]  id_ex_rd1_o,
    output      [31:0]  id_ex_rd2_o,
    output              rd1_i_sel,
    output              rd2_i_sel,
    output              rd1_o_sel,
    output              rd2_o_sel
    );
    //A 
    wire a_rs1;
    wire a_rs2;
    assign a_rs1 = ex_mem_rf_we && (ex_mem_rd != 5'h0) && (id_ex_reg1 == ex_mem_rd);
    assign a_rs2 = ex_mem_rf_we && (ex_mem_rd != 5'h0) && (id_ex_reg2 == ex_mem_rd);
    //B 
    wire b_rs1;
    wire b_rs2;
    assign b_rs1 = mem_wb_rf_we && (mem_wb_rd != 5'h0) && (id_ex_reg1 == mem_wb_rd);
    assign b_rs2 = mem_wb_rf_we && (mem_wb_rd != 5'h0) && (id_ex_reg2 == mem_wb_rd);
    //C 
    wire c_rs1;
    wire c_rs2;
    assign c_rs1 = mem_wb_rf_we && (mem_wb_rd != 5'h0) && (rf_rr1 == mem_wb_rd);
    assign c_rs2 = mem_wb_rf_we && (mem_wb_rd != 5'h0) && (rf_rr2 == mem_wb_rd);
    //forward
    assign id_ex_rd1_i = mem_wb_rf_wdata_o;
    assign id_ex_rd2_i = mem_wb_rf_wdata_o;
    assign id_ex_rd1_o =    ({b_rs1, a_rs1} == 2'b01)   ?   mem_wb_rf_wdata_i : 
                            ({b_rs1, a_rs1} == 2'b10)   ?   mem_wb_rf_wdata_o : 
                            ({b_rs1, a_rs1} == 2'b11)   ?   mem_wb_rf_wdata_i : 
                                                            32'h0;
    assign id_ex_rd2_o =    ({b_rs2, a_rs2} == 2'b01)   ?   mem_wb_rf_wdata_i : 
                            ({b_rs2, a_rs2} == 2'b10)   ?   mem_wb_rf_wdata_o : 
                            ({b_rs2, a_rs2} == 2'b11)   ?   mem_wb_rf_wdata_i : 
                                                            32'h0;
    
    assign rd1_i_sel = c_rs1;
    assign rd2_i_sel = c_rs2;
    assign rd1_o_sel = a_rs1 || b_rs1;
    assign rd2_o_sel = a_rs2 || b_rs2;
endmodule
