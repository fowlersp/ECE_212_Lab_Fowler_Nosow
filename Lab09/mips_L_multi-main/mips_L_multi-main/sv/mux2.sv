//--------------------------------------------------------------
// mux2.sv - parameterized 2-1 mux
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
//--------------------------------------------------------------

module mux2 #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] d0, d1,
    input  logic             s,
    output logic [WIDTH-1:0] y
    );

    assign y = s ? d1 : d0;

endmodule // mux2
