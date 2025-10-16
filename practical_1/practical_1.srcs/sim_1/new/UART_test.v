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
reg RsRx;
wire RsTx;
wire led_r, led_g, led_b;

Top top_inst(
    .clk(clk),
    .RsRx(RsRx),	 	// Бит принимаемых данных (UART_RX)
	.RsTx(RsTx), 	// Бит отправляемых данных (UART_TX)
    .led_r(led_r),
    .led_g(led_g),
    .led_b(led_b)
);

always #5 clk <= ~clk;

initial begin
    #10 RsRx <= 0;
    #1 RsRx <= 0;
    #1 RsRx <= 1;
    #1 RsRx <= 0;
    #1 RsRx <= 1;
    #1 RsRx <= 1;
    #1 RsRx <= 0;
    #1 RsRx <= 1;

    #1 RsRx <= 0;
    #1 RsRx <= 0;
    #1 RsRx <= 0;
    #1 RsRx <= 0;
    #1 RsRx <= 1;
    #1 RsRx <= 1;
    #1 RsRx <= 0;
    #1 RsRx <= 1;
end

endmodule
