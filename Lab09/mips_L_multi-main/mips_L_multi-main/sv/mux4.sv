//--------------------------------------------------------------------
// mux4.sv - 4:1 mux parameterized by width
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. Moved to separate file
//  2. Changed non-blocking assignments to blocking (comb. logic)
//
//--------------------------------------------------------------------

module mux4 #(parameter WIDTH = 32) (
    input  logic [WIDTH-1:0] d0, d1, d2, d3,
    input  logic [1:0]       s,
    output logic [WIDTH-1:0] y
    );

    always_comb begin
        case(s)
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            2'b11: y = d3;
            default: y = '0;
        endcase
    end
endmodule // mux4
