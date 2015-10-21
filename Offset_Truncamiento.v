`timescale 1ns / 1ps

module Offset_Truncamiento(in,out
    );
input wire [27:0] in;
output wire [11:0] out;


assign out= (in[15]==1'b0)?{1'b1,in[14:4]}:{1'b0,in[14:4]};


endmodule 