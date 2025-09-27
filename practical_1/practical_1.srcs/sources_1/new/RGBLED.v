`timescale 1ns / 1ps

module RGBLED #(
    parameter WIGTH_PWM = 17
)(
    input clk,
    output pwm_r, pwm_g, pwm_b
);

wire clk_angle;
wire clk_slow;

wire [16:0] cordic_cos_brightness;
wire [31:0] cordic_angle_brightness;

delitel #(
    .mod(277008) // T = 1s
//    .mod(27)
) my_delitel_angle (
    .clk(clk),
    .out(clk_angle)
);

delitel #(
    .mod(3) // T = 3s 
) my_delitel_slow (
    .clk(clk_angle),
    .out(clk_slow)
);

GenarateCORDICAngle #(
    .SHIFT(0)
) genarate_CORDIC_angle_brightness (
    .clk(clk_slow),
    .cordic_angle(cordic_angle_brightness)
);

CordicCos MyCordicCos (
    .clk(clk),
    .angle(cordic_angle_brightness),
    .cos_cordic(cordic_cos_brightness)
);

LED #(
    .SHIFT(0),
    .WIGTH_PWM(WIGTH_PWM)
) led_r (
    .clk(clk),
    .clk_angle(clk_angle),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness),
    .pwm(pwm_r)
);

LED #(
    .SHIFT(120),
    .WIGTH_PWM(WIGTH_PWM)
) led_g (
    .clk(clk),
    .clk_angle(clk_angle),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness),
    .pwm(pwm_g)
);

LED #(
    .SHIFT(240),
    .WIGTH_PWM(WIGTH_PWM)
) led_b (
    .clk(clk),
    .clk_angle(clk_angle),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness),
    .pwm(pwm_b)
);

endmodule
