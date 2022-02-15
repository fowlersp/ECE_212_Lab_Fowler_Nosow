`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/08/2022 07:52:39 AM
// Module Name: round: 
// Description: This module rounds the current temperature to one decimal place.
//////////////////////////////////////////////////////////////////////////////////


module round(input logic [16:0] tx10_mag,
		output logic [12:0] tx10_mag_r);

always_comb
	begin
	   if (tx10_mag[3]) //determines wether or not the hundredths bit is on and should be rounded
	       tx10_mag_r = tx10_mag[16:4] + 1;
        else
	       tx10_mag_r = tx10_mag[16:4];
    end
endmodule

