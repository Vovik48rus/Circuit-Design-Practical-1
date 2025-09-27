`timescale 1ns / 1ps

module LED #(
    parameter SHIFT = 0,
    parameter WIGTH_PWM = 4
)  (
    input clk,
    input clk_angle,
    input clk_slow,
    input [16:0] cordic_cos_brightness,
    output pwm
);

wire [31:0] cordic_angle_generate;

GenarateCORDICAngle #(
    .SHIFT(SHIFT)
) genarate_CORDIC_angle (
    .clk(clk_angle),
    .cordic_angle(cordic_angle_generate)
);

CordicCosPWMwithBrightness #(
    .width_pwm(WIGTH_PWM)
) cordic_cos (
    .clk(clk),
    .angle(cordic_angle_generate),
    .cos_brightness(cordic_cos_brightness),
    .pwm(pwm)
);

endmodule
