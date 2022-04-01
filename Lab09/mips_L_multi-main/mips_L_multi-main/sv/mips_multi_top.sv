//------------------------------------------------
// mips_multi_top.sv
// David_Harris@hmc.edu 9 November 2005
// Update to SystemVerilog 17 Nov 2010 DMH
// Top level system including multicycle MIPS and
// and unified memory
// Refactored into separate files & updated using additional
// SystemVerilog features by John Nestor May 2018
//------------------------------------------------

module mips_multi_top(
    input  logic        clk, reset,
    output logic [31:0] writedata, adr,
    output logic        memwrite
    );

    logic [31:0]        readdata;

    // microprocessor (control & datapath)
    mips_multi U_MIPS(.clk, .reset, .adr, .writedata, .memwrite, .readdata);

    // memory
    mem U_MEM(.clk, .we(memwrite), .adr, .wd(writedata), .rd(readdata));

endmodule // mips_multi_top
