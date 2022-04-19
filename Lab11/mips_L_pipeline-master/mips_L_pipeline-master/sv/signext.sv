//--------------------------------------------------------------
// signext.sv - single-cycle MIPS datapath
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module: none except placing in own file

module signext(input  logic [15:0] a,
               output logic [31:0] y);
              
  assign y = {{16{a[15]}}, a};
   
endmodule
