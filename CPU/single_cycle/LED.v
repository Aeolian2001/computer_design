module LED(
    input               clk,
    input               rst_n,
    input   [13:0]      addr_led,
    input   [31:0]      cal_result,
    input               led_ena,
    output  [23:0]      led
);

    reg [31:0] led_num;
    always@(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            led_num <= 32'h0000_0000;
        end
        else if(led_ena)begin
            led_num <= cal_result;
        end
        else begin
            led_num <= led_num;
        end
    end

    assign led = led_num[23:0];

endmodule