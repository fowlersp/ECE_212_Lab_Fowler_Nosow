`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 09:27:25 AM
// Design Name: 
// Module Name: mips_f
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


module mips_f(input  logic        clk, reset,
            output logic [31:0] pc,
            input logic [31:0]  instr,
            output logic        memwrite,
            output logic [31:0] aluout, writedata,
            input logic [31:0]  readdata);

   import mips_decls_p::*;

   // local properly named control signal
   logic memwrite_d, memwrite_m;
   assign memwrite = memwrite_m;  // for external connection

   // instruction fields
   // using enumerate type makes symbolic values visible during simulation
   logic [31:0] instr_d;
   opcode_t opcode_d;
   funct_t funct_d;
   assign opcode_d = opcode_t'(instr_d[31:26]);
   assign funct_d = funct_t'(instr_d[5:0]); // caution: will show "phantom" function codes for
                                        // non-R-Type instructions

   // status signals
   logic                        zero_d;

   // control signals

   logic                        memtoreg_d, alusrc_d, regdst_d, regwrite_d, jump_d, pcsrc_d, jal_d, jr_d, flush_d, branch_d;
   logic                        stall_f, stall_d, forward_a_d, forward_b_d, flush_e;
   logic                        memtoreg_e, regwrite_e, memtoreg_m, regwrite_m, regwrite_w;
   logic [1:0]                  forward_a_e, forward_b_e;
   logic [2:0]                  alucontrol_d;
   logic [4:0]                  rs_d, rt_d, rs_e, rt_e, writereg_e, writereg_m, writereg_w;

   controller_f U_C(.opcode(opcode_d), .funct(funct_d), .zero(zero_d), .memtoreg(memtoreg_d),
                  .memwrite(memwrite_d), .pcsrc(pcsrc_d),
                  .alusrc(alusrc_d), .regdst(regdst_d), .regwrite(regwrite_d), .jump(jump_d), .flush(flush_d),
                  .alucontrol(alucontrol_d), .jal(jal_d), .jr(jr_d), .branch(branch_d));

   datapath_f U_DP(.clk, .reset, .memtoreg_d, .memwrite_d, .pcsrc_d,
                 .alusrc_d, .regdst_d, .regwrite_d, .jump_d, .jal_d, .jr_d,
                 .alucontrol_d, .zero_d, .pc_f(pc), .instr_f(instr), .instr_d,
                 .stall_f, .flush_d, .stall_d, .forward_a_d, .forward_b_d, .flush_e, .forward_a_e, .forward_b_e,   
                 .memwrite_m, .aluout_m(aluout), .writedata_m(writedata), .readdata_m(readdata),
                 .rs_d, .rt_d, .rs_e, .rt_e, .writereg_e, .writereg_m, .writereg_w,
                 .memtoreg_e, .regwrite_e, .memtoreg_m, .regwrite_m, .regwrite_w);
                 
   hazardunit  U_HU(.rs_d, .rt_d, .rs_e, .rt_e, .writereg_e, .writereg_m, .writereg_w,
                  .jump_d, .branch_d, .memtoreg_e, .regwrite_e, .memtoreg_m, .regwrite_m, .regwrite_w,
                  .stall_f, .stall_d, .forward_a_d, .forward_b_d, .flush_e, 
                  .forward_a_e, .forward_b_e);
endmodule
