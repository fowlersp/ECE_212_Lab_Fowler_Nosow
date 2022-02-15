`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/08/2022 07:52:10 AM
// Module Name: conv_sgnmag
// Description: Gets the sign and the magnitude of the converted temperature
//////////////////////////////////////////////////////////////////////////////////


module conv_sgnmag(input logic [17:0] tx10,
			output logic [16:0] tx10_mag,
			output logic tx10_sign);


	assign tx10_sign = tx10[17];
	
	always_comb
		begin
			if(~tx10[17])
			    begin
				    tx10_mag = tx10 [16:0]; //if positive send magnitude on
		        end
			else
			    begin
				    tx10_mag = (~tx10[16:0]) + 1;  //if negative flip values and add one
                end
		end
endmodule
