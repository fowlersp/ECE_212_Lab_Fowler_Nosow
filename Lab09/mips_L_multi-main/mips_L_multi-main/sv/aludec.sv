//--------------------------------------------------------------
// aludec.sv - MIPS multi-cycle ALU decoder
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
//--------------------------------------------------------------
module aludec(
    mips_decls_p::funct_t funct,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol
    );

   import mips_decls_p::*;

  // ADD CODE HERE
  // Complete the design for the ALU Decoder.
  // Your design goes here.  Remember that this is a combinational
  // module.

  // Remember that you may also reuse any code from previous labs.

endmodule // aludec
