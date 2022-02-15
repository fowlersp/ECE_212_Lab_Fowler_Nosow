`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 08:38:28 AM
// Design Name: 
// Module Name: tconvert_tb
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


module tconvert_tb;

logic [12:0] tc;
logic c_f;
logic [16:0] tx10;

tconvert DUV(.tc, .c_f, .tx10);

initial
begin
    tc = 13'b111111111_0000;
    c_f = 1;
    #10;
    tc = 13'b111111111_0000;
    c_f = 0;
    #10;
    tc = 13'b000110010_0000;
    c_f = 1;
    #10;
    tc = 13'b000110010_0000;
    c_f = 0;
    #10;
    $stop;
end
    
    


endmodule
