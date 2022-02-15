`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2022 09:01:27 AM
// Design Name: 
// Module Name: clk_temp_top
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


module clk_temp_top(input logic clk, rst, sw15, sw14, sw0, enb_hr, enb_min,
                    output logic [7:0] an_n,
                    output logic [6:0] segs_n,
                    output logic dp,
                    inout tmp_scl, // use inout only - no logic
                    inout tmp_sda // use inout only - no logic
                    );
    
    logic enb_out, sel;
    logic [6:0] cel_far, neg_pos, d0, d1, d2, d3, d4, td1, td2, td3, td4, d5, d6, d7;
    logic [6:0] h1, h0, m1, m0, s1, s0, am_pm;
    
    
    temp U_TTOP(.clk, .rst, .c_f(sw0), .d1(td1), .d2(td2), .d3(td3), .d4(td4), .cel_far, .neg_pos, .tmp_scl, .tmp_sda);
    dig_clk U_DIG_CLK(.clk, .enb(enb_out), .rst, .enb_hr, .enb_min, .h1, .h0, .m1, .m0, .s1, .s0, .am_pm);
    
    fsm U_FSM(.sw1(sw15), .sw2(sw14), .clk(enb_out), .rst, .sel);
    
    period_enb #(.PERIOD_MS(1000)) U_ENB(.clk, .rst, .clr(1'b0), .enb_out);
    
    always_comb
        begin 
            if(sel)
                begin
                    d0 = cel_far;
                    d1 = td1;
                    d2 = td2;
                    d3 = td3;
                    d4 = td4;
                    d5 = neg_pos;
                    d6 = 7'b1000000;
                    d7 = 7'b1000000;
                end
            else
                begin
                    d0 = am_pm;
                    d1 = s0;
                    d2 = s1;
                    d3 = m0;
                    d4 = m1;
                    d5 = h0;
                    d6 = h1;
                    d7 = 7'b1000000;
                end
        end
                
    
    sevenseg_control U_SEG(.d0, .d1, .d2, .d3, .d4, .d5, .d6, .d7, .clk, .rst, .segs_n, .an_n, .dp);
endmodule
