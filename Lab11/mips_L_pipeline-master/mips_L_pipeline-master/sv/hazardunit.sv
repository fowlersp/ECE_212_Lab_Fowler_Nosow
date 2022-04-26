`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 08:20:47 AM
// Design Name: 
// Module Name: hazardunit
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


module hazardunit(input logic [4:0] rs_d, rt_d, rs_e, rt_e, writereg_e, writereg_m, writereg_w,
    input logic jump_d, branch_d, memtoreg_e, regwrite_e, memtoreg_m, regwrite_m, regwrite_w,
    output logic stall_f, stall_d, forward_a_d, forward_b_d, flush_e, 
    output logic [1:0] forward_a_e, forward_b_e
    );
    
    logic branchstall;
    logic lwstall;
    
    //Forwarding
    assign forward_a_d = (rs_d != 0) && (rs_d == writereg_m) && regwrite_m;
    assign forward_b_d = (rt_d != 0) && (rt_d == writereg_m) && regwrite_m;
    
    //Stalling
    assign branchstall = (branch_d && regwrite_e && (writereg_e == rs_d || writereg_e == rt_d))||
                          (branch_d && memtoreg_m && (writereg_m == rs_d || writereg_m == rt_d));                      
    assign lwstall = ((rs_d == rt_e) || (rt_d == rt_e)) && memtoreg_e;
    
    assign stall_f = branchstall || lwstall;
    assign stall_d = branchstall || lwstall;
    assign flush_e = branchstall || lwstall;
    
    always_comb
    begin
        if((rs_e != 0) && (rs_e == writereg_m) && regwrite_m) forward_a_e = 2'b10;
        else if ((rs_e != 0) && (rs_e == writereg_w) && regwrite_w) forward_a_e = 2'b01;
        else forward_a_e = 2'b00;
        
        if((rt_e != 0) && (rt_e == writereg_m) && regwrite_m) forward_b_e = 2'b10;
        else if ((rt_e != 0) && (rt_e == writereg_w) && regwrite_w) forward_b_e = 2'b01;
        else forward_b_e = 2'b00;
    end
    
endmodule
