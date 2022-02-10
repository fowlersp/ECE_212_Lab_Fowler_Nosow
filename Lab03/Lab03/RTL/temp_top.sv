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
 logic tmp_rdy, tmp_err; // unused temp controller outputs
 logic [12:0] temp;// 13-bit two's complement result with 4-bit fractional part
 logic [16:0] tx10_w;
 logic [15:0] mag;
 logic [12:0] round;
 logic [4:0] thou, hund, tens, ones;
 logic sign;
 logic [6:0] cel_far;
 logic [6:0] neg_pos;
 logic [12:0] sel_temp;


 // instantiate the VHDL temperature sensor controller
 TempSensorCtl U_TSCTL (
 .TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(temp),
 .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk),
 .SRST_I(rst)
 );
 
 tconvert U_TCON(.tc(sel_temp), .c_f, .tx10(tx10_w));
 conv_sgnmag U_SM(.tx10(tx10_w), .tx10_mag(mag), .tx10_sign(sign));
 round U_RND(.tx10_mag(mag), .tx10_mag_r(round));
 dbl_dabble_ext(.b(round), .thousands(thou), .hundreds(hund), .tens, .ones);
 
always_comb
 begin
 if(SW[1])
    sel_temp = temp;
 else 
    sel_temp = SW[15:3];
    
    if(sign)
       neg_pos = 7'b0010000;
    else
        neg_pos = 7'b1000000;
    if(c_f)
        cel_far = 7'd10;
    else
        cel_far = 7'd11;
 end
 
 sevenseg_control(.d0(cel_far), .d1({2'b00, ones}), .d2({2'b01, tens}), .d3({2'b00, hund}), .d4({2'b00, thou}), .d5(neg_pos), .clk, .rst, .segs_n, .an_n, .dp(dp_n));
 
endmodule
