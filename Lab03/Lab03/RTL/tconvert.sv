`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 07:51:35 AM
// Design Name: 
// Module Name: tconvert
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


module tconvert(input logic[12:0] tc,
                input logic c_f,
                output logic [16:0]tx10);
                
    logic [16:0] tc_concat;
    logic [16:0] tc_shift4;
    logic [16:0] tc_shift1a;
    logic [16:0] tc_shift3;
    logic [16:0] tc_shift1b;
    logic [16:0] tc_add32;
    logic [16:0] tc_sum;
    logic [16:0] tx10f;
    logic [16:0] tx10c;
    
    
                
    always_comb
        begin
        if(tc[12])
        begin
            tc_concat = {4'b1111, tc};
        end
        else
        begin
            tc_concat = {4'b0000, tc}; 
       end 
       
       if(c_f)
       begin
            tc_shift4 = tc_concat << 4;
            tc_shift1a = tc_concat << 1;
            tc_sum = tc_shift4 + tc_shift1a;
            tx10 = tc_sum + 17'b0000101000000_0000;
       end
       else 
       begin
            tc_shift3 = tc_concat << 3;
            tc_shift1b = tc_concat << 1;
            tx10 = tc_shift3 + tc_shift1b;
       end
       
       end
        
            

endmodule
