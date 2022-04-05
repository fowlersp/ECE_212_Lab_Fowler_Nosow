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
    mips_decls_p::funct_t funct;
    logic       zero, pcen, memwrite, irwrite, regwrite;
    logic       alusrca, iord, memtoreg, regdst;
    logic [1:0] alusrcb, pcsrc;
    logic [2:0] alucontrol;
    
    controller DUV(.clk, .reset, .opcode, .funct,
    .zero, .pcen, .memwrite, .irwrite, .regwrite,
    .alusrca, .iord, .memtoreg, 
    .regdst, .alusrcb, .pcsrc, .alucontrol);
    
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end
    
    initial
        begin
            reset = 1;
            zero = 0;
            @(negedge clk) #1;
            reset = 0;
            opcode = OP_LW;
            repeat(5)@(negedge clk) #5;
            opcode = OP_SW;
            repeat(4)@(negedge clk) #5;
            opcode = OP_RTYPE;
            repeat(4)@(negedge clk) #5;
            opcode = OP_BEQ;
            zero = 1;
            repeat(3)@(negedge clk) #5;
            opcode = OP_BEQ;
            zero = 0;
            repeat(3)@(negedge clk) #5;
            opcode = OP_ADDI;
            repeat(4)@(negedge clk) #5;
            opcode = OP_J;
            repeat(3)@(negedge clk) #5;
            $stop;
        end

endmodule
