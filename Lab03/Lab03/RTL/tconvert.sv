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
                output logic [17:0]tx10);
                
    logic [17:0] tc_concat;
    logic [16:0] tc_shift4;
    logic [16:0] tc_shift1a;
    logic [16:0] tc_shift3;
    logic [16:0] tc_shift1b;
    logic [17:0] tc_add32;
    logic [17:0] tc_sum;

    
    
                
    always_comb
        begin
        if(tc[12])
        begin
            tc_concat = {5'b11111, tc};
        end
        else
        begin
            tc_concat = {5'b00000, tc}; 
       end 
       
       if(c_f)
       begin
            tc_shift4 = tc_concat << 4;
            tc_shift1a = tc_concat << 1;
            tc_sum = tc_shift4 + tc_shift1a;
            tx10 = tc_sum + 18'b00000101000000_0000;
       end
       else 
       begin
            tc_shift3 = tc_concat << 3;
            tc_shift1b = tc_concat << 1;
            tx10 = tc_shift3 + tc_shift1b;
       end
       
       end
        
            

endmodule
