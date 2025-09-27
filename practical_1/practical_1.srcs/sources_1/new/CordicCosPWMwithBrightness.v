`timescale 1ns / 1ps

module CordicCosPWMwithBrightness#(
    parameter width_pwm = 4
)(
    input clk, [31:0] angle,
    input [16:0] cos_brightness,
    output pwm
);

localparam width_analog = 17;

wire [16:0] cos_cordic;
wire [16:0] angle_brightness;

CordicCos MyCordicCos (
    .clk(clk),
    .angle(angle),
    .cos_cordic(cos_cordic)
);

CosWithBrightness my_cos_with_brightness(
    .clk(clk),
    .cos_cordic(cos_cordic),
    .cos_brightness(cos_brightness),
    .angle_brightness(angle_brightness)
);

PWMfA #(
    .width_pwm(width_pwm),
    .width_analog(width_analog)
) dut (
    .clk(clk),
    .analog(~angle_brightness),
    .pwm(pwm)
);

endmodule
