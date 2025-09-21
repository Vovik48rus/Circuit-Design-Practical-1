`timescale 1ns / 1ps
module COMPARE_TEST_TRIG;

// Несинтезируемые функции расчётов синуса и косинуса по ряду Тейлора
// ------------------------------------------------------------------
// Генерация последовательности углов
// ----------------------------------

// Синхросигнал
reg clk;
initial clk = 0;
always #5 clk <= ~clk;

wire [31:0] cordic_angle_generate;

GenarateCORDICAngle #(
    .SHIFT(0)
) genarate_CORDIC_angle (
    .clk(clk),
    .cordic_angle(cordic_angle_generate)
);

reg [63:0] i;
initial i = 0;

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

wire pwm;

CordicCosPWM #(
    .width_pwm(4)
) cordic_cos_r (
    .clk(clk),
    .angle(cordic_angle_generate),
    .pwm(pwm_r)
);

CordicCosPWM #(
    .width_pwm(4)
) cordic_cos_g (
    .clk(clk),
    .angle(cordic_angle_g),
    .pwm(pwm_g)
);

CordicCosPWM #(
    .width_pwm(4)
) cordic_cos_b (
    .clk(clk),
    .angle(cordic_angle_b),
    .pwm(pwm_b)
);

//CordicCosPWM #(
//    .width_pwm(4)
//) cordic_cos (
//    .clk(clk),
//    .angle(cordic_angle),
//    .pwm(pwm)
//);

endmodule
