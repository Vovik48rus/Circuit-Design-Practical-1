`timescale 1ns / 1ps

module TestLED;

reg clk;
initial clk = 0;
always #5 clk <= ~clk;

wire clk_10, clk_slow;

clk_wiz_0 my_clk_wiz
(
    .clk_in1(clk),
    .clk_out1(clk_10),
    .clk_out2(clk_1),
    .clk_out3(clk_2),
    .clk_out4(clk_3),
    .clk_out5(clk_slow),
    .clk_out6(clk_5),
    .clk_out7(clk_6)
);

wire [16:0] cordic_cos_brightness;
wire [31:0] cordic_angle_brightness;

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

wire pwm;

LED #(
    .SHIFT(0),
    .WIGTH_PWM(4)
) led (
    .clk(clk),
    .clk_slow(clk_slow),
    .cordic_cos_brightness(cordic_cos_brightness),
    .pwm(pwm)
);
endmodule
