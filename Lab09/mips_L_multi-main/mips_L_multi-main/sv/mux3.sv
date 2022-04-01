//--------------------------------------------------------------------
// mux3.sv - 3:1 mux parameterized by width
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. Moved to separate file
//  2. Changed nested conditional operators to a case stmt for clarity
//
//--------------------------------------------------------------------

module mux3 #(parameter WIDTH = 32) (
    input  logic [WIDTH-1:0] d0, d1, d2,
    input  logic [1:0]       s,
    output logic [WIDTH-1:0] y
    );

    always_comb begin
        case(s)
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            default: y = '0;
        endcase
    end

endmodule // mux3
