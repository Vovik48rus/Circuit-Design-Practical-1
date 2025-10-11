`timescale 1ns / 1ps


module ASCII_To_HEX (
    input  wire [7:0] ascii_in,
    output reg  [3:0] hex_out
);
    always @(*)
    begin
        case (ascii_in)
            // Цифры 0-9
            8'h2b: hex_out = 4'h1; // +
            8'h2d: hex_out = 4'h2; // -
            8'h3c: hex_out = 4'h3; // <
            8'h3e: hex_out = 4'h4; // >
            
            8'h31: hex_out = 4'h5; // 1           
            8'h32: hex_out = 4'h6; // 2            
            8'h33: hex_out = 4'h7; // 3            
            
            8'h37: hex_out = 4'h8; // 7           
            8'h38: hex_out = 4'h9; // 8            
            8'h39: hex_out = 4'ha; // 9
            
            // Значение по умолчанию (ошибка/неизвестный символ)
            default: hex_out = 4'h0;
        endcase
    end
endmodule
