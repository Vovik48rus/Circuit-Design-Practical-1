`timescale 1ns / 1ps

module TestDivider;

parameter wight = 4;

reg [wight-1:0] border;
wire out_clk;

reg clk;
initial clk = 0;
always #5 clk <= ~clk;

Divider #(
    .WIGHT(wight)
) uut (
    .clk(clk),
    .border(1),
    .out_clk(out_clk)
);

delitel #(
    .mod(1) // T = 1s
//    .mod(27)
) my_delitel_angle (
    .clk(clk),
    .out(clk_delitel)
);

initial begin
    border = 4'd5;
end

endmodule
