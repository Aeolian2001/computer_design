`timescale 1ns / 1ps

module PC(
    input               clk,
    input               rst_n,  
    input  wire [31:0]  npc,
    output wire [31:0]  pc 
);
parameter INIT_PC = 32'b0;  // 假设0为CPU复位后的首条指令对应地址
reg [31:0] pc_reg;
reg first_flag;
assign pc = pc_reg;

always @(posedge clk or negedge rst_n) begin
    if( ~rst_n ) begin
        pc_reg <= INIT_PC;
        first_flag <= 1'b0;
    end
    else 
        if (first_flag == 1'b0) //first time don't run
            first_flag <= 1'b1;
        else
            pc_reg <= npc;
end

endmodule
