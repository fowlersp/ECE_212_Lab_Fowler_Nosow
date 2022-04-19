//--------------------------------------------------------------
// flopr.sv - parameterized flop with asynchronous reset
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Modifications to this file:
//  1. Changed asynchronous reset to synchronous reset
//--------------------------------------------------------------

module flopr #(parameter WIDTH = 8)
              (input  logic             clk, reset,
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

  always_ff @(posedge clk)
    if (reset) q <= 0;
    else       q <= d;
endmodule
