`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2022 08:17:55 AM
// Design Name: 
// Module Name: clock_top
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

module clock_top(input logic clk, rst, mode, enb_hr, enb_min,
output logic [6:0] segs_n,
output logic [7:0] AN,
output logic dp_n);

logic [6:0] h1, h0, m1, m0, s1, s0, am_pm;




dig_clk U_DIG_CLK (.clk, .rst, .enb_hr, .enb_min, .h1, .h0, .m1, .m0, .s1, .s0, .am_pm);

seven_seg_n U_SEVTOP (.d0(am_pm), .d1(7'b1000000), .d2(s0), .d3(s1), .d4(m0), .d5(m1), .d6(h0), .d7(h1), .clk, .rst, .mode, .segs_n, .AN, .dp_n);

endmodule

