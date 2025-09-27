`timescale 1ns / 1ps

module CordicCos(
    input clk, [31:0] angle,
    output [16:0] cos_cordic
);

reg [15:0] Xin, Yin;
wire [16:0] Xout, Yout;

initial
begin
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

endmodule
