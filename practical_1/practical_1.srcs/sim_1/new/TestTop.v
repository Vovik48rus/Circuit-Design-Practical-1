`timescale 1ns / 1ps

module TestTop;

reg clk;
always #5 clk <= ~clk;

reg [16:0] min_cos_brightness;
reg [16:0] min_cos_led_r_with_brightness;

initial 
begin
    clk = 0;
    min_cos_brightness = 17'b11111111111111111;
    min_cos_led_r_with_brightness = 17'b11111111111111111;
end

always@(posedge clk)
begin
    if (min_cos_brightness > top.rgb_leb.cordic_cos_brightness_to_0)
    begin
        min_cos_brightness <= top.rgb_leb.cordic_cos_brightness_to_0;
    end
    
    if (min_cos_led_r_with_brightness > top.rgb_leb.led_r.cordic_cos.cos_cordic)
    begin
        min_cos_led_r_with_brightness <= top.rgb_leb.led_r.cordic_cos.cos_cordic;
    end
end


localparam WIGTH_PWM = 5;
localparam divider_led_counter_size = 27;
localparam divider_brightness_counter_size = divider_led_counter_size * 10 + divider_led_counter_size / 7;

Top #(
    .WIGTH_PWM(WIGTH_PWM),
    .divider_led_counter_size(divider_led_counter_size),
    .divider_brightness_counter_size(divider_brightness_counter_size)
) top (
    .clk(clk),
    .led_r(led_r), 
    .led_g(led_g), 
    .led_b(led_b)
);

endmodule
