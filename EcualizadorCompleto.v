`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module EcualizadorCompleto(clk_i, dataf_i, dataf_o, reset, dato_i, dato_o1,dato_o2,dato_o3
    );
	input clk_i;
	input reset;
	input dataf_i;
	output wire dataf_o;
	//output wire [28:0] total;
	input [28:0] dato_i;
	output wire [28:0] dato_o1;
	output wire [28:0] dato_o2;
	output wire [28:0] dato_o3;
	///enlaces
	wire [28:0] cable1;
	wire [28:0] cable2;
	wire [28:0] cable3;
	//banderas
	wire bandera1;
	wire bandera2;
	wire bandera3;
	
	//indic
	//wire dataf_o1;
	wire dataf_o2;
	wire dataf_o3;
	
	//outputs de filtros 2 y 3
	//wire [28:0] dato_00b;
	//wire [28:0] dato_00c;
	
	//Filtro filtro1(.clk_i(clk_i), .dataf_i(dataf_i),.dataf_o(dataf_o), .reset(reset), .dato_i(dato_i), .dato_o(dato_o), .coeficiente_b0(28'd10) , .coeficiente_b1(28'd20),.coeficiente_b2(28'd30), .coeficiente_a2(28'd50), .coeficiente_a1(28'd40));
	
	
	////////////////////*******************FILTRO PASABANDAS 20Hz~2KHz*****************************/////////////////////////////////
	
	FiltroPasa filtro1(.dato_i(dato_i), .dato_o(cable1),.clk_i(clk_i),.reset(reset),.dataf_i(dataf_i),.dataf_oo(bandera1),.coeff_b0_section1(29'sb00000000000000000000000001101) ,.coeff_b1_section1(29'sb00000000000000000000000011010) , .coeff_b2_section1(29'sb00000000000000000000000001101) ,.coeff_a1_section1(29'sb00000000000011111010111000011) ,.coeff_a2_section1(29'sb11111111111110000101000011101) ,.coeff_1_section1(29'sb00000000000010000000000000000));
	FiltroPasa filtro2(.dato_i(cable1),.dato_o(dato_o1),.clk_i(clk_i),.reset(reset),.dataf_i(bandera1),.dataf_oo(dataf_o),.coeff_b0_section1(29'sb00000000000001111111101111101) ,.coeff_b1_section1(29'sb11111111111100000000100000110) , .coeff_b2_section1(29'sb00000000000001111111101111101) ,.coeff_a1_section1(29'sb00000000000011111111011111010) ,.coeff_a2_section1(29'sb11111111111110000000100000110) ,.coeff_1_section1(29'sb00000000000010000000000000000));
	
	
	////////////////////*******************FILTRO PASABANDAS 2KHz~5KHz*****************************/////////////////////////////////
	
	FiltroPasa filtro3(.dato_i(dato_i), .dato_o(cable2),.clk_i(clk_i),.reset(reset),.dataf_i(dataf_i),.dataf_oo(bandera2),.coeff_b0_section1(29'sb00000000000000001010101001010) ,.coeff_b1_section1(29'sb00000000000000010101010010011) , .coeff_b2_section1(29'sb00000000000000001010101001010) ,.coeff_a1_section1(29'sb00000000000010000100011110110) ,.coeff_a2_section1(29'sb11111111111111010000111011000) ,.coeff_1_section1(29'sb00000000000010000000000000000));
	FiltroPasa filtro4(.dato_i(cable2),.dato_o(dato_o2),.clk_i(clk_i),.reset(reset),.dataf_i(bandera2),.dataf_oo(dataf_o2),.coeff_b0_section1(29'sb00000000000010000000000000000) ,.coeff_b1_section1(29'sb11111111111100000000000000000) , .coeff_b2_section1(29'sb00000000000010000000000000000) ,.coeff_a1_section1(29'sb00000000000011111010111000011) ,.coeff_a2_section1(29'sb11111111111110000101000011101) ,.coeff_1_section1(29'sb00000000000010000000000000000));
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////*******************FILTRO PASABANDAS 5KHz~20KHz*****************************/////////////////////////////////
	
	FiltroPasa filtro5(.dato_i(dato_i), .dato_o(cable3),.clk_i(clk_i),.reset(reset),.dataf_i(dataf_i),.dataf_oo(bandera3),.coeff_b0_section1(29'sb00000000000001101000000101110) ,.coeff_b1_section1(29'sb00000000000011010000001000010) , .coeff_b2_section1(29'sb00000000000001101000000101110) ,.coeff_a1_section1(29'sb11111111111100110100010110100) ,.coeff_a2_section1(29'sb11111111111110101011010011011) ,.coeff_1_section1(29'sb00000000000010000000000000000));
	FiltroPasa filtro6(.dato_i(cable3),.dato_o(dato_o3),.clk_i(clk_i),.reset(reset),.dataf_i(bandera3),.dataf_oo(dataf_o3),.coeff_b0_section1(29'sb00000000000001001100111000111) ,.coeff_b1_section1(29'sb11111111111101100110010001011) , .coeff_b2_section1(29'sb00000000000001001100111000111) ,.coeff_a1_section1(29'sb00000000000010000100011110110) ,.coeff_a2_section1(29'sb11111111111111010000111011000) ,.coeff_1_section1(29'sb00000000000010000000000000000));
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//assign total=dato_o1+dato_o2+dato_o3;
	/*
	always @( posedge clk_i)  
		begin
			dato_o2=dato_o;
		end 
*/
endmodule