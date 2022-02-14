`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 09:24:21 AM
// Design Name: 
// Module Name: conv_sgn_mag_tb
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


module conv_sgn_mag_tb;

logic [16:0] tx10_mag;
logic tx10_sign;
logic [17:0] tx10;

conv_sgnmag DUV(.tx10, .tx10_sign, .tx10_mag);

initial
begin
    tx10 = 18'b11111111110110_0000;
    #10;
    tx10 = 18'b00000000110010_0000;
    #10;
    tx10 = 18'b11111110110110_0000;
    #10;
    tx10 = 18'b00001111110010_0000;
    #10;
    $stop;
end

endmodule
