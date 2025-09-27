`timescale 1ns / 1ps
module COMPARE_TEST_TRIG;

reg clk;
initial clk = 0;
always #5 clk <= ~clk;

wire clk_10, clk_01;

clk_wiz_0 my_clk_wiz
(
    .clk_in1(clk),
    .clk_out1(clk_10),
    .clk_out2(clk_1),
    .clk_out3(clk_2),
    .clk_out4(clk_3),
    .clk_out5(clk_01),
    .clk_out6(clk_5),
    .clk_out7(clk_6)
);

wire [31:0] cordic_angle_generate;
wire [31:0] cordic_angle_brightness;

GenarateCORDICAngle #(
    .SHIFT(0)
) genarate_CORDIC_angle (
    .clk(clk),
    .cordic_angle(cordic_angle_generate)
);

GenarateCORDICAngle #(
    .SHIFT(0)
) genarate_CORDIC_angle_brightness (
    .clk(clk_01),
    .cordic_angle(cordic_angle_brightness)
);

reg [63:0] i;
initial i = 0;

wire [16:0] cordic_cos_brightness;
reg [31:0] cordic_angle_r, cordic_angle_g, cordic_angle_b; 
reg [31:0] cordic_angle_old = 0;
wire [31:0] difference;

assign difference = cordic_angle_r - cordic_angle_old;

always
begin
    //2^32 * a / 360 = 
    cordic_angle_old = cordic_angle_r;
    // Использовать не 1 << 32 (4294967296), а число которое далится на 45 нацело (4294967265), пусть такое число x,
    // тогда увеличим битность cordic_angle_r на 3, summ (0) = summ + x, cordic_angle_r = summ << 3, 360 = 45 * 8 (2**3)
    // Перезаписать таблицу tang
    cordic_angle_r = ((1 << 32)*i)/360;
    cordic_angle_g = ((1 << 32)*(i + 120))/360;
    cordic_angle_b = ((1 << 32)*(i + 240))/360;
    #10;
    i = i + 1;
end 

CordicCosPWMwithBrightness #(
    .width_pwm(4)
) cordic_cos_r (
    .clk(clk),
    .angle(cordic_angle_generate),
    .cos_brightness(cordic_cos_brightness),
    .pwm(pwm_r)
);

CordicCosPWMwithBrightness #(
    .width_pwm(4)
) cordic_cos_g (
    .clk(clk),
    .angle(cordic_angle_g),
    .cos_brightness(cordic_cos_brightness),
    .pwm(pwm_g)
);

CordicCosPWMwithBrightness #(
    .width_pwm(4)
) cordic_cos_b (
    .clk(clk),
    .angle(cordic_angle_b),
    .cos_brightness(cordic_cos_brightness),
    .pwm(pwm_b)
);

CordicCos MyCordicCos (
    .clk(clk),
    .angle(cordic_angle_brightness),
    .cos_cordic(cordic_cos_brightness)
);

endmodule
