`timescale 1ns / 1ps
module COMPARE_TEST_TRIG;

// Несинтезируемые функции расчётов синуса и косинуса по ряду Тейлора
// ------------------------------------------------------------------
// Генерация последовательности углов
// ----------------------------------
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
    cordic_angle_r = ((1 << 32)*i)/360;
    cordic_angle_g = ((1 << 32)*(i + 120))/360;
    cordic_angle_b = ((1 << 32)*(i + 240))/360;
    #10;
    i = i + 1;
end 

// Синхросигнал
reg clk;
initial clk = 0;
always #5 clk <= ~clk;

wire pwm;

CordicCosPWM #(
    .width_pwm(4)
) cordic_cos_r (
    .clk(clk),
    .angle(cordic_angle_r),
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
