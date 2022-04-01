//---------------------------------------------------------------------------
// mips_multi.v - Multicycle MIPS Processor
// David_Harris@hmc.edu 8 November 2005
// Update to SystemVerilog 17 Nov 2010 DMH
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//   1. Use enums from package for opcode & function code
//--------------------------------------------------------------------------

module mips_multi(
    input  logic        clk, reset,
    output logic [31:0] adr, writedata,
    output logic        memwrite,
    input logic [31:0]  readdata
    );

   import mips_decls_p::*;

   // status & control signals
   logic                              zero, pcen, irwrite, regwrite,
                                      alusrca, iord, memtoreg, regdst;
   logic [1:0]                        alusrcb, pcsrc;
   logic [2:0]                        alucontrol;

   // instruction fields
   opcode_t opcode;
   funct_t funct;

  controller U_CTL(.clk, .reset, .opcode, .funct, .zero,
                   .pcen, .memwrite, .irwrite, .regwrite,
                   .alusrca, .iord, .memtoreg, .regdst,
                   .alusrcb, .pcsrc, .alucontrol);

   datapath U_DP(clk, reset,
                 pcen, irwrite, regwrite,
                 alusrca, iord, memtoreg, regdst,
                 alusrcb, pcsrc, alucontrol,
                 opcode, funct, zero,
                 adr, writedata, readdata);

endmodule // mips_multi
