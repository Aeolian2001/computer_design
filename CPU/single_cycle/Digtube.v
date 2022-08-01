`timescale 1ns / 1ps

module Digtube(
    input            clk,
    input            rst_n,
    input  [13:0]    addr_digtube,
    input            digtube_ena,
    input  [31:0]    cal_result,
    output  reg [7:0]led_en,
	output  reg      led_ca,
	output  reg      led_cb,
    output  reg      led_cc,
	output  reg      led_cd,
	output  reg      led_ce,
	output  reg      led_cf,
	output  reg      led_cg,
	output  reg      led_dp
);

reg [19:0]cnt;
wire cnt_end = (cnt == 20'd20000);

    reg [31:0] display_num;
    //digtube
    always@(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            display_num <= 32'b0;
        end
        else if (digtube_ena)begin
            display_num <= cal_result;
        end
        else begin
            display_num <= display_num;
        end
    end


always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)         cnt <= 20'd0;
    else if (cnt_end)    cnt <= 20'd0;
    else    cnt <= cnt + 1;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)          led_en <= 8'b01111111;
    else if(cnt_end)   led_en <= {led_en[0], led_en[7:1]};
    else led_en <= led_en;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) {led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg } <=7'b1111111;
    else
       begin
        case(led_en)
            8'b01111111:begin
                case(display_num[31:28])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b10111111:begin
                case(display_num[27:24])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b11011111:begin
                case(display_num[23:20])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b11101111:begin
                case(display_num[19:16])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b11110111:begin
                case(display_num[15:12])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b11111011:begin
                case(display_num[11:8])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b11111101:begin
                case(display_num[7:4])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
            8'b11111110:begin
                case(display_num[3:0])
                    4'hf:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0111000;
                    4'he:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0110000;
                    4'hd:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1000010;
                    4'hc:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1110010;
                    4'hb:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b1100000;
                    4'ha:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <= 7'b0001000;
                    4'h9:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001100;
                    4'h8:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000000;
                    4'h7:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0001111;
                    4'h6:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100000;
                    4'h5:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0100100;
                    4'h4:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001100;
                    4'h3:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000110;
                    4'h2:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0010010;
                    4'h1:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b1001111;
                    default:{led_ca, led_cb, led_cc,led_cd, led_ce, led_cf, led_cg} <=7'b0000001;
                endcase 
            end
        endcase
    end
end
endmodule
