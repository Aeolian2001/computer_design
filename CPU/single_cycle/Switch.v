module Switch(
    input [23:0] switch_i,
    input [13:0] addr_switch,
    input [31:0] wdata_switch,
    input        switch_ena,
    output reg [31:0] rdata_switch_o
    );
    
    always@(*) begin
        rdata_switch_o = {8'b0,switch_i[23:0]};
    end
    
endmodule