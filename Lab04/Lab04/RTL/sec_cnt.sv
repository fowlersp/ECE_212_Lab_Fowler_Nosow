
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sam Fowler
// Create Date: 02/15/2022 08:17:55 AM
// Module Name: sec_cnt
// Description: This module is used to count and store the time in seconds for the digital clock. 
// It will reset every 60 seconds.
//////////////////////////////////////////////////////////////////////////////////
module sec_cnt(
                input logic clk, rst, enb,
                output logic [3:0] sec_tens, sec_ones,
                output logic cy_s_t);
logic cy_s_o;
    
counter_rc_mod #(.MOD(10)) U_CNT_SEC_ONES (.clk, .rst, .enb, .q(sec_ones), .cy(cy_s_o));

counter_rc_mod #(.MOD(6)) U_CNT_SEC_TENS (.clk, .rst, .enb(cy_s_o), .q(sec_tens), .cy(cy_s_t));
    
endmodule

