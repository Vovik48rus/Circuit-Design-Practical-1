`timescale 1ns / 1ps

module Top(
    input clk,
    output led_r, led_g, led_b
);

RGBLED rgb_leb (
    .clk(clk),
    .pwm_r(led_r),
    .pwm_g(led_g),
    .pwm_b(led_b)
);

endmodule
