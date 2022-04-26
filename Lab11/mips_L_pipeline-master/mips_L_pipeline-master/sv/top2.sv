`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 09:25:31 AM
// Design Name: 
// Module Name: top2
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


module top2(input logic         clk, reset, 
           output logic [31:0] writedata, dataadr, 
           output logic        memwrite);

   logic [31:0]                pc, instr, readdata;
  
  // instantiate processor and memories
  mips_f mips(.clk, .reset, .pc, .instr, .memwrite, .aluout(dataadr), .writedata, .readdata);
   
  imem imem(.adr(pc), .rd(instr));
   
  dmem dmem(.clk, .we(memwrite), .adr(dataadr), .wd(writedata), .rd(readdata));
endmodule
