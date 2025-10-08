`timescale 1ns / 1ps

module Top #(
    parameter WIGTH_PWM = 17,
    parameter divider_led_counter_size = 277008 * 2,
    parameter divider_brightness_counter_size = divider_led_counter_size * 3 + divider_led_counter_size / 10
)(
    input clk,
    output led_r, led_g, led_b
);

RGBLED #(
    .WIGTH_PWM(WIGTH_PWM)
) rgb_leb (
    .clk(clk),
    .divider_led_counter_threshold(divider_led_counter_size),
    .divider_brightness_counter_threshold(divider_brightness_counter_size),
    .pwm_r(led_r),
    .pwm_g(led_g),
    .pwm_b(led_b)
);

endmodule
