`timescale 1ns / 1ps

module TestPWMfA(

    );
    
localparam width_pwm    = 3;
localparam width_analog = 4;

reg clk;
reg [0:width_analog - 1] analog;
wire pwm;

always #5 clk <= ~clk;

initial
begin
    clk = 0;
    analog = 2;
    repeat (12 * 4)
        @(posedge clk);
    analog = 10;
    repeat (12 * 4)
        @(posedge clk);
    analog = 15;
    repeat (12 * 4)
        @(posedge clk);
    analog = 0;
end

PWMfA #(
    .width_pwm(width_pwm),
    .width_analog(width_analog)
) dut (
    .clk(clk),
    .analog(analog),
    .pwm(pwm)
);

   
endmodule
