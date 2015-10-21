`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:00 10/18/2015 
// Design Name: 
// Module Name:    Frec_Divider 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Frec_Divider( 
    input wire clk,
    input wire rst,
    output wire a_PWM          //esta es la se�al que ingresar�a al PWM module
    );

wire [8:0] din;     //realmente deber�a ser 10
wire [8:0] clkdiv; 
 
dff dff_inst0 (
    .clk(clk),
    .rst(rst),
    .D(din[0]),
    .Q(clkdiv[0])
);
 
genvar i;
generate
for (i = 1; i < 9; i=i+1) //ciclo para instanciar los 11 FF's D necesarios para bajar la frec a 49kHz
begin : dff_gen_label
    dff dff_inst (
        .clk(clkdiv[i-1]),
        .rst(rst),
        .D(din[i]),
        .Q(clkdiv[i])
    );
    end
endgenerate;
 
assign din = ~clkdiv;
 
assign a_PWM = clkdiv[8];


endmodule 