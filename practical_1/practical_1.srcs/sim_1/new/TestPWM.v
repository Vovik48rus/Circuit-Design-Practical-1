`timescale 1ns / 1ps

module TestPWM(
    
    );
    
localparam width = 3;
wire pwm;
reg [0:width - 1] threshold;
reg clk;

initial 
begin
    clk = 0;
    threshold = 8;
    #1000;
    threshold = 4;
    #1000
    threshold = 0;
end
always #5 clk <= ~clk;

PWM #(
    .width(width)
) dut (
    .clk(clk),
    .threshold(threshold),
    .pwm(pwm)
);

endmodule
