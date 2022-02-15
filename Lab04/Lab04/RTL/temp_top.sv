`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 10:00:02 AM
// Design Name: 
// Module Name: temp_top
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


module temp_top(input logic clk, rst, c_f, 
                input logic [15:1] SW,
                output logic [7:0] an_n,
                output logic [6:0] segs_n,
                output logic dp_n,
                inout tmp_scl, // use inout only - no logic
                inout tmp_sda // use inout only - no logic
                );
  
  logic [6:0] d1, d2, d3, d4, cel_far, neg_pos; 
                
 temp U_TEMP(.clk, .rst, .c_f, .SW, .d1, .d2, .d3, .d4, .cel_far, .neg_pos, .tmp_scl, .tmp_sda); 
 
 sevenseg_control(.d0(cel_far), .d1, .d2, .d3, .d4, .d5(neg_pos), .clk, .rst, .segs_n, .an_n, .dp(dp_n));
 
endmodule
