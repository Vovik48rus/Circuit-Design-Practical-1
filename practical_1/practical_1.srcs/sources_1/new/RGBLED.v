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

localparam divider_led_counter_size = 277008 * 2;
localparam divider_brightness_counter_size = divider_led_counter_size * 3 + divider_led_counter_size / 7;
//localparam divider_led_counter_size = 27;
//localparam divider_brightness_counter_size = divider_led_counter_size * 50 + divider_led_counter_size / 10;

delitel #(
//    .mod(277008) // T = 1s
    .mod(divider_led_counter_size) // T = 0.1ms
) my_delitel_angle (
    .clk(clk),
    .out(clk_angle)
);

delitel #(
    .mod(divider_brightness_counter_size) // T = 3s 
) my_delitel_slow (
    .clk(clk),
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

wire [16:0] cordic_cos_brightness_to_0;
assign cordic_cos_brightness_to_0 = cordic_cos_brightness - 17'b00011001000100001;

LED #(
    .SHIFT(0),
    .WIGTH_PWM(WIGTH_PWM)
) led_r (
    .clk(clk),
    .clk_angle(clk_angle),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness_to_0),
    .pwm(pwm_r)
);

LED #(
    .SHIFT(120),
    .WIGTH_PWM(WIGTH_PWM)
) led_g (
    .clk(clk),
    .clk_angle(clk_angle),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness_to_0),
    .pwm(pwm_g)
);

LED #(
    .SHIFT(240),
    .WIGTH_PWM(WIGTH_PWM)
) led_b (
    .clk(clk),
    .clk_angle(clk_angle),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness_to_0),
    .pwm(pwm_b)
);

endmodule
