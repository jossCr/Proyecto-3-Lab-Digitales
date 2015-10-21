`timescale 1ns / 1ps
module Sumador_Filtros(F1,F2,F3,suma_total
    );
	parameter WIDTH = 29;
	parameter WIDTH2 = 36;
	input signed [WIDTH-1:0] F1,F2,F3;
	output wire signed [WIDTH-1:0] suma_total;	
  	wire signed [WIDTH2-1:0] temporal1,temporal3, temporal2,temporal4,temporal5;
	wire signed [WIDTH-1:0]tempsalida, tempsalida2;
	assign temporal1 = {{7{F1[28]}}, F1};
	assign temporal2 = {{7{F2[28]}}, F2};
	assign temporal3=temporal1+temporal2;/*
	assign temporal3 = ((temporal3[35]==0)&&(temporal3[35:29] !=7'b0000000))? (29'sb01111111111111111111111111111) :
	((temporal3[35]==1'b1)&& (temporal3[35:29] != 7'b1111111)) ? (29'sb10000000000000000000000000000):
	($signed ((tempsalida[28:0])));
/////////////////////////////////////////////////////*/
	assign temporal5={{7{F3[28]}}, F3};
	assign temporal4=temporal3+temporal5;
	assign tempsalida2 = (~(temporal4[35]==0)&&(|temporal4[34:29]))? (29'sb01111111111111111111111111111) :
	((temporal4[35]==1'b1)&& (&temporal4[35:29]) )? (29'sb10000000000000000000000000000):
	($signed ((temporal4[28:0])));
	assign suma_total=tempsalida2;
endmodule

