//--------------------------------------------------------------
// aludec.sv - single-cycle MIPS ALU decode
// Dvid_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//    1. Use enum for function codes declared in external package
//    2. Use blocking assignments for comb. logic
//--------------------------------------------------------------

module aludec(mips_decls_p::funct_t funct,
              input  logic [1:0] aluop,
              output logic [2:0] alucontrol);
   
   import mips_decls_p::*;
   
  always_comb
    case(aluop)
      2'b00: alucontrol = 3'b010;  // add
      2'b01: alucontrol = 3'b110;  // sub
      2'b10: case(funct)          // RTYPE
                 F_ADD: alucontrol = 3'b010; // ADD
                 F_SUB: alucontrol = 3'b110; // SUB
                 F_AND: alucontrol = 3'b000; // AND
                 F_OR: alucontrol = 3'b001; // OR
                 F_SLT: alucontrol = 3'b111; // SLT
                 default:   alucontrol = 3'bxxx; // unimplemented/unknown
             endcase // case (funct)
      default: alucontrol = 3'bxxx;
    endcase
endmodule
