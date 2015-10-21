`timescale 1ns / 1ps
module SIMU_TOPTOP;

	// Inputs
	reg [28:0] in1;
	reg [28:0] in2;
	reg [28:0] in3;
	reg bandera, clk,rst;

	// Outputs
	wire salida_audio;

	// Instantiate the Unit Under Test (UUT)
	TOPTOP uut (
		.clk(clk),
		.in1(in1), 
		.in2(in2), 
		.in3(in3), 
		.salida_audio(salida_audio), 
		.bandera(bandera)
	);

	initial begin
		// Initialize Inputs
		in1 = 0;
		in2 = 0;
		in3 = 0;
		rst=0;
		bandera = 0;
		clk=0;
		// Wait 100 ns for global reset to finish
		#100;
		rst=1;
		#50;
		rst=0;
        
		// Add stimulus here
		
		#100;
		bandera = 1;
		#100;
		bandera = 0;
		in1 = 29'b00000000000000000000000001011;
		in2 = 29'b00000000000000000000000000100;
		in3 = 29'b00000000000000000000000001001;
		#4200000;
		
		bandera = 1;
		#100;
		bandera = 0;
		in1 = 29'b00000000000000000000000100000;
		in2 = 29'b00000000000000000000000000011;
		in3 = 29'b00000001000000000000000000000;
		#4200000;
		bandera = 1;
		#100;
		bandera = 0;
	
	
		in1 = 29'b00000000000000000000010000001;
		in2 = 29'b00000000000000000000000000111;
		in3 = 29'b00000001000000011000000000000;
		
		#4200000;
		bandera = 1;
		#100;
		bandera = 0;
		in1 = 29'b00000010000000000000010000001;
		in2 = 29'b00000000000000000000000000111;
		in3 = 29'b00000001000000011000000000000;
		
		
		#4200000;
		bandera = 1;
		#100;
		bandera = 0;
		in1 = 29'b00000000000000000000010000001;
		in2 = 29'b00000011000000000000000000111;
		in3 = 29'b00000001000000011000000000000;

		#4200000;
		bandera = 1;
		#100;
		bandera = 0;
		in1 = 29'b00000000000000000000010000001;
		in2 = 29'b00000000000000000000000000111;
		in3 = 29'b00000001000111011000000000000;
		#100;
		bandera = 0;
	
	end
      initial forever #1 clk =~clk;
endmodule

