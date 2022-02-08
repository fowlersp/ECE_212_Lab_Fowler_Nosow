`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 10:24:06 AM
// Design Name: 
// Module Name: seven_seg_n
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


module seven_seg_n(
		 input logic [6:0]  d,
		 output logic [6:0] segs_n,  // ordered g(6) - a(0)
		 output logic dp_n
		 );

   always_comb
   begin
   
   dp_n = 1;
   
   if(d[6] == 1)    //blank
    segs_n = 7'b1111111;
    
   else if((d[4] == 1) && (d[6] == 0))  //dash
    segs_n = 7'b0111111;
    
   else if((d[6] == 0) && (d[4] == 0))
     case (d[3:0])     //  gfedcba
           4'd0: segs_n = 7'b1000000;
           4'd1: segs_n = 7'b1111001;
           4'd2: segs_n = 7'b0100100;
           4'd3: segs_n = 7'b0110000;
           4'd4: segs_n = 7'b0011001;
           4'd5: segs_n = 7'b0010010;
           4'd6: segs_n = 7'b0000010;
           4'd7: segs_n = 7'b1111000;   
           4'd8: segs_n = 7'b0000000;
           4'd9: segs_n = 7'b0010000;
           4'd10: segs_n = 7'b0001110;  //F
           4'd11: segs_n = 7'b1000110;  //C
           default: segs_n = 7'b1111111;
       
       endcase
       
       if((d[5] == 1) && (d[6] == 0))   //dp
        dp_n = 0;
    
     end
endmodule: seven_seg_n

