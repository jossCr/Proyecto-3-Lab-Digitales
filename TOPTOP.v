`timescale 1ns / 1ps

module TOPTOP(in1, in2, in3, salida_audio,bandera,clk,rst
    );
	input wire [28:0] in1, in2, in3;
	input wire bandera,clk,rst;
	wire [28:0] resul_filtros;
	reg [28:0] entrada_pwm;
	
	output wire salida_audio;
	reg [28:0]registro_salida;

	always @ (posedge clk)
	begin
	if (bandera)
	entrada_pwm=resul_filtros;
	else 
	entrada_pwm=entrada_pwm;
	end
	 
Sumador_Filtros Filtrillos (.F1(in1), .F2(in2), .F3(in3), .suma_total(resul_filtros));
TOP_Module PWM (.Datos(entrada_pwm), .rst(rst), .clk(clk), .Sennal_Salida(salida_audio));
	
endmodule
