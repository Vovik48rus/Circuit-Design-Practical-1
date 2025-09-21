`timescale 1ns / 1ps

module PWMfA#(
    parameter width_pwm = 3,
    parameter width_analog = 4
)(
    input clk,
    input [0:width_analog - 1] analog,
    output pwm
);

wire [0:width_pwm - 1] threshold;

assign threshold = analog >> (width_analog - width_pwm);

PWM #(
    .width(width_pwm)
) dut (
    .clk(clk),
    .threshold(threshold),
    .pwm(pwm)
);

endmodule
