`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sam Fowler
// Create Date: 02/20/2022 07:02:03 PM
// Module Name: count_hr
// Description: This module counts the hours for the clock and keeps track of am and pm
//////////////////////////////////////////////////////////////////////////////////


module count_hr(input logic enb, clk, rst,
                output logic [6:0] ones, tens,
                output logic [6:0] am_pm);
                
                logic [3:0] h1;
                logic [3:0] h1_add1;
                logic [7:0] h1_h1;
                logic [3:0]ones_bcd;
                logic [3:0]tens_bcd;
                logic [3:0] set_am_pm;
                logic enb_am_pm;
                logic [3:0] h2;
                
                logic temp; // empty wires
                logic temp2;
                logic temp3;
                
                counter_rc_mod #(.MOD(4'd12)) COUNT_HOUR (.clk, .rst, .enb, .q(h1), .cy(enb_am_pm));
                counter_rc_mod #(.MOD(4'd2)) AM_PM_ENB (.clk, .rst, .enb(enb_am_pm), .q(set_am_pm), .cy(temp));
                
                assign am_pm = set_am_pm + 7'b0001010;
                
                
                                        
                always_comb 
                    begin
                        if(h1 == 4'd0)
                            h2 = 4'd12;
                        else
                            h2 = h1;
                        
                    end
                
                assign h1_h1 = {4'b0, h2};
                
                dbl_dabble DABBLE (.b(h1_h1), .hundreds(temp2), .tens(tens_bcd), .ones(ones_bcd));
                
                assign ones = {3'b010, ones_bcd};
                assign tens = {3'b000, tens_bcd};
                
endmodule

