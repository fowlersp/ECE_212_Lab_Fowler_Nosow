`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sam Fowler
// Create Date: 02/15/2022 08:23:55 AM
// Module Name: min_cnt
// Description: This method is used to count and store the minutes for the clock display.
//////////////////////////////////////////////////////////////////////////////////
module min_cnt(
                input logic clk, rst, enb,
                output logic [3:0] min_tens, min_ones,
                output logic cy_m_t);
logic cy_m_o;
    
counter_rc_mod #(.MOD(10)) U_CNT_MIN_ONES (.clk, .rst, .enb, .q(min_ones), .cy(cy_m_o));

counter_rc_mod #(.MOD(6)) U_CNT_MIN_TENS (.clk, .rst, .enb(cy_m_o), .q(min_tens), .cy(cy_m_t));
    
endmodule
