`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:07 10/18/2015 
// Design Name: 
// Module Name:    Prueba_29b 
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
module FiltroPasa(dato_i,dato_o,clk_i,reset,dataf_i,dataf_oo, coeff_b0_section1 ,coeff_b1_section1 , coeff_b2_section1 ,coeff_a1_section1 ,coeff_a2_section1 ,coeff_1_section1


    );
	 output wire dataf_oo;
	 reg dataf_o;
	 input wire clk_i;
	 input dataf_i;
	 input wire reset;
	 
	 input wire signed [WIDTH-1:0] coeff_b0_section1;
	 input wire signed [WIDTH-1:0] coeff_b1_section1;
	 input wire signed [WIDTH-1:0] coeff_b2_section1;
	 input wire signed [WIDTH-1:0] coeff_a1_section1;
	 input wire signed [WIDTH-1:0] coeff_a2_section1;
	 input wire signed [WIDTH-1:0] coeff_1_section1;
	 
	 parameter FRA=16;
	 parameter INT=12;
	 parameter WIDTH=29;
	 //A[]=S[1],E[12],F[16] 
	 
	 reg signed [WIDTH-1:0] Reg1,Reg2;
	 wire overflow, underflow;
	 reg [3:0] muxselect1, muxselect2;
	 wire signed [2*WIDTH-1:0] result_mul_sum;
	 wire signed [2*WIDTH-1:0] result_concatenation;
	 wire signed  [WIDTH-1:0] truncate ;
	 reg signed  [WIDTH-1:0]Regacu;
	 input signed  [WIDTH-1:0] dato_i;
	 reg signed  [WIDTH-1:0] f_k, y_k;
	 wire signed [WIDTH-1:0]out1,out2;
	 output wire signed[WIDTH-1:0]dato_o;
	 //reg [WIDTH-1:0] Regacu;   /// System Accumulator
	 reg signed [WIDTH-1:0] Regsum;   /// System Accumulator
	 ///////////////////////////////////////////////////////////////
	 reg [3:0] state_reg, state_next;
	 localparam[3:0]
		state_start=4'b0000, 
		state_m1=4'b0001, state_m1_1=4'b0010,
		state_m2=4'b0011,  state_m2_2=4'b0100,
		state_m3=4'b0101, state_f_k=4'b0110, state_clean=4'b0111,
		state_m4=4'b1000, state_m4_4=4'b1001,
		state_m5=4'b1010, state_m5_5=4'b1011,
		state_m6=4'b1100, state_RegChange1=4'b1101,
		state_RegChange2=4'b1110, state_reset=4'b1111;
//////////////////////Parameter/////////////////////////////////
///PONER VARIABLES CORREGIDAS, CON ANCHO NUEVO
		 /* parameter signed [WIDTH-1:0] coeff_b0_section1 = 29'sb00000000000000000000000001101; //sfix28_En26
		  parameter signed [WIDTH-1:0] coeff_b1_section1 =   29'sb00000000000000000000000011010; //sfix28_En26
		  parameter signed [WIDTH-1:0] coeff_b2_section1 =   29'sb00000000000000000000000001101; //sfix28_En26
		  parameter signed [WIDTH-1:0] coeff_a1_section1 =   29'sb00000000000001111010111100011; //sfix28_En29
		  parameter signed [WIDTH-1:0] coeff_a2_section1 =   29'sb11111111111100000101000111101; //sfix28_En29		
		  parameter signed [WIDTH-1:0] coeff_1_section1 =    29'sb00000000000010000000000000000; //sfix28_En29	*/		
///////////////////MUX 1 /////////////////////////////////////////


	assign out1= (muxselect1==3'b111) ? coeff_b0_section1:
					 (muxselect1==3'b110) ? coeff_b1_section1:
					 (muxselect1==3'b101) ? coeff_b2_section1:
					 (muxselect1==3'b010) ? coeff_a2_section1:
					 (muxselect1==3'b001) ? coeff_a1_section1:
					 (muxselect1==3'b011) ? coeff_1_section1:
					 29'sb0;
					 
////////////////////MUX 2 //////////////////////////////////////////
	assign out2 =(muxselect2==3'b000) ? Reg1:
					 (muxselect2==3'b001) ? Reg2:
					 (muxselect2==3'b010) ? dato_i:
					 (muxselect2==3'b011) ? f_k:
					 29'sb0;
//////////////////////////////////////////////////////////////////////		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//***********************Banderas************************************************************************************
	assign overflow = (~result_mul_sum[2*WIDTH-1] && |result_mul_sum[2*WIDTH-2:2*WIDTH-2-INT]) ? 1'b1  :  1'b0;//GENERA BANDERA DE OVERFLOW
	assign underflow = (result_mul_sum[2*WIDTH-1] && ~(&result_mul_sum[2*WIDTH-2:2*WIDTH-2-INT])) ? 1'b1  :  1'b0; //GENERA BANDERA DE UNDERFLOW
//*******************************Redondeo y truncamiento******************************************************//
	assign truncate= (overflow) ?  (29'sh0fffffff) :
							(underflow) ? (29'sh10000000) :
							$signed({result_mul_sum[2*WIDTH-1],result_mul_sum[2*WIDTH-INT-3:2*WIDTH-2*INT-2],result_mul_sum[2*WIDTH-2*INT-3:2*WIDTH-2*INT-FRA-2]});	
///////////////////ojo con el regacu//////////////////////////////////
	
	//assign regacu=truncate;
	assign dato_o=y_k;
	assign dataf_oo=dataf_o;
	
	assign result_concatenation=(Regacu[WIDTH-1]==1'b0)? $signed({14'h0,Regacu[WIDTH-2:0],16'b0}):$signed({14'h3fff,Regacu[WIDTH-2:0],16'b0});  
	//assign y_k=regacu;
//Module Arithmetic operation
	assign result_mul_sum=  out1*out2+result_concatenation;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////// ------control-------///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk_i,posedge reset) 
			begin 
				if(reset)
					begin
						state_reg <=state_reset;
					end
				else
					state_reg  <= state_next;
			end
			
			//State Machine	
 /*assign Sum_add_cast = {{7{In1[24]}}, In1};
  assign Sum_add_cast_1 = {{7{In2[24]}}, In2};
  assign Sum_add_temp = Sum_add_cast + Sum_add_cast_1;
  assign Sum_out1 = ((Sum_add_temp[31] == 1'b0) && (Sum_add_temp[30:24] != 7'b0000000) ? 25'sb0111111111111111111111111 :
              ((Sum_add_temp[31] == 1'b1) && (Sum_add_temp[30:24] != 7'b1111111) ? 25'sb1000000000000000000000000 :
              $signed(Sum_add_temp[24:0])));

  assign Out1 = Sum_out1;			*/
////////////////////////////////////////////////////////////////////////////////////////////
			always @* 
			begin
					//state_reg=state_next;
					state_next=state_reg;
					case(state_reg)
						state_reset: 
							begin
								dataf_o=1'b0;
								Reg1=29'b0;
								Reg2=29'b0;
								Regacu=29'b0;
								Regsum=29'b0;
                        f_k=29'b0;
								y_k=29'b0;
								state_next=state_start;
							end					
						state_start: 
							begin
								dataf_o=1'b0;
								Regacu=29'b0;
								Regsum=29'b0;
								if(dataf_i)
									state_next=state_m1;
								else
									state_next=state_start;
							end
						state_m1:
							begin
								//MUX target 
								muxselect1=3'b001;
								muxselect2=3'b000;
								//save data
								Regsum=truncate;
								//next state
								state_next=state_m1_1;
							end
						state_m1_1:
							begin
								//MUX target 
								muxselect1=3'b001;
								muxselect2=3'b000;
								//save data
								Regacu=Regsum;
								//next state
								state_next=state_m2;
							end
						state_m2:
							begin
								//MUX target 
								muxselect1=3'b010;
								muxselect2=3'b001;
								//save data
								Regsum=truncate;
								state_next=state_m2_2;
							end
						state_m2_2:
							begin
								//MUX target 
								muxselect1=3'b010;
								muxselect2=3'b001;
								//save data
								Regacu=Regsum;
								state_next=state_m3;
							end

						state_m3:
							begin
								//MUX target 
								muxselect1=3'b011;
								muxselect2=3'b010;
								//save data
								Regsum=truncate;
								//next state
								state_next=state_f_k;
							end
						state_f_k:
							begin
								//MUX target dont change
								//save data
								f_k=Regsum;
								Regacu=Regsum;
								//next state
								state_next=state_clean;
							end
						state_clean:
							begin
								Regacu=29'b0;
								Regsum=29'b0;
								state_next=state_m4;
							end
						state_m4:
							begin
								//MUX target 
								muxselect1=3'b101;
								muxselect2=3'b001;
								//save data
								Regsum=truncate;
								
								//next state
								state_next=state_m4_4;
							end
						state_m4_4:
							begin
								//MUX target 
								muxselect1=3'b101;
								muxselect2=3'b001;
								//save data
								Regacu=Regsum;
								
								//next state
								state_next=state_m5;
							end
						state_m5:
							begin
								//MUX target 
								muxselect1=3'b110;
								muxselect2=3'b000;
								//save data
								Regsum=truncate;
								//next state
								state_next=state_m5_5;
							end
						state_m5_5:
							begin
								//MUX target 
								muxselect1=3'b110;
								muxselect2=3'b000;
								//save data
								Regacu=Regsum;
								//next state
								state_next=state_m6;
							end
						state_m6:
							begin
								//MUX target 
								muxselect1=3'b111;
								muxselect2=3'b011;
								//save data
								Regsum=truncate;
								//next state
								state_next=state_RegChange1;
							end
							
						state_RegChange1:
							begin
								
								//Move register
								Reg2=Reg1;
								
								y_k=Regsum;
								Regacu=Regsum;
								//temp2=f_k;
								
								state_next=state_RegChange2;
							end
						state_RegChange2:
							begin
								//Move register
								Reg1=f_k;
								Regacu=29'b0;
								Regsum=29'b0;
								dataf_o=1'b1;
								state_next=state_start;
							end
					default state_next=state_start;
					endcase
			end
endmodule 