`timescale 1ns / 1ps

module PWM#(
    parameter width = 3
)(
    input clk,
    input [0:width - 1] threshold,
    output pwm
);

reg [0:width - 1] counter;

initial
begin
    counter = 0;
end

always@(posedge clk)
begin
    if (counter == 2**width - 2)
    begin
        counter <= 0;
    end
    else
    begin
        counter <= counter +1;
    end
end

assign pwm = (threshold <= counter);

endmodule
