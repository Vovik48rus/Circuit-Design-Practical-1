`timescale 1ns / 1ps


module GenarateCORDICAngle #(
    parameter SHIFT = 0
)
(
    input clk,
    output [31:0] cordic_angle
);

localparam [31 + 3:0] max_angle_divided_45 = 32'b101101100000101101100000101;
localparam [31 + 3:0] shift_cordic_angle = max_angle_divided_45 * SHIFT;

reg [31 + 3:0] summ = shift_cordic_angle;

always@ (posedge clk)
begin
    summ <= summ + max_angle_divided_45;
end

assign cordic_angle = summ[34:3];

endmodule
