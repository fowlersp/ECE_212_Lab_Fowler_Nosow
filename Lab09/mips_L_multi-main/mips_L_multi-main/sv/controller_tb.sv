`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2022 07:42:30 PM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb;

   import mips_decls_p::*;

    logic clk, reset;
    mips_decls_p::opcode_t opcode;
    logic       pcwrite, memwrite, irwrite, regwrite;
    logic       alusrca, branch, iord, memtoreg, regdst;
    logic [1:0] alusrcb, pcsrc;
    logic [1:0] aluop;
    
    maindec DUV(.clk, .reset,
 
    .opcode,
 .pcwrite, .memwrite, 
    .irwrite, .regwrite,
 .alusrca, 
    .branch, .iord, .memtoreg, 
    .regdst,
 .alusrcb, .pcsrc,
 .aluop);
    
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end
    
    initial
        begin
            reset = 1;
            @(negedge clk) #1;
            reset = 0;
            opcode = OP_LW;
            repeat(4)@(negedge clk) #5;
            opcode = OP_SW;
            repeat(4)@(negedge clk) #5;
            opcode = OP_RTYPE;
            repeat(4)@(negedge clk) #5;
            opcode = OP_BEQ;
            repeat(3)@(negedge clk) #5;
            opcode = OP_ADDI;
            repeat(4)@(negedge clk) #5;
            opcode = OP_J;
            repeat(3)@(negedge clk) #5;
            $stop;
        end

endmodule
