`timescale 1ns / 1ps

module CosWithBrightness(
    input clk, 
    input [16:0] cos_cordic,
    input [16:0] cos_brightness,
    output reg [16:0] cos_with_brightness
    );

wire [33:0] cos_cordic_extended;
wire [33:0] cos_brightness_extended;

assign cos_cordic_extended = {17'b0, cos_cordic};
assign cos_brightness_extended = {17'b0, cos_brightness};

always@(posedge clk)
begin
    cos_with_brightness <= (cos_cordic_extended * cos_brightness_extended) >> 17;
end

endmodule
