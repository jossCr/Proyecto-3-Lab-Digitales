`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:50:17 10/18/2015
// Design Name:   voyaverquehagoconelPWM
// Module Name:   C:/Users/ACER/Desktop/U/VoyaverquehagoconelADC/voyaverquehagoconelPWM_TB.v
// Project Name:  VoyaverquehagoconelADC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: voyaverquehagoconelPWM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module voyaverquehagoconelPWM_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [11:0] load;
	reg [11:0] compare;

	// Outputs
	wire pwm_out;

	// Instantiate the Unit Under Test (UUT)
	voyaverquehagoconelPWM uut (
		.clk(clk), 
		.rst(rst), 
		.load(load), 
		.compare(compare), 
		.pwm_out(pwm_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		load=12'b111111111111;
		compare = 0;
		rst=1;
		#50;
		rst=0;
		
		// Wait 100 ns for global reset to finish
		#21000000;
       
		// Add stimulus here
	
		compare=12'b000010101010;
		#42000000;
		compare=12'b000000101010;
		#42000000;
		compare=12'b000011111010;
		#42000000;
		compare=12'b000010111110;
		#42000000;
		compare=12'b000010110110;
		#42000000;
		compare=12'b000011111111;
		#42000000;
		compare=12'b000010101010;
		#42000000;
	
	end
initial forever #5120 clk=~clk;
endmodule

