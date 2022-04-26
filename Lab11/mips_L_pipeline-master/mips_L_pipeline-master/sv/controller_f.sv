`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 09:09:53 AM
// Design Name: 
// Module Name: controller_f
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


module controller_f(
    input mips_decls_p::opcode_t opcode,
    input mips_decls_p::funct_t funct,
    input logic        zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump, jal, jr, flush, branch,
    output logic [2:0] alucontrol
    );

  logic [1:0] aluop;

  maindec U_MD(.opcode, .memtoreg, .memwrite, .branch, .funct,
             .alusrc, .regdst, .regwrite, .jump, .aluop, .jal, .jr);

  aludec  U_AD(.funct, .aluop, .alucontrol);

  assign pcsrc = branch & zero;
  
  //flush if branch or jump
  assign flush = (jump || pcsrc);

endmodule
