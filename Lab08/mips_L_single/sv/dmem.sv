//--------------------------------------------------------------------
// dmem.sv - word-aligned data memory for single-cycle MIPS simulation
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. parameterize memory size
//  2. read 'x' when address is out of range (to aid debugging)
//  3. don't write when address is out of rnage
//------------------------------------------------

module dmem #(parameter SIZE=32) (
    input logic             clk, we,
    input logic [SIZE-1:0]  adr, wd,
    output logic [31:0]     rd
    );

    logic [31:0]    RAM[63:0];

    logic [29:0] adr_w;

    assign adr_w = adr[31:2];  // word aligned

    always_comb
    if (adr_w < SIZE) rd = RAM[adr_w];
    else rd = 'x;

    always @(posedge clk)
    if (we && (adr_w < SIZE))
    RAM[adr_w] <= wd;

endmodule
