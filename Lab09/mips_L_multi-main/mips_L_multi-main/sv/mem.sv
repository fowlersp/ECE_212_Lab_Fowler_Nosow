//------------------------------------------------
// mem.sv
// Sarah_Harris@hmc.edu 27 May 2007
// Update to SystemVerilog 17 Nov 2010 DMH
// External unified memory used by MIPS multicycle
// processor.
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module: none
//------------------------------------------------

module mem(
    input  logic        clk, we,
    input  logic [31:0] adr, wd,
    output logic [31:0] rd
    );

    logic  [31:0] RAM[63:0];

    // initialize memory with instructions
    initial begin
        $readmemh("memfile.dat",RAM);  // "memfile.dat" contains your instructions in hex
        // you must create this file
    end

    assign rd = RAM[adr[31:2]]; // word aligned

    always_ff @(posedge clk) begin
        if (we)
        RAM[adr[31:2]] <= wd;
    end

endmodule
