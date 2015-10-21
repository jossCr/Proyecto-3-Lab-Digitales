`timescale 1ns / 1ps

module TOP_Module_TB;

	// Inputs
	reg [28:0] Datos;
	reg rst;
	reg clk;
	reg [28:0] v_mem [0:16];
	// Outputs
	wire Sennal_Salida;
	integer i;
	// Instantiate the Unit Under Test (UUT)   
	TOP_Module uut (
		.Datos(Datos), 
		.rst(rst), 
		.clk(clk), 
		.Sennal_Salida(Sennal_Salida)
	);

	initial begin
		// Initialize Inputs
		Datos = 0;
		rst = 0;
		clk = 0;
		#50;
		rst=1;
		#50;
		rst=0;
		// Wait 100 ns for global reset to finish
		#100;
		// Initialize Inputs
		
		$readmemb("Joss_jodiendo.txt",v_mem);
	
		for (i=0;i<17;i=i+1)
		
		begin
		Datos=v_mem[i];
		#4200000;
		end
		
end 
initial forever #1 clk=~clk;

endmodule

