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

reg old_reg_overflow = 0;

wire [31 + 3:0] next_summ = summ + max_angle_divided_45;

always@ (posedge clk)
begin
    if (next_summ[34] < old_reg_overflow)
    begin
        summ <= 0;
    end
    else begin
        summ <= next_summ;
    end
    old_reg_overflow <= next_summ[34];
end

assign cordic_angle = summ[34:3];

endmodule
