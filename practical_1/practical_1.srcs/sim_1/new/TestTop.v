`timescale 1ns / 1ps

module TestTop;

reg clk;
initial clk = 0;
always #5 clk <= ~clk;

Top top (
    .clk(clk),
    .led_r(led_r), 
    .led_g(led_g), 
    .led_b(led_b)
);

endmodule
