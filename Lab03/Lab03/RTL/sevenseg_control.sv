`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 10:31:40 AM
// Design Name: 
// Module Name: sevenseg_control
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


module sevenseg_control(input logic[6:0] d0, d1, d2, d3, d4, d5, d6,
                        input logic clk, rst, 
                        output logic [6:0] segs_n,
                        output logic [7:0] an_n,
                        output logic dp);
                        
                        
    logic [2:0] sel;
    logic [6:0] y;
    logic dec; 
    
    period_enb U_ENB(.clk, .rst, .clr(1'b0), .enb_out);
    count_3bit U_COUNT3C (.clk, .rst, .enb(enb_out), .q(sel), .dec); 
    mux8 #(.W(7)) U_MUX8 (.d0, .d1, .d2, .d3, .d4, .d5, .d6, .d7(7'd0), .sel, .y);
    dec_3_8_n U_DEC3 (.a(sel), .y_n(an_n));
    seven_seg_n U_SSN(.d(y), .segs_n, .dp_n(dp));
    
endmodule
