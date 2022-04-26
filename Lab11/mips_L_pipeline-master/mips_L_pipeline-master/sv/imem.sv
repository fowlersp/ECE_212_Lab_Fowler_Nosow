//------------------------------------------------
// imem.sv - Instruction memory for MIPS
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// External memories used by MIPS single-cycle
// processor
// Key modifications this module:
//  1. Use byte addressing to be consistent with dmem
//  2.
//  2. Outputt 'x when address out of range
//  Add error messages when out of range?
//  Add a starting address?
//------------------------------------------------

module imem #(parameter SIZE=64 ) (
   input  logic [31:0]  adr,
   output logic [31:0] rd
                                  );

   logic [31:0]         RAM[63:0];

   logic [29:0]         adr_w;

   assign adr_w = adr[31:2];  // word aligned

   initial
     begin
        $readmemh("memfile.dat",RAM); // initialize memory
     end

   always_comb
     if (adr_w < SIZE) rd = RAM[adr_w];
     else rd = 'x;

endmodule
