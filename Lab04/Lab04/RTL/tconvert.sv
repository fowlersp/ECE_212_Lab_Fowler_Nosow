`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/08/2022 07:51:35 AM
// Module Name: tconvert 
// Description: Converts celcius value to either 10x celcius value or Farenheit
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
            if(tc[12])  //Determine if the value is negative or positive
                begin
                    tc_concat = {5'b11111, tc};
                end
            else
                begin
                    tc_concat = {5'b00000, tc}; 
                end 
       
            if(c_f)
                begin
                    tc_shift4 = tc_concat << 4;     //multiply value by 16
                    tc_shift1a = tc_concat << 1;    //multiply value by 2
                    tc_sum = tc_shift4 + tc_shift1a;    //sum values so it is tempx18
                    tx10 = tc_sum + 18'b00000101000000_0000;    //add 32
                end
            else 
                begin
                    tc_shift3 = tc_concat << 3;     //multiply value by 8
                    tc_shift1b = tc_concat << 1;    //multiply value by 12
                    tx10 = tc_shift3 + tc_shift1b;  //sum values so it is tempx10
                end 
        end

endmodule
