`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 07:52:10 AM
// Design Name: 
// Module Name: conv_sgnmag
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module conv_sgnmag(input logic [16:0] tx10,
			output logic [15:0] tx10_mag,
			output logic tx10_sign);

	logic [16:0] tx10_flip;

	assign tx10_sign = tx10[16];
	
	always_comb
		begin
			if(~tx10[16])
			begin
				tx10_mag = tx10 [15:0];
		    end
			else
			begin
				tx10_mag = (~tx10[15:0]) + 1; 
              //  tx10_sign = 1;
            end
		end
endmodule
