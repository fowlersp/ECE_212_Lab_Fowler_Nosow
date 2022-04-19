//--------------------------------------------------------------
// mips.sv - single-cycle MIPS processor
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//  1. Use enum for opcode & function code for aid in simulation
//  2. Use explicit port style in instantiations
//--------------------------------------------------------------

module mips(input  logic        clk, reset,
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

   logic                        memtoreg_d, alusrc_d, regdst_d, regwrite_d, jump_d, pcsrc_d;
   logic [2:0]                  alucontrol_d;

   controller U_C(.opcode(opcode_d), .funct(funct_d), .zero(zero_d), .memtoreg(memtoreg_d),
                  .memwrite(memwrite_d), .pcsrc(pcsrc_d),
                  .alusrc(alusrc_d), .regdst(regdst_d), .regwrite(regwrite_d), .jump(jump_d),
                  .alucontrol(alucontrol_d));

   datapath U_DP(.clk, .reset, .memtoreg_d, .memwrite_d, .pcsrc_d,
                 .alusrc_d, .regdst_d, .regwrite_d, .jump_d,
                 .alucontrol_d, .zero_d, .pc_f(pc), .instr_f(instr), .instr_d,
                 .memwrite_m, .aluout_m(aluout), .writedata_m(writedata), .readdata_m(readdata));
endmodule
