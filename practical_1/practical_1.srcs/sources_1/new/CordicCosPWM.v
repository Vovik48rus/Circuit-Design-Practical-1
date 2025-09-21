`timescale 1ns / 1ps


module CordicCosPWM#(
    parameter width_pwm = 4
)(
    input clk, [31:0] angle,
    output pwm
);

localparam width_analog = 17;

reg [15:0] Xin, Yin;
wire [16:0] Xout, Yout, cos_cordic;
initial 
begin
//    Xin = 32000/1.647;
    Xin = 32000;
    Yin = 0;
end

cordic uut1 (
    .clk(clk), 
    .angle(angle), 
    .Xin(Xin), 
    .Yin(Yin), 
    .cos_out(Xout), 
    .sin_out(Yout)
);
assign cos_cordic = {~Xout[16], Xout[15:0]};


PWMfA #(
    .width_pwm(width_pwm),
    .width_analog(width_analog)
) dut (
    .clk(clk),
    .analog(~cos_cordic),
    .pwm(pwm)
);


endmodule
