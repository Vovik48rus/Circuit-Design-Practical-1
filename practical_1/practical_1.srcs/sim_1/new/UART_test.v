`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2025 10:55:00
// Design Name: 
// Module Name: UART_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_test;

reg clk = 0;
reg RsRx = 1;
wire RsTx;
wire led_r, led_g, led_b;

localparam WIGTH_PWM = 5;
localparam divider_led_counter_size = 27;
localparam divider_brightness_counter_size = divider_led_counter_size * 10 + divider_led_counter_size / 7;

Top #(
    .WIGTH_PWM(WIGTH_PWM),
    .rgb_inv_freq_def(divider_led_counter_size),
    .brightness_inv_freq_def(divider_brightness_counter_size)
) top_inst(
    .clk(clk),
    .RsRx(RsRx),	 	// Бит принимаемых данных (UART_RX)
	.RsTx(RsTx), 	// Бит отправляемых данных (UART_TX)
    .led_r(led_r),
    .led_g(led_g),
    .led_b(led_b)
);

always #5 clk <= ~clk;

initial begin
    #5000000;
    #50 RsRx <= 0;
    #20 RsRx <= 1;
    #20 RsRx <= 0;
    #20 RsRx <= 0;
    #20 RsRx <= 0;
    #20 RsRx <= 1;
    #20 RsRx <= 1;
    #20 RsRx <= 0;
    #20 RsRx <= 0;
    #20 RsRx <= 1;
    
    #50 RsRx <= 0;
    #20 RsRx <= 1;
    #20 RsRx <= 0;
    #20 RsRx <= 1;
    #20 RsRx <= 1;
    #20 RsRx <= 0;
    #20 RsRx <= 0;
    #20 RsRx <= 0;
    #20 RsRx <= 0;
    #20 RsRx <= 1;
end

endmodule
