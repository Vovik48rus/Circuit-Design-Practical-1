`timescale 1ns / 1ps

module Top #(
    parameter WIGTH_PWM = 17,
    parameter rgb_inv_freq_def = 277008 * 2,
    localparam rgb_freq_step = rgb_inv_freq_def / 10,
    parameter brightness_inv_freq_def = rgb_inv_freq_def * 3 + rgb_inv_freq_def / 10,
    localparam brightness_freq_step = brightness_inv_freq_def /10,
    localparam CLOCK_RATE = 100_000_000, // Частота ПЛИС XC7A100T-1CSG324 семейства Artix-7 (в Гц)
    localparam BAUD_RATE = 9600 	// Скорость передачи данных по UART (в бод)
)(
    input clk,
    input RsRx,	 	// Бит принимаемых данных (UART_RX)
	output RsTx, 	// Бит отправляемых данных (UART_TX)
    output led_r, led_g, led_b
);

reg reset = 0;
wire [15:0] data_in;    // Шина входных данных автомата
wire ready_in;		    // Сигнал о том, что данные на входе автомата сформированы
reg ready_out;		    // Сигнал о том, что данные на выходе автомата сформированы
reg [63:0] data_out;    // Шина выходных данных автомата

reg [31:0] rgb_inv_freq = rgb_inv_freq_def;
reg [31:0] brightness_inv_freq = brightness_inv_freq_def;

always@(posedge clk)
    if (ready_in) begin
        case(data_in)
            4'h1: rgb_inv_freq <= rgb_inv_freq - rgb_freq_step;
            4'h2: rgb_inv_freq <= rgb_inv_freq + rgb_freq_step;
            4'h3: brightness_inv_freq <= brightness_inv_freq + brightness_freq_step;
            4'h4: brightness_inv_freq <= brightness_inv_freq - brightness_freq_step;
            
            4'h5: rgb_inv_freq <= {2'b10, 30'b1};
            4'h6: rgb_inv_freq <= rgb_inv_freq_def;
            4'h7: rgb_inv_freq <= {2'b00, 30'b1};
            4'h8: brightness_inv_freq <= {2'b10, 30'b1};
            4'h9: brightness_inv_freq <= brightness_inv_freq_def;
            4'ha: brightness_inv_freq <= {2'b00, 30'b1};
        endcase
        data_out <= {rgb_inv_freq, brightness_inv_freq};
        ready_out <= 1;
    end else begin
        ready_out <= 0;
    end
    

RGBLED #(
    .WIGTH_PWM(WIGTH_PWM)
) rgb_leb (
    .clk(clk),
    .divider_led_counter_threshold(rgb_inv_freq),
    .divider_brightness_counter_threshold(brightness_inv_freq),
    .pwm_r(led_r),
    .pwm_g(led_g),
    .pwm_b(led_b)
);

UART_Input_Manager #(.DIGIT_COUNT(4)) uart_input_manager 
(
	.clk(clk), 		       // Вход синхросигнала
	.reset(reset),
	.RsRx(RsRx),
	.out(data_in),         // Выход со значением для входа основного автомата
	.ready_out(ready_in)   // Выход - сигнал о том, что данные на выходе <number_out> сформированы
);
// Автомат, занимающийся менеджментом выходных данных на UART
UART_Output_Manager #(.RESULT_SIZE(64)) uart_output_manager 
(
	.clk(clk),            // Вход: Синхросигнал
	.reset(reset),
	.ready_in(ready_out), // Вход: сигнал о том, что данные для отправки по UART сформированы
	.data_in(data_out),   // Вход: данные для отправки по UART
	.RsTx(RsTx)
);


endmodule
