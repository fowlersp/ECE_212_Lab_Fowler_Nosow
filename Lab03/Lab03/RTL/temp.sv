`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2022 07:46:19 AM
// Design Name: 
// Module Name: temp
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


module temp(input logic clk, rst, c_f, 
            input logic [15:1] SW,
            output logic [6:0] d1, d2, d3, d4,
            output logic [6:0] cel_far, neg_pos,
            inout tmp_scl, // use inout only - no logic
            inout tmp_sda); // use inout only - no logic
 
 logic tmp_rdy, tmp_err; // unused temp controller outputs
 logic [12:0] temp;// 13-bit two's complement result with 4-bit fractional part
 logic [17:0] tx10_w;
 logic [16:0] mag;
 logic [12:0] round;
 logic [4:0] thou, hund, tens, ones;
 logic sign;
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
     
 if(hund == 4'b0000 && thou == 4'b0000)
    d3 = 7'b1000000;
 else
    d3 = {2'b00,hund};
    
 if(thou == 4'b0000)
    d4 = 7'b1000000;
 else
    d4 = {2'b00,thou};
 end

assign d2 = {2'b01,tens};
assign d1 = {2'b00,ones};

endmodule