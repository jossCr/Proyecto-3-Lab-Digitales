`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 

//////////////////////////////////////////////////////////////////////////////////
module TOP_Module(Datos,clk,rst, Sennal_Salida
    );
input wire rst, clk;	 

input wire [28:0] Datos;
output wire Sennal_Salida;

wire CLK;
wire [11:0] out;
reg [11:0] registro;

assign out= (Datos[15]==1'b0)?{1'b1,Datos[14:4]}:{1'b0,Datos[14:4]};


//if (bandera)
//begin
//assign Datos=registro;
//end

Frec_Divider Divisor (
.clk(clk),
.rst(rst),
.a_PWM(CLK)
);

voyaverquehagoconelPWM PWM (
.clk(CLK),
.rst(rst),
.compare(out),
.pwm_out(Sennal_Salida)
);

/*
always @*  
begin
registro=Sennal_Salida;
end*/

endmodule
