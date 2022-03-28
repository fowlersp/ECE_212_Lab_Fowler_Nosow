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

module mips(
    input  logic        clk, reset,
    output logic [31:0] pc,
    input logic [31:0]  instr,
    output logic        memwrite,
    output logic [31:0] aluout, writedata,
    input logic [31:0]  readdata
    );

    import mips_decls_p::*;

    // instruction fields
    // using enum types make symbolic values visible during simulation
    opcode_t opcode;
    funct_t funct;
    assign opcode = opcode_t'(instr[31:26]);
    assign funct = funct_t'(instr[5:0]); // caution: will show "phantom" function codes for
    // non-R-Type instructions

    // status signals
    logic        zero;

    // control signals

    logic        memtoreg, alusrc, regdst, regwrite, jump, pcsrc;
    logic [2:0]  alucontrol;

   controller U_C(.opcode, .funct, .zero,
                  .memtoreg, .memwrite, .pcsrc,
                  .alusrc, .regdst, .regwrite, .jump,
                  .alucontrol);

   datapath U_DP(.clk, .reset, .memtoreg, .pcsrc,
                 .alusrc, .regdst, .regwrite, .jump,
                 .alucontrol,.zero, .pc, .instr,
                 .aluout, .writedata, .readdata);
endmodule
