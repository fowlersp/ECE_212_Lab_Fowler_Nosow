`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 09:49:16 AM
// Design Name: 
// Module Name: round_tb
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


module round_tb;
    
    logic [16:0] tx10_mag;
    logic [12:0] tx10_mag_r;

round DUV(.tx10_mag, .tx10_mag_r);

initial
begin
    tx10_mag = 17'b0000011110110_0000;
    #10;
    tx10_mag = 17'b0000011110110_1100;
    #10;
    tx10_mag = 17'b0000011110110_0100;
    #10;
    tx10_mag = 17'b0000011110110_0001;
    #10;
    
    $stop;
end
endmodule
