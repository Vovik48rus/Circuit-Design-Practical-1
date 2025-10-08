`timescale 1ns / 1ps

module Divider #(
    parameter WIGHT = 4
)(
    input clk,
    input [WIGHT - 1:0] border,
    output reg out_clk
    );

reg [WIGHT - 1:0] counter;

initial
begin
   counter = 0;
   out_clk = 0;
end

always@(posedge clk)
begin
    if (counter >= border)
    begin
        out_clk <= ~out_clk;
        counter <= 0;
    end
    else begin
        counter <= counter + 1;
    end
end

endmodule
