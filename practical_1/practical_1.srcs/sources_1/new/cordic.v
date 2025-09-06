`timescale 1ns / 1ps

module cordic(
    input clk, [31:0] angle, [31:0] Yin, Xin,
    output [31:0] sin_out, cos_out
    );
    
wire signed [31:0] atan_table [0:30];
`include "atan_table.vh"

reg signed [31:0] X [0:31];
reg signed [31:0] Y [0:31];
reg signed [31:0] RES_ACC [0:31];

wire [1:0] quadrant = angle[31:30];

always@(posedge clk)
begin
    case(quadrant)
    2'b00, 2'b11:
        begin
            RES_ACC[0] <= angle;
            X[0] <= Xin;
            Y[0] <= Yin;
        end
        
        2'b01:
        begin
            RES_ACC[0] <= {2'b00, angle[29:0]};
            X[0] <= -Yin;
            Y[0] <= Xin;
        end
        
        2'b10:
        begin
            RES_ACC[0] <= {2'b11, angle[29:0]};
            X[0] <= Yin;
            Y[0] <= -Xin;
        end
    endcase
end

genvar i;
generate 
    for (i = 0; i < 31;i = i + 1)
    begin
        wire rotation_sing = RES_ACC[i][31];
        wire [31:0] X_shift = X[i] >>> i;
        wire [31:0] Y_shift = Y[i] >>> i;
        
        always@(posedge clk)
        begin
            X[i+1] <= rotation_sing ? X[i] + Y_shift : X[i] - Y_shift;
            Y[i+1] <= rotation_sing ? Y[i] - X_shift : Y[i] + X_shift;
            RES_ACC[i+1] <= rotation_sing ? RES_ACC[i] + atan_table[i] : RES_ACC[i] - atan_table[i];
        end
    end
endgenerate

assign cos_out = X[31];
assign sin_out = Y[31];

endmodule
